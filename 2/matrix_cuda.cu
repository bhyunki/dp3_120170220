#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#include"timer.h"

#define N 1024

__global__ void matrix_mul(int *a, int *b, int *c){
	// a[][] * b[][] = c[][]
	// c is initiallized with 0

	int row = blockIdx.y * blockDim.y + threadIdx.y;
	int col = blockIdx.x * blockDim.x + threadIdx.x;
	int sum = 0;

	if( col<N && row<N){
		for(int i=0; i<N; i++){
			sum+=a[row*N+i]*b[i*N+col];
		}
		c[row*N+col]=sum;
	}
}

int main(int argc, char *argv[]){
	int *d_A, *d_B, *d_C;
	int *h_A, *h_B, *h_C;
	int i, j;
	double st, fn;
	dim3 block(4,4);
	dim3 grid(8,8);

	srand(time(NULL));

	h_A=(int*)calloc(N*N, sizeof(int));
	h_B=(int*)calloc(N*N, sizeof(int));
	h_C=(int*)calloc(N*N, sizeof(int));

	for(i=0; i<N; i++){
		for(j=0; j<N; j++){
			h_A[i*N+j]=rand()%10;
			h_B[i*N+j]=rand()%10;
		}
	}// host memory allocation and initialiization
	
	cudaMalloc((void**)&d_A, sizeof(int)*N*N);
	cudaMalloc((void**)&d_B, sizeof(int)*N*N);
	cudaMalloc((void**)&d_C, sizeof(int)*N*N);
 	// device memory allocation
	
	cudaMemcpy( d_A, h_A, sizeof(int)*N*N, cudaMemcpyHostToDevice);
	cudaMemcpy( d_B, h_B, sizeof(int)*N*N, cudaMemcpyHostToDevice);
	// copy matrix from host to device

	GET_TIME(st);

	matrix_mul<<<grid,block>>>(d_A, d_B, d_C);

	cudaMemcpy( h_C, d_C, sizeof(int)*N*N, cudaMemcpyDeviceToHost);
	// copy multiplication result from device to host

	GET_TIME(fn);

	printf("Elapsed Time : %lf\n", fn-st);

	cudaFree(d_A);
	cudaFree(d_B);
	cudaFree(d_C);
	free(h_A);
	free(h_B);
	free(h_C);

	return 0;
}
