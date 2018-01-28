#include <stdio.h>
const float EPS = 1e-6;
int main(){
  float tex;
  while(1){
    scanf("%f", &tex);
    if(tex - 0 < EPS){
      break;
    }
    float length = 0;
    int num = 0;
    while(length < tex){
      num++;
      length += 1.0 / (num + 1);
    }
    printf("%d card(s)\n", num);
  }
  return 0;
}