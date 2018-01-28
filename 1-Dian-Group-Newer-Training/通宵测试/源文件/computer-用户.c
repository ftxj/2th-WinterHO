#include <WINSOCK2.H>
#include <stdio.h>
#pragma comment(lib,"ws2_32.lib")

int main()
{
       int err;
       WORD versionRequired;
       WSADATA wsaData;
       versionRequired=MAKEWORD(1,1);
       err=WSAStartup(versionRequired,&wsaData);//协议库的版本信息

       if (!err)
       {
              printf("        欢迎使用终端计算器!请先打开服务端！！\n");
       }
       else
       {
              printf("客户端的嵌套字打开失败!\n");
              return 0;//结束
       }


       SOCKET clientSocket=socket(AF_INET,SOCK_STREAM,0);

       //绑定数据
       SOCKADDR_IN clientsock_in;
       clientsock_in.sin_addr.S_un.S_addr=inet_addr("127.0.0.1");
       clientsock_in.sin_family=AF_INET;
       clientsock_in.sin_port=htons(1234);

       connect(clientSocket,(SOCKADDR*)&clientsock_in,sizeof(SOCKADDR));//开始连接


       char receiveBuf[100];
       recv(clientSocket,receiveBuf,101,0);
       printf("%s\n",receiveBuf);


       while(1){



            char a[100];
            gets(a);
            send(clientSocket,a,101,0);


            char receiveBuf[100];
            recv(clientSocket,receiveBuf,101,0);
            printf("计算结果：%s\n",receiveBuf);
       }
       return 0;
}
