/*
 * Name: Nissan Pow
 * Problem: CS341 A3 Q4f
 */
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

void printAnswer(int *A, int *choice, int idx) {
  int i = choice[idx];
  if (i != -1) {
    printAnswer(A, choice, i);
  }
  printf("%d\n", A[idx]);
}

int main() {
    int i, j, maxIdx, nels, *A, *R, *choice;

    scanf("%d", &nels);
    A = calloc(nels, sizeof(*A));
    R = calloc(nels, sizeof(*R));
    choice = calloc(nels, sizeof(*choice));

    // read in sequence
    for (i=0; i<nels; i+=1) {
      scanf("%d", &A[i]);
      choice[i] = -1;
    }

    // for each index i, find the length of the longest ascending subsequence 
    // ending in A[i]
    R[0] = 1;
    for (i=1; i<nels; i+=1) {
      maxIdx = -1;
      for (j=i-1; j>=0; j-=1) {
        if ( A[i] >= A[j] && R[j] > (maxIdx == -1 ? 0 : R[maxIdx]) ) maxIdx = j;
      }
      R[i] = (maxIdx == -1 ? 0 : R[maxIdx]) + 1;
      choice[i] = maxIdx;
    }

    // find index of last element in longest ascending subsequence
    maxIdx = 0;
    for (i=0; i<nels; i+=1) {
      if ( R[i] > R[maxIdx] ) maxIdx = i;
    }

    // display longest ascending subsequence
    printf("%d\n", R[maxIdx]);
    printAnswer(A, choice, maxIdx);

    // clean up
    free(A), free(R), free(choice);
    return 0;
}
