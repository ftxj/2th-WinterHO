  #include <cstdio>
  #include <iostream>
  using namespace std;
  char* mult(char* a, int len1, char* b, int len2, int* len);
  void pow(char* n, char* temp, int len1, int* len2,  int r);
  int main(){
    char s[9];
    int R;
    while(scanf("%s%d", s, &R) != EOF){  
      if(s[0] == '.'){
        for(int i = 7; i > 0; ++i){
          s[i] = s[i - 1];
        }
        s[0] = '0';
      }
      int dot = 0;
      char a[180] = {0};
      char b[180] = {0};
      int ll = 0;
      for(int i = 0; i < 7; ++i){
        if(s[i] == '.'){
          dot = i + 1;
        }
        if(s[i] == '\0'){
          ll = i - 1;
          if(dot == 0)
            ll = i;
          break;
        }
      }
      for(int i = ll, j = 0; i > 0;){
        if(s[j] != '.'){
          a[i] = s[j];
          i--;
          j++;
        }
        else{
          j++;
        }
      } 
      if(dot != 0){
        dot = ll - dot + 1;
        dot = dot * R;
      }
      //printf("%d %d\n", dot, ll);
      if(dot == 0 && s[0] == '0'){
        printf("0\n");
        continue;
      }
      for(int i = 1; i <= ll; ++i){
        a[i] -= '0';
      }
      int len = 0;
      pow(a, b, ll, &len, R);
      int ck = 1;
      for(int i = 1; i <= len; ++i){
        if(b[i] == 0 && dot != 0 && dot >= i){
          ck++;
        }
        else{
          break;
        }
      }
      for(int i = len; i > 0; i--){
        if(b[i] == 0 && i != dot){
          len--;
        }
        else{
          break;
        }
      }
      for(int i = len; i >= ck; --i){
        if(i == dot){
          printf(".");
        }
        printf("%c", b[i] + '0');
      }
      printf("\n");
    }
    return 0;
  }

  char* mult(char* a, int len1, char* b, int len2, int* len){
    char temp;
    char res[180] = {0};
    *len = 0;
    for(int i = 1; i <= len1; ++i){
      for(int j = 1; j <= len2; ++j){
        temp = a[i] * b[j];
        res[i + j - 1] += temp % 10;
        if(res[i + j - 1] >= 10){
          res[i + j] += res[i + j - 1] / 10;
          res[i + j - 1] = res[i + j - 1] % 10;
        }
        res[i + j] += temp / 10;
        if(i == len1 && j == len2){
          *len = res[i + j] == 0? i + j - 1 : i + j;
          int k = 0;
          int rand = res[i + j] / 10;
          while(rand > 0){
            res[i + j + 1 + k] = rand % 10;
            rand = rand / 10;
            k++;
          }
          len += k;
        }
      }
    }
    for(int i = *len; i >= 1; --i){
      a[i] = res[i];
    }
    return a;
  }

  void pow(char* n, char* temp, int len1, int* len2,  int r){
    if(r == 0){
      temp[1] = 1;
      *len2 = 1;
      return;
    }
    pow(n, temp, len1, len2, r / 2);
    if(r % 2 == 1){
      mult(temp, *len2, temp, *len2, len2);
      mult(temp, *len2,    n,  len1, len2);
      return;
    }
    else{
      mult(temp, *len2, temp, *len2, len2);
      return;
    }
  }