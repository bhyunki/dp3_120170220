OpenMP Programming
----
   Find Palindrome words in dictionary
   ```
   cd ./1/
   ```

   1. Source Codes
   ```
   palindrome.c : find palindrome using OpenMP with given number of threads
   ```
   2. Make
   ```
   make
   ```
   3. Execution
   ```
   ./palindrome [# of threads]

   ex. ./palindrome 10
   ```

CUDA Programming
----
   Matrix multiplication
   ```
   cd ./2/
   ```

   1. Source Code
   ```
   matrix_host.c : multiply two matrices using host cpu
   matrix_omp.c  : multiply two matrices parallely using OpenMP
   matrix_cuda.cu: multiply two matrices using CUDA
   ```
   2. Make
   ```
   make
   ```
   3. Execution
   ```
   ./matrix_host
   ./matrix_omp
   ./matrix_cuda
   ```

   Reduction algorithm finds the maximum
   ```
   cd ./3/
   ```
   1. Source Code
   ```
   reduction_seq.c  : Find maximum in an array sequentially using cpu
   reduction_cuda.cu: Find maximum in an array parallely using CUDA
   reduction_div.cu : Find maximum in an array using CUDA but with path divergency
   ```
   2. Make
   ```
   make
   ```
   3. Execution
   ```
   ./reduction_seq
   ./reduction_cuda
   ./reduction_div
   ```
