var PIE         //inflation
PIE4            // year on year inflation rate   
Y               // output gap
C               // credibility
DC              // changes in credibility
DCNEG           // negative changes in credibility
RS              // nominal interest rate
CUMSUMY         // cumulative output gap 
PGAP            // price level gap 
LOSS            // loss function  
RR              // real interest rate
RS10YR          // 10 year nominal interest rate
RR4             // annual real interest rate
LR_GAP          // gap between long-run interest rate and its trend
RR_BAR          // real interest rate trend
RR_BAR4         // annual real interest rate trend 
LR              // long-run interest rate
LR_BAR          // long-run interest rate trend
DRS             // difference of nominal interest rate
PIE_GAP         // deviation of YOY inflation from target
RR_GAP          // gap between real interest rate and its trend
RS4             // YOY nominal interest rate 
RS8             // 2 year nominal interest rate 
RS20            // 5 year nominal interest rate
RS40            // 10 year nominal interest rate
YNEG            // negative output gap  
TERM10YR        // term premia 
RSFED           // Fed fund's rate
X               // switch Variable to Tune the Fed Fund's Rate
RSFEDGAP        // gap between Fed's rate and nominal interest rate
PIE4EXP4        // 4 quarter ahead YOY inflation rate
PIE4EXP8        //2 years ahead inflation expectations for YOY inflation rate 
PIE4EXP20       //5 years ahead inflation expectations YOY inflation rate 
PIE4EXP40       //10 years ahead inflation expectations YOY inflation rate 
RES_PIE4_LOW    // low inflation regime 
RES_PIE4_HIGH   // high inflation regime 
SIGNAL_CBP      // CB performance index
PGAPNEG         // Negative Price Gap
RS_TAY          //Taylor Rule Fed Funds Rate
RS40_TAY        // Taylor Rule 10 year nominal interest rate
RS10Y_TAY      // Taylor 10 year nominal interest rate
UNR            // Unemployment rate
UNR_GAP        // Unemployment GAP
UNR_BAR        // Equilibrium Unemployment Rate (NAIRU)
g_UNR          // Persistent component in NAIRU
DL_GDP         // Real GDP, Q-o-Q Log Growth
DL4_GDP        // Real GDP, Y-o-Y Log Growth
DL_GDP_BAR     // Potential GDP, Q-o-Q Log Growth
G_GDP_BAR     // Persistent Component in Potential GDP Growth
BLT           // Bank Landing Tightening
BLT_BAR       // Equilibrium Bank Landing Tightening
ETA;          // Bank Landing Tightening Shock

varexo E_PIE E_Y E_RR_BAR E_TERM10YR RSDOTPLOT E_X E_PIE4EXP4 E_C E_PIE4EXP8 E_PIE4EXP20 E_PIE4EXP40 E_UNR E_UNR_BAR E_UNR_g E_DL_GDP_BAR E_G_GDP_BAR E_BLT E_BLT_BAR;
parameters  PIE_STAR RR_BAR_STAR TERM10YR_SS X_SS, growth_ss;

PIE_STAR       =   2.0;  // Consistent with Fed's Target for PCE Inflation
RR_BAR_STAR    =   1.0; //0.5;  // Consistent with Fed's DOTS Projections
TERM10YR_SS    =   1.5; //1.5;  // Conservative compensation for interest rate uncertainty 
X_SS           =   1.0;  // Steady State Switch Variable to Tune the Fed Fund's Rate
growth_ss      =   1.8/4; // Q-o-Q Steady-state growth rate of GDP

model; 

// 1 PIE
//PIE = .70*PIE4EXP4 + (1-0.70)*PIE4(-1) + 0.10*(5*Y(-1)/(5-Y(-1))) + E_PIE ;

PIE = .70*PIE4EXP4 + (1-0.70)*PIE4(-1) + 0.10*(5*Y(-1)/(5-Y(-1))) + E_PIE ;

PIE4EXP4 = C*PIE4(+4)+(1-C)*PIE4(-1) + E_PIE4EXP4 + .1*(1-C);

PIE4EXP8 = C*PIE4(+8)+(1-C)*PIE4(+3) + E_PIE4EXP8;

PIE4EXP20 = C*PIE4(+20)+(1-C)*PIE4(+15) + E_PIE4EXP20;

PIE4EXP40 = C*PIE4(+40)+(1-C)*PIE4(+35) + E_PIE4EXP40;

C = 0.04*SIGNAL_CBP + (1-0.04)*C(-1) + E_C;

SIGNAL_CBP =  RES_PIE4_HIGH^2/(RES_PIE4_HIGH^2+RES_PIE4_LOW^2) ; 

// RES_PIE4_LOW =    Actual           -          Forecast
RES_PIE4_LOW =       PIE4    -      (   0.5*PIE_STAR+0.5*PIE4(-1))   ;

// RES_PIE4_HIGH =    Actual           -          Forecast
RES_PIE4_HIGH =       PIE4    -      (   0.1*10 + 0.9*PIE4(-1))   ;

CUMSUMY = CUMSUMY(-1) + Y/4;

// 2 PIE4
PIE4 = 0.25*(PIE+PIE(-1)+PIE(-2)+PIE(-3));


// 3 PGAP
PGAP = PGAP(-1) + .25*(PIE-PIE_STAR);

// 4 Y
DL_GDP = DL_GDP_BAR + (Y - Y(-1));

DL4_GDP = DL_GDP_BAR + (Y - Y(-4));

DL_GDP_BAR = 0.9*DL_GDP_BAR(-1) + (1-0.9)*G_GDP_BAR + E_DL_GDP_BAR;

G_GDP_BAR = 0.9*G_GDP_BAR(-1) + (1-0.9)*growth_ss + E_G_GDP_BAR;

Y =  .57*Y(-1) +.23*Y(+1) - 0.19*LR_GAP(-1) - 0.19*(TERM10YR-TERM10YR_SS) - 0.1*ETA  + E_Y;

// 6
RR = RS-PIE(+1);

RR4 = (1/4)*(RR + RR(+1) + RR(+2) + RR(+3));

RS4 = (1/4)*(RS + RS(+1) + RS(+2) + RS(+3));

RS8 = (1/8)*(RS + RS(+1) + RS(+2) + RS(+3) + RS(+4) + RS(+5) + RS(+6) + RS(+7));

RS20 = (1/20)*( RS + RS(+1) + RS(+2) + RS(+3)+ RS(+4)+ RS(+5) + RS(+6) + RS(+7) + RS(+8) + RS(+9)
              + RS(+10) + RS(+11) + RS(+12) + RS(+13)+ RS(+14) + RS(+15) + RS(+16) + RS(+17) + RS(+18) 
              + RS(+19)  );

RS40 = (1/40)*( RS + RS(+1) + RS(+2) + RS(+3)+ RS(+4)                 
                + RS(+5) + RS(+6) + RS(+7) + RS(+8) + RS(+9)
                + RS(+10) + RS(+11) + RS(+12) + RS(+13)+ RS(+14) 
                + RS(+15) + RS(+16) + RS(+17) + RS(+18) + RS(+19)  
                + RS(+20) + RS(+21) + RS(+22) + RS(+23) + RS(+24)  
                + RS(+25) + RS(+26) + RS(+27) + RS(+28) + RS(+29)  
                + RS(+30) + RS(+31) + RS(+32) + RS(+33) + RS(+34)  
                + RS(+35) + RS(+36) + RS(+37) + RS(+38) + RS(+39)  );

TERM10YR = 0.05*TERM10YR_SS + (1-.05)*TERM10YR(-1) 
             +0.25*(1-C) - 2.00*DCNEG + E_TERM10YR; 

RS10YR = RS40 + TERM10YR;

RR_BAR4 = (1/4)*(RR_BAR + RR_BAR(+1) + RR_BAR(+2) + RR_BAR(+3));

LR = 0.1*RR + 0.35*RR4 + (0.35/3)*(RR4 + RR4(+4) + RR4(+8))
     + (0.2/5)* (RR4 + RR4(+4) + RR4(+8) + RR4(+12) + RR4(+16));

LR_BAR = 0.1*RR_BAR + 0.35*RR_BAR4 + (0.35/3)*(RR_BAR4 + RR_BAR4(+4) + RR_BAR4(+8))
     + (0.2/5)* (RR_BAR4 + RR_BAR4(+4) + RR_BAR4(+8) + RR_BAR4(+12) + RR_BAR4(+16));

LR_GAP = LR - LR_BAR;


// 5 RR_GAP
RR_BAR = 0.95*RR_BAR(-1) + (1-0.95)*RR_BAR_STAR + E_RR_BAR;

RR_GAP = RR - RR_BAR;

// 7
DRS = RS - RS(-1);

// 8
PIE_GAP = PIE4 - PIE_STAR;


// 9
LOSS = PIE_GAP^2 + 1.0*Y^2 + .5*DRS^2 + 0.1*PGAP^2;

YNEG = (Y-ABS(Y))/2;

PGAPNEG = (PGAP-ABS(PGAP))/2;

DC = C - C(-1);

DCNEG = (DC-ABS(DC))/2;

RSFED = X*RS + (1-X)*RSDOTPLOT;

RSFEDGAP = RSFED - RS;

X = X_SS + E_X;

RS_TAY = RR_BAR + PIE4 + 0.5*(PIE4-PIE_STAR) + 0.5*Y;

RS40_TAY = (1/40)*( RS_TAY + RS_TAY(+1) + RS_TAY(+2) + RS_TAY(+3)+ RS_TAY(+4)                 
                + RS_TAY(+5) + RS_TAY(+6) + RS_TAY(+7) + RS_TAY(+8) + RS_TAY(+9)
                + RS_TAY(+10) + RS_TAY(+11) + RS_TAY(+12) + RS_TAY(+13)+ RS_TAY(+14) 
                + RS_TAY(+15) + RS_TAY(+16) + RS_TAY(+17) + RS_TAY(+18) + RS_TAY(+19)  
                + RS_TAY(+20) + RS_TAY(+21) + RS_TAY(+22) + RS_TAY(+23) + RS_TAY(+24)  
                + RS_TAY(+25) + RS_TAY(+26) + RS_TAY(+27) + RS_TAY(+28) + RS_TAY(+29)  
                + RS_TAY(+30) + RS_TAY(+31) + RS_TAY(+32) + RS_TAY(+33) + RS_TAY(+34)  
                + RS_TAY(+35) + RS_TAY(+36) + RS_TAY(+37) + RS_TAY(+38) + RS_TAY(+39)  ) ;

RS10Y_TAY = RS40_TAY + + TERM10YR;

//10 Unemployment
UNR_GAP = UNR_BAR - UNR;

UNR_BAR = UNR_BAR(-1) + g_UNR + E_UNR_BAR;

g_UNR   =(1-0.4)*g_UNR(-1) + E_UNR_g;

//UNR_GAP = 0.2*Y + 0.7*UNR_GAP(-1) + 0.1*Y(+1) + E_UNR;
UNR_GAP = 0.1*Y + 0.7*UNR_GAP(-1) + 0.1*Y(+1) + E_UNR;



//11 Bank Landing Tightening
BLT = BLT_BAR - 20*Y(+4) + E_BLT;

BLT_BAR = 0.9*BLT_BAR(-1) + E_BLT_BAR;

ETA = 0.04*E_BLT(-1) + 0.08*E_BLT(-2) + 0.12*E_BLT(-3) + 0.16*E_BLT(-4) + 0.20*E_BLT(-5) + 0.16*E_BLT(-6) + 0.12*E_BLT(-7) + 0.08*E_BLT(-8) + 0.04*E_BLT(-9); 

end; 

steady_state_model;
  PIE = PIE_STAR;
  PIE4 = PIE_STAR;
  PIE_GAP = 0;
  Y = 0;
  RR = RS - PIE;
  RR4 = RR;
  DRS = 0;
  RR_BAR = RR_BAR_STAR;
  RR_BAR4 = RR_BAR_STAR;
  LR = RR4;
  LR_BAR = RR_BAR4;
  RR_GAP = 0;
  LR_GAP = 0;
  LOSS = 0;
  PGAP = 0;
  PGAPNEG = 0;
  RS4 = RS;
  RS8 = RS;
  RS20 = RS;
  RS40 = RS;
  YNEG =0;
  TERM10YR = TERM10YR_SS;
  RS10YR = RS + TERM10YR;
  RSFED = RS ;
  X = X_SS;
  RSFEDGAP = 0;
  C = 1;
  SIGNAL_CBP = 1;
  PIE4EXP4 = PIE_STAR;
  PIE4EXP8 = PIE_STAR;
  PIE4EXP20 = PIE_STAR;
  PIE4EXP40 = PIE_STAR;
  CUMSUMY = 0;
  RES_PIE4_LOW = 0;
  RES_PIE4_HIGH = -.8;
  DC = 0;
  DCNEG = 0;
  RS_TAY = RR_BAR + PIE4 + 0.5*(PIE4-PIE_STAR) + 0.5*Y;
  RS40_TAY = RS_TAY;
  RS10Y_TAY = RS40_TAY + + TERM10YR;
  UNR_BAR = 5;
  UNR_GAP = 0;
  UNR     = UNR_BAR;
  g_UNR   = 0;
  G_GDP_BAR = growth_ss;
  DL_GDP_BAR = G_GDP_BAR;   
  DL_GDP = DL_GDP_BAR; 
  DL4_GDP = DL_GDP_BAR;
  BLT_BAR = 0;   
  BLT = BLT_BAR; 
  ETA = 0;   

end; 
 

planner_objective 1.0*PIE_GAP^2 + 1.0*YNEG^2 + 0.5*DRS^2 + 10*PGAPNEG^2 + 10*RSFEDGAP^2;

ramsey_model(planner_discount = 0.95, instruments=(RS));

ramsey_constraints;
  RS > 0.1;
end;
  
initval;
  RS = 3.0;
  RSDOTPLOT = 3.0;
end;

steady;

histval;
C(0) = 0.95;
Y(-1) = 1.3; //0.5
Y(0) = 1.0;
PIE(0) = 3.0; //2.1;  // Nowcast for Core PCE 2025Q1, QoQ Annualized, April 29, 2025
PIE(-1) = 2.7; 
PIE(-2) = 2.6;
PIE(-3) = 2.6; 
//PIE4(0) = 3.3; 
LR_GAP(0) = -1.0; 
RR_BAR(0) = 1.0; //0.8; 
RS(0) = 4.3; // Average Effective Fed Funds Rate 2025Q1
PGAP(0) = -1.0; 
TERM10YR(0) = 0.8;
RS10YR(0)= 4.5;
UNR_BAR(0)  = 4.5;
UNR(0)  = 4.1; //2025Q1
UNR_GAP(0) = 0.4;
DL_GDP(-1) = 0.6; //2025Q1
DL_GDP(0) = -2.7; 
DL_GDP_BAR(0) = 0.45;
G_GDP_BAR(0) = 0.45;
BLT(-3) = 36.0;
BLT(-2) = 41.2;
BLT(-1) = 42.1;
BLT(0) = 39.7;
end;


// shocks learned in period 1
scenario!(name = :E_Y, period = 1, value = 0.6);
scenario!(name = :E_Y, period = 2, value = 0.5);
scenario!(name = :E_PIE, period = 1, value = 1.5);
scenario!(name = :E_PIE, period = 2, value = 1.0);
scenario!(name = :E_PIE, period = 2, value = 0.5);
scenario!(name = :E_X, period = 1, value = 0.0);
//scenario!(name = :E_X, period = 1, value = -1.0); // 0 turn off, -2 turn on
scenario!(name = :RSDOTPLOT, period = 1, value = 5.3);

// shocks learned in period 2
scenario!(name = :E_Y, period = 2, value = 0.0, infoperiod = 2);
scenario!(name = :E_Y, period = 3, value = 0.0, infoperiod = 2);
scenario!(name = :E_Y, period = 4, value = 0.0, infoperiod = 2);

scenario!(name = :E_PIE, period = 2, value = 0.0, infoperiod = 2);
scenario!(name = :E_PIE, period = 3, value = 0.0, infoperiod = 2);
scenario!(name = :E_PIE, period = 4, value = 0.0, infoperiod = 2);

scenario!(name = :RSDOTPLOT, period = 2, value = 3.25);

perfect_foresight!(periods = 150, mcp = true);
