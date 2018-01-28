/*
                            *
                            *
        *                   *
        *                   *     *   *
        *                   *     *   *
*       *     *             *     *   *
*       *     * *     * *   *     * * *
*       *   * * *     * *   * *   * * * *
*     * * * * * *     * * * * *   * * * *     * *
* * * * * * * * * * * * * * * * * * * * * * * * * *
A B C D E F G H I J K L M N O P Q R S T U V W X Y Z
*/
#include <cstdio>
using namespace std;
int main(){
  char line[73];
  int histogram[26] = {0};
  int highest = 0;
  while(gets(line)){
    for(int i = 0; line[i] != '\0'; ++i){
      if(line[i] >= 'A' && line[i] <= 'Z'){
        histogram[line[i] - 'A'] += 1;
        highest = highest >= histogram[line[i] - 'A']? highest : histogram[line[i] - 'A'];
      }
    }
  }
  for(int i = highest; i > 0; --i){
    for(int j = 0; j < 26; ++j){
      if(histogram[j] >= i){
        printf("*");
      }
      else{
        printf(" ");
      }
      if(j == 25){
        printf("\n");
      }
      else{
        printf(" ");
      }
    }
  }
  printf("A B C D E F G H I J K L M N O P Q R S T U V W X Y Z");
}