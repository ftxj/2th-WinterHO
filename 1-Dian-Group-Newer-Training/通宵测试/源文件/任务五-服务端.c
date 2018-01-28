#include <WINSOCK2.H>
#include <stdio.h>
#include<stdlib.h>
#pragma comment(lib,"ws2_32.lib")
float math(int f,float a,float b);
int main()
{
       //创建套接字
       WORD banben;
       WSADATA infor;
       banben=MAKEWORD(1,1);//拼接低八位与高八位


       int c;
       c=WSAStartup(banben,&infor);//找到socket版本，返回



        //出错处理
       if (!c)
       {
              printf("计算机后台服务器已经打开！\n");

       }
       else
       {
              printf("没有成功打开socket!");
              return 0;
       }



       SOCKET server=socket(AF_INET,SOCK_STREAM,0);//创建套接字---协议


       //需要绑定的参数
       SOCKADDR_IN mation;
       mation.sin_family=AF_INET;//windows  tcp协议
       mation.sin_addr.S_un.S_addr=inet_addr("127.0.0.1");//绑定IP地址
       mation.sin_port=htons(1234);//htons()返回一个网络字节顺序的值，绑定端口



       bind(server,(SOCKADDR*)&mation,sizeof(SOCKADDR));//绑定完成
       listen(server,5);//其中第二个参数代表能够接收的最多的连接，表明它愿意接收连接
                            //开始进行监听


       SOCKADDR_IN client;


        int len=sizeof(SOCKADDR);
        SOCKET serget=accept(server,(SOCKADDR*)&client,&len);//接受
        send(serget,"后台服务器成功打开\n请输入您要计算的式子（限定为两位数的加减乘除）\n(1代表+；2代表-；3代表*；4代表/；)\n例如 1 2 3 表示2+3：",100,0);

        int f,i;
        char t[20];
        char d[20];


       while (1)
       {

                char receive[100];

                int j=0;
                recv(serget,receive,101,0);
                printf("计算式 %s\n",receive);

                f=atoi(receive);

               for(i=2;receive[i]!=0x20;i++,j++)
                    *(t+j)=receive[i];
                    j=0;
                float a=atof(t);


                for(i=i+1;receive[i]!='\0';i++,j++)
                    *(d+j)=receive[i];
                    j=0;
                float b=atof(d);


                float x=math(f,a,b);
                char str[20];
                sprintf(str,"%f ",x);
                char str2[]="你的计算结果为：";
                strcat (str2,str);


                send(serget,str2,20,0);


       }
       return 0;
}


float math(int f,float a,float b){
    switch(f){
        case 1: return (a+b);
        case 2: return (a-b);
        case 3: return (a*b);
        case 4: return (a/b);
    }
}
