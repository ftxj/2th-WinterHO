#include <WINSOCK2.H>
#include <stdio.h>
#pragma comment(lib,"ws2_32.lib")
void debug(int err);
int main()
{
       //�����׽���
       WORD banben;
       WSADATA infor;
       banben=MAKEWORD(1,1);//ƴ�ӵͰ�λ��߰�λ


       int c;
       c=WSAStartup(banben,&infor);//�ҵ�socket�汾������



        //������
       debug(c);


       SOCKET server=socket(AF_INET,SOCK_STREAM,0);//�����׽���---Э��


       //��Ҫ�󶨵Ĳ���
       SOCKADDR_IN client;
       client.sin_family=AF_INET;//windows  tcpЭ��
       client.sin_addr.S_un.S_addr=inet_addr("127.0.0.1");//��IP��ַ
       client.sin_port=htons(1234);//htons()����һ�������ֽ�˳���ֵ���󶨶˿�



       bind(server,(SOCKADDR*)&client,sizeof(SOCKADDR));//�����
       listen(server,5);//���еڶ������������ܹ����յ��������ӣ�������Ը���������
                            //��ʼ���м���


       SOCKADDR_IN clientsocket;


       int len=sizeof(SOCKADDR);
        SOCKET serConn=accept(server,(SOCKADDR*)&clientsocket,&len);//����
        send(serConn,"����������˵�����������ҽ�Ϊ�����",100,0);


       while (1)
       {
                char sendBuf[100];
                char receiveBuf[200];


                recv(serConn,receiveBuf,201,0);
                printf("�û���  %s\n",receiveBuf);


                scanf("%s",sendBuf);
                send(serConn,sendBuf,101,0);


       }
       return 0;
}
void debug(int err){
    if (!err)
       {
              printf("����̨�Ѿ��򿪣�\n");

       }
       else
       {
              printf("Ƕ����δ��!");

       }
}
