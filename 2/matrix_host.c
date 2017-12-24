#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#include"timer.h"

#define N 1024

void matrix_mul(int **a, int **b, int **c){
	// a[][] * b[][] = c[][]
	// c is initiallized with 0

	for(int i=0; i<N; i++){
		for(int j=0; j<N; j++){
			for(int k=0; k<N; k++)
				c[i][j]+=a[i][k]*b[k][j];
		}
	}
}

int main(int argc, char *argv[]){

	int **A, **B, **C;
	int i, j;
	double st, fn;

	srand(time(NULL));

	A=(int**)calloc(N, sizeof(int*));
	for(i=0; i<N; i++)
		A[i]=(int*)calloc(N, sizeof(int));
	
	B=(int**)calloc(N, sizeof(int*));
	for(i=0; i<N; i++)
		B[i]=(int*)calloc(N, sizeof(int));
		
	C=(int**)calloc(N, sizeof(int*));
	for(i=0; i<N; i++)
		C[i]=(int*)calloc(N, sizeof(int));

	for(i=0; i<N; i++){
		for(j=0; j<N;j++){
			A[i][j]=rand()%10;
			B[i][j]=rand()%10;
		}
	}

	GET_TIME(st);

	matrix_mul(A, B, C);

	GET_TIME(fn);

	printf("Elapsed Time : %lf\n", fn-st);

//	for(i=0; i<N; i++){
//		for(j=0; j<N; j++)
//			printf("%2d ", C[i][j]);
//		printf("\n");
//	}

	return 0;
}
