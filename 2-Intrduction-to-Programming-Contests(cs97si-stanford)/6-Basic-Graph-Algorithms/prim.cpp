#include <iostream>
#include <vector>
#include <queue>
using namespace std;
int n;
int Graph[100][100];
int dic[100];
int prim();
int main(){
  while(cin >> n){
    for(int i = 0; i < n; ++i){
      for(int j = 0; j < n; ++j){
        cin >> Graph[i][j];
      }
    }
    cout << prim() << endl;
  }
  return 0;
}

int prim(){
  for(int i = 0; i < n; ++i){
    dic[i] = Graph[0][i];
  }
  int res = 0;
  int num = 1;
  int min = -1, index = -1;
  while(num != n){
    min = -1, index = -1;
    for(int i = 0; i < n; ++i){
      if(dic[i] > 0){
        if(min == -1 || min > dic[i]){
          index = i;
          min = dic[i];
        }
      }
    }
    res += min;
    dic[index] = 0;
    for(int i = 0; i < n; ++i){
      if(dic[i] > Graph[index][i]){
        dic[i] = Graph[index][i];
      }
    }
    num++;
  }
  return res;
}