#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <omp.h>
#include "timer.h"

#define MAX_NUM 25144
#define Input_File "words.txt"
#define Output_File "result.txt"

void Read_Dictionary(char **words){
	FILE *fd=fopen(Input_File, "r");

	for(int i=0; i<MAX_NUM; i++)
		fscanf(fd, "%s\n", &words[i][0]);

	fclose(fd);
}

char* Reverse(char *ptr){
	int l=strlen(ptr);
	char *tmp = (char*)calloc(l, sizeof(char));

	for(int i=0; i<l; i++){
		tmp[i]=ptr[l-1-i];
	}
	
	return tmp;
}

int Find_Palindrome(char **words, char *ptr){
	int f=-1;
	char *rvs;

	rvs = Reverse(ptr);

	for(int i=0; i<MAX_NUM; i++){
		f=strcmp(&words[i][0], rvs);
		if( f==0 )
			return 1;
	}

	return 0;
}

int main(int argc, char *argv[]){
	int i, j, ProcessNum;
	char **words;
	FILE *fd=fopen(Output_File, "w");
	double st, rd, fn;

	if( argc <2 ){
		printf("Usage : %s [# of threads]\n", argv[0]);
		return -1;
	}

	ProcessNum = atoi(argv[1]);

	omp_set_num_threads(ProcessNum);

	words=(char**)calloc(MAX_NUM, sizeof(char*));
	for(i=0; i<MAX_NUM; i++)
		words[i]=(char*)calloc(16, sizeof(char));

	GET_TIME(st);

	Read_Dictionary(words);

	GET_TIME(rd);

	#pragma omp parallel for
	for(i=0; i<MAX_NUM; i++)
	{
		char *ptr=&words[i][0];
		int find = Find_Palindrome(words, ptr);

		if( find == 1){
			#pragma omp critical
			fprintf(fd, "%s\n", ptr);
		}
	}

	GET_TIME(fn);
	fclose(fd);

	printf("Elapsed Read Time: %lf\n", rd-st);
	printf("Elapsed Process Time: %lf\n", fn-rd);

	return 0;
}
