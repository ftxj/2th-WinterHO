#include <cstdio>
#include <cstring>
using namespace std;

struct trie{
public:
  int count;
  trie* next[127];
  bool exist;
  bool isbig;
};  

trie* creatNode(){
  trie* node = new trie [1];
  node->count = 0;
  node->isbig = false;
  node->exist = false;
  memset(node->next, 0, sizeof(node->next));
  return node;
}

void insert(trie* root, char* str){
  trie* node = root;
  char* p = str;
  int id = 0;
  while(*p != '\0'){
    if(*p == ' '){
      id = *p;
      if(node->next[id] == NULL){
        node->next[id] = creatNode();
      }
      node = node->next[id];
    }
    else if(*p >= 'A' && *p <= 'Z'){
      id = *p;
      if(node->next[id] == NULL){
        node->next[id] = creatNode();
      }
      node = node->next[id];
      node->isbig = true;
    }
    else{
      id = *p;
      if(node->next[id] == NULL){
        node->next[id] = creatNode();
      }
      node = node->next[id];
    }
    ++p;
  }
  node->exist = true;
  node->count += 1;
}


char S[30] ={""};


void DFS(trie* node, int k, int sum, char c){
  if(!node){
    return;
  }
  if(node->exist == true){
    printf("%s %.4lf\n", S, node->count * 100.0 / sum * 1.0);
  }
  for(int i = 0; i < 127; ++i){
    if(node->next[i]){
      if(i == ' '){
        S[k] = ' '; S[k + 1] = '\0';
        DFS(node->next[i], k + 1, sum, ' ');
      }
      else if(node->next[i]->isbig){
        S[k] = i; S[k + 1] = '\0';
        DFS(node->next[i], k + 1, sum, i + 'A');
      }
      else{
        S[k] = i ;S[k + 1] = '\0';
        DFS(node->next[i], k + 1, sum, i + 'a');
      }
    }
  }
}
int main(){
  trie* T = creatNode();
  int sum = 0;
  char str[30];
  while(gets(str) != NULL){
    insert(T, str);
    sum += 1;
  }
  DFS(T, 0, sum, 'a');
  return 0;
}