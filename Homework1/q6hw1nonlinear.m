% Define symbolic variables
syms x1 x2 a b c

% Define the system of equations
f1 = atan(a * x1) - x1 * x2;
f2 = b * x1^2 - c * x2;
M = [f1,f2];
lambda = [a,b,c];
x = [x1,x2];
A = jacobian([f1;f2],x);
B = jacobian([f1;f2],lambda)

