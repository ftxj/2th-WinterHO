#include <cstdio>

int reverseInt(int a){
  int res = 0;
  while(a > 0){
    res = res * 10 + a % 10;
    a = a / 10;
  }
  return res;
}
using namespace std;
int main(){
  int lines, a, b, result;
  scanf("%d", &lines);
  for(int num = 0; num < lines; ++num){
    scanf("%d%d", &a, &b);
    result = reverseInt(reverseInt(a) + reverseInt(b));
    printf("%d\n", result);
  }
  return 0;
}