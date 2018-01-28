#include <cstdio>
#include <cstring>
using namespace std;

int T[10001];
int ET[10001];
bool findRoot[10001];

int Anc[10001];
bool underGo[10001];
int testCase = 0;
int flag = 0;


void initDJS(int n){
  memset(Anc, 0, 10001 * sizeof(int));
  memset(underGo, false, 10001 * sizeof(bool));
  flag = 0;
  for(int i = 0; i <= n; ++i){
    Anc[i] = i;
  }
}

int find(int u){
  while(u != Anc[u]){
    u = Anc[u];
  }
  return u;
}

void merge(int u, int v){
  Anc[find(u)] = find(v);
}

int initialTree(int n){
  int edgeNum = n - 1;
  int st, ed;
  memset(findRoot, true, 10001 * sizeof(bool));
  memset(T, 0, 10001 * sizeof(int));
  memset(ET, 0, 10001 * sizeof(int));
  while(edgeNum){
    scanf("%d%d", &st, &ed);
    findRoot[ed] = false;
    if(T[st] == 0){
      T[st] = ed;
    }
    else{
      ET[ed] = T[st];
      T[st] = ed;
    }
    edgeNum--;
  }

  for(int i = 1; i <= n; ++i){
    if(findRoot[i] == true){
      return i;
    }
  }
}


void Tarjon(int node, int u, int v){
  int beg = T[node];
  for(int i = beg; i != 0; i = ET[i]){
    Tarjon(i, u, v);
    merge(i, node);
    underGo[i] = true;
  }

  if(node == u && flag == 0){
    if(underGo[v] == true){
      flag = 1;
      int res = find(v);
      printf("%d\n", res);
    }
  }
  else if(node == v && flag == 0){
    if(underGo[u] == true){
      flag = 1;
      int res = find(u);
      printf("%d\n", res);
    }
  }
}

int main(){
  int nodeNum = 0;
  int st, ed;
  scanf("%d", &testCase);
  while(testCase){
    scanf("%d", &nodeNum);
    int root = initialTree(nodeNum);
    initDJS(nodeNum);
    scanf("%d%d", &st, &ed);
    Tarjon(root, st, ed);
    testCase -= 1;
  }
  return 0;
}