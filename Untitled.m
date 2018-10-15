clear all;
clf;
randn('seed',2);
rand('seed',2);
x = -10 + 20*rand(50,1);
a_true = 2; b_true = 5;
y =a_true * x + b_true;
%noise = randn(50,1) + 20*[zeros(19,1);1;zeros(19,1);1;zeros(10,1)];
%noise = randn(50,1);
noise = trnd(1,[50,1]);

y = y + noise;
plot(x,y,'b.')

cvx_begin
    variable a_est1(1)
    variable b_est1(1)
    minimize( norm( y-a_est1 * x - b_est1, 2 ) )
cvx_end
x_est1 = (-10:10);
y_est1 = a_est1 * x_est1 + b_est1;
hold on;
plot(x_est1,y_est1,'r-');
txt2 = ' \phi_1(r) \Rightarrow';
text(x_est1(14)-3,y_est1(14),txt2)
grid on


cvx_begin
    variable a_est2(1)
    variable b_est2(1)
    minimize( norm( y-a_est2 * x - b_est2, 1 ) )
cvx_end
x_est2 = (-10:10);
y_est2 = a_est2 * x_est2 + b_est2;
hold on;
plot(x_est2,y_est2,'g-');
txt1 = '\Leftarrow \phi_2(r)';
text(x_est2(7)+1,y_est2(7),txt1)
grid on

est_error1 = (a_est1-a_true)^2+(b_est1-b_true)^2;
est_error2 = (a_est2-a_true)^2+(b_est2-b_true)^2;

txt = sprintf('%s=%f','a_{est1}',a_est1);
text(-8,21,txt)
txt = sprintf('%s=%f','b_{est1}',b_est1);
text(-8,18,txt)
txt = sprintf('%s=%f','error_{est1}',est_error1);
text(-8,15,txt)
txt = sprintf('%s=%f','a_{est2}',a_est2);
text(0,-9,txt)
txt = sprintf('%s=%f','b_{est2}',b_est2);
text(0,-12,txt)
txt = sprintf('%s=%f','error_{est2}',est_error2);
text(0,-15,txt)
title('Noise(2) (Significant Noise)')