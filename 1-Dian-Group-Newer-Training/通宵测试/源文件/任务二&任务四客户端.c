#include <WINSOCK2.H>
#include <stdio.h>
#pragma comment(lib,"ws2_32.lib")
void debug(int err);
int main()
{

       WORD banben;//WORD�������ͣ��޷��Ŷ����Σ�2�ֽ�
       WSADATA infor;//WASDATA�������ͣ��������汻WASStartup����֮�������
       banben=MAKEWORD(1,1);//makeword�������������ֵ���������ƴ�ӣ�ǰһ������Ϊ�߰�λ����һ��Ϊ�Ͱ�λ
       int c;
       c=WSAStartup(banben,&infor);//Э���İ汾��Ϣ����һ������Ϊ����汾��Ϣ���ڶ����������ذ汾��Ϣ
       debug(c);//��ֹ����

       SOCKET client=socket(AF_INET,SOCK_STREAM,0);//����socket��Э��Ԫ����һ��������ͨ�ŷ������򣻹��������ڶ��������׽������ͣ�TCP��ʽ��

       //������
       SOCKADDR_IN server;
       server.sin_addr.S_un.S_addr=inet_addr("127.0.0.1");
       server.sin_family=AF_INET;//Э����
       server.sin_port=htons(1234);

       connect(client,(SOCKADDR*)&server,sizeof(SOCKADDR));//��ʼ����


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
              printf("                             ��ӭ�����ҵ��ն������!\n");
       }
       else
       {
              printf("�ͻ��˵�Ƕ���ִ�ʧ��!\n");
       }

}
