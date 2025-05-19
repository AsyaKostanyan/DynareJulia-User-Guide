var PIE, R, Y;

varexo eps_Y;

model;

PIE = 0.5*PIE(-1) + 0.5*PIE(+1) + 0.5*Y;

Y = 0.5*Y(-1) + 0.5*Y(+1) - 0.2*R + eps_Y;

R = 1.5*PIE(+1) + 0.2*Y;

end;

shocks;
var eps_Y; stderr 0.01;
end;

check;

stoch_simul(order = 1, irf = 25);
