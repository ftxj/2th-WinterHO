#include <WINSOCK2.H>
#include <stdio.h>
#pragma comment(lib,"ws2_32.lib")
void debug(int err);
int main()
{

       WORD banben;//WORD数据类型，无符号短整形，2字节
       WSADATA infor;//WASDATA数据类型，用来储存被WASStartup调用之后的数据
       banben=MAKEWORD(1,1);//makeword函数将两个数字当作二进制拼接，前一个数字为高八位，后一个为低八位
       int c;
       c=WSAStartup(banben,&infor);//协议库的版本信息，第一个参数为请求版本信息，第二个参数返回版本信息
       debug(c);//防止出错

       SOCKET client=socket(AF_INET,SOCK_STREAM,0);//创建socket，协议元：第一个参数：通信发生区域；国际网；第二个参数套接字类型（TCP流式）

       //绑定数据
       SOCKADDR_IN server;
       server.sin_addr.S_un.S_addr=inet_addr("127.0.0.1");
       server.sin_family=AF_INET;//协议族
       server.sin_port=htons(1234);

       connect(client,(SOCKADDR*)&server,sizeof(SOCKADDR));//开始连接


       char receive[200];
       recv(client,receive,101,0);
       printf("%s\n",receive);


       while(1){



            char a[100];
            scanf("%s",a);
            send(client,a,101,0);


            char receive[200];
            recv(client,receive,101,0);
            printf("myword:  %s\n",receive);
       }
       return 0;
}
void debug(int err){
    if (!err)
       {
              printf("                             欢迎来到我的终端聊天框!\n");
       }
       else
       {
              printf("客户端的嵌套字打开失败!\n");
       }

}
