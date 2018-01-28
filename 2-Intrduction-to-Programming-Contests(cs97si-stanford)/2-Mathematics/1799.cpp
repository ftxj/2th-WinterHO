/*
  给定两种圆，其中一种半径为R，另一种为r(R < r)
  求第一种圆最多可以装多少个第二种圆，第二种圆必须的圆心必须处在同一个圆上
*/

#include <cstdio>
#include <cmath>
#include <cstdlib>
const float EPS = 1e-8;
const float pi = 3.14159;
int main(){
  int N, n;
  float R, r, degree;
  scanf("%d", &N);
  for(int i = 0; i != N; ++i){
    scanf("%f%d", &R, &n);
    degree = 2 * pi / n;
    if(abs(degree - pi) < EPS)
      printf("Scenario #%d:\n%.3f\n", i + 1, R / 2);
    else if(abs(degree - 2 * pi) < EPS)
      printf("Scenario #%d:\n%.3f\n", i + 1, R);
    else{
      r = R * sin(degree / 2) / (1 + sin(degree / 2));
      printf("Scenario #%d:\n%.3f\n", i + 1, r);
    }
  }
  printf("\n");
  return 0;
}