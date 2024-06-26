//+------------------------------------------------------------------+
//|                                                      EA Flow.mq4 |
//|                                  Copyright 2024, Flow Community. |
//|                                  https://www.myflowcommunity.com |
//+------------------------------------------------------------------+
#property strict
#property copyright "Copyright © 2024, Flow Community"
#property link      "http://myflowcommunity.com.br"
#property version "1.5"
#include <new flow\MQLDefender.mqh>


#resource "\\Experts\\EA FLOW\\botaoFechar2.bmp"
#resource "\\Experts\\EA FLOW\\botaoMaximizar2.bmp"
#resource "\\Experts\\EA FLOW\\botaoMinimizar2.bmp"
#resource "\\Experts\\EA FLOW\\botoesPause.bmp"
#resource "\\Experts\\EA FLOW\\botoesPause_FPreto.bmp"
#resource "\\Experts\\EA FLOW\\botoesPlay.bmp"
#resource "\\Experts\\EA FLOW\\botoesPlay_FPreto.bmp"

#resource "\\Experts\\EA FLOW\\logo_goldBot200_88.bmp"
#resource "\\Experts\\EA FLOW\\logo_goldBot200_88_FundoPreto.bmp"
#resource "\\Experts\\EA FLOW\\logo_PropFull200_88_FundoBranco.bmp"
#resource "\\Experts\\EA FLOW\\logo_PropFull200_88_FundoPreto.bmp"

enum Tipo_ResolucaoPainel
  {
   PAINEL_RESOLUCAO_FULL,
   PAINEL_RESULUCAO_MENOR,
  };


enum Tipo_FundoPainel
  {
   PAINEL_FUNDO_PRETO,
   PAINEL_FUNDO_BRANCO,
  };

enum Tipo_Meta
  {
   META_FINANCEIRA,
   META_PERCENTUAL_CONTA,
  };


string nomeRobo = "Flow Community";

bool Allow_BUY = TRUE;
bool Allow_SELL = TRUE;
bool EA_makes_first_order = TRUE;
bool Open_order_on_trend = FALSE;
int First_step = 30;
int Minimum_price_distance = 50;
int Move_step = 5;
int Distance_between_orders = 500;
double Maximum_allowed_loss = 100000.0;
double Close_loss_by_drawdown = 10.0;


extern double Order_lotsize = 0.01;                   // Lote
double Increase_lotsize_by = 0.0;
extern double Multiply_lotsize_by = 1.0;              // Multiplicador


int Round_lotsize_to_decimals = 2;
double Profit_for_closing_2_directions = 10.0;
double Profit_for_closing_1_direction = 50.0;
int Auto_calculated_profit = 150;
double Loss_for_closing = 1000000.0;
string __________ = "";
string Trailing_settings = "0-Off  1-Candles  2-Fractals  3-Points";
int Trailing_type = 0;
int Trailing_step = 20;
int Minimum_trailing_profit = 100;
int Padding_by_fractals_or_candles = 0;
int Timeframe_fractals_or_candles = 15;
string ___________ = "";
string Other_settings = "";
int Magic = 2024;
int Font_size = 10;
color Color_information = Black;
int Stoploss = 300;
int Takeprofit = 100;
string ____________ = "";
string Indicator_settings = "RSI";
bool Opening_1_order_on_indicators = TRUE;
int Oversold_zone = 20;
int Overbought_zone = 80;
int RSI_Period = 5;
int Timeframe_indicator = 0;
string _____________ = "";
string Trading_hours = "";
int StartHour = 2;
int EndHour = 21;
string ________________ = "";

string ComentOrder = "EA Flow";
string ______________ = "";





input bool inpUtilizarMetaDia = TRUE;                       // Utiliza Meta
input Tipo_Meta inpTipoMeta = META_PERCENTUAL_CONTA;        // Tipo Meta
input double inpMetaGainValorFin = 100.0;                   // Gain - Valor fin
input double inpMetaGainValorPerc = 0.30;                   // Gain - Valor %
input double inpLimiteLossValorFin = 200.0;                 // Limite Loss - Valor fin
input double inpLimiteLossValorPerc = 0.60;                  // Limite Loss - Valor %




string _________________ = "";
string PanelSettings = "";
string nomeSetup = "FLOW COMMUNITY";
Tipo_ResolucaoPainel TipoResolucaoPainel=PAINEL_RESOLUCAO_FULL;      // Tipo de resolucao do Painel
input Tipo_FundoPainel TipoFundoPainel = PAINEL_FUNDO_PRETO;              // Cor Fundo Painel
color CorContornoPainel = clrSteelBlue;
//input color CorFundoPainel = clrWhite;
color CorFonteCabecalho = clrLightGray;
color CorFonteDescricao = clrSlateGray;
color CorFonteResFechados = clrGoldenrod;
color CorFonteResAbertos = clrDimGray;
color CorFonteStatus = clrSteelBlue;


bool Gi_unused_312;
double G_tickvalue_316;
int Gi_324;
int Gi_unused_328 = 3456;
int G_acc_number_332;
int G_slippage_336;
string Gs_340;
//+------------------------------------------------------------------+
//|Global                                                            |
//+------------------------------------------------------------------+
double price_0;
double Ld_8;
double Ld_16;
double Ld_24;
double Ld_32;
double order_lots_40;
double price_48;
double price_56;
double price_64;
double price_72;
int Li_80;
int Li_84;
int Li_88;
int Li_92;
int cmd_96;
int ticket_100;
int ticket_104;
double price_108;
double price_116;
double price_124;
double price_132;
double price_140;
double price_148;
double Ld_156;
double Ld_164;
double price_172;
double price_180;
double price_188;
double Ld_196;
double Ld_204;
double price_212;
double lots_220;
double irsi_228;
int pos_236;
int Li_8;
int Li_28;
int Li_32;
double lowest;
double highest;

bool roboLigadoBotao = true;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   COLAR_NA_FUNCAO_ONINIT_OU_INIT(__VERIFICA__,__PROJETO__,__COMPILE__);

   Gs_340 = " " + AccountCurrency();
   G_tickvalue_316 = MarketInfo(Symbol(), MODE_TICKVALUE);
   Timeframe_fractals_or_candles = f0_0(Timeframe_fractals_or_candles);
   if(Digits == 5 || Digits == 3)
      G_slippage_336 = 30;
   Comment("Grid");
   Gi_324 = (int)MarketInfo(Symbol(), MODE_STOPLEVEL);
   if(Distance_between_orders < Gi_324)
     {
      Alert("Distance_between_orders less STOPLEVEL, changed to ", Gi_324);
      Distance_between_orders = Gi_324;
     }
   if(First_step < Gi_324)
     {
      Alert("First_step less STOPLEVEL, changed to ", Gi_324);
      First_step = Gi_324;
     }
   int y_0 = Font_size + Font_size / 2;

   Close_loss_by_drawdown = -1.0 * Close_loss_by_drawdown;
   Maximum_allowed_loss = -1.0 * Maximum_allowed_loss;
   Loss_for_closing = -1.0 * Loss_for_closing;

   if(!MQLInfoInteger(MQL_TESTER))
      roboLigadoBotao = false;

   CriarPainel(50,500);
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   ObjectsDeleteAll(0);

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
   AtualizarPainel();


   if(roboLigadoBotao && MetaDiariaAtingida())
     {
      Zerar_Posicoes_decrescente(Magic);
      CancelaOrdens(Magic);
      roboLigadoBotao = false;
      ObjectSetInteger(0,"botaoPlay",OBJPROP_STATE,false);
     }

   if(!roboLigadoBotao)
     {
      Zerar_Posicoes_decrescente(Magic);
      CancelaOrdens(Magic);
     }

   if(!roboLigadoBotao)
      return;
//---

   Ld_16 = 0;
   Li_88 = 0;
   Li_92 = 0;
   Li_80 = 0;
   Ld_24 = 0;
   Ld_164 = 0;
   Li_84 = 0;
   Ld_32 = 0;
   Ld_156 = 0;
   price_116 = 0;
   price_108 = 0;
   price_132 = 0;
   price_124 = 0;
   Ld_8 = 0;
   ticket_100=0;
   ticket_104 = 0;
   lowest = 0;
   highest = 0;
   for(pos_236 = 0; pos_236 < OrdersTotal(); pos_236++)
     {
      if(OrderSelect(pos_236, SELECT_BY_POS, MODE_TRADES))
        {
         if(OrderSymbol() == Symbol() && Magic == OrderMagicNumber())
           {
            cmd_96 = OrderType();
            order_lots_40 = OrderLots();
            price_0 = NormalizeDouble(OrderOpenPrice(), Digits);
            price_64 = NormalizeDouble(OrderStopLoss(), Digits);
            price_72 = NormalizeDouble(OrderTakeProfit(), Digits);
            price_48 = price_64;
            price_56 = price_72;
            if(cmd_96 == OP_BUYSTOP)
              {
               Li_88++;
               if(price_108 < price_0 || price_108 == 0.0)
                  price_108 = price_0;
               ticket_100 = OrderTicket();
               price_140 = price_0;
               if(lowest == 0 || price_0 < lowest)
                 {
                  lowest = price_0;
                 }
              }
            if(cmd_96 == OP_SELLSTOP)
              {
               Li_92++;
               if(price_132 > price_0 || price_132 == 0.0)
                  price_132 = price_0;
               ticket_104 = OrderTicket();
               price_148 = price_0;
               if(highest == 0 || price_0 > highest)
                 {
                  highest = price_0;
                 }
              }
            if(cmd_96 == OP_BUY)
              {
               Li_80++;
               Ld_24 += order_lots_40;
               Ld_164 += price_0 * order_lots_40;
               if(price_108 < price_0 || price_108 == 0.0)
                  price_108 = price_0;
               if(price_116 > price_0 || price_116 == 0.0)
                  price_116 = price_0;
               Ld_16 += OrderProfit() + OrderSwap() + OrderCommission();
               if(price_64 == 0.0 && Stoploss >= Gi_324 && Stoploss != 0)
                  price_48 = NormalizeDouble(price_0 - Stoploss * Point, Digits);
               else
                  price_48 = price_64;
               if(price_72 == 0.0 && Takeprofit >= Gi_324 && Takeprofit != 0)
                  price_56 = NormalizeDouble(price_0 + Takeprofit * Point, Digits);
               else
                  price_56 = price_72;
               if((price_48 > price_64 || price_56 != price_72) && (price_48!=OrderStopLoss() || price_56 != OrderTakeProfit()))
                  if(!OrderModify(OrderTicket(), price_0, price_48, price_56, 0, White))
                     Print("Error OrderModify ", GetLastError(), " ", price_0, " ",price_48, " ",price_56);
              }
            if(cmd_96 == OP_SELL)
              {
               Li_84++;
               Ld_32 += order_lots_40;
               Ld_156 += price_0 * order_lots_40;
               if(price_132 > price_0 || price_132 == 0.0)
                  price_132 = price_0;
               if(price_124 < price_0 || price_124 == 0.0)
                  price_124 = price_0;
               Ld_8 += OrderProfit() + OrderSwap() + OrderCommission();
               if(price_64 == 0.0 && Stoploss >= Gi_324 && Stoploss != 0)
                  price_48 = NormalizeDouble(price_0 + Stoploss * Point, Digits);
               else
                  price_48 = price_64;
               if(price_72 == 0.0 && Takeprofit >= Gi_324 && Takeprofit != 0)
                  price_56 = NormalizeDouble(price_0 - Takeprofit * Point, Digits);
               else
                  price_56 = price_72;
               if((price_48 < price_64 || (price_64 == 0.0 && price_48 != 0.0) || price_56 != price_72) && (price_48!=OrderStopLoss() || price_56 != OrderTakeProfit()))
                  if(!OrderModify(OrderTicket(), price_0, price_48, price_56, 0, White))
                     Print("Error OrderModify ", GetLastError());
              }
           }
        }
     }
   ObjectDelete("SLb");
   ObjectDelete("SLs");
   if(Li_80 > 0)
     {
      price_172 = NormalizeDouble(Ld_164 / Ld_24, Digits);
      ObjectCreate("SLb", OBJ_ARROW, 0, Time[0], price_172, 0, 0, 0, 0);
      ObjectSet("SLb", OBJPROP_ARROWCODE, SYMBOL_RIGHTPRICE);
      ObjectSet("SLb", OBJPROP_COLOR, Blue);
     }
   if(Li_84 > 0)
     {
      price_180 = NormalizeDouble(Ld_156 / Ld_32, Digits);
      ObjectCreate("SLs", OBJ_ARROW, 0, Time[0], price_180, 0, 0, 0, 0);
      ObjectSet("SLs", OBJPROP_ARROWCODE, SYMBOL_RIGHTPRICE);
      ObjectSet("SLs", OBJPROP_COLOR, Red);
     }
   if(Trailing_type != 0)
     {
      for(pos_236 = 0; pos_236 < OrdersTotal(); pos_236++)
        {
         if(OrderSelect(pos_236, SELECT_BY_POS, MODE_TRADES))
           {
            if(OrderSymbol() == Symbol() && Magic == OrderMagicNumber())
              {
               cmd_96 = OrderType();
               price_64 = NormalizeDouble(OrderStopLoss(), Digits);
               price_0 = NormalizeDouble(OrderOpenPrice(), Digits);
               price_48 = price_64;
               if(cmd_96 == OP_BUY)
                 {
                  price_188 = f0_3(1, Bid, Trailing_type);
                  if(price_188 >= price_172 + Minimum_trailing_profit * Point && price_188 > price_64 + Trailing_step * Point && (Bid - price_188) / Point > Gi_324)
                     price_48 = price_188;
                  if(price_48 > price_64)
                     if(!OrderModify(OrderTicket(), price_0, price_48, OrderTakeProfit(), 0, White))
                        Print("Error ", GetLastError(), "   Trailing Modify Buy  SL ", price_64, "->", price_48);
                 }
               if(cmd_96 == OP_SELL)
                 {
                  price_188 = f0_3(-1, Ask, Trailing_type);
                  if((price_188 <= price_180 - Minimum_trailing_profit * Point && price_188 < price_64 - Trailing_step * Point) || (price_64 == 0.0 && (price_188 - Ask) / Point > Gi_324))
                     price_48 = price_188;
                  if((price_48 < price_64 || price_64 == 0.0) && price_48 != 0.0)
                     if(!OrderModify(OrderTicket(), price_0, price_48, OrderTakeProfit(), 0, White))
                        Print("Error ", GetLastError(), "   Trailing Modify Sell  SL ", price_64, "->", price_48, "  TP ");
                 }
              }
           }
        }
     }
   if(Auto_calculated_profit == 0)
     {
      Ld_196 = Profit_for_closing_1_direction;
      Ld_204 = Profit_for_closing_1_direction;
     }
   else
     {
      if(Ld_24 == 0.0)
         Ld_196 = Order_lotsize * Auto_calculated_profit * G_tickvalue_316;
      else
         Ld_196 = Ld_24 * Auto_calculated_profit * G_tickvalue_316;
      if(Ld_32 == 0.0)
         Ld_204 = Order_lotsize * Auto_calculated_profit * G_tickvalue_316;
      else
         Ld_204 = Ld_32 * Auto_calculated_profit * G_tickvalue_316;
     }
   if(Ld_16 > Close_loss_by_drawdown && Ld_8 > Close_loss_by_drawdown)
     {
      ObjectSetText("Char.op", CharToStr(251), Font_size + 2, "Wingdings", Black);
      if(Ld_16 >= Ld_196)
        {
         Print("Closure of Buy on Profit ", Ld_16);
         f0_2(1);
         return;
        }
      if(Ld_8 >= Ld_204)
        {
         Print("Closure of Sell on Profit ", Ld_8);
         f0_2(-1);
         return;
        }
     }
   else
     {
      ObjectSetText("Char.op", CharToStr(74), Font_size + 2, "Wingdings", Black);
      if(Ld_16 + Ld_8 >= Profit_for_closing_2_directions)
        {
         Print("Closing all orders in 2 directions ", Ld_16 + Ld_8);
         f0_2(0);
         return;
        }
     }
   if(Ld_16 <= Loss_for_closing)
     {
      Print("Closure of Buy on Loss ", Ld_16);
      f0_2(1);
      return;
     }
   if(Ld_8 <= Loss_for_closing)
     {
      Print("Closure of Sell on Loss ", Ld_8);
      f0_2(-1);
      return;
     }
   if(Ld_16 <= Maximum_allowed_loss)
     {
      Comment("Do not open the Buy");
      ObjectSetText("Char.b", CharToStr(225) + CharToStr(251), Font_size, "Wingdings", Red);
     }
   else
      ObjectSetText("Char.b", CharToStr(233), Font_size, "Wingdings", Black);
   if(Ld_8 <= Maximum_allowed_loss)
     {
      Comment("Do not open Sell");
      ObjectSetText("Char.s", CharToStr(226) + CharToStr(251), Font_size, "Wingdings", Red);
     }
   else
      ObjectSetText("Char.s", CharToStr(234), Font_size, "Wingdings", Black);
   if(Li_80 == 0 || Li_84 == 0)
      irsi_228 = iRSI(NULL, Timeframe_indicator, RSI_Period, PRICE_CLOSE, 0);
   if(Li_88 == 0 && Ld_16 > Maximum_allowed_loss && Allow_BUY)
     {
      if(Li_80 == 0)
        {
         if(irsi_228 < Oversold_zone || (!Opening_1_order_on_indicators))
            price_212 = NormalizeDouble(Ask + First_step * Point, Digits);
         else
            price_212 = 0;
        }
      else
        {
         price_212 = NormalizeDouble(Ask + Minimum_price_distance * Point, Digits);
         if(price_212 < NormalizeDouble(price_116 - Distance_between_orders * Point, Digits))
            price_212 = NormalizeDouble(Ask + Distance_between_orders * Point, Digits);
        }
      if((Li_80 == 0 || (price_108 != 0.0 && price_212 >= NormalizeDouble(price_108 + Distance_between_orders * Point, Digits) && Open_order_on_trend) || (price_116 != 0.0 &&
            price_212 <= NormalizeDouble(price_116 - Distance_between_orders * Point, Digits))) && price_212 > 0.0)
        {
         if(Li_80 == 0)
            lots_220 = Order_lotsize;
         else
            lots_220 = NormalizeDouble(Order_lotsize * MathPow(Multiply_lotsize_by, Li_80) + Li_80 * Increase_lotsize_by, Round_lotsize_to_decimals);
         if((lots_220 < AccountFreeMargin() / MarketInfo(Symbol(), MODE_MARGINREQUIRED) && Li_80 > 0) || EA_makes_first_order)
           {
            if(f0_6())
              {
               if(OrderSend(Symbol(), OP_BUYSTOP, lots_220, price_212, G_slippage_336, 0, 0, ComentOrder, Magic, 0, Blue) == -1)
                  Print("Impossible to place a BUYSTOP order with Lot ", DoubleToStr(lots_220, 2), " Price ", price_212, " Ask ", Ask);
               else
                  Comment("BUYSTOP order stopped since time is outside of trading hours!");
              }
           }
         else
            Comment("Impossible to set Lot ", DoubleToStr(lots_220, 2));
        }
     }
   if(Li_92 == 0 && Ld_8 > Maximum_allowed_loss && Allow_SELL)
     {
      if(Li_84 == 0)
        {
         if(irsi_228 > Overbought_zone || (!Opening_1_order_on_indicators))
            price_212 = NormalizeDouble(Bid - First_step * Point, Digits);
         else
            price_212 = 0;
        }
      else
        {
         price_212 = NormalizeDouble(Bid - Minimum_price_distance * Point, Digits);
         if(price_212 < NormalizeDouble(price_124 + Distance_between_orders * Point, Digits))
            price_212 = NormalizeDouble(Bid - Distance_between_orders * Point, Digits);
        }
      if((Li_84 == 0 || (price_132 != 0.0 && price_212 <= NormalizeDouble(price_132 - Distance_between_orders * Point, Digits) && Open_order_on_trend) || (price_124 != 0.0 &&
            price_212 >= NormalizeDouble(price_124 + Distance_between_orders * Point, Digits))) && price_212 > 0.0)
        {
         if(Li_84 == 0)
            lots_220 = Order_lotsize;
         else
            lots_220 = NormalizeDouble(Order_lotsize * MathPow(Multiply_lotsize_by, Li_84) + Li_84 * Increase_lotsize_by, Round_lotsize_to_decimals);
         if((lots_220 < AccountFreeMargin() / MarketInfo(Symbol(), MODE_MARGINREQUIRED) && Li_84 > 0) || EA_makes_first_order)
           {
            if(f0_6())
              {
               if(OrderSend(Symbol(), OP_SELLSTOP, lots_220, price_212, G_slippage_336, 0, 0, ComentOrder, Magic, 0, Red) == -1)
                  Print("Impossible to place a SELLSTOP order with Lot ", DoubleToStr(lots_220, 2), " Price ", price_212, " Bid ", Bid);
               else
                  Comment("SLLSTOP order stopped since time is outside of trading hours!");
              }
           }
         else
            Comment("Impossible to set Lot ", DoubleToStr(lots_220, 2));
        }
     }
   double Ld_240 = Ld_16 + Ld_8;
   if(price_140 != 0.0 && Allow_BUY)
     {
      bool newB = true;//NewBar();
      if(Li_80 == 0)
         price_212 = NormalizeDouble(Ask + First_step * Point, Digits);
      else
         price_212 = NormalizeDouble(Ask + Minimum_price_distance * Point, Digits);
      if((NormalizeDouble(price_140 - Move_step * Point, Digits) > price_212 && price_212 <= NormalizeDouble(price_116 - Distance_between_orders * Point, Digits)) || (price_116 == 0.0 && newB) ||
         (Open_order_on_trend && Li_80 == 0) || price_212 >= NormalizeDouble(price_108 + Distance_between_orders * Point, Digits) || (newB && price_116 > 0 && price_212 <= NormalizeDouble(price_116 - Distance_between_orders * Point,
               Digits)))
        {
         if(ticket_100 > 0 && (price_212  < lowest || lowest == 0))
           {
            if(!OrderModify(ticket_100, price_212, 0, 0, 0, White))
               Print("Error ", GetLastError(), "   Order Modify Buy   OOP ", price_140, "->", price_212);
            else
               Print("Order Buy Modify   OOP ", price_0, "->", price_212);
            Print("a ",price_212);
            Print("b ",price_108);
            //   Print("c ",(Open_order_on_trend && Li_80 == 0));
            //   Print("d ",price_212 >= NormalizeDouble(price_108 + Distance_between_orders * Point, Digits));
            //Print(price_212 <= NormalizeDouble(price_116 - Distance_between_orders * Point,Digits));
           }
        }
     }
   if(price_148 != 0.0 && Allow_SELL)
     {
      bool newB = true;//NewBar2();
      if(Li_84 == 0)
         price_212 = NormalizeDouble(Bid - First_step * Point, Digits);
      else
         price_212 = NormalizeDouble(Bid - Minimum_price_distance * Point, Digits);
      if((NormalizeDouble(price_148 + Move_step * Point, Digits) < price_212 && price_212 >= NormalizeDouble(price_124 + Distance_between_orders * Point, Digits)) || (price_124 == 0.0 && newB) ||
         (Open_order_on_trend && Li_84 == 0) || price_212 <= NormalizeDouble(price_132 - Distance_between_orders * Point, Digits) || (newB && price_124 > 0 && price_212 >= NormalizeDouble(price_124 +
               Distance_between_orders * Point, Digits)))
        {
         if(ticket_104 > 0 && (price_212 > highest || highest == 0))
           {
            if(!OrderModify(ticket_104, price_212, 0, 0, 0, White))
               Print("Error ", GetLastError(), "   Order Modify Sell   OOP ", price_148, "->", price_212);
            else
               Print("Order Sell Modify   OOP ", price_0, "->", price_212);
           }
        }
     }


  }
//+------------------------------------------------------------------+

// 441F2875E7D7BD4233BE798272C8614E
int f0_2(int Ai_0)
  {
   int error_4;
   int cmd_12;
   int count_16;
   bool Li_20 = TRUE;
   while(true)
     {
      for(int pos_24 = OrdersTotal() - 1; pos_24 >= 0; pos_24--)
        {
         if(OrderSelect(pos_24, SELECT_BY_POS))
           {
            if(OrderSymbol() == Symbol() && OrderMagicNumber() == Magic)
              {
               cmd_12 = OrderType();
               if((cmd_12 == OP_BUY && Ai_0 == 1) || Ai_0 == 0)
                 {
                  Li_20 = OrderClose(OrderTicket(), OrderLots(), NormalizeDouble(Bid, Digits), G_slippage_336, Blue);
                  if(Li_20)
                     Comment("Closed order N ", OrderTicket(), "  profit ", OrderProfit(), "     ", TimeToStr(TimeCurrent(), TIME_SECONDS));
                 }
               if((cmd_12 == OP_SELL && Ai_0 == -1) || Ai_0 == 0)
                 {
                  Li_20 = OrderClose(OrderTicket(), OrderLots(), NormalizeDouble(Ask, Digits), G_slippage_336, Red);
                  if(Li_20)
                     Comment("Closed order N ", OrderTicket(), "  profit ", OrderProfit(), "     ", TimeToStr(TimeCurrent(), TIME_SECONDS));
                 }
               if((cmd_12 == OP_BUYSTOP && Ai_0 == 1) || Ai_0 == 0)
                  Li_20 = OrderDelete(OrderTicket());
               if((cmd_12 == OP_SELLSTOP && Ai_0 == -1) || Ai_0 == 0)
                  Li_20 = OrderDelete(OrderTicket());
               if(!Li_20)
                 {
                  error_4 = GetLastError();
                  if(error_4 >= 2/* COMMON_ERROR */)
                    {
                     if(error_4 == 129/* INVALID_PRICE */)
                       {
                        Comment("Wrong price ", TimeToStr(TimeCurrent(), TIME_SECONDS));
                        RefreshRates();
                        continue;
                       }
                     if(error_4 == 146/* TRADE_CONTEXT_BUSY */)
                       {
                        if(!(IsTradeContextBusy()))
                           continue;
                        Sleep(2000);
                        continue;
                       }
                     Comment("Error ", error_4, " closing of the order N ", OrderTicket(), "     ", TimeToStr(TimeCurrent(), TIME_SECONDS));
                    }
                 }
              }
           }
        }
      count_16 = 0;
      int pos_24 = 0;
      for(pos_24 = 0; pos_24 < OrdersTotal(); pos_24++)
        {
         if(OrderSelect(pos_24, SELECT_BY_POS))
           {
            if(OrderSymbol() == Symbol() && OrderMagicNumber() == Magic)
              {
               cmd_12 = OrderType();
               if(cmd_12 == OP_BUYSTOP || (cmd_12 == OP_BUY && Ai_0 == 1) || Ai_0 == 0)
                  count_16++;
               if(cmd_12 == OP_SELLSTOP || (cmd_12 == OP_SELL && Ai_0 == -1) || Ai_0 == 0)
                  count_16++;
              }
           }
        }
      if(count_16 == 0)
         break;
      Li_8++;
      if(Li_8 > 10)
        {
         Alert(Symbol(), " Failed to close all trades, there are still ", count_16);
         return (0);
        }
      Sleep(1000);
      RefreshRates();
     }
   return (1);
  }

// 3B657219E43D9F65E0D9ABD6723021E4
int f0_1(bool Ai_0, int Ai_4, int Ai_8)
  {
   if(Ai_0)
      return (Ai_4);
   return (Ai_8);
  }

// 8B73C0300B4783F354728356BF7636BE
double f0_3(int Ai_0, double Ad_4, double A_pips_12)
  {
   double price_20 = 0;
   if(A_pips_12 > 2.0)
     {
      if(Ai_0 == 1)
         price_20 = NormalizeDouble(Ad_4 - A_pips_12 * Point, Digits);
      else
         price_20 = NormalizeDouble(Ad_4 + A_pips_12 * Point, Digits);
     }
   else
     {
      if(A_pips_12 == 2.0)
        {
         if(Ai_0 == 1)
           {
            for(Li_28 = 1; Li_28 < 100; Li_28++)
              {
               price_20 = iFractals(Symbol(), Timeframe_fractals_or_candles, MODE_LOWER, Li_28);
               if(price_20 != 0.0)
                 {
                  price_20 -= NormalizeDouble(Padding_by_fractals_or_candles * Point, Digits);
                  if(Ad_4 - Gi_324 * Point > price_20)
                     break;
                 }
               else
                  price_20 = 0;
              }
            ObjectDelete("FR Buy");
            ObjectCreate("FR Buy", OBJ_ARROW, 0, Time[Li_28], price_20 + Point, 0, 0, 0, 0);
            ObjectSet("FR Buy", OBJPROP_ARROWCODE, 218);
            ObjectSet("FR Buy", OBJPROP_COLOR, Red);
           }
         if(Ai_0 == -1)
           {
            for(Li_32 = 1; Li_32 < 100; Li_32++)
              {
               price_20 = iFractals(Symbol(), Timeframe_fractals_or_candles, MODE_UPPER, Li_32);
               if(price_20 != 0.0)
                 {
                  price_20 += NormalizeDouble(Padding_by_fractals_or_candles * Point, Digits);
                  if(Ad_4 + Gi_324 * Point < price_20)
                     break;
                 }
               else
                  price_20 = 0;
              }
            ObjectDelete("FR Sell");
            ObjectCreate("FR Sell", OBJ_ARROW, 0, Time[Li_32], price_20, 0, 0, 0, 0);
            ObjectSet("FR Sell", OBJPROP_ARROWCODE, 217);
            ObjectSet("FR Sell", OBJPROP_COLOR, Red);
           }
        }
      if(A_pips_12 == 1.0)
        {
         if(Ai_0 == 1)
           {
            for(Li_28 = 1; Li_28 < 500; Li_28++)
              {
               price_20 = NormalizeDouble(iLow(Symbol(), Timeframe_fractals_or_candles, Li_28) - Padding_by_fractals_or_candles * Point, Digits);
               if(price_20 != 0.0)
                 {
                  if(Ad_4 - Gi_324 * Point > price_20)
                     break;
                  price_20 = 0;
                 }
              }
            ObjectDelete("FR Buy");
            ObjectCreate("FR Buy", OBJ_ARROW, 0, iTime(Symbol(), Timeframe_fractals_or_candles, Li_28), price_20 + Point, 0, 0, 0, 0);
            ObjectSet("FR Buy", OBJPROP_ARROWCODE, 159);
            ObjectSet("FR Buy", OBJPROP_COLOR, Red);
           }
         if(Ai_0 == -1)
           {
            for(Li_32 = 1; Li_32 < 500; Li_32++)
              {
               price_20 = NormalizeDouble(iHigh(Symbol(), Timeframe_fractals_or_candles, Li_32) + Padding_by_fractals_or_candles * Point, Digits);
               if(price_20 != 0.0)
                 {
                  if(Ad_4 + Gi_324 * Point < price_20)
                     break;
                  price_20 = 0;
                 }
              }
            ObjectDelete("FR Sell");
            ObjectCreate("FR Sell", OBJ_ARROW, 0, iTime(Symbol(), Timeframe_fractals_or_candles, Li_32), price_20, 0, 0, 0, 0);
            ObjectSet("FR Sell", OBJPROP_ARROWCODE, 159);
            ObjectSet("FR Sell", OBJPROP_COLOR, Red);
           }
        }
     }
   if(Ai_0 == 1)
     {
      if(price_20 != 0.0)
        {
         ObjectDelete("SL Buy");
         ObjectCreate("SL Buy", OBJ_ARROW, 0, Time[0] + 60 * Period(), price_20, 0, 0, 0, 0);
         ObjectSet("SL Buy", OBJPROP_ARROWCODE, SYMBOL_RIGHTPRICE);
         ObjectSet("SL Buy", OBJPROP_COLOR, Blue);
        }
      if(Gi_324 > 0)
        {
         ObjectDelete("STOPLEVEL-");
         ObjectCreate("STOPLEVEL-", OBJ_ARROW, 0, Time[0] + 60 * Period(), Ad_4 - Gi_324 * Point, 0, 0, 0, 0);
         ObjectSet("STOPLEVEL-", OBJPROP_ARROWCODE, 4);
         ObjectSet("STOPLEVEL-", OBJPROP_COLOR, Blue);
        }
     }
   if(Ai_0 == -1)
     {
      if(price_20 != 0.0)
        {
         ObjectDelete("SL Sell");
         ObjectCreate("SL Sell", OBJ_ARROW, 0, Time[0] + 60 * Period(), price_20, 0, 0, 0, 0);
         ObjectSet("SL Sell", OBJPROP_ARROWCODE, SYMBOL_RIGHTPRICE);
         ObjectSet("SL Sell", OBJPROP_COLOR, Pink);
        }
      if(Gi_324 > 0)
        {
         ObjectDelete("STOPLEVEL+");
         ObjectCreate("STOPLEVEL+", OBJ_ARROW, 0, Time[0] + 60 * Period(), Ad_4 + Gi_324 * Point, 0, 0, 0, 0);
         ObjectSet("STOPLEVEL+", OBJPROP_ARROWCODE, 4);
         ObjectSet("STOPLEVEL+", OBJPROP_COLOR, Pink);
        }
     }
   return (price_20);
  }

// 3A62B06A167CFF5D9B2988F1B53DA68C
int f0_0(int Ai_0)
  {
   if(Ai_0 > 43200)
      return (0);
   if(Ai_0 > 10080)
      return (43200);
   if(Ai_0 > 1440)
      return (10080);
   if(Ai_0 > 240)
      return (1440);
   if(Ai_0 > 60)
      return (240);
   if(Ai_0 > 30)
      return (60);
   if(Ai_0 > 15)
      return (30);
   if(Ai_0 > 5)
      return (15);
   if(Ai_0 > 1)
      return (5);
   if(Ai_0 == 1)
      return (1);
   if(Ai_0 == 0)
      return (Period());
   return (0);
  }

// 9994BE04E21FE0D7130FAFE36FD7D8B4
string f0_4(int Ai_0)
  {
   if(Ai_0 == 1)
      return ("M1");
   if(Ai_0 == 5)
      return ("M5");
   if(Ai_0 == 15)
      return ("M15");
   if(Ai_0 == 30)
      return ("M30");
   if(Ai_0 == 60)
      return ("H1");
   if(Ai_0 == 240)
      return ("H4");
   if(Ai_0 == 1440)
      return ("D1");
   if(Ai_0 == 10080)
      return ("W1");
   if(Ai_0 == 43200)
      return ("MN1");
   return ("îøèáêà ïåðèîäà");
  }

// CCCC0B710200C5F727F28B5E2B990B7B
void f0_5(string A_name_0, string A_text_8, int A_x_16, int A_y_20, color A_color_24)
  {
   if(ObjectFind(A_name_0) == -1)
     {
      ObjectCreate(A_name_0, OBJ_LABEL, 0, 0, 0);
      ObjectSet(A_name_0, OBJPROP_CORNER, 1);
      ObjectSet(A_name_0, OBJPROP_XDISTANCE, A_x_16);
      ObjectSet(A_name_0, OBJPROP_YDISTANCE, A_y_20);
     }
   ObjectSetText(A_name_0, A_text_8, Font_size, "Arial", A_color_24);
  }

// F6690C448450A2C90FBFA7DD781BE412
int f0_6()
  {
   int hour_0 = TimeHour(TimeCurrent());
   if(StartHour == 0)
      StartHour = 24;
   if(EndHour == 0)
      EndHour = 24;
   if(hour_0 == 0)
      hour_0 = 24;
   if(StartHour < EndHour)
      if(hour_0 < StartHour || hour_0 >= EndHour)
         return (0);
   if(StartHour > EndHour)
      if(hour_0 < StartHour && hour_0 >= EndHour)
         return (0);
   return (1);
  }



//--- FUNÇÃO PARA OBTER A QUANTIDADE SOMADA DE TODAS AS POSIÇÕES COMPRADAS EM ANDAMENTO
double qtde_soma_todas_pos_compra(int magic_number)
  {
   double volumeOp = 0;

   for(int i =  OrdersTotal() - 1; i >= 0; i--)
     {
      if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
         continue;

      if(OrderSymbol() == _Symbol && OrderMagicNumber() == magic_number && OrderType() == OP_BUY)
        {
         volumeOp += OrderLots();
        }
     }

   return volumeOp;
  }

//--- FUNÇÃO PARA OBTER A QUANTIDADE SOMADA DE TODAS AS POSIÇÕES VENDIDAS EM ANDAMENTO
double qtde_soma_todas_pos_venda(int magic_number)
  {
   double volumeOp = 0;

   for(int i =  OrdersTotal() - 1; i >= 0; i--)
     {
      if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
         continue;

      if(OrderSymbol() == _Symbol && OrderMagicNumber() == magic_number && OrderType() == OP_SELL)
        {
         volumeOp += OrderLots();
        }
     }

   return volumeOp;
  }


//--- FUNÇÃO PARA OBTER A QUANTIDADE DE POSIÇÕES COMPRADAS EM ANDAMENTO
int num_pos_compra(int magic_number)
  {
   int count = 0;

   for(int i =  OrdersTotal() - 1; i >= 0; i--)
     {
      if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
         continue;

      if(OrderSymbol() == _Symbol && OrderMagicNumber() == magic_number && OrderType() == OP_BUY)
        {
         count ++;
        }
     }

   return count;
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int num_pos_venda(int magic_number)
  {
   int count = 0;

   for(int i =  OrdersTotal() - 1; i >= 0; i--)
     {
      if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
         continue;

      if(OrderSymbol() == _Symbol && OrderMagicNumber() == magic_number && OrderType() == OP_SELL)
        {
         count ++;
        }
     }

   return count;
  }

//--- FUNÇÃO PARA OBTER O LUCRO SOMADO DE TODAS AS POSIÇÕES DE COMPRA EM ANDAMENTO
double lucro_soma_todas_pos_compra(int magic_number)
  {
   double lucro=0;

   for(int i =  OrdersTotal() - 1; i >= 0; i--)
     {
      if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
         continue;

      if(OrderSymbol() == _Symbol && OrderMagicNumber() == magic_number && OrderType() == OP_BUY)
        {
         lucro += OrderProfit();
        }
     }

   return lucro;
  }

//--- FUNÇÃO PARA OBTER O LUCRO SOMADO DE TODAS AS POSIÇÕES DE VENDA EM ANDAMENTO
double lucro_soma_todas_pos_venda(int magic_number)
  {
   double lucro=0;

   for(int i =  OrdersTotal() - 1; i >= 0; i--)
     {
      if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
         continue;

      if(OrderSymbol() == _Symbol && OrderMagicNumber() == magic_number && OrderType() == OP_SELL)
        {
         lucro += OrderProfit();
        }
     }

   return lucro;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ApagarPainelGrande()
  {
   ObjectDelete("retangulo1op1");
   ObjectDelete("retangulo2op1");
   ObjectDelete("logoGoldBot");


   ObjectDelete("botaoMinimizar");
   ObjectDelete("retangulo1op1");
   ObjectDelete("botaoFechar");
   ObjectDelete("botaoPlay");
   ObjectDelete("tituloop1");
   ObjectDelete("titulo2op1");
   ObjectDelete("detalhe1op1");
   ObjectDelete("rotulo_timeframeop1");
   ObjectDelete("rotulo_horaop1");
   ObjectDelete("valor_timeframeop1");

   ObjectDelete("valor_horaservop1");
   ObjectDelete("rotulo_acertoop1");
   ObjectDelete("rotulo_lucroop1");
   ObjectDelete("rotulo_diaop1");
   ObjectDelete("rotulo_semanaop1");
   ObjectDelete("rotulo_mesop1");
   ObjectDelete("rotulo_totalop1");
   ObjectDelete("detalhe2op1");
   ObjectDelete("rotulo_posicaoop1");
   ObjectDelete("rotulo_n_posicaoop1");

   ObjectDelete("rotulo_n_volumeop1");
   ObjectDelete("rotulo_resultadoop1");
   ObjectDelete("detalhe3op1");
   ObjectDelete("valor_diaop1");
   ObjectDelete("valor_semanaop1");
   ObjectDelete("valor_mesop1");

   ObjectDelete("valor_totalop1");
   ObjectDelete("valor_lucrodiaop1");
   ObjectDelete("valor_lucrosemanaop1");
   ObjectDelete("valor_lucromesop1");
   ObjectDelete("valor_lucrototalop1");
   ObjectDelete("valor_tipoPosop1");
   ObjectDelete("valor_numPosop1");
   ObjectDelete("valor_qtdePosop1");

   ObjectDelete("valor_lucroPosop1");
   ObjectDelete("rotulo_status");

   ChartRedraw();

  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ApagarPainelPequeno()
  {
   ObjectDelete("retangulo1op1");
   ObjectDelete("retangulo2op1");
   ObjectDelete("logoGoldBot");

   ObjectDelete("botaoMaximizar");
   ObjectDelete("retangulo1op1");
   ObjectDelete("botaoFechar");
   ObjectDelete("botaoPlay");
   ObjectDelete("tituloop1");
   ObjectDelete("titulo2op1");
   ObjectDelete("detalhe1op1");
   ObjectDelete("rotulo_timeframeop1");
   ObjectDelete("rotulo_horaop1");
   ObjectDelete("valor_timeframeop1");
   ObjectDelete("valor_horaservop1");

   ObjectDelete("valor_lucroPosop1");
   ObjectDelete("rotulo_status");

   ChartRedraw();

  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CriarPainel(const int alinX = 10, const int alinY = 400)
  {


   if(TipoResolucaoPainel==PAINEL_RESOLUCAO_FULL)
     {

      CriarRetangulo(0,"retangulo1op1",0,alinX,alinY,350,390,CorContornoPainel,BORDER_SUNKEN,CORNER_LEFT_LOWER);

      color corFundo = TipoFundoPainel == PAINEL_FUNDO_BRANCO ? clrWhite : clrBlack;


      CriarRetangulo(0,"retangulo2op1",0,alinX + 5, alinY - 18,340,367,corFundo,BORDER_RAISED,CORNER_LEFT_LOWER);

      if(TipoFundoPainel == PAINEL_FUNDO_BRANCO)
         Criar_Bitmap(0,"logoGoldBot",0,alinX + 20,alinY - 120,"::Experts\\EA FLOW\\logo_PropFull200_88_FundoBranco.bmp","::Experts\\EA FLOW\\logo_PropFull200_88_FundoBranco.bmp",200,88,0,0,true,CORNER_LEFT_LOWER,ANCHOR_LEFT_LOWER);
      else
         Criar_Bitmap(0,"logoGoldBot",0,alinX + 20,alinY - 120,"::Experts\\EA FLOW\\logo_PropFull200_88_FundoPreto.bmp","::Experts\\EA FLOW\\logo_PropFull200_88_FundoPreto.bmp",200,88,0,0,true,CORNER_LEFT_LOWER,ANCHOR_LEFT_LOWER);



      Criar_Bitmap(0,"botaoMinimizar",0,alinX + 290,alinY - 18,"::Experts\\EA FLOW\\botaoMinimizar2.bmp","::Experts\\EA FLOW\\botaoMinimizar2.bmp",27,18,0,0,true,CORNER_LEFT_LOWER,ANCHOR_LEFT_LOWER);
      //Criar_Bitmap(0,"botaoMaximizar",0,300,382,"::Experts\\EA FLOW\\botaoMaximizar2.bmp","::Experts\\EA FLOW\\botaoMaximizar2.bmp",27,18,0,0,true,CORNER_LEFT_LOWER,ANCHOR_LEFT_LOWER);

      Criar_Bitmap(0,"botaoFechar",0,alinX + 318,alinY - 18,"::Experts\\EA FLOW\\botaoFechar2.bmp","::Experts\\EA FLOW\\botaoFechar2.bmp",27,18,0,0,true,CORNER_LEFT_LOWER,ANCHOR_LEFT_LOWER);


      if(TipoFundoPainel == PAINEL_FUNDO_BRANCO)
         Criar_Bitmap(0,"botaoPlay",0,alinX + 257,alinY - 110,"::Experts\\EA FLOW\\botoesPause.bmp","::Experts\\EA FLOW\\botoesPlay.bmp",71,73,0,0,true,CORNER_LEFT_LOWER,ANCHOR_LEFT_LOWER);
      else
         Criar_Bitmap(0,"botaoPlay",0,alinX + 257,alinY - 110,"::Experts\\EA FLOW\\botoesPause_FPreto.bmp","::Experts\\EA FLOW\\botoesPlay_FPreto.bmp",71,73,0,0,true,CORNER_LEFT_LOWER,ANCHOR_LEFT_LOWER);

      CriarEtiqueta(0,"tituloop1",0,alinX + 10,alinY - 2,CORNER_LEFT_LOWER,nomeSetup+" ID: "+string(Magic),"Arial",10,CorFonteCabecalho);
      CriarEtiqueta(0,"titulo2op1",0,alinX + 285,alinY - 2,CORNER_LEFT_LOWER,_Symbol,"Arial",10,CorFonteCabecalho,0,ANCHOR_RIGHT_UPPER);
      CriarRetangulo(0,"detalhe1op1",0,alinX + 5,alinY - 155,340,2,CorContornoPainel,BORDER_SUNKEN,CORNER_LEFT_LOWER);
      CriarEtiqueta(0,"rotulo_timeframeop1",0,alinX + 15, alinY - 130,CORNER_LEFT_LOWER,"Timeframe:","Arial",10,CorFonteDescricao);
      CriarEtiqueta(0,"rotulo_horaop1",0,alinX + 215,alinY - 130,CORNER_LEFT_LOWER,"Hora Serv.:","Arial",10,CorFonteDescricao);
      CriarEtiqueta(0,"valor_timeframeop1",0,alinX + 85,alinY - 130,CORNER_LEFT_LOWER,ObterTimeFrame(Period()),"Arial Black",9,CorFonteDescricao,0,ANCHOR_LEFT_UPPER);
      CriarEtiqueta(0,"valor_horaservop1",0,alinX + 280,alinY - 130,CORNER_LEFT_LOWER,TimeToString(TimeCurrent(),TIME_SECONDS),"Arial Black",9,CorFonteDescricao,0,ANCHOR_LEFT_UPPER);
      CriarEtiqueta(0,"rotulo_acertoop1",0,alinX + 130,alinY - 160,CORNER_LEFT_LOWER,"ACERTOS","Arial Black",9,CorFonteDescricao);
      CriarEtiqueta(0,"rotulo_lucroop1",0,alinX + 250,alinY - 160,CORNER_LEFT_LOWER,"LUCRO "+string(SymbolInfoString(_Symbol,SYMBOL_CURRENCY_PROFIT)),"Arial Black",9,CorFonteDescricao);
      CriarEtiqueta(0,"rotulo_diaop1",0,alinX + 15,alinY - 178,CORNER_LEFT_LOWER,"DIA","Arial",10,CorFonteDescricao);
      CriarEtiqueta(0,"rotulo_semanaop1",0,alinX + 15,alinY - 196,CORNER_LEFT_LOWER,"SEMANA","Arial",10,CorFonteDescricao);
      CriarEtiqueta(0,"rotulo_mesop1",0,alinX + 15,alinY - 214,CORNER_LEFT_LOWER,"MÊS","Arial",10,CorFonteDescricao);
      CriarEtiqueta(0,"rotulo_totalop1",0,alinX + 15,alinY - 232,CORNER_LEFT_LOWER,"TOTAL","Arial",10,CorFonteDescricao);
      CriarRetangulo(0,"detalhe2op1",0,alinX + 5,alinY - 255,340,2,CorContornoPainel,BORDER_SUNKEN,CORNER_LEFT_LOWER);
      CriarEtiqueta(0,"rotulo_posicaoop1",0,alinX + 15,alinY - 260,CORNER_LEFT_LOWER,"Posição","Arial",10,CorFonteDescricao);
      CriarEtiqueta(0,"rotulo_n_posicaoop1",0,alinX + 15,alinY - 285,CORNER_LEFT_LOWER,"Número Posições","Arial",10,CorFonteDescricao);
      CriarEtiqueta(0,"rotulo_n_volumeop1",0,alinX + 15,alinY - 310,CORNER_LEFT_LOWER,"Volume total","Arial",10,CorFonteDescricao);
      CriarEtiqueta(0,"rotulo_resultadoop1",0,alinX + 15,alinY - 335,CORNER_LEFT_LOWER,"Resultado","Arial",10,CorFonteDescricao);
      CriarRetangulo(0,"detalhe3op1",0,alinX + 5,alinY - 355,340,2,CorContornoPainel,BORDER_SUNKEN,CORNER_LEFT_LOWER);

      string txacertoDia;
      string txacertoSemana;
      string txacertoMes;
      string txacertoTotal;

      string lucrodia;
      string lucrosemana;
      string lucromes;
      string lucrototal;

      double txacertoDiavalor;
      double txacertoSemanavalor;
      double txacertoMesvalor;
      double txacertoTotalvalor;

      int acertos_dia;
      int total_operacao_dia;
      int acertos_semana;
      int total_operacao_semana;
      int acertos_mes;
      int total_operacao_mes;
      int acertos_total;
      int total_operacao_total;


      acertos_dia = Ganhos_n_operacao_periodoDia(Magic);
      total_operacao_dia = N_operacao_periodoDia(Magic);

      acertos_semana = Ganhos_n_operacao_periodoSemana(Magic);
      total_operacao_semana = N_operacao_periodoSemana(Magic);

      acertos_mes = Ganhos_n_operacao_periodoMes(Magic);
      total_operacao_mes = N_operacao_periodoMes(Magic);

      acertos_total = Ganhos_n_operacao_total(Magic);
      total_operacao_total = N_operacao_total(Magic);



      if(total_operacao_dia!=0)
         txacertoDiavalor = 100*((double)acertos_dia/(double)total_operacao_dia);
      else
         txacertoDiavalor = 0;

      if(total_operacao_semana!=0)
         txacertoSemanavalor = 100*((double)acertos_semana/(double)total_operacao_semana);
      else
         txacertoSemanavalor = 0;

      if(total_operacao_mes!=0)
         txacertoMesvalor = 100*((double)acertos_mes/(double)total_operacao_mes);
      else
         txacertoMesvalor = 0;

      if(total_operacao_total!=0)
         txacertoTotalvalor = 100*((double)acertos_total/(double)total_operacao_total);
      else
         txacertoTotalvalor = 0;


      lucrodia = DoubleToString(Lucro_periodoDia(Magic),2);
      lucrosemana = DoubleToString(Lucro_periodoSemana(Magic),2);
      lucromes = DoubleToString(Lucro_periodoMes(Magic),2);
      lucrototal = DoubleToString(Lucro_periodoTotal(Magic),2);


      txacertoDia = IntegerToString(acertos_dia)+string("/")+string(IntegerToString(total_operacao_dia))+string(" (")+string(DoubleToString(txacertoDiavalor,0))+string("%)");
      txacertoSemana = IntegerToString(acertos_semana)+string("/")+string(IntegerToString(total_operacao_semana))+string(" (")+string(DoubleToString(txacertoSemanavalor,0))+string("%)");
      txacertoMes = IntegerToString(acertos_mes)+string("/")+string(IntegerToString(total_operacao_mes))+string(" (")+string(DoubleToString(txacertoMesvalor,0))+string("%)");
      txacertoTotal = IntegerToString(acertos_total)+string("/")+string(IntegerToString(total_operacao_total))+string(" (")+string(DoubleToString(txacertoTotalvalor,0))+string("%)");

      CriarEtiqueta(0,"valor_diaop1",0,alinX + 140,alinY - 178,CORNER_LEFT_LOWER,txacertoDia,"Arial",10,CorFonteResFechados);
      CriarEtiqueta(0,"valor_semanaop1",0,alinX + 140,alinY - 196,CORNER_LEFT_LOWER,txacertoSemana,"Arial",10,CorFonteResFechados);
      CriarEtiqueta(0,"valor_mesop1",0,alinX + 140,alinY - 214,CORNER_LEFT_LOWER,txacertoMes,"Arial",10,CorFonteResFechados);
      CriarEtiqueta(0,"valor_totalop1",0,alinX + 140,alinY - 232,CORNER_LEFT_LOWER,txacertoTotal,"Arial",10,CorFonteResFechados);
      CriarEtiqueta(0,"valor_lucrodiaop1",0,alinX + 290,alinY - 178,CORNER_LEFT_LOWER,lucrodia,"Arial",10,CorFonteResFechados,0,ANCHOR_RIGHT_UPPER);
      CriarEtiqueta(0,"valor_lucrosemanaop1",0,alinX + 290,alinY - 196,CORNER_LEFT_LOWER,lucrosemana,"Arial",10,CorFonteResFechados,0,ANCHOR_RIGHT_UPPER);
      CriarEtiqueta(0,"valor_lucromesop1",0,alinX + 290,alinY - 214,CORNER_LEFT_LOWER,lucromes,"Arial",10,CorFonteResFechados,0,ANCHOR_RIGHT_UPPER);
      CriarEtiqueta(0,"valor_lucrototalop1",0,alinX + 290,alinY - 232,CORNER_LEFT_LOWER,lucrototal,"Arial",10,CorFonteResFechados,0,ANCHOR_RIGHT_UPPER);
      CriarEtiqueta(0,"valor_tipoPosop1",0,alinX + 310,alinY - 260,CORNER_LEFT_LOWER,DoubleToString(qtde_soma_todas_pos_compra(Magic),2)+" buy // "+DoubleToString(qtde_soma_todas_pos_venda(Magic),2)+" sell","Arial",10,CorFonteResAbertos,0,ANCHOR_RIGHT_UPPER);
      CriarEtiqueta(0,"valor_numPosop1",0,alinX + 310,alinY - 285,CORNER_LEFT_LOWER,IntegerToString(num_pos_compra(Magic))+" buy // "+IntegerToString(num_pos_venda(Magic))+" sell","Arial",10,CorFonteResAbertos,0,ANCHOR_RIGHT_UPPER);

      double volLiquido = qtde_soma_todas_pos_compra(Magic) - qtde_soma_todas_pos_venda(Magic);
      string volLiquidoStr = volLiquido > 0 ? DoubleToString(volLiquido,2)+" buy" : volLiquido < 0 ? DoubleToString(volLiquido*(-1),2)+" sell" : "-";

      CriarEtiqueta(0,"valor_qtdePosop1",0,alinX + 310,alinY - 310,CORNER_LEFT_LOWER,volLiquidoStr,"Arial Black",10,CorFonteResAbertos,0,ANCHOR_RIGHT_UPPER);
      CriarEtiqueta(0,"valor_lucroPosop1",0,alinX + 310,alinY - 335,CORNER_LEFT_LOWER,DoubleToString(lucro_soma_todas_pos_compra(Magic)+lucro_soma_todas_pos_venda(Magic),2),"Arial Black",10,CorFonteResAbertos,0,ANCHOR_RIGHT_UPPER);


      if(roboLigadoBotao)
         ObjectSetInteger(0,"botaoPlay",OBJPROP_STATE,true);
      else
         ObjectSetInteger(0,"botaoPlay",OBJPROP_STATE,false);

      string ligadoDesligado = ObjectGetInteger(0,"botaoPlay",OBJPROP_STATE) ? "LIGADO" : "DESLIGADO";
      CriarEtiqueta(0,"rotulo_status",0,alinX + 15,alinY - 360,CORNER_LEFT_LOWER,"Status: "+ligadoDesligado,"Arial",10,CorFonteStatus);




     }

   if(TipoResolucaoPainel==PAINEL_RESULUCAO_MENOR)
     {
      color corFundo = TipoFundoPainel == PAINEL_FUNDO_BRANCO ? clrWhite : clrBlack;
      CriarRetangulo(0,"retangulo1op1",0,alinX,alinY,400,390,CorContornoPainel,BORDER_SUNKEN,CORNER_LEFT_LOWER);
      CriarRetangulo(0,"retangulo2op1",0,alinX + 5,alinY-18,390,367,corFundo,BORDER_RAISED,CORNER_LEFT_LOWER);


      if(TipoFundoPainel == PAINEL_FUNDO_BRANCO)
         Criar_Bitmap(0,"logoGoldBot",0,alinX + 20,alinY - 120,"::Experts\\EA FLOW\\logo_PropFull200_88_FundoBranco.bmp","::Experts\\EA FLOW\\logo_PropFull200_88_FundoBranco.bmp",200,88,0,0,true,CORNER_LEFT_LOWER,ANCHOR_LEFT_LOWER);
      else
         Criar_Bitmap(0,"logoGoldBot",0,alinX + 20,alinY - 120,"::Experts\\EA FLOW\\logo_PropFull200_88_FundoPreto.bmp","::Experts\\EA FLOW\\logo_PropFull200_88_FundoPreto.bmp",200,88,0,0,true,CORNER_LEFT_LOWER,ANCHOR_LEFT_LOWER);



      Criar_Bitmap(0,"botaoMinimizar",0,alinX + 300+37,alinY - 18,"::Experts\\EA FLOW\\botaoMinimizar2.bmp","::Experts\\EA FLOW\\botaoMinimizar2.bmp",27,18,0,0,true,CORNER_LEFT_LOWER,ANCHOR_LEFT_LOWER);
      //Criar_Bitmap(0,"botaoMaximizar",0,300+20,382,"::Experts\\EA FLOW\\botaoMaximizar2.bmp","::Experts\\EA FLOW\\botaoMaximizar2.bmp",27,18,0,0,true,CORNER_LEFT_LOWER,ANCHOR_LEFT_LOWER);

      Criar_Bitmap(0,"botaoFechar",0,alinX + 328+37,alinY - 18,"::Experts\\EA FLOW\\botaoFechar2.bmp","::Experts\\EA FLOW\\botaoFechar2.bmp",27,18,0,0,true,CORNER_LEFT_LOWER,ANCHOR_LEFT_LOWER);


      if(TipoFundoPainel == PAINEL_FUNDO_BRANCO)
         Criar_Bitmap(0,"botaoPlay",0,alinX + 267 + 20,alinY - 110,"::Experts\\EA FLOW\\botoesPause.bmp","::Experts\\EA FLOW\\botoesPlay.bmp",71,73,0,0,true,CORNER_LEFT_LOWER,ANCHOR_LEFT_LOWER);
      else
         Criar_Bitmap(0,"botaoPlay",0,alinX + 267 + 20,alinY - 110,"::Experts\\EA FLOW\\botoesPause_FPreto.bmp","::Experts\\EA FLOW\\botoesPlay_FPreto.bmp",71,73,0,0,true,CORNER_LEFT_LOWER,ANCHOR_LEFT_LOWER);

      CriarEtiqueta(0,"tituloop1",0,alinX + 10,alinY - 2,CORNER_LEFT_LOWER,nomeSetup+" ID: "+string(Magic),"Arial",10,CorFonteCabecalho);
      CriarEtiqueta(0,"titulo2op1",0,alinX + 325,alinY - 2,CORNER_LEFT_LOWER,_Symbol,"Arial",10,CorFonteCabecalho,0,ANCHOR_RIGHT_UPPER);
      CriarRetangulo(0,"detalhe1op1",0,alinX + 5,alinY - 155,390,2,CorContornoPainel,BORDER_SUNKEN,CORNER_LEFT_LOWER);
      CriarEtiqueta(0,"rotulo_timeframeop1",0,alinX + 15,alinY - 130,CORNER_LEFT_LOWER,"Timeframe:","Arial",10,CorFonteDescricao);
      CriarEtiqueta(0,"rotulo_horaop1",0,alinX + 240,alinY - 130,CORNER_LEFT_LOWER,"Hora Serv.:","Arial",10,CorFonteDescricao);
      CriarEtiqueta(0,"valor_timeframeop1",0,alinX + 100,alinY - 130,CORNER_LEFT_LOWER,ObterTimeFrame(_Period),"Arial Black",8,CorFonteDescricao,0,ANCHOR_LEFT_UPPER);
      CriarEtiqueta(0,"valor_horaservop1",0,alinX + 325,alinY - 130,CORNER_LEFT_LOWER,TimeToString(TimeCurrent(),TIME_SECONDS),"Arial Black",8,CorFonteDescricao,0,ANCHOR_LEFT_UPPER);
      CriarEtiqueta(0,"rotulo_acertoop1",0,alinX + 130,alinY - 160,CORNER_LEFT_LOWER,"ACERTOS","Arial Black",8,CorFonteDescricao);
      CriarEtiqueta(0,"rotulo_lucroop1",0,alinX + 270,alinY - 160,CORNER_LEFT_LOWER,"LUCRO "+string(SymbolInfoString(_Symbol,SYMBOL_CURRENCY_PROFIT)),"Arial Black",8,CorFonteDescricao);
      CriarEtiqueta(0,"rotulo_diaop1",0,alinX + 15,alinY - 178,CORNER_LEFT_LOWER,"DIA","Arial",10,CorFonteDescricao);
      CriarEtiqueta(0,"rotulo_semanaop1",0,alinX + 15,alinY - 196,CORNER_LEFT_LOWER,"SEMANA","Arial",10,CorFonteDescricao);
      CriarEtiqueta(0,"rotulo_mesop1",0,alinX + 15,alinY - 214,CORNER_LEFT_LOWER,"MÊS","Arial",10,CorFonteDescricao);
      CriarEtiqueta(0,"rotulo_totalop1",0,alinX + 15,alinY - 232,CORNER_LEFT_LOWER,"TOTAL","Arial",10,CorFonteDescricao);
      CriarRetangulo(0,"detalhe2op1",0,alinX + 5,alinY - 255,390,2,CorContornoPainel,BORDER_SUNKEN,CORNER_LEFT_LOWER);
      CriarEtiqueta(0,"rotulo_posicaoop1",0,alinX + 15,alinY - 260,CORNER_LEFT_LOWER,"Posição","Arial",10,CorFonteDescricao);
      CriarEtiqueta(0,"rotulo_n_posicaoop1",0,alinX + 15,alinY - 285,CORNER_LEFT_LOWER,"Número Posições","Arial",10,CorFonteDescricao);
      CriarEtiqueta(0,"rotulo_n_volumeop1",0,alinX + 15,alinY - 310,CORNER_LEFT_LOWER,"Volume total","Arial",10,CorFonteDescricao);
      CriarEtiqueta(0,"rotulo_resultadoop1",0,alinX + 15,alinY - 335,CORNER_LEFT_LOWER,"Resultado","Arial",10,CorFonteDescricao);
      CriarRetangulo(0,"detalhe3op1",0,alinX + 5,alinY - 355,390,2,CorContornoPainel,BORDER_SUNKEN,CORNER_LEFT_LOWER);


      string txacertoDia;
      string txacertoSemana;
      string txacertoMes;
      string txacertoTotal;

      string lucrodia;
      string lucrosemana;
      string lucromes;
      string lucrototal;

      double txacertoDiavalor;
      double txacertoSemanavalor;
      double txacertoMesvalor;
      double txacertoTotalvalor;

      int acertos_dia;
      int total_operacao_dia;
      int acertos_semana;
      int total_operacao_semana;
      int acertos_mes;
      int total_operacao_mes;
      int acertos_total;
      int total_operacao_total;


      acertos_dia = Ganhos_n_operacao_periodoDia(Magic);
      total_operacao_dia = N_operacao_periodoDia(Magic);

      acertos_semana = Ganhos_n_operacao_periodoSemana(Magic);
      total_operacao_semana = N_operacao_periodoSemana(Magic);

      acertos_mes = Ganhos_n_operacao_periodoMes(Magic);
      total_operacao_mes = N_operacao_periodoMes(Magic);

      acertos_total = Ganhos_n_operacao_total(Magic);
      total_operacao_total = N_operacao_total(Magic);



      if(total_operacao_dia!=0)
         txacertoDiavalor = 100*((double)acertos_dia/(double)total_operacao_dia);
      else
         txacertoDiavalor = 0;

      if(total_operacao_semana!=0)
         txacertoSemanavalor = 100*((double)acertos_semana/(double)total_operacao_semana);
      else
         txacertoSemanavalor = 0;

      if(total_operacao_mes!=0)
         txacertoMesvalor = 100*((double)acertos_mes/(double)total_operacao_mes);
      else
         txacertoMesvalor = 0;

      if(total_operacao_total!=0)
         txacertoTotalvalor = 100*((double)acertos_total/(double)total_operacao_total);
      else
         txacertoTotalvalor = 0;


      lucrodia = DoubleToString(Lucro_periodoDia(Magic),2);
      lucrosemana = DoubleToString(Lucro_periodoSemana(Magic),2);
      lucromes = DoubleToString(Lucro_periodoMes(Magic),2);
      lucrototal = DoubleToString(Lucro_periodoTotal(Magic),2);


      txacertoDia = IntegerToString(acertos_dia)+string("/")+string(IntegerToString(total_operacao_dia))+string(" (")+string(DoubleToString(txacertoDiavalor,0))+string("%)");
      txacertoSemana = IntegerToString(acertos_semana)+string("/")+string(IntegerToString(total_operacao_semana))+string(" (")+string(DoubleToString(txacertoSemanavalor,0))+string("%)");
      txacertoMes = IntegerToString(acertos_mes)+string("/")+string(IntegerToString(total_operacao_mes))+string(" (")+string(DoubleToString(txacertoMesvalor,0))+string("%)");
      txacertoTotal = IntegerToString(acertos_total)+string("/")+string(IntegerToString(total_operacao_total))+string(" (")+string(DoubleToString(txacertoTotalvalor,0))+string("%)");

      CriarEtiqueta(0,"valor_diaop1",0,alinX + 140,alinY - 178,CORNER_LEFT_LOWER,txacertoDia,"Arial",10,CorFonteResFechados);
      CriarEtiqueta(0,"valor_semanaop1",0,alinX + 140,alinY - 196,CORNER_LEFT_LOWER,txacertoSemana,"Arial",10,CorFonteResFechados);
      CriarEtiqueta(0,"valor_mesop1",0,alinX + 140,alinY - 214,CORNER_LEFT_LOWER,txacertoMes,"Arial",10,CorFonteResFechados);
      CriarEtiqueta(0,"valor_totalop1",0,alinX + 140,alinY - 232,CORNER_LEFT_LOWER,txacertoTotal,"Arial",10,CorFonteResFechados);
      CriarEtiqueta(0,"valor_lucrodiaop1",0,alinX + 350,alinY - 178,CORNER_LEFT_LOWER,lucrodia,"Arial",10,CorFonteResFechados,0,ANCHOR_RIGHT_UPPER);
      CriarEtiqueta(0,"valor_lucrosemanaop1",0,alinX + 350,alinY - 196,CORNER_LEFT_LOWER,lucrosemana,"Arial",10,CorFonteResFechados,0,ANCHOR_RIGHT_UPPER);
      CriarEtiqueta(0,"valor_lucromesop1",0,alinX + 350,alinY - 214,CORNER_LEFT_LOWER,lucromes,"Arial",10,CorFonteResFechados,0,ANCHOR_RIGHT_UPPER);
      CriarEtiqueta(0,"valor_lucrototalop1",0,alinX + 350,alinY - 232,CORNER_LEFT_LOWER,lucrototal,"Arial",10,CorFonteResFechados,0,ANCHOR_RIGHT_UPPER);

      CriarEtiqueta(0,"valor_tipoPosop1",0,alinX + 350,alinY - 260,CORNER_LEFT_LOWER,DoubleToString(qtde_soma_todas_pos_compra(Magic),2)+" buy // "+DoubleToString(qtde_soma_todas_pos_venda(Magic),2)+" sell","Arial",10,CorFonteResAbertos,0,ANCHOR_RIGHT_UPPER);
      CriarEtiqueta(0,"valor_numPosop1",0,alinX + 350,alinY - 285,CORNER_LEFT_LOWER,IntegerToString(num_pos_compra(Magic))+" buy // "+IntegerToString(num_pos_venda(Magic))+" sell","Arial",10,CorFonteResAbertos,0,ANCHOR_RIGHT_UPPER);

      double volLiquido = qtde_soma_todas_pos_compra(Magic) - qtde_soma_todas_pos_venda(Magic);

      string volLiquidoStr = volLiquido > 0 ? DoubleToString(volLiquido,2)+" buy" : volLiquido < 0 ? DoubleToString(volLiquido*(-1),2)+" sell" : "-";

      CriarEtiqueta(0,"valor_qtdePosop1",0,alinX + 350,alinY - 310,CORNER_LEFT_LOWER,volLiquidoStr,"Arial Black",10,CorFonteResAbertos,0,ANCHOR_RIGHT_UPPER);
      CriarEtiqueta(0,"valor_lucroPosop1",0,alinX + 350,alinY - 335,CORNER_LEFT_LOWER,DoubleToString(lucro_soma_todas_pos_compra(Magic)+lucro_soma_todas_pos_venda(Magic),2),"Arial Black",10,CorFonteResAbertos,0,ANCHOR_RIGHT_UPPER);


      if(roboLigadoBotao)
         ObjectSetInteger(0,"botaoPlay",OBJPROP_STATE,true);
      else
         ObjectSetInteger(0,"botaoPlay",OBJPROP_STATE,false);

      string ligadoDesligado = ObjectGetInteger(0,"botaoPlay",OBJPROP_STATE) ? "LIGADO" : "DESLIGADO";
      CriarEtiqueta(0,"rotulo_status",0,alinX + 15,alinY - 360,CORNER_LEFT_LOWER,"Status: "+ligadoDesligado,"Arial",10,CorFonteStatus);


     }

   ChartRedraw();

  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CriarPainelPequeno(const int alinX = 10, const int alinY = 400)
  {


   if(TipoResolucaoPainel==PAINEL_RESOLUCAO_FULL)
     {
      color corFundo = TipoFundoPainel == PAINEL_FUNDO_BRANCO ? clrWhite : clrBlack;
      CriarRetangulo(0,"retangulo1op1",0,alinX,alinY,350,390-200,CorContornoPainel,BORDER_SUNKEN,CORNER_LEFT_LOWER);
      CriarRetangulo(0,"retangulo2op1",0,alinX + 5, alinY - 18,340,367-200,corFundo,BORDER_RAISED,CORNER_LEFT_LOWER);


      if(TipoFundoPainel == PAINEL_FUNDO_BRANCO)
         Criar_Bitmap(0,"logoGoldBot",0,alinX + 20,alinY - 120,"::Experts\\EA FLOW\\logo_PropFull200_88_FundoBranco.bmp","::Experts\\EA FLOW\\logo_PropFull200_88_FundoBranco.bmp",200,88,0,0,true,CORNER_LEFT_LOWER,ANCHOR_LEFT_LOWER);
      else
         Criar_Bitmap(0,"logoGoldBot",0,alinX + 20,alinY - 120,"::Experts\\EA FLOW\\logo_PropFull200_88_FundoPreto.bmp","::Experts\\EA FLOW\\logo_PropFull200_88_FundoPreto.bmp",200,88,0,0,true,CORNER_LEFT_LOWER,ANCHOR_LEFT_LOWER);



      //Criar_Bitmap(0,"botaoMinimizar",0,alinX + 290,alinY - 18,"::Experts\\EA FLOW\\botaoMinimizar2.bmp","::Experts\\EA FLOW\\botaoMinimizar2.bmp",27,18,0,0,true,CORNER_LEFT_LOWER,ANCHOR_LEFT_LOWER);
      Criar_Bitmap(0,"botaoMaximizar",0,alinX + 290,alinY - 18,"::Experts\\EA FLOW\\botaoMaximizar2.bmp","::Experts\\EA FLOW\\botaoMaximizar2.bmp",27,18,0,0,true,CORNER_LEFT_LOWER,ANCHOR_LEFT_LOWER);

      Criar_Bitmap(0,"botaoFechar",0,alinX + 318,alinY - 18,"::Experts\\EA FLOW\\botaoFechar2.bmp","::Experts\\EA FLOW\\botaoFechar2.bmp",27,18,0,0,true,CORNER_LEFT_LOWER,ANCHOR_LEFT_LOWER);


      if(TipoFundoPainel == PAINEL_FUNDO_BRANCO)
         Criar_Bitmap(0,"botaoPlay",0,alinX + 257,alinY - 110,"::Experts\\EA FLOW\\botoesPause.bmp","::Experts\\EA FLOW\\botoesPlay.bmp",71,73,0,0,true,CORNER_LEFT_LOWER,ANCHOR_LEFT_LOWER);
      else
         Criar_Bitmap(0,"botaoPlay",0,alinX + 257,alinY - 110,"::Experts\\EA FLOW\\botoesPause_FPreto.bmp","::Experts\\EA FLOW\\botoesPlay_FPreto.bmp",71,73,0,0,true,CORNER_LEFT_LOWER,ANCHOR_LEFT_LOWER);


      CriarEtiqueta(0,"tituloop1",0,alinX + 10,alinY - 2,CORNER_LEFT_LOWER,nomeSetup+" ID: "+string(Magic),"Arial",10,CorFonteCabecalho);
      CriarEtiqueta(0,"titulo2op1",0,alinX + 285,alinY - 2,CORNER_LEFT_LOWER,_Symbol,"Arial",10,CorFonteCabecalho,0,ANCHOR_RIGHT_UPPER);

      CriarRetangulo(0,"detalhe1op1",0,alinX + 5,alinY - 155,340,2,CorContornoPainel,BORDER_SUNKEN,CORNER_LEFT_LOWER);
      CriarEtiqueta(0,"rotulo_timeframeop1",0,alinX + 15, alinY - 130,CORNER_LEFT_LOWER,"Timeframe:","Arial",10,CorFonteDescricao);
      CriarEtiqueta(0,"rotulo_horaop1",0,alinX + 215,alinY - 130,CORNER_LEFT_LOWER,"Hora Serv.:","Arial",10,CorFonteDescricao);
      CriarEtiqueta(0,"valor_timeframeop1",0,alinX + 85,alinY - 130,CORNER_LEFT_LOWER,ObterTimeFrame(Period()),"Arial Black",9,CorFonteDescricao,0,ANCHOR_LEFT_UPPER);
      CriarEtiqueta(0,"valor_horaservop1",0,alinX + 280,alinY - 130,CORNER_LEFT_LOWER,TimeToString(TimeCurrent(),TIME_SECONDS),"Arial Black",9,CorFonteDescricao,0,ANCHOR_LEFT_UPPER);


      if(roboLigadoBotao)
         ObjectSetInteger(0,"botaoPlay",OBJPROP_STATE,true);
      else
         ObjectSetInteger(0,"botaoPlay",OBJPROP_STATE,false);

      string ligadoDesligado = ObjectGetInteger(0,"botaoPlay",OBJPROP_STATE) ? "LIGADO" : "DESLIGADO";
      CriarEtiqueta(0,"rotulo_status",0,alinX + 15,alinY - 360+200,CORNER_LEFT_LOWER,"Status: "+ligadoDesligado,"Arial",10,CorFonteStatus);



     }

   if(TipoResolucaoPainel==PAINEL_RESULUCAO_MENOR)
     {
      color corFundo = TipoFundoPainel == PAINEL_FUNDO_BRANCO ? clrWhite : clrBlack;
      CriarRetangulo(0,"retangulo1op1",0,alinX,alinY,400,390-200,CorContornoPainel,BORDER_SUNKEN,CORNER_LEFT_LOWER);
      CriarRetangulo(0,"retangulo2op1",0,alinX + 5,alinY-18,390,367-200,corFundo,BORDER_RAISED,CORNER_LEFT_LOWER);



      if(TipoFundoPainel == PAINEL_FUNDO_BRANCO)
         Criar_Bitmap(0,"logoGoldBot",0,alinX + 20,alinY - 120,"::Experts\\EA FLOW\\logo_PropFull200_88_FundoBranco.bmp","::Experts\\EA FLOW\\logo_PropFull200_88_FundoBranco.bmp",200,88,0,0,true,CORNER_LEFT_LOWER,ANCHOR_LEFT_LOWER);
      else
         Criar_Bitmap(0,"logoGoldBot",0,alinX + 20,alinY - 120,"::Experts\\EA FLOW\\logo_PropFull200_88_FundoPreto.bmp","::Experts\\EA FLOW\\logo_PropFull200_88_FundoPreto.bmp",200,88,0,0,true,CORNER_LEFT_LOWER,ANCHOR_LEFT_LOWER);



      //Criar_Bitmap(0,"botaoMinimizar",0,alinX + 300+37,alinY - 18,"::Experts\\EA FLOW\\botaoMinimizar2.bmp","::Experts\\EA FLOW\\botaoMinimizar2.bmp",27,18,0,0,true,CORNER_LEFT_LOWER,ANCHOR_LEFT_LOWER);
      Criar_Bitmap(0,"botaoMaximizar",0,alinX +300+37,alinY - 18,"::Experts\\EA FLOW\\botaoMaximizar2.bmp","::Experts\\EA FLOW\\botaoMaximizar2.bmp",27,18,0,0,true,CORNER_LEFT_LOWER,ANCHOR_LEFT_LOWER);

      Criar_Bitmap(0,"botaoFechar",0,alinX + 328+37,alinY - 18,"::Experts\\EA FLOW\\botaoFechar2.bmp","::Experts\\EA FLOW\\botaoFechar2.bmp",27,18,0,0,true,CORNER_LEFT_LOWER,ANCHOR_LEFT_LOWER);


      if(TipoFundoPainel == PAINEL_FUNDO_BRANCO)
         Criar_Bitmap(0,"botaoPlay",0,alinX + 267 + 20,alinY - 110,"::Experts\\EA FLOW\\botoesPause.bmp","::Experts\\EA FLOW\\botoesPlay.bmp",71,73,0,0,true,CORNER_LEFT_LOWER,ANCHOR_LEFT_LOWER);
      else
         Criar_Bitmap(0,"botaoPlay",0,alinX + 267 + 20,alinY - 110,"::Experts\\EA FLOW\\botoesPause_FPreto.bmp","::Experts\\EA FLOW\\botoesPlay_FPreto.bmp",71,73,0,0,true,CORNER_LEFT_LOWER,ANCHOR_LEFT_LOWER);


      CriarEtiqueta(0,"tituloop1",0,alinX + 10,alinY - 2,CORNER_LEFT_LOWER,nomeSetup+" ID: "+string(Magic),"Arial",10,CorFonteCabecalho);
      CriarEtiqueta(0,"titulo2op1",0,alinX + 325,alinY - 2,CORNER_LEFT_LOWER,_Symbol,"Arial",10,CorFonteCabecalho,0,ANCHOR_RIGHT_UPPER);
      CriarRetangulo(0,"detalhe1op1",0,alinX + 5,alinY - 155,390,2,CorContornoPainel,BORDER_SUNKEN,CORNER_LEFT_LOWER);
      CriarEtiqueta(0,"rotulo_timeframeop1",0,alinX + 15,alinY - 130,CORNER_LEFT_LOWER,"Timeframe:","Arial",10,CorFonteDescricao);
      CriarEtiqueta(0,"rotulo_horaop1",0,alinX + 240,alinY - 130,CORNER_LEFT_LOWER,"Hora Serv.:","Arial",10,CorFonteDescricao);
      CriarEtiqueta(0,"valor_timeframeop1",0,alinX + 100,alinY - 130,CORNER_LEFT_LOWER,ObterTimeFrame(_Period),"Arial Black",8,CorFonteDescricao,0,ANCHOR_LEFT_UPPER);
      CriarEtiqueta(0,"valor_horaservop1",0,alinX + 325,alinY - 130,CORNER_LEFT_LOWER,TimeToString(TimeCurrent(),TIME_SECONDS),"Arial Black",8,CorFonteDescricao,0,ANCHOR_LEFT_UPPER);


      if(roboLigadoBotao)
         ObjectSetInteger(0,"botaoPlay",OBJPROP_STATE,true);
      else
         ObjectSetInteger(0,"botaoPlay",OBJPROP_STATE,false);

      string ligadoDesligado = ObjectGetInteger(0,"botaoPlay",OBJPROP_STATE) ? "LIGADO" : "DESLIGADO";
      CriarEtiqueta(0,"rotulo_status",0,alinX + 15,alinY - 360+200,CORNER_LEFT_LOWER,"Status: "+ligadoDesligado,"Arial",10,CorFonteStatus);

     }

   ChartRedraw();

  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void AtualizarPainel()
  {

   double txacertoDiavalor;
   double txacertoSemanavalor;
   double txacertoMesvalor;
   double txacertoTotalvalor;

   int acertos_dia;
   int total_operacao_dia;
   int acertos_semana;
   int total_operacao_semana;
   int acertos_mes;
   int total_operacao_mes;
   int acertos_total;
   int total_operacao_total;

   acertos_dia = Ganhos_n_operacao_periodoDia(Magic);
   total_operacao_dia = N_operacao_periodoDia(Magic);

   acertos_semana = Ganhos_n_operacao_periodoSemana(Magic);
   total_operacao_semana = N_operacao_periodoSemana(Magic);

   acertos_mes = Ganhos_n_operacao_periodoMes(Magic);
   total_operacao_mes = N_operacao_periodoMes(Magic);

   acertos_total = Ganhos_n_operacao_total(Magic);
   total_operacao_total = N_operacao_total(Magic);


   if(total_operacao_dia!=0)
      txacertoDiavalor = 100*((double)acertos_dia/(double)total_operacao_dia);
   else
      txacertoDiavalor = 0;

   if(total_operacao_semana!=0)
      txacertoSemanavalor = 100*((double)acertos_semana/(double)total_operacao_semana);
   else
      txacertoSemanavalor = 0;

   if(total_operacao_mes!=0)
      txacertoMesvalor = 100*((double)acertos_mes/(double)total_operacao_mes);
   else
      txacertoMesvalor = 0;

   if(total_operacao_total!=0)
      txacertoTotalvalor = 100*((double)acertos_total/(double)total_operacao_total);
   else
      txacertoTotalvalor = 0;


   string txacertoDia;
   string txacertoSemana;
   string txacertoMes;
   string txacertoTotal;

   string lucrodia;
   string lucrosemana;
   string lucromes;
   string lucrototal;

   string tipo_posicao;
   string numero_posicoes;
   string qtdetotal_posicoes;
   string lucro_posicoes;

   lucrodia = DoubleToString(Lucro_periodoDia(Magic),2);
   lucrosemana = DoubleToString(Lucro_periodoSemana(Magic),2);
   lucromes = DoubleToString(Lucro_periodoMes(Magic),2);
   lucrototal = DoubleToString(Lucro_periodoTotal(Magic),2);


   txacertoDia = IntegerToString(acertos_dia)+string("/")+string(IntegerToString(total_operacao_dia))+string(" (")+string(DoubleToString(txacertoDiavalor,0))+string("%)");
   txacertoSemana = IntegerToString(acertos_semana)+string("/")+string(IntegerToString(total_operacao_semana))+string(" (")+string(DoubleToString(txacertoSemanavalor,0))+string("%)");
   txacertoMes = IntegerToString(acertos_mes)+string("/")+string(IntegerToString(total_operacao_mes))+string(" (")+string(DoubleToString(txacertoMesvalor,0))+string("%)");
   txacertoTotal = IntegerToString(acertos_total)+string("/")+string(IntegerToString(total_operacao_total))+string(" (")+string(DoubleToString(txacertoTotalvalor,0))+string("%)");

   tipo_posicao = DoubleToString(qtde_soma_todas_pos_compra(Magic),2)+" buy // "+DoubleToString(qtde_soma_todas_pos_venda(Magic),2)+" sell";
   numero_posicoes = IntegerToString(num_pos_compra(Magic))+" buy // "+IntegerToString(num_pos_venda(Magic))+" sell";


   double volLiquido = qtde_soma_todas_pos_compra(Magic) - qtde_soma_todas_pos_venda(Magic);

   string volLiquidoStr = volLiquido > 0 ? DoubleToString(volLiquido,2)+" buy" : volLiquido < 0 ? DoubleToString(volLiquido*(-1),2)+" sell" : "-";

   qtdetotal_posicoes = volLiquidoStr;
   lucro_posicoes = DoubleToString(lucro_soma_todas_pos_compra(Magic)+lucro_soma_todas_pos_venda(Magic),2);


   string horaServ = TimeToString(TimeCurrent(),TIME_SECONDS);


   if(ObjectGetString(0,"valor_horaservop1",OBJPROP_TEXT)!=horaServ)
      ObjectSetString(0,"valor_horaservop1",OBJPROP_TEXT,horaServ);



   if(ObjectGetString(0,"valor_diaop1",OBJPROP_TEXT)!=txacertoDia)
      ObjectSetString(0,"valor_diaop1",OBJPROP_TEXT,txacertoDia);
   if(ObjectGetString(0,"valor_semanaop1",OBJPROP_TEXT)!=txacertoSemana)
      ObjectSetString(0,"valor_semanaop1",OBJPROP_TEXT,txacertoSemana);
   if(ObjectGetString(0,"valor_mesop1",OBJPROP_TEXT)!=txacertoMes)
      ObjectSetString(0,"valor_mesop1",OBJPROP_TEXT,txacertoMes);
   if(ObjectGetString(0,"valor_totalop1",OBJPROP_TEXT)!=txacertoTotal)
      ObjectSetString(0,"valor_totalop1",OBJPROP_TEXT,txacertoTotal);

   if(ObjectGetString(0,"valor_lucrodiaop1",OBJPROP_TEXT)!=lucrodia)
      ObjectSetString(0,"valor_lucrodiaop1",OBJPROP_TEXT,lucrodia);
   if(ObjectGetString(0,"valor_lucrosemanaop1",OBJPROP_TEXT)!=lucrosemana)
      ObjectSetString(0,"valor_lucrosemanaop1",OBJPROP_TEXT,lucrosemana);
   if(ObjectGetString(0,"valor_lucromesop1",OBJPROP_TEXT)!=lucromes)
      ObjectSetString(0,"valor_lucromesop1",OBJPROP_TEXT,lucromes);
   if(ObjectGetString(0,"valor_lucrototalop1",OBJPROP_TEXT)!=lucrototal)
      ObjectSetString(0,"valor_lucrototalop1",OBJPROP_TEXT,lucrototal);

   if(ObjectGetString(0,"valor_tipoPosop1",OBJPROP_TEXT)!=tipo_posicao)
      ObjectSetString(0,"valor_tipoPosop1",OBJPROP_TEXT,tipo_posicao);
   if(ObjectGetString(0,"valor_numPosop1",OBJPROP_TEXT)!=numero_posicoes)
      ObjectSetString(0,"valor_numPosop1",OBJPROP_TEXT,numero_posicoes);
   if(ObjectGetString(0,"valor_qtdePosop1",OBJPROP_TEXT)!=qtdetotal_posicoes)
      ObjectSetString(0,"valor_qtdePosop1",OBJPROP_TEXT,qtdetotal_posicoes);
   if(ObjectGetString(0,"valor_lucroPosop1",OBJPROP_TEXT)!=lucro_posicoes)
      ObjectSetString(0,"valor_lucroPosop1",OBJPROP_TEXT,lucro_posicoes);



   string ligadoDesligado = ObjectGetInteger(0,"botaoPlay",OBJPROP_STATE) ? "Status: LIGADO" : "Status: DESLIGADO";
   if(ObjectGetString(0,"rotulo_status",OBJPROP_TEXT)!=ligadoDesligado)
      ObjectSetString(0,"rotulo_status",OBJPROP_TEXT,ligadoDesligado);


   ChartRedraw();

  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CriarRetangulo(const long             chart_ID=0,                // ID do gráfico
                    const string           name="RectLabel",         // nome da etiqueta
                    const int              sub_window=0,             // índice da sub-janela
                    const int              x=0,                      // coordenada X
                    const int              y=0,                      // coordenada Y
                    const int              width=50,                 // largura
                    const int              height=18,                // altura
                    const color            back_clr=C'236,233,216',  // cor do fundo
                    const ENUM_BORDER_TYPE border=BORDER_SUNKEN,     // tipo de borda
                    const ENUM_BASE_CORNER corner=CORNER_LEFT_UPPER, // canto do gráfico para ancoragem
                    const color            clr=clrRed,               // cor da borda plana (Flat)
                    const ENUM_LINE_STYLE  style=STYLE_SOLID,        // estilo da borda plana
                    const int              line_width=1,             // largura da borda plana
                    const bool             back=false,               // no fundo
                    const bool             selection=false,          // destaque para mover
                    const bool             hidden=true,              // ocultar na lista de objeto
                    const long             z_order=0)                // prioridade para clicar no mouse
  {
//--- Apagar o último retângulo criado
   ObjectDelete(chart_ID,name);

//--- redefine o valor de erro
   ResetLastError();
//--- criar uma etiqueta retangular
   if(!ObjectCreate(chart_ID,name,OBJ_RECTANGLE_LABEL,sub_window,0,0))
     {
      Print(__FUNCTION__,
            ": falha ao criar uma etiqueta retangular! Código de erro = ",GetLastError());
      return(false);
     }
//--- definir coordenadas da etiqueta
   ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);
   ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
//--- definir tamanho da etiqueta
   ObjectSetInteger(chart_ID,name,OBJPROP_XSIZE,width);
   ObjectSetInteger(chart_ID,name,OBJPROP_YSIZE,height);
//--- definir a cor de fundo
   ObjectSetInteger(chart_ID,name,OBJPROP_BGCOLOR,back_clr);
//--- definir o tipo de borda
   ObjectSetInteger(chart_ID,name,OBJPROP_BORDER_TYPE,border);
//--- determinar o canto do gráfico onde as coordenadas do ponto são definidas
   ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner);
//--- definir a cor da borda plana (no modo Flat)
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
//--- definir o estilo da linha da borda plana
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
//--- definir a largura da borda plana
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,line_width);
//--- exibir em primeiro plano (false) ou fundo (true)
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
//--- Habilitar (true) ou desabilitar (false) o modo de movimento da etiqueta pelo mouse
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
//--- ocultar (true) ou exibir (false) o nome do objeto gráfico na lista de objeto
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
//--- definir a prioridade para receber o evento com um clique do mouse no gráfico
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
//--- sucesso na execução
   return(true);
  }

//--- CRIAR ETIQUETA

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CriarEtiqueta(const long              chart_ID=0,               // ID do gráfico
                   const string            name="Label",             // nome da etiqueta
                   const int               sub_window=0,             // índice da sub-janela
                   const int               x=0,                      // coordenada X
                   const int               y=0,                      // coordenada Y
                   const ENUM_BASE_CORNER  corner=CORNER_LEFT_UPPER, // canto do gráfico para ancoragem
                   const string            text="Label",             // texto
                   const string            font="Arial",             // fonte
                   const int               font_size=10,             // tamanho da fonte
                   const color             clr=clrRed,               // cor
                   const double            angle=0.0,                // inclinação do texto
                   const ENUM_ANCHOR_POINT anchor=ANCHOR_LEFT_UPPER, // tipo de ancoragem
                   const bool              back=false,               // no fundo
                   const bool              selection=false,          // destaque para mover
                   const bool              hidden=true,              // ocultar na lista de objetos
                   const long              z_order=0)                // prioridade para clicar no mouse
  {
//--- redefine o valor de erro
   ResetLastError();
//--- criar um a etiqueta de texto
   if(!ObjectCreate(chart_ID,name,OBJ_LABEL,sub_window,0,0))
     {
      Print(__FUNCTION__,
            ": falha ao criar uma etiqueta de texto! Código de erro = ",GetLastError());
      return(false);
     }
//--- definir coordenadas da etiqueta
   ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);
   ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
//--- determinar o canto do gráfico onde as coordenadas do ponto são definidas
   ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner);
//--- definir o texto
   ObjectSetString(chart_ID,name,OBJPROP_TEXT,text);
//--- definir o texto fonte
   ObjectSetString(chart_ID,name,OBJPROP_FONT,font);
//--- definir tamanho da fonte
   ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size);
//--- definir o ângulo de inclinação do texto
   ObjectSetDouble(chart_ID,name,OBJPROP_ANGLE,angle);
//--- tipo de definição de ancoragem
   ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor);
//--- definir cor
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
//--- exibir em primeiro plano (false) ou fundo (true)
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
//--- Habilitar (true) ou desabilitar (false) o modo de movimento da etiqueta pelo mouse
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
//--- ocultar (true) ou exibir (false) o nome do objeto gráfico na lista de objeto
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
//--- definir a prioridade para receber o evento com um clique do mouse no gráfico
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
//--- sucesso na execução
   return(true);
  }

//--- CRIAR ETIQUETA

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool EditarEtiqueta(const long              chart_ID=0,               // ID do gráfico
                    const string            name="Label",             // nome da etiqueta
                    const string            text="Label",             // texto
                    const string            font="Arial",             // fonte
                    const int               font_size=10,             // tamanho da fonte
                    const color             clr=clrRed,               // cor
                    const double            angle=0.0,                // inclinação do texto
                    const ENUM_ANCHOR_POINT anchor=ANCHOR_LEFT_UPPER, // tipo de ancoragem
                    const bool              back=false,               // no fundo
                    const bool              selection=false,          // destaque para mover
                    const bool              hidden=true,              // ocultar na lista de objetos
                    const long              z_order=0)                // prioridade para clicar no mouse
  {

//--- procurar o objeto com o nome especificado
   if(ObjectFind(chart_ID,name)<0)
     {
      Print(__FUNCTION__,
            "Falhar ao procurar o objeto label de nome: ",name," Erro...",GetLastError());
      return false;
     }

//--- redefine o valor de erro
   ResetLastError();
//--- definir o texto
   ObjectSetString(chart_ID,name,OBJPROP_TEXT,text);
//--- definir o texto fonte
   ObjectSetString(chart_ID,name,OBJPROP_FONT,font);
//--- definir tamanho da fonte
   ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size);
//--- definir o ângulo de inclinação do texto
   ObjectSetDouble(chart_ID,name,OBJPROP_ANGLE,angle);
//--- tipo de definição de ancoragem
   ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor);
//--- definir cor
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
//--- exibir em primeiro plano (false) ou fundo (true)
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
//--- Habilitar (true) ou desabilitar (false) o modo de movimento da etiqueta pelo mouse
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
//--- ocultar (true) ou exibir (false) o nome do objeto gráfico na lista de objeto
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
//--- definir a prioridade para receber o evento com um clique do mouse no gráfico
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
//--- sucesso na execução
   return(true);
  }

//---

//+------------------------------------------------------------------+
//| Criar objeto Etiqueta Bitmap                                     |
//+------------------------------------------------------------------+
bool Criar_Bitmap(const long              chart_ID=0,                    // ID do gráfico
                  const string            name="BmpLabel",          // nome da etiqueta
                  const int               sub_window=0,             // índice da sub-janela
                  const int               x=0,                      // coordenada X
                  const int               y=0,                      // coordenada Y
                  const string            file_on="",               // imagem em modo On
                  const string            file_off="",              // imagem em modo Off
                  const int               width=0,                  // coordenada X do escopo de visibilidade
                  const int               height=0,                 // coordenada Y do escopo de visibilidade
                  const int               x_offset=10,              // escopo de visibilidade deslocado pelo eixo X
                  const int               y_offset=10,              // escopo de visibilidade deslocado pelo eixo Y
                  const bool              state=false,              // pressionada/liberada
                  const ENUM_BASE_CORNER  corner=CORNER_LEFT_UPPER, // canto do gráfico para ancoragem
                  const ENUM_ANCHOR_POINT anchor=ANCHOR_LEFT_UPPER, // tipo de ancoragem
                  const color             clr=clrRed,               // a cor da borda quando destacada
                  const ENUM_LINE_STYLE   style=STYLE_SOLID,        // estilo da linha quando destacada
                  const int               point_width=1,            // mover tamanho do ponto
                  const bool              back=false,               // no fundo
                  const bool              selection=false,          // destaque para mover
                  const bool              hidden=true,              // ocultar na lista de objetos
                  const long              z_order=0)                // prioridade para clicar no mouse
  {
//--- redefine o valor de erro
   ResetLastError();
//--- criar uma etiqueta bitmap
   if(!ObjectCreate(chart_ID,name,OBJ_BITMAP_LABEL,sub_window,0,0))
     {
      Print(__FUNCTION__,
            ": falha ao criar objeto \"Etiqueta Bitmap\"! Código de erro = ",GetLastError());
      return(false);
     }
//--- definir as imagens para os modos ligar (On) e desligar (Off)
   if(!ObjectSetString(chart_ID,name,OBJPROP_BMPFILE,0,file_on))
     {
      Print(__FUNCTION__,
            ": falha para carregar a imagem para o modo On! Código de erro = ",GetLastError());
      return(false);
     }
   if(!ObjectSetString(chart_ID,name,OBJPROP_BMPFILE,1,file_off))
     {
      Print(__FUNCTION__,
            ": falha para carregar a imagem para o modo Off! Código de erro = ",GetLastError());
      return(false);
     }
//--- definir coordenadas da etiqueta
   ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);
   ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
//--- definir escopo de visibilidade para a imagem, se os valores da largura ou altura
//--- excederem a largura e a altura (respectivamente) de uma imagem de origem,
//--- não será desenhada, no caso oposto
//--- apenas a parte correspondente a esses valores será desenhada
   ObjectSetInteger(chart_ID,name,OBJPROP_XSIZE,width);
   ObjectSetInteger(chart_ID,name,OBJPROP_YSIZE,height);
//--- definir a parte de uma imagem que está sendo exibida no escopo de visibilidade,
//--- a parte padrão é a área superior esquerda de uma imagem, os valores permitem
//--- realizar uma mudança a partir desta área de exibição de uma outra parte da imagem
   ObjectSetInteger(chart_ID,name,OBJPROP_XOFFSET,x_offset);
   ObjectSetInteger(chart_ID,name,OBJPROP_YOFFSET,y_offset);
//--- definir os status da etiqueta(pressionada ou liberada)
   ObjectSetInteger(chart_ID,name,OBJPROP_STATE,state);
//--- determinar o canto do gráfico onde as coordenadas do ponto são definidas
   ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner);
//--- tipo de definição de ancoragem
   ObjectSetInteger(chart_ID,name,OBJPROP_ANCHOR,anchor);
//--- definir a cor da borda quando o modo de destaque do objeto é habilitado
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
//--- definir o estilo de linha quando o modo de destaque do objeto é habilitado
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
//--- definir o tamanho do ponto de ancoragem para movimentar o objeto
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,point_width);
//--- exibir em primeiro plano (false) ou fundo (true)
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
//--- Habilitar (true) ou desabilitar (false) o modo de movimento da etiqueta pelo mouse
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
//--- ocultar (true) ou exibir (false) o nome do objeto gráfico na lista de objeto
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
//--- definir a prioridade para receber o evento com um clique do mouse no gráfico
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
//--- sucesso na execução
   return(true);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Ganhos_n_operacao_periodoDia(int magic_number)
  {
   int gains = 0;
   int deals = OrdersHistoryTotal();
   int DiahorarioInicio = TimeDay(TimeCurrent());
   int MeshorarioInicio = TimeMonth(TimeCurrent());
   int AnohorarioInicio = TimeYear(TimeCurrent());

   for(int i=0; i<deals; i++)
     {
      //---- check selection result
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==false)
        {
         Print("Access to history failed with error (",GetLastError(),")");
         break;
        }

      datetime horarioClose = OrderCloseTime();

      int DiahorarioOrdem = TimeDay(horarioClose);
      int MeshorarioOrdem = TimeMonth(horarioClose);
      int AnohorarioOrdem = TimeYear(horarioClose);

      if(horarioClose>0 && DiahorarioOrdem == DiahorarioInicio &&
         MeshorarioOrdem == MeshorarioInicio && AnohorarioOrdem == AnohorarioInicio)
        {
         int ticket = OrderTicket();
         int dealMagic = OrderMagicNumber();

         string symbol = OrderSymbol();
         double profit = OrderProfit();

         if(dealMagic == magic_number && symbol == _Symbol)
           {
            if(profit > 0.0)
               gains++;
           }
        }
     }

   return(gains);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Ganhos_n_operacao_periodoSemana(int magic_number)
  {
   int gains = 0;
   int deals = OrdersHistoryTotal();
   int DiahorarioInicio = TimeDay(TimeCurrent());
   int MeshorarioInicio = TimeMonth(TimeCurrent());
   int AnohorarioInicio = TimeYear(TimeCurrent());

   for(int i=deals - 1; i>=0; i--)
     {
      //---- check selection result
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==false)
        {
         Print("Access to history failed with error (",GetLastError(),")");
         break;
        }

      datetime horarioClose = OrderCloseTime();

      int DiahorarioOrdem = TimeDay(horarioClose);
      int MeshorarioOrdem = TimeMonth(horarioClose);
      int AnohorarioOrdem = TimeYear(horarioClose);

      MqlDateTime timeStruct;
      MqlDateTime timeCorrenteStruct;

      TimeToStruct(horarioClose,timeStruct);
      TimeToStruct(TimeCurrent(),timeCorrenteStruct);

      int diaSemanaCorrente = timeCorrenteStruct.day_of_week;
      int diaSemanaOrdem = timeStruct.day_of_week;

      bool semanaOK = ((DiahorarioInicio-DiahorarioOrdem<7 && DiahorarioInicio >= DiahorarioOrdem) || (DiahorarioInicio < DiahorarioOrdem && DiahorarioInicio+30-DiahorarioOrdem<7));
      bool mesOK = ((MeshorarioInicio - MeshorarioOrdem <2 && MeshorarioInicio >= MeshorarioOrdem) || (MeshorarioInicio < MeshorarioOrdem && MeshorarioInicio+12-MeshorarioOrdem<2));
      bool anoOK = (AnohorarioInicio - AnohorarioOrdem <2 && AnohorarioInicio >= AnohorarioOrdem);


      if(diaSemanaCorrente>=diaSemanaOrdem && semanaOK && mesOK && anoOK)
        {
         if(horarioClose>0)
           {
            int ticket = OrderTicket();
            int dealMagic = OrderMagicNumber();

            string symbol = OrderSymbol();
            double profit = OrderProfit();

            if(dealMagic == magic_number && symbol == _Symbol)
              {
               if(profit > 0.0)
                  gains++;
              }
           }
        }
      else
         break;

     }
   return(gains);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Ganhos_n_operacao_periodoMes(int magic_number)
  {
   int gains = 0;
   int deals = OrdersHistoryTotal();
   int DiahorarioInicio = TimeDay(TimeCurrent());
   int MeshorarioInicio = TimeMonth(TimeCurrent());
   int AnohorarioInicio = TimeYear(TimeCurrent());

   for(int i=0; i<deals; i++)
     {
      //---- check selection result
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==false)
        {
         Print("Access to history failed with error (",GetLastError(),")");
         break;
        }

      datetime horarioClose = OrderCloseTime();

      int MeshorarioOrdem = TimeMonth(horarioClose);
      int AnohorarioOrdem = TimeYear(horarioClose);

      if(horarioClose>0 &&
         MeshorarioOrdem == MeshorarioInicio && AnohorarioOrdem == AnohorarioInicio)
        {
         int ticket = OrderTicket();
         int dealMagic = OrderMagicNumber();

         string symbol = OrderSymbol();
         double profit = OrderProfit();

         if(dealMagic == magic_number && symbol == _Symbol)
           {
            if(profit > 0.0)
               gains++;
           }
        }
     }

   return(gains);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int Ganhos_n_operacao_total(int magic_number)
  {
   int gains = 0;
   int deals = OrdersHistoryTotal();

   for(int i=0; i<deals; i++)
     {
      //---- check selection result
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==false)
        {
         Print("Access to history failed with error (",GetLastError(),")");
         break;
        }

      datetime horarioClose = OrderCloseTime();


      if(horarioClose>0)
        {
         int ticket = OrderTicket();
         int dealMagic = OrderMagicNumber();

         string symbol = OrderSymbol();
         double profit = OrderProfit();

         if(dealMagic == magic_number && symbol == _Symbol)
           {
            if(profit > 0.0)
               gains++;
           }
        }
     }

   return(gains);
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int N_operacao_periodoDia(int magic_number)
  {
   int trades = 0;
   int deals = OrdersHistoryTotal();
   int DiahorarioInicio = TimeDay(TimeCurrent());
   int MeshorarioInicio = TimeMonth(TimeCurrent());
   int AnohorarioInicio = TimeYear(TimeCurrent());

   for(int i=0; i<deals; i++)
     {
      //---- check selection result
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==false)
        {
         Print("Access to history failed with error (",GetLastError(),")");
         break;
        }

      datetime horarioClose = OrderCloseTime();

      int DiahorarioOrdem = TimeDay(horarioClose);
      int MeshorarioOrdem = TimeMonth(horarioClose);
      int AnohorarioOrdem = TimeYear(horarioClose);



      if(horarioClose>0 && DiahorarioOrdem == DiahorarioInicio &&
         MeshorarioOrdem == MeshorarioInicio && AnohorarioOrdem == AnohorarioInicio)
        {
         int ticket = OrderTicket();
         int dealMagic = OrderMagicNumber();

         string symbol = OrderSymbol();
         double profit = OrderProfit();

         if(dealMagic == magic_number && symbol == _Symbol)
           {
            trades++;
           }
        }
     }

   return(trades);
  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int N_operacao_periodoSemana(int magic_number)
  {
   int trades = 0;
   int deals = OrdersHistoryTotal();
   int DiahorarioInicio = TimeDay(TimeCurrent());
   int MeshorarioInicio = TimeMonth(TimeCurrent());
   int AnohorarioInicio = TimeYear(TimeCurrent());

   for(int i=deals - 1; i>=0; i--)
     {
      //---- check selection result
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==false)
        {
         Print("Access to history failed with error (",GetLastError(),")");
         break;
        }

      datetime horarioClose = OrderCloseTime();

      int DiahorarioOrdem = TimeDay(horarioClose);
      int MeshorarioOrdem = TimeMonth(horarioClose);
      int AnohorarioOrdem = TimeYear(horarioClose);

      MqlDateTime timeStruct;
      MqlDateTime timeCorrenteStruct;

      TimeToStruct(horarioClose,timeStruct);
      TimeToStruct(TimeCurrent(),timeCorrenteStruct);

      int diaSemanaCorrente = timeCorrenteStruct.day_of_week;
      int diaSemanaOrdem = timeStruct.day_of_week;

      bool semanaOK = ((DiahorarioInicio-DiahorarioOrdem<7 && DiahorarioInicio >= DiahorarioOrdem) || (DiahorarioInicio < DiahorarioOrdem && DiahorarioInicio+30-DiahorarioOrdem<7));
      bool mesOK = ((MeshorarioInicio - MeshorarioOrdem <2 && MeshorarioInicio >= MeshorarioOrdem) || (MeshorarioInicio < MeshorarioOrdem && MeshorarioInicio+12-MeshorarioOrdem<2));
      bool anoOK = (AnohorarioInicio - AnohorarioOrdem <2 && AnohorarioInicio >= AnohorarioOrdem);


      if(diaSemanaCorrente>=diaSemanaOrdem && semanaOK && mesOK && anoOK)
        {
         if(horarioClose>0)
           {
            int ticket = OrderTicket();
            int dealMagic = OrderMagicNumber();

            string symbol = OrderSymbol();
            double profit = OrderProfit();

            if(dealMagic == magic_number && symbol == _Symbol)
              {
               trades++;
              }
           }
        }
      else
         break;
     }

   return(trades);
  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int N_operacao_periodoMes(int magic_number)
  {
   int trades = 0;
   int deals = OrdersHistoryTotal();
   int DiahorarioInicio = TimeDay(TimeCurrent());
   int MeshorarioInicio = TimeMonth(TimeCurrent());
   int AnohorarioInicio = TimeYear(TimeCurrent());

   for(int i=0; i<deals; i++)
     {
      //---- check selection result
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==false)
        {
         Print("Access to history failed with error (",GetLastError(),")");
         break;
        }

      datetime horarioClose = OrderCloseTime();


      int MeshorarioOrdem = TimeMonth(horarioClose);
      int AnohorarioOrdem = TimeYear(horarioClose);

      if(horarioClose>0  &&
         MeshorarioOrdem == MeshorarioInicio && AnohorarioOrdem == AnohorarioInicio)
        {
         int ticket = OrderTicket();
         int dealMagic = OrderMagicNumber();

         string symbol = OrderSymbol();
         double profit = OrderProfit();

         if(dealMagic == magic_number && symbol == _Symbol)
           {
            trades++;
           }
        }
     }

   return(trades);
  }



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int N_operacao_total(int magic_number)
  {
   int trades = 0;
   int deals = OrdersHistoryTotal();
   int DiahorarioInicio = TimeDay(TimeCurrent());
   int MeshorarioInicio = TimeMonth(TimeCurrent());
   int AnohorarioInicio = TimeYear(TimeCurrent());

   for(int i=0; i<deals; i++)
     {
      //---- check selection result
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==false)
        {
         Print("Access to history failed with error (",GetLastError(),")");
         break;
        }

      datetime horarioClose = OrderCloseTime();

      int DiahorarioOrdem = TimeDay(horarioClose);
      int MeshorarioOrdem = TimeMonth(horarioClose);
      int AnohorarioOrdem = TimeYear(horarioClose);

      if(horarioClose>0)
        {
         int ticket = OrderTicket();
         int dealMagic = OrderMagicNumber();

         string symbol = OrderSymbol();
         double profit = OrderProfit();

         if(dealMagic == magic_number && symbol == _Symbol)
           {
            trades++;
           }
        }
     }

   return(trades);
  }



//--- Cálculo do lucro financeiro no dia
double Lucro_periodoDia(int magic_number)
  {
   double profit_total=0;
   int deals = OrdersHistoryTotal();

   int DiahorarioInicio = TimeDay(TimeCurrent());
   int MeshorarioInicio = TimeMonth(TimeCurrent());
   int AnohorarioInicio = TimeYear(TimeCurrent());

   for(int i=0; i<deals; i++)
     {
      //---- check selection result
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==false)
        {
         Print("Access to history failed with error (",GetLastError(),")");
         break;
        }

      datetime horarioClose = OrderCloseTime();

      int DiahorarioOrdem = TimeDay(horarioClose);
      int MeshorarioOrdem = TimeMonth(horarioClose);
      int AnohorarioOrdem = TimeYear(horarioClose);

      if(horarioClose>0 && DiahorarioOrdem == DiahorarioInicio &&
         MeshorarioOrdem == MeshorarioInicio && AnohorarioOrdem == AnohorarioInicio)
        {
         int ticket = OrderTicket();
         int dealMagic = OrderMagicNumber();

         string symbol = OrderSymbol();
         double profit = OrderProfit();

         if(dealMagic == magic_number && symbol == _Symbol)
           {
            profit_total += profit;
           }
        }
     }
//---
   return(profit_total);
  }

//--- Cálculo do lucro financeiro no dia
double Lucro_periodoSemana(int magic_number)
  {
   double profit_total=0;
   int deals = OrdersHistoryTotal();

   int DiahorarioInicio = TimeDay(TimeCurrent());
   int MeshorarioInicio = TimeMonth(TimeCurrent());
   int AnohorarioInicio = TimeYear(TimeCurrent());

   for(int i=deals-1; i>=0; i--)
     {
      //---- check selection result
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==false)
        {
         Print("Access to history failed with error (",GetLastError(),")");
         break;
        }

      datetime horarioClose = OrderCloseTime();

      int DiahorarioOrdem = TimeDay(horarioClose);
      int MeshorarioOrdem = TimeMonth(horarioClose);
      int AnohorarioOrdem = TimeYear(horarioClose);


      MqlDateTime timeStruct;
      MqlDateTime timeCorrenteStruct;

      TimeToStruct(horarioClose,timeStruct);
      TimeToStruct(TimeCurrent(),timeCorrenteStruct);

      int diaSemanaCorrente = timeCorrenteStruct.day_of_week;
      int diaSemanaOrdem = timeStruct.day_of_week;

      bool semanaOK = ((DiahorarioInicio-DiahorarioOrdem<7 && DiahorarioInicio >= DiahorarioOrdem) || (DiahorarioInicio < DiahorarioOrdem && DiahorarioInicio+30-DiahorarioOrdem<7));
      bool mesOK = ((MeshorarioInicio - MeshorarioOrdem <2 && MeshorarioInicio >= MeshorarioOrdem) || (MeshorarioInicio < MeshorarioOrdem && MeshorarioInicio+12-MeshorarioOrdem<2));
      bool anoOK = (AnohorarioInicio - AnohorarioOrdem <2 && AnohorarioInicio >= AnohorarioOrdem);


      if(diaSemanaCorrente>=diaSemanaOrdem && semanaOK && mesOK && anoOK)
        {
         if(horarioClose>0)
           {
            int ticket = OrderTicket();
            int dealMagic = OrderMagicNumber();

            string symbol = OrderSymbol();
            double profit = OrderProfit();

            if(dealMagic == magic_number && symbol == _Symbol)
              {
               profit_total += profit;
              }
           }
        }
      else
         break;
     }

//---
   return(profit_total);
  }

//--- Cálculo do lucro financeiro no dia
double Lucro_periodoMes(int magic_number)
  {
   double profit_total=0;
   int deals = OrdersHistoryTotal();

   int MeshorarioInicio = TimeMonth(TimeCurrent());
   int AnohorarioInicio = TimeYear(TimeCurrent());

   for(int i=0; i<deals; i++)
     {
      //---- check selection result
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==false)
        {
         Print("Access to history failed with error (",GetLastError(),")");
         break;
        }

      datetime horarioClose = OrderCloseTime();

      int MeshorarioOrdem = TimeMonth(horarioClose);
      int AnohorarioOrdem = TimeYear(horarioClose);

      if(horarioClose>0  &&
         MeshorarioOrdem == MeshorarioInicio && AnohorarioOrdem == AnohorarioInicio)
        {
         int ticket = OrderTicket();
         int dealMagic = OrderMagicNumber();

         string symbol = OrderSymbol();
         double profit = OrderProfit();

         if(dealMagic == magic_number && symbol == _Symbol)
           {
            profit_total += profit;
           }
        }
     }
//---
   return(profit_total);
  }

//--- Cálculo do lucro financeiro no dia
double Lucro_periodoTotal(int magic_number)
  {
   double profit_total=0;
   int deals = OrdersHistoryTotal();

   int MeshorarioInicio = TimeMonth(TimeCurrent());
   int AnohorarioInicio = TimeYear(TimeCurrent());

   for(int i=0; i<deals; i++)
     {
      //---- check selection result
      if(OrderSelect(i,SELECT_BY_POS,MODE_HISTORY)==false)
        {
         Print("Access to history failed with error (",GetLastError(),")");
         break;
        }

      datetime horarioClose = OrderCloseTime();

      int MeshorarioOrdem = TimeMonth(horarioClose);
      int AnohorarioOrdem = TimeYear(horarioClose);

      if(horarioClose>0)
        {
         int ticket = OrderTicket();
         int dealMagic = OrderMagicNumber();

         string symbol = OrderSymbol();
         double profit = OrderProfit();

         if(dealMagic == magic_number && symbol == _Symbol)
           {
            profit_total += profit;
           }
        }
     }
//---
   return(profit_total);
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string ObterTimeFrame(int timeFrame)
  {
   string timeReturn = "";


   if(timeFrame == PERIOD_D1)
      timeReturn = "DIARIO";

   if(timeFrame == PERIOD_H1)
      timeReturn = "H1";

   if(timeFrame == PERIOD_H4)
      timeReturn = "H4";

   if(timeFrame == PERIOD_M1)
      timeReturn = "M1";

   if(timeFrame == PERIOD_M15)
      timeReturn = "M15";

   if(timeFrame == PERIOD_M30)
      timeReturn = "M30";

   if(timeFrame == PERIOD_M5)
      timeReturn = "M5";

   if(timeFrame == PERIOD_MN1)
      timeReturn = "MENSAL";

   if(timeFrame == PERIOD_W1)
      timeReturn = "WEEK";

   return timeReturn;
  }





//+------------------------------------------------------------------+
//|              On Chart Event                                      |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long& lparam,
                  const double& dparam,
                  const string& sparam)
  {

   static bool CliqueMovPainel = false;
   ChartSetInteger(0,CHART_EVENT_MOUSE_MOVE,true);
   string nomeBotaoMov = "retangulo1op1";

   static int posX, posY;



   if(id==CHARTEVENT_OBJECT_CLICK && sparam=="botaoPlay")
     {
      if(!ObjectGetInteger(0,"botaoPlay",OBJPROP_STATE))
        {
         Zerar_Posicoes_decrescente(Magic);
         CancelaOrdens(Magic);
         Print("Robô desligado no botão");

         if(num_pos_compra(Magic)==0 && num_pos_venda(Magic)==0 && num_ordens(Magic)==0)
            roboLigadoBotao = false;
         else
            ObjectSetInteger(0,"botaoPlay",OBJPROP_STATE,true);
        }
      else
        {
         Print("Robô ligado no botão");
         roboLigadoBotao = true;
        }
      AtualizarPainel();
     }




   if(id==CHARTEVENT_OBJECT_CLICK && sparam=="botaoFechar")
     {
      if(MessageBox("Tem certeza que deseja encerrar operações e finalizar o EA?","FINALIZAÇÃO",MB_YESNO) == IDYES)
        {
         Zerar_Posicoes_decrescente(Magic);
         CancelaOrdens(Magic);

         if(num_pos_compra(Magic)==0 && num_pos_venda(Magic)==0 && num_ordens(Magic)==0)
            ExpertRemove();
        }
     }




//--- EVENTOS QUE OCORREM DENTRO DO PAINEL DE RESULTADOS
// Minimizando e Maximizando o painel Superior
   if(id==CHARTEVENT_OBJECT_CLICK && sparam=="botaoMinimizar")
     {
      long lastX = ObjectGetInteger(0,"retangulo1op1",OBJPROP_XDISTANCE);
      long lastY = ObjectGetInteger(0,"retangulo1op1",OBJPROP_YDISTANCE);

      ApagarPainelGrande();
      CriarPainelPequeno(int(lastX),int(lastY));
     }

   if(id==CHARTEVENT_OBJECT_CLICK && sparam=="botaoMaximizar")
     {
      long lastX = ObjectGetInteger(0,"retangulo1op1",OBJPROP_XDISTANCE);
      long lastY = ObjectGetInteger(0,"retangulo1op1",OBJPROP_YDISTANCE);

      ApagarPainelPequeno();
      CriarPainel(int(lastX),int(lastY));
     }


   if(id==CHARTEVENT_MOUSE_MOVE && sparam=="1" && CliqueMovPainel)
     {
      uint t1 = GetTickCount();
      static uint t1StaticOnCh = GetTickCount();

      if(t1-t1StaticOnCh>300)
        {
         t1 = t1StaticOnCh;
         int novoX = int(lparam) + posX;
         int novoY = (int)(ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS)-dparam) - posY;
         //long nBarras = ChartGetInteger(0,CHART_FIRST_VISIBLE_BAR);
         //Print(ChartNavigate(0,CHART_CURRENT_POS,nBarras-nBarrasGrafStati));

         if(PainelGrande())
           {
            ApagarPainelGrande();
            CriarPainel(novoX,novoY);
           }

         if(PainelReduzido())
           {
            ApagarPainelPequeno();
            CriarPainelPequeno(novoX,novoY);
           }
        }
     }


   if(id==CHARTEVENT_MOUSE_MOVE && sparam=="1")
     {
      //      int distXmin = ObjectGetInteger(0,nomeBotaoMov,OBJPROP_XDISTANCE);
      //      int distXmax = distXmin+ObjectGetInteger(0,nomeBotaoMov,OBJPROP_XSIZE);
      //
      //      int distYmin = ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS)-ObjectGetInteger(0,nomeBotaoMov,OBJPROP_YDISTANCE);
      //      int distYmax = distYmin+ObjectGetInteger(0,nomeBotaoMov,OBJPROP_YSIZE);

      int distXmin = (int)ObjectGetInteger(0,nomeBotaoMov,OBJPROP_XDISTANCE);
      int distXmax = distXmin+(int)ObjectGetInteger(0,nomeBotaoMov,OBJPROP_XSIZE);

      int distYmin = (int)ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS) - (int)ObjectGetInteger(0,nomeBotaoMov,OBJPROP_YDISTANCE);
      int distYmax = distYmin+10;

      if(lparam>=distXmin && lparam<=distXmax && dparam>=distYmin && dparam<=distYmax)
        {
         //         posX = lparam+distXmin;
         //
         //         posY = dparam;

         //Print(nBarrasGrafStati);
         //Print("Clique no Botão de Movimento!");
         if(CliqueMovPainel==false)
           {
            CliqueMovPainel = true;
            //nBarrasGrafStati = ChartGetInteger(0,CHART_FIRST_VISIBLE_BAR);
           }
        }
     }

   if(id==CHARTEVENT_CLICK)
     {
      if(CliqueMovPainel)
        {
         CliqueMovPainel = false;
        }
     }


  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool PainelGrande()
  {
   if(ObjectFind(0,"botaoMinimizar")>=0)
      return true;
   else
      return false;
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool PainelReduzido()
  {
   if(ObjectFind(0,"botaoMaximizar")>=0)
      return true;
   else
      return false;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Zerar_Posicoes_decrescente(int magic_number, int slippage=-1)
  {
   for(int i = OrdersTotal() - 1; i >= 0; i--)
     {
      if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
         continue;

      if(OrderSymbol() == _Symbol && OrderMagicNumber() == magic_number)
        {
         if(OrderType() == OP_BUY)
           {
            if(!OrderClose(OrderTicket(),OrderLots(),Bid,100,clrRed))
              {
               Print("Erro de execução ao tentar fechar posição de ticket: ",IntegerToString(OrderTicket())," ",GetLastError());
               ResetLastError();
              }
            else
              {
               Print("A posição de ticket: ",IntegerToString(OrderTicket())," no valor de: ",OrderOpenPrice()," foi fechada.");
              }
           }

         if(OrderType() == OP_SELL)
           {
            if(!OrderClose(OrderTicket(),OrderLots(),Ask,100,clrGreen))
              {
               Print("Erro de execução ao tentar fechar posição de ticket: ",IntegerToString(OrderTicket())," ",GetLastError());
               ResetLastError();
              }
            else
              {
               Print("A posição de ticket: ",IntegerToString(OrderTicket())," no valor de: ",OrderOpenPrice()," foi fechada.");
              }
           }

        }
     }
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int num_ordens(int magic_number)
  {
   int count=0;
   for(int i = 0; i < OrdersTotal(); i++)
     {
      if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
         continue;

      if(OrderSymbol() == _Symbol && OrderMagicNumber() == magic_number)
        {
         RefreshRates();
         if(OrderType() == OP_BUYLIMIT || OrderType() == OP_BUYSTOP ||
            OrderType() == OP_SELLLIMIT || OrderType() == OP_SELLSTOP)
           {
            count++;
           }
        }
     }
   return count;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CancelaOrdens(int magic_number)
  {
   for(int i = OrdersTotal() - 1 ; i >= 0; i--)
     {
      if(!OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
         continue;

      if(OrderSymbol() == _Symbol && OrderMagicNumber() == magic_number &&
         OrderType() != ORDER_TYPE_BUY && OrderType() != ORDER_TYPE_SELL)
        {
         if(!OrderDelete(OrderTicket()))
           {
            Print("Erro de execução ao deletar Ordem Ticket: ",OrderTicket()," ....",GetLastError());
            ResetLastError();
           }
         else
           {
            printf("A ordem posicionada em %g foi cancelada",OrderOpenPrice());
           }
        }
     }
  }


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool MetaDiariaAtingida()
  {
   if(inpUtilizarMetaDia == false)
      return false;

   double lucroFinDia = lucro_soma_todas_pos_compra(Magic) + lucro_soma_todas_pos_venda(Magic) + Lucro_periodoDia(Magic);

   if(inpTipoMeta == META_FINANCEIRA)
     {
      if(lucroFinDia > inpMetaGainValorFin || lucroFinDia < inpLimiteLossValorFin*(-1))
        {
         Print("Meta / Limite Loss atingido no dia...");
         return true;
        }
      else
        {
         return false;
        }
     }

   if(inpTipoMeta == META_PERCENTUAL_CONTA)
     {
      double saldoConta = AccountBalance();

      double varPercentual = (lucroFinDia / saldoConta) * 100;

      if(varPercentual > inpMetaGainValorPerc || varPercentual < inpLimiteLossValorPerc*(-1))
        {
         Print("Meta / Limite Loss atingido no dia... Valor Percentual Conta: ",DoubleToString(varPercentual,2)," %");
         return true;
        }
      else
        {
         return false;
        }
     }
   return false;
  }
//+------------------------------------------------------------------+
