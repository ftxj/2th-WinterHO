#include <cstdio>
#include <map>
#include <string>
using namespace std;
int main(){
  map<string, int, less<string> > M;
  int sum = 0;
  string S;
  char tree[30];
  while(gets(tree) != NULL){
    S = tree;
    if(M.find(S) == M.end()){
      M[S] = 0;
    }
    M[S] += 1;
    ++sum;
  }
  for(map<string, int, less<string> >::iterator i = M.begin(); i != M.end(); ++i){
    printf("%s %.4lf\n",(*i).first.data(), (*i).second * 100.0 / sum);
  }
  return 0;
}