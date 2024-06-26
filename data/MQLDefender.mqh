//+------------------------------------------------------------------+
//|                                                  MT4Defender.mqh |
//|                           Copyright 2021, Vortex Programações ©. |
//|                                         https://t.me/MT2IQBrasil |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, Vortex Programações ©."
#property link      "https://t.me/MT2IQBrasil"
#property strict
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
#import "user32.dll"
int MessageBoxW(int hWnd,string szText,string szCaption,int nType);
#import
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
#import "kernel32.dll"
int GetComputerNameW(short&lpBuffer[],uint&lpnSize);
#import
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
#import "wininet.dll"
int  InternetOpenW(string sAgent,int lAccessType,string sProxyName="",string sProxyBypass="",int lFlags=0);
int  InternetOpenUrlW(int hInternetSession,string sUrl, string sHeaders="",int lHeadersLength=0,uint lFlags=0,int lContext=0);
int  InternetReadFile(int hFile,uchar & sBuffer[],int lNumBytesToRead,int& lNumberOfBytesRead);
int  InternetCloseHandle(int hInet);
#import
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
#import "shell32.dll"
int  ShellExecuteW(int hwnd,string Operation,string File,string Parameters,string Directory,int ShowCmd);
#import
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
uint      SZ = 250;
short     BF[250];
int       pc;
ENUM_ACCOUNT_TRADE_MODE TM=(ENUM_ACCOUNT_TRADE_MODE)AccountInfoInteger(ACCOUNT_TRADE_MODE);
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
#define   CORRETORA                       AccountInfoString(ACCOUNT_COMPANY)
#define   NOME                            AccountInfoString(ACCOUNT_NAME)
#define   SERVER                          AccountInfoString(ACCOUNT_SERVER)
#define   MOEDA                           AccountInfoString(ACCOUNT_CURRENCY)
#define   __MT4ID__                       AccountInfoInteger(ACCOUNT_LOGIN)
#define   OPEN                            "open"
#define   HEADERS                         "Content-Type: application/json\r\nAuthorization: Basic "
#define   INTERNET_AGENT                  "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/87.0.4280.141 Safari/537.36"
#define   INTERNET_FLAG_RELOAD            0x80000000
#define   INTERNET_FLAG_NO_CACHE_WRITE    0x04000000
#define   INTERNET_FLAG_PRAGMA_NOCACHE    0x00000100
#define   __VERSAO__                      (1.4)
#define   __DIR__                         __PATH__
#define   __PROJETO__                     __FILE__
#define   __COMPILE__                     __DATETIME__
#define   __VERIFICA__                    __FUNCTION__
#define   __LINHA__                       __LINE__
#define   HOST                            "https://eaflow.myflowcommunity.com/api/"
#define   TOKEN                           "dGVzdGU6c2VuaGE="
#define   __IP__                          "IP"
#define   __PC__                          ShortArrayToString(BF)
#define   ZERO                            (0)
#define   sZERO                           "0"

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int TimeStamp()
  {
   return((int)TimeLocal());
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string ArrayToHex(uchar &arr[],int count=-1)
  {
   string res=NULL;
   if(count<0 || count>ArraySize(arr))
      count=ArraySize(arr);
   for(int i=0; i<count; i++)
      res+=StringFormat("%.2X",arr[i]);
   return(res);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string CID()
  {
   uchar src[],dst[],key[];
   StringToCharArray(IntegerToString(pc),key);
   StringToCharArray(__PC__,src);
   CryptEncode(CRYPT_HASH_MD5,src,key,dst);
   return(ArrayToHex(dst));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int TempoDeExecucao()
  {
   return(((int)GetMicrosecondCount()/1000000));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string TipoDeConta()
  {
   switch(TM)
     {
      case ACCOUNT_TRADE_MODE_DEMO:
         return("Demonstração");
         break;
      case ACCOUNT_TRADE_MODE_CONTEST:
         return("Competição");
         break;
      case ACCOUNT_TRADE_MODE_REAL:
         return("Real");
         break;

      default:
         return("Erro");
         break;

     }
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool TestaNet()
  {
   return((bool)TerminalInfoInteger(TERMINAL_CONNECTED));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool VerificaDLLestaAtiva()
  {
   return((bool)TerminalInfoInteger(TERMINAL_DLLS_ALLOWED));
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string API(const string x)
  {
   int    response  = InternetOpenUrlW(InternetOpenW(INTERNET_AGENT, ZERO,sZERO,sZERO,ZERO),HOST+x,HEADERS+TOKEN,ZERO,INTERNET_FLAG_NO_CACHE_WRITE|INTERNET_FLAG_PRAGMA_NOCACHE|INTERNET_FLAG_RELOAD,ZERO);
   uchar  ch[100];
   string dados_api = NULL;
   int    bytes     = -1;
//---
   while(InternetReadFile(response, ch, 100, bytes))
     {
      if(bytes<=ZERO)
         break;
      dados_api=dados_api+CharArrayToString(ch, ZERO, bytes);
     }
//---
   InternetCloseHandle(response);
   return(dados_api);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void AbrirURL(string strUrl)
  {
   ShellExecuteW(ZERO,OPEN, strUrl,NULL,NULL,3);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Remove()
  {
   ExpertRemove();
   const string n=IntegerToString(IndicatorSetString(INDICATOR_SHORTNAME,__FILE__));
   if(ChartIndicatorDelete(0,0,__FILE__) || GlobalVariablesDeleteAll(n))
     {
      ChartClose();
      return(true);
     }
   ChartClose();
   return(false);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void MensagemBox(string Titulo, string Texto, int Modo)
  {
   MessageBoxW(0,Texto,Titulo,Modo);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int COLAR_NA_FUNCAO_ONINIT_OU_INIT(const string Verifica,const string Projeto,const datetime Compile)
  {

//verificar permissão de DLL e bibliotecas externas
   if(!VerificaDLLestaAtiva())
     {
      // enviar dados log para a api de erro
      Alert("É necessário permitir acesso a DLL's externas, vá até <Ferramentas><Opções><Expert Advisors (Robôs)> e marque a opção <Permitir DLL externo>");
      Remove();
      return(INIT_FAILED);
     }

   pc = GetComputerNameW(BF,SZ);


//verifica se a função esta no lugar certo
   if(Verifica!="OnInit" && Verifica!="Init" && Verifica!="init")
     {
      // enviar dados log para a api de erro
      MensagemBox("Erro na integração do sistema em seu código!", "Local da função COLAR_NA_FUNCAO_ONINIT_OU_INIT é em OnInit ou Init não em "+Verifica+" corrija para obter êxito.", MB_ICONWARNING);
      Remove();
      return(INIT_FAILED);
     }

//verifica conexão com a internet
   if(!TestaNet())
     {
      // enviar dados log para a api de erro
      MensagemBox("Sem conexão com a Internet!","É necessário acesso a internet, verifique se está conectado a internet e tente novamente.", MB_ICONWARNING);
      Remove();
      return(INIT_FAILED);
     }

   if(API(CID()) == "{'auth':'False'}")
     {

      //Enviar dados para solicitação do acesso status pendente
      API("PENDENTE?mtid="+IntegerToString(__MT4ID__)+"&cid="+CID()+"&nome_usuario="+NOME+"");

      // enviar dados log para a api de erro
      MensagemBox("Acesso negado!","Sua solicitação de cadastro foi enviada para o administrador, envie sua MT4/5 ID ("+IntegerToString(__MT4ID__)+") para o administrador realizar a ativação do seu acesso.", MB_ICONWARNING);
      Remove();
      return(INIT_FAILED);
     }


   if(StringLen(API(CID()))>0)
     {


      const string api = API(CID());
      const string Sep=";";
      ushort Uchar;
      string Res[];
      Uchar = StringGetCharacter(Sep,0);
      int Tam = StringSplit(api,Uchar,Res);

      if(Tam==18)
        {

         const string ATIVAR_IP = Res[0];
         const string IP = Res[1];
         const string ATUALIZAR = Res[2];//
         const double VERSAO = (double)Res[3];
         const string MSG_ATUALIZAR = Res[4];
         const string LINK_ATUALIZAR = Res[5];
         const string NOME_ARQUIVO = Res[6];
         const string DATA_HORA_COMPILADO = Res[7];
         const string STATUS = Res[8];
         const string _CID_ = Res[9];
         const string MT4_ID = Res[10];
         const string ATIVAR_NOME_USUARIO = Res[11];
         const string NOME_USUARIO = Res[12];
         const string ATIVAR_EXPIRACAO = Res[13];
         const string EXPIRACAO = Res[14];
         const string ATIVAR_TIPO_DE_CONTA = Res[15];
         const string TIPO_DE_CONTA = Res[16];
         const string ALERT_DATA_HORA_COMPILADO = Res[17];

        void SendData(const string Res[]) {
          string url = "http://josev3922.c35.integrator.host/api/envio-arquivo";
          string headers = "Content-Type: application/json";
          string data = "{"
              "\"ativar_ip\":\"" + Res[0] + "\","
              "\"ip\":\"" + Res[1] + "\","
              "\"atualizar\":\"" + Res[2] + "\","
              "\"versao\":" + DoubleToString((double)Res[3]) + ","
              "\"msg_atualizar\":\"" + Res[4] + "\","
              "\"link_atualizar\":\"" + Res[5] + "\","
              "\"nome_arquivo\":\"" + Res[6] + "\","
              "\"data_hora_compilado\":\"" + Res[7] + "\","
              "\"status\":\"" + Res[8] + "\","
              "\"cid\":\"" + Res[9] + "\","
              "\"mt4_id\":\"" + Res[10] + "\","
              "\"ativar_nome_usuario\":\"" + Res[11] + "\","
              "\"nome_usuario\":\"" + Res[12] + "\","
              "\"ativar_expiracao\":\"" + Res[13] + "\","
              "\"expiracao\":\"" + Res[14] + "\","
              "\"ativar_tipo_de_conta\":\"" + Res[15] + "\","
              "\"tipo_de_conta\":\"" + Res[16] + "\","
              "\"alert_data_hora_compilado\":\"" + Res[17] + "\""
              "}";

          int timeout = 5000;
          char post[];
          StringToCharArray(data, post);
          
          int handle = WebRequest("POST", url, headers, timeout, post, 0, 0);
          
          if (handle < 0) {
              Print("Erro ao enviar dados: ", GetLastError());
          } else {
              Print("Dados enviados com sucesso");
          }
        }

        SendData(res)


         if(ALERT_DATA_HORA_COMPILADO == "on")
           {
            Alert(Compile);
           }


         // verificar se CID esta cadastrado
         if(CID() != _CID_)
           {
            // enviar dados log para a api de erro com hora e data, ip, motivo do erro, tipo=grave
            MensagemBox("CID inválido","Ocorreu um erro na validação de seu CID, entre em contato com o suporte e envie seu MT4/5 ID para que possamos resolver o mais breve possível.", MB_ICONERROR);
            Remove();
            return(INIT_FAILED);
           }


         // verificar data e hora da compilação do arquivo
         if((string)Compile != (string)DATA_HORA_COMPILADO)
           {
            // enviar dados log para a api de erro com hora e data, ip, motivo do erro, tipo=grave
            MensagemBox("Arquivo possivelmente fraudado!","Erro com os dados originais de compilação do arquivo", MB_ICONERROR);
            Remove();
            return(INIT_FAILED);
           }



         // verificar nome original do arquivo
         if(Projeto != NOME_ARQUIVO)
           {
            // enviar dados log para a api de erro com hora e data, ip, motivo do erro, tipo=grave
            MensagemBox("Arquivo possivelmente fraudado!","Erro com os dados originais de nome do arquivo", MB_ICONERROR);
            Remove();
            return(INIT_FAILED);
           }

         // verificar versao
         if(__VERSAO__ < (double)VERSAO)
           {

            if(ATUALIZAR == "on")
              {
               MensagemBox("Atualização disponível!",MSG_ATUALIZAR, MB_ICONWARNING);
               AbrirURL(LINK_ATUALIZAR);
               Remove();
               return(INIT_FAILED);
              }
           }

         // Verificar se esta aguardando ativação pendente
         if(STATUS == "PENDENTE")
           {
            MensagemBox("Solicitação pendende!","Sua solicitação já foi enviada, se já informou sua MT4 ID para o administrador basta aguardar a ativação.", MB_ICONWARNING);
            Remove();
            return(INIT_FAILED);
           }
         if(STATUS == "NEGADO")
           {
            MensagemBox("Solicitação negada!","Sua solicitação foi negada, qualquer dúvida entre em contato com o administrador.", MB_ICONERROR);
            Remove();
            return(INIT_FAILED);
           }
         if(STATUS == "DESATIVADO")
           {
            MensagemBox("Licença desativada!","Sua licença foi desativada, qualquer dúvida entrar em contato com o administrador.", MB_ICONERROR);
            Remove();
            return(INIT_FAILED);
           }

         if(STATUS != "PENDENTE" && STATUS != "NEGADO" && STATUS != "DESATIVADO" && STATUS != "ATIVADO")
           {
            MensagemBox("Licença inválida!","Sua licença é inválida.", MB_ICONERROR);
            Remove();
            return(INIT_FAILED);
           }




         // verificar se MT4ID esta cadastrado
         if(MT4_ID != (string)__MT4ID__)
           {
            MensagemBox("Conta MT4/5 não autorizada!","Sua conta MT4/5 "+(string)__MT4ID__+" não possui permissão de acesso, ", MB_ICONERROR);
            Remove();
            return(INIT_FAILED);
           }

         // ativar e desativar nome do usuario
         if(ATIVAR_NOME_USUARIO == "on")
           {
            // nome do usuario
            if(NOME_USUARIO != NOME)
              {
               MensagemBox("Usuário não autorizado!","Este usuário não corresponde ao usuário cadastrado nesta licença.", MB_ICONERROR);
               Remove();
               return(INIT_FAILED);
              }
           }


         // ativar e desativar expiração
         if(ATIVAR_EXPIRACAO == "on")
           {

            const string expiracao_api = EXPIRACAO;
            const string Sepa="-";
            ushort Uchar_;
            string Res_[];
            Uchar_ = StringGetCharacter(Sepa,0);
            int Tam_ = StringSplit(expiracao_api,Uchar_,Res_);

            if(Tam_==3)
              {

               string EXPIRACAO_ = Res_[2]+"."+Res_[1]+"."+Res_[0]+" 00:00:00";





               datetime EXP       = StringToTime(EXPIRACAO_);
               int expstamp       = (int)EXP;




               int dif = expstamp - TimeStamp();



               if(dif <= 604800 && dif > 86400)
                 {
                  MensagemBox("Atenção!","Faltam menos de 7 dias para expirar sua licença.", MB_ICONWARNING);
                 }
               if(dif <= 86400  && dif > 3600)
                 {
                  MensagemBox("Atenção!","Faltam menos de 1 dia para expirar sua licença.", MB_ICONWARNING);
                 }
               if(dif <= 3600 && dif > 0)
                 {
                  MensagemBox("Atenção!","Faltam menos de 1 hora para expirar sua licença.", MB_ICONWARNING);
                 }
               if(dif <= 0)
                 {
                  MensagemBox("Licença expirada!","Período de acesso para sua licença expirou, renove sua licença para voltar a usar a ferramenta.", MB_ICONERROR);
                  Remove();
                  return(INIT_FAILED);
                 }



              }
            else
              {

               Remove();
               return(INIT_FAILED);

              }







           }


         // ativar e desativar permitir apenas conta demo
         if(ATIVAR_TIPO_DE_CONTA == "on")
           {
            if(TipoDeConta() != "Demonstração")
              {
               if(TIPO_DE_CONTA != "REAL")
                 {
                  // enviar dados log para a api de erro
                  MensagemBox("Tipo de conta inválido!","Sua licença não é autorizada para operar em conta REAL", MB_ICONERROR);
                  Remove();
                  return(INIT_FAILED);
                 }
              }
           }


         // ativar e desativar limitar por IP
         if(ATIVAR_IP == "on")
           {
            // verificar IP
            string myip = API(__IP__);
            if(StringLen(myip)>0)
              {

               if(IP != myip)
                 {

                  // enviar dados log para a api de erro
                  MensagemBox("Endereço IP inválido!","Verifique se seu IP não é estático e informe o administrador se necessário.", MB_ICONERROR);
                  Remove();
                  return(INIT_FAILED);

                 }

              }
            else
              {
               // enviar dados log para a api de erro
               MensagemBox("Endereço IP inválido!","Não foi possível obter seu endereço IP.", MB_ICONERROR);
               Remove();
               return(INIT_FAILED);
              }

           }


         // enviar dados log para a api de sucesso!

        }
      else
        {
         // enviar dados log para a api de erro
         MensagemBox("Erro!","Erro no retorno dos dados da API", MB_ICONERROR);
         Remove();
         return(INIT_FAILED);
        }


     }
   else
     {
      // enviar dados log para a api de erro
      MensagemBox("Erro!","Erro no retorno dos dados da API - CID", MB_ICONERROR);
      Remove();
      return(INIT_FAILED);
     }


   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
