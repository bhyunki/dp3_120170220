CC =  gcc
NVCC = nvcc

all :
	$(CC) -o reduction_seq reduction_seq.c
	$(NVCC) -o reduction_cuda reduction_cuda.cu
	$(NVCC) -o reduction_div reduction_div.cu

clean :
	rm -rf reduction_seq
	rm -rf reduction_cuda
	rm -rf reduction_div
