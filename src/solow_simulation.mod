// ------------------------------------------------------------------------
// 1. VARIABLE DEFINITION
// ------------------------------------------------------------------------
// Here we define the endogenous variables (calculated by the model).
// We use lowercase letters to denote variables "per capita" or per effective worker.
var y   // Output per effective worker (adjusted per capita GDP)
    k   // Capital per effective worker
    c   // Consumption per effective worker
    i   // Investment per effective worker
    r   // Marginal return on capital (implicit real interest rate)
    w;  // Real wage per unit of effective labor

// We define the exogenous variables (shocks coming from outside).
// In our case, the main shock is the population growth rate (n).
varexo n; 

// ------------------------------------------------------------------------
// 2. PARAMETERS AND CALIBRATION
// ------------------------------------------------------------------------
parameters alpha delta s g;

// Values extracted from the essay:
alpha = 0.37;   // Capital share of income
delta = 0.038;  // Annual depreciation rate
s     = 0.21;   // Structural savings rate
g     = 0.011;  // Productivity growth (1.1%)

// ------------------------------------------------------------------------
// 3. MODEL (EQUATIONS)
// ------------------------------------------------------------------------
// Here we translate the equations from the essay into Dynare language.

model;
    // 1. Cobb-Douglas production function
    y = k(-1)^alpha;

    // 2. Law of motion for capital 
    // k_t+1 = (s*y_t + (1-delta)*k_t) / ((1+n)*(1+g))
    // Note: Since 'n' is now an exogenous variable, we include it in the equation.
    k = (s*y + (1-delta)*k(-1)) / ((1+n)*(1+g));

    // 3. Income Identity (Consumption is what remains after saving)
    c = (1-s) * y;

    // 4. Investment
    i = s * y;

    // 5. Factor prices (Perfect competition)
    // Real interest rate (Marginal product of capital - depreciation)
    r = alpha * k(-1)^(alpha-1) - delta;
    
    // Wages (Marginal product of labor)
    w = (1-alpha) * k(-1)^alpha;
end;

// ------------------------------------------------------------------------
// 4. INITIAL STEADY STATE
// ------------------------------------------------------------------------
// We provide Dynare with a starting point. We assume n=0 initially (stable population).
initval;
    n = 0; 
    // Solow steady state capital formula: k* = (s / (n+g+delta+n*g))^(1/(1-alpha))
    k = (s / (0 + g + delta + 0*g))^(1/(1-alpha));
    y = k^alpha;
    c = (1-s)*y;
    i = s*y;
    r = alpha * k^(alpha-1) - delta;
    w = (1-alpha) * k^alpha;
end;

// We verify that residuals are zero (equations hold)
steady;
check;

// ------------------------------------------------------------------------
// 5. DEMOGRAPHIC SHOCK SIMULATION (Demographic Winter)
// ------------------------------------------------------------------------
// Here we define the "shock": We move from n=0 to n=-0.001 (population decline)
// as indicated in the essay.

shocks;
    var n;
    periods 1:100; // The shock lasts 100 periods (long run)
    values -0.001; // Population growth rate falls to -0.1%
end;

// We simulate 100 years (approx. 2025-2125)
perfect_foresight_setup(periods=100);
perfect_foresight_solver;

// ------------------------------------------------------------------------
// 6. PLOTTING
// ------------------------------------------------------------------------
// This block automatically creates the charts.

// Define time vector
T_sim = length(oo_.endo_simul(1,:));
t_vec = 0:(T_sim-1);

// Variable names to find their indices
iy = strmatch('y', M_.endo_names, 'exact');
ik = strmatch('k', M_.endo_names, 'exact');
ir = strmatch('r', M_.endo_names, 'exact');
ic = strmatch('c', M_.endo_names, 'exact');
iw = strmatch('w', M_.endo_names, 'exact');

figure('Name', 'Impact of Demographic Winter (Solow Model)');

// 1. Capital per effective worker (Capital Deepening)
subplot(2,3,1);
plot(t_vec, oo_.endo_simul(ik,:), 'LineWidth', 2); title('Capital per ef. worker (k)'); grid on;

// 2. Output (Adjusted per capita GDP)
subplot(2,3,2);
plot(t_vec, oo_.endo_simul(iy,:), 'LineWidth', 2); title('Output per ef. worker (y)'); grid on;

// 3. Real Interest Rate (r)
subplot(2,3,3);
plot(t_vec, oo_.endo_simul(ir,:), 'r', 'LineWidth', 2); title('Real Interest Rate (r)'); grid on;

// 4. Real Wages (w)
subplot(2,3,4);
plot(t_vec, oo_.endo_simul(iw,:), 'm', 'LineWidth', 2); title('Real Wages (w)'); grid on;

// 5. Consumption (c)
subplot(2,3,5);
plot(t_vec, oo_.endo_simul(ic,:), 'k', 'LineWidth', 2); title('Consumption (c)'); grid on;

sgtitle('Simulation: n drops from 0% to -0.1% (Spain Scenario 2025-2050)');
