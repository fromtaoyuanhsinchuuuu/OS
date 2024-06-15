#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"
#include <stdbool.h>
#include <assert.h>
#include <stddef.h>

#define MAX_PATH 100
#define MAX_NAME 16

void countOccurrences(char *path, char *key, int *count) 
{
    *count = 0;
    int keyLen = strlen(key);
	if (keyLen != 1) exit(1);
	int path_len = strlen(path);
	for (int i = 0; i < path_len; i++){
		if (path[i] == key[0]){
			(*count)++;
		}
	}
}

void traverse(char path[], char key[], int *file_num, int *dir_num, bool isRoot) 
{
    int fd;
    struct dirent de;
    struct stat st;
    
    if ((fd = open(path, 0)) < 0){ // read only
		if (!isRoot) exit(1); 
        printf("%s [error opening dir]\n", path);
        return;
    }

    if (fstat(fd, &st) < 0){
        printf("cannot stat %s\n", path);
        close(fd);
        return;
    }

	if (st.type != T_DIR){
		if (!isRoot) exit(1);
		printf("%s [error opening dir]\n", path);
        return;
	}

	int count = 0;
	countOccurrences(path, key, &count);
	printf("%s %d\n", path, count);

    if (st.type == T_DIR){ // dir
        char buf[MAX_PATH];
        strcpy(buf, path);
        char *p = buf + strlen(buf);
        *p++ = '/';
        while (read(fd, &de, sizeof(de)) == sizeof(de)){
            if (de.inum == 0 || !strcmp(de.name, ".") || !strcmp(de.name, "..")) continue;
            memmove(p, de.name, MAX_NAME);
            p[MAX_PATH] = '\0';
            if (stat(buf, &st) < 0){
                printf("cannot stat %s\n", buf);
                continue;
            }																																				
            if (st.type == T_DIR){
				(*dir_num)++;
				// printf("now_buf:%s\n", buf);
                traverse(buf, key, file_num, dir_num, 0);
            }
			else{
                (*file_num)++;
                int count = 0;
                countOccurrences(buf, key, &count);
                printf("%s %d\n", buf, count);
            }
        }
    }
    close(fd);
}

int main(int argc, char *argv[]) {

    int p[2];
    pipe(p);

    int pid = fork();
	if (pid == 0) { // Child process
        close(p[0]); // Close read end 
        int file_num = 0, dir_num = 0;
        
		char path[MAX_PATH];
		char key[MAX_NAME];
		strcpy(path, argv[1]);
		strcpy(key, argv[2]);
		
        traverse(path, key, &file_num, &dir_num, 1);

        write(p[1], &file_num, sizeof(file_num));
        write(p[1], &dir_num, sizeof(dir_num));
        close(p[1]); // Close write end after sending data
        exit(1);
    } 
	else { // Parent process
        close(p[1]); // Close write end 
        wait(NULL); 

        int file_num, dir_num;
        read(p[0], &file_num, sizeof(file_num));
        read(p[0], &dir_num, sizeof(dir_num));
        
        printf("\n%d directories, %d files\n", dir_num, file_num);
        close(p[0]); // Close read end after receiving data
    }

    exit(1);
}
