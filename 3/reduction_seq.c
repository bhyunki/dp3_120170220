#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#include"timer.h"

#define NUM 10000

int find_max(int *arr){
	int max=0;

	for(int i=0; i<NUM; i++){
		if( max<arr[i] )
			max=arr[i];
	}

	return max;
}

int main(int argc, char *argv[]){
	int *arr;
	int max, i;
	double st, fn;

	srand(time(NULL));

	arr=(int*)calloc(NUM, sizeof(int));
	for(i =0; i<NUM; i++)
		arr[i]=rand()%10000;

	GET_TIME(st);

	max=find_max(arr);

	GET_TIME(fn);

	printf("%d\n", max);
	printf("Elapsed Time: %lf\n", fn-st);

	return 0;
}
