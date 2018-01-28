#include <cstdio>
#include <cstring>
using namespace std;
int Ans[10001][2];
int Depth[10001];
int main(){
  int testCase = 0;
  int nodeNum = 0;
  int st, to;
  scanf("%d", &testCase);
  while(testCase){
    scanf("%d", &nodeNum);
    memset(Ans, 0, 30 * 30 * sizeof(int));
    memset(Depth, 0, 30 * sizeof(int));

    for(int i = 1; i < nodeNum; ++i){
      scanf("%d%d", &st, &to);
      Ans[to][0] = to; Ans[to][1] = st;
      Ans[st][0] = st;
    }

    scanf("%d%d", &st, &to);
    Depth[st] += 1;
    Depth[to] += 1;
    while(st != to){
      st = Ans[st][1];
      if(st != 0)
        Depth[st] += 1;
      if(Depth[st] == 2){
        break;
      }
      to = Ans[to][1];
      if(to != 0)
        Depth[to] += 1;
      if(Depth[to] == 2){
        st = to;
        break;
      }
    }
    printf("%d\n", st);
    testCase -= 1;
  }
  return 0;
}