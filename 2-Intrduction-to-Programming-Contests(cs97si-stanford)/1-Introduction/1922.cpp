#include <cstdio>
#include <cmath>
int main(){
  int N;
  int Speed;
  int Time;
  while(scanf("%d", &N) && N != 0){
    double time = 1e6;
    for(int i = 0; i < N; ++i){
      scanf("%d%d", &Speed, &Time);
      if(Time >= 0){
        time = time > Time + 16200.0/Speed? Time + 16200.0/Speed : time;
      }
    }
    int t = ceil(time);
    printf("%d\n", t);
  }
  return 0;
}