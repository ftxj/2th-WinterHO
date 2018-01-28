#include <cstdio>
using namespace std;
typedef struct heapElm {
  int res;
  int index;
} heapElm;

class heap{
public:
  heapElm* H;
  int size;
  int volm;
  void push(heapElm elm){
    if(size == volm){
      return;
    }
    H[size] = elm;
    int index = size;
    size++;
    while(index != 0 && H[father(index)].res > H[index].res){
      heapElm temp = H[father(index)];
      H[father(index)] = H[index];
      H[index] = temp;
      index = father(index);
    }
    return;
  }
  heapElm top(){
    return H[0];
  }
  void pop(){
    size--;
    H[0] = H[size];
    int index = 0;
    while( 
      (index < size - 1) && 
      (leftSon(index) < size  && H[leftSon(index)].res < H[index].res) || 
      (rightSon(index) < size && H[rightSon(index)].res < H[index].res)
      ){
      if((rightSon(index) < size && H[rightSon(index)].res > H[leftSon(index)].res) ||
        rightSon(index) >= size
        ){
        heapElm temp = H[leftSon(index)];
        H[leftSon(index)] = H[index];
        H[index] = temp;
        index = leftSon(index);
      }
      else{
        heapElm temp = H[rightSon(index)];
        H[rightSon(index)] = H[index];
        H[index] = temp;
        index = rightSon(index);
      }
    }
  }
private:
  int leftSon(int j){
    return j * 2 + 1;
  }
  int rightSon(int j){
    return 2 * (j + 1);
  }
  int father(int j){
    return j / 2 + j % 2 - 1;
  }
};


int len , num;
int main(){
  scanf("%d%d", &len, &num);
  char ** dna;
  dna = new char* [num];
  for(int i = 0; i < num; ++i){
    dna[i] = new char [len];
  }
  heap reslist;
  reslist.H = new heapElm [num];
  reslist.size = 0;
  reslist.volm = num;
  for(int i = 0; i < num; ++i){
    int A = 0, C = 0, G = 0, T = 0;
    int dnalen = len, res = 0;
    scanf("%s", dna[i]);
    for(int j = dnalen - 1; j >= 0; --j){
      switch(dna[i][j]){
        case 'A': A++; break;
        case 'C': C++; res += A; break;
        case 'G': G++; res += (A + C); break;
        case 'T': T++; res += (A + C + G); break;
      }
    }
    heapElm M;
    M.res = res;
    M.index = i;
    reslist.push(M);
  }

  //printf("\n");
  for(int i = 0; i < num; ++i){
    heapElm M = reslist.top();
    reslist.pop();
    printf("%s\n", dna[M.index]);
  }
  return 0;
}