% Define the ODE parameters
f = @(t, x) 7.*t.*x;
t0 = 3;
x0 = 5;
t_end = 5;  % Choose an end time for visualization

% Analytical solution
x_analytical = @(t) 5 .* exp(7/2 .* (t.^2 - 9));

% Define the contraction mapping
P = @(x, t) x0 + arrayfun(@(ti) integral(@(s) f(s, x(s)), t0, ti), t);

% Initialize
n_iterations = 10;  % Number of iterations
t = linspace(t0, t_end, 100);  % Time vector for plotting
x = cell(n_iterations + 1, 1);  % Cell array to store each iteration
x{1} = @(t) x0 .* ones(size(t));  % Initial guess: constant function

% Perform iterations
for n = 1:n_iterations
    x{n+1} = @(t) P(x{n}, t);
end

% Compute errors
errors = zeros(n_iterations + 1, 1);
for n = 1:(n_iterations + 1)
    errors(n) = max(abs(x{n}(t) - x_analytical(t)));
end

% Plotting
figure;

% Plot approximations
subplot(2, 1, 1);
hold on;
for n = 1:(n_iterations + 1)
    plot(t, x{n}(t), 'DisplayName', sprintf('Iteration %d', n-1));
end
plot(t, x_analytical(t), 'k--', 'LineWidth', 2, 'DisplayName', 'Analytical');
hold off;
xlabel('t');
ylabel('x(t)');
title('Approximations vs Analytical Solution');
legend('show', 'Location', 'northwest');

% Plot errors
subplot(2, 1, 2);
semilogy(0:n_iterations, errors, 'o-');
xlabel('Iteration');
ylabel('Max Error');
title('Convergence of Approximations');
grid on;

% Display final error
fprintf('Final max error: %e\n', errors(end));