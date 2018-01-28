#include <stdio.h>

int main(){
  float sum = 0, a;
  for(int i = 0; i != 12; ++i){
    scanf("%f", &a);
    sum += a;
  }
  printf("$%.2f",sum / 12);
  return 0;
}