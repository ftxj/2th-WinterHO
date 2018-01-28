#include <WINSOCK2.H>
#include <stdio.h>
#pragma comment(lib,"ws2_32.lib")
void debug(int err);
int main()
{
       //创建套接字
       WORD banben;
       WSADATA infor;
       banben=MAKEWORD(1,1);//拼接低八位与高八位


       int c;
       c=WSAStartup(banben,&infor);//找到socket版本，返回



        //出错处理
       debug(c);


       SOCKET server=socket(AF_INET,SOCK_STREAM,0);//创建套接字---协议


       //需要绑定的参数
       SOCKADDR_IN client;
       client.sin_family=AF_INET;//windows  tcp协议
       client.sin_addr.S_un.S_addr=inet_addr("127.0.0.1");//绑定IP地址
       client.sin_port=htons(1234);//htons()返回一个网络字节顺序的值，绑定端口



       bind(server,(SOCKADDR*)&client,sizeof(SOCKADDR));//绑定完成
       listen(server,5);//其中第二个参数代表能够接收的最多的连接，表明它愿意接收连接
                            //开始进行监听


       SOCKADDR_IN clientsocket;


       int len=sizeof(SOCKADDR);
        SOCKET serConn=accept(server,(SOCKADDR*)&clientsocket,&len);//接受
        send(serConn,"服务器：请说出您的困惑，我将为您解答",100,0);


       while (1)
       {
                char sendBuf[100];
                char receiveBuf[200];


                recv(serConn,receiveBuf,201,0);
                printf("用户：  %s\n",receiveBuf);


                scanf("%s",sendBuf);
                send(serConn,sendBuf,101,0);


       }
       return 0;
}
void debug(int err){
    if (!err)
       {
              printf("服务台已经打开！\n");

       }
       else
       {
              printf("嵌套字未打开!");

       }
}
