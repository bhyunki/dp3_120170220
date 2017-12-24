CC = gcc
NVCC = nvcc
FLAG = -fopenmp

all:
	$(CC) -o matrix_host matrix_host.c
	$(CC) -o matrix_omp matrix_omp.c $(FLAG)
	$(NVCC) -o matrix_cuda matrix_cuda.cu

clean:
	rm -rf matrix_host
	rm -rf matrix_omp
	rm -rf matrix_cuda
