#include <cstdio>
using namespace std;
int main(){
  int N;
  int num = 0, start = 1;
  int sum = 0;
  scanf("%d", &N);
  for(int i = 1; i <= N; ++i){
    sum += i;
    while(sum > N){
      sum -= start;
      start++;
    }
    if(sum == N){
      sum -= start;
      start++;
      num++;
    }
  }
  printf("%d", num);
  return 0;
}