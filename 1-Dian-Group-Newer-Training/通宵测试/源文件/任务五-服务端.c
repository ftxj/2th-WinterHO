#include <WINSOCK2.H>
#include <stdio.h>
#include<stdlib.h>
#pragma comment(lib,"ws2_32.lib")
float math(int f,float a,float b);
int main()
{
       //�����׽���
       WORD banben;
       WSADATA infor;
       banben=MAKEWORD(1,1);//ƴ�ӵͰ�λ��߰�λ


       int c;
       c=WSAStartup(banben,&infor);//�ҵ�socket�汾������



        //������
       if (!c)
       {
              printf("�������̨�������Ѿ��򿪣�\n");

       }
       else
       {
              printf("û�гɹ���socket!");
              return 0;
       }



       SOCKET server=socket(AF_INET,SOCK_STREAM,0);//�����׽���---Э��


       //��Ҫ�󶨵Ĳ���
       SOCKADDR_IN mation;
       mation.sin_family=AF_INET;//windows  tcpЭ��
       mation.sin_addr.S_un.S_addr=inet_addr("127.0.0.1");//��IP��ַ
       mation.sin_port=htons(1234);//htons()����һ�������ֽ�˳���ֵ���󶨶˿�



       bind(server,(SOCKADDR*)&mation,sizeof(SOCKADDR));//�����
       listen(server,5);//���еڶ������������ܹ����յ��������ӣ�������Ը���������
                            //��ʼ���м���


       SOCKADDR_IN client;


        int len=sizeof(SOCKADDR);
        SOCKET serget=accept(server,(SOCKADDR*)&client,&len);//����
        send(serget,"��̨�������ɹ���\n��������Ҫ�����ʽ�ӣ��޶�Ϊ��λ���ļӼ��˳���\n(1����+��2����-��3����*��4����/��)\n���� 1 2 3 ��ʾ2+3��",100,0);

        int f,i;
        char t[20];
        char d[20];


       while (1)
       {

                char receive[100];

                int j=0;
                recv(serget,receive,101,0);
                printf("����ʽ %s\n",receive);

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
                char str2[]="��ļ�����Ϊ��";
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
