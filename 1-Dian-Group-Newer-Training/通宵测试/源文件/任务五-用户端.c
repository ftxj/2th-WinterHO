#include <WINSOCK2.H>
#include <stdio.h>
#pragma comment(lib,"ws2_32.lib")

int main()
{
       int c;
       WORD banben;
       WSADATA infor;
       banben=MAKEWORD(1,1);
       c=WSAStartup(banben,&infor);//协议库的版本信息

       if (!c)
       {
              printf("        欢迎使用终端计算器!请先打开服务端！！\n");
       }
       else
       {
              printf("客户端的嵌套字打开失败!\n");
              return 0;//结束
       }


       SOCKET client=socket(AF_INET,SOCK_STREAM,0);

       //绑定数据
       SOCKADDR_IN server;
       server.sin_addr.S_un.S_addr=inet_addr("127.0.0.1");
       server.sin_family=AF_INET;
       server.sin_port=htons(1234);

       connect(client,(SOCKADDR*)&server,sizeof(SOCKADDR));//开始连接


       char receive[100];
       recv(client,receive,101,0);
       printf("%s\n",receive);


       while(1){



            char a[100];
            gets(a);
            send(client,a,101,0);


            char receive[100];
            recv(client,receive,101,0);
            printf("计算结果：%s\n",receive);
       }
       return 0;
}
