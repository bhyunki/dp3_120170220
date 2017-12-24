#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#include"timer.h"

#define NUM 10000

__global__ void find_max(int *arr, int *max, int *min){
	int i;
	int idx= blockIdx.x*blockDim.x + threadIdx.x;

	for(i=(*max)/2; ; i/=2){
		if( idx < i ){
			if( arr[idx] < arr[idx+i] )
				arr[idx] = arr[idx+i];
		}
		else{
			if( arr[idx] < arr[idx-i] )
				arr[idx-i] = arr[idx];
		} // Make path divergency

		if( i%2!=0) break;				
	}
	for(int j=0; i<10; i++){
		if(arr[idx] < arr[idx+j])
			arr[idx]=arr[idx+j];
	}

	*min = arr[(*max)/2];
	*max = arr[0];
}

int main(int argc, char *argv[]){
	int *arr;
	int *d_arr, *d_m, *d_min;
	int max=0, i, n, min=0;
	double st, fn;

	srand(time(NULL));

	if( NUM%1024 != 0 )
		n = ((int)(NUM/1024)+1)*1024;


	arr=(int*)calloc(n, sizeof(int));
	for(i =0; i<n; i++)
		arr[i]=rand()%10000;

	cudaMalloc((void**)&d_arr, sizeof(int)*n);
	cudaMalloc((void**)&d_m, sizeof(int));
	cudaMalloc((void**)&d_min, sizeof(int));

	cudaMemcpy( d_arr, arr, sizeof(int)*NUM, cudaMemcpyHostToDevice);
	cudaMemcpy( d_m, &n, sizeof(int), cudaMemcpyHostToDevice);

	GET_TIME(st);

	find_max<<<10, 512>>>(d_arr, d_m, d_min);

	cudaMemcpy( &max, d_m, sizeof(int), cudaMemcpyDeviceToHost);
	cudaMemcpy( &min, d_min, sizeof(int), cudaMemcpyDeviceToHost);

	GET_TIME(fn);

	printf("%d %d\n", max, min);
	printf("Elapsed Time: %lf\n", fn-st);

	cudaFree(d_arr);
	cudaFree(d_m);
	free(arr);

	return 0;
}
