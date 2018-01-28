#include <cstdio>
#include <cmath>
void Graphical(int petrol);
using namespace std;
int graph[19][19][19];
int main(){
  int N, petrol;
  scanf("%d", &N);
  for(int n = 0; n < N; ++n){
    scanf("%d", &petrol);
    printf("Scenario #%d:\n", n + 1);
    Graphical(petrol);
    printf("\n");
  }
  return 0;
}
void Graphical(int petrol){
  int sideways = 2 * petrol + 1;
  for(int i = 0; i < sideways; ++i){
    int rest =  i > petrol? 2 * petrol - i : i;
    printf("slice #%d:\n", i + 1);
    int cost = petrol + petrol;
    for(int j = 0; j < sideways; ++j){
      for(int k = 0; k < sideways; ++k){
        if(cost <= rest){
          printf("%d", petrol - rest + cost);
        }
        else{
          printf(".");
        }
        if(k >= petrol){
          cost += 1;
        }
        else{
          cost -= 1;
        }
      }
      printf("\n");
      if(j >= petrol){
        cost += 0;
      }
      else{
        cost -= 2;
      }
    }
  }
}
