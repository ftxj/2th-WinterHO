#include <WINSOCK2.H>
#include <stdio.h>
#pragma comment(lib,"ws2_32.lib")

int main()
{
       int err;
       WORD versionRequired;
       WSADATA wsaData;
       versionRequired=MAKEWORD(1,1);
       err=WSAStartup(versionRequired,&wsaData);//Э���İ汾��Ϣ

       if (!err)
       {
              printf("        ��ӭʹ���ն˼�����!���ȴ򿪷���ˣ���\n");
       }
       else
       {
              printf("�ͻ��˵�Ƕ���ִ�ʧ��!\n");
              return 0;//����
       }


       SOCKET clientSocket=socket(AF_INET,SOCK_STREAM,0);

       //������
       SOCKADDR_IN clientsock_in;
       clientsock_in.sin_addr.S_un.S_addr=inet_addr("127.0.0.1");
       clientsock_in.sin_family=AF_INET;
       clientsock_in.sin_port=htons(1234);

       connect(clientSocket,(SOCKADDR*)&clientsock_in,sizeof(SOCKADDR));//��ʼ����


       char receiveBuf[100];
       recv(clientSocket,receiveBuf,101,0);
       printf("%s\n",receiveBuf);


       while(1){



            char a[100];
            gets(a);
            send(clientSocket,a,101,0);


            char receiveBuf[100];
            recv(clientSocket,receiveBuf,101,0);
            printf("��������%s\n",receiveBuf);
       }
       return 0;
}
