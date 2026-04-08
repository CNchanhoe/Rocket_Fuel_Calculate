function advanced_rocket_simulation()
    p.g0 = 9.80665;
    p.Re = 6371000;
    
    p.thrust_kN = 7600;
    p.Isp = 282;
    p.m_initial = 500000;
    p.m_propellant = 400000;
    p.m_dry = p.m_initial - p.m_propellant;
    
    p.Cd = 0.5;
    p.A = 10.5;
    p.rho0 = 1.225;
    p.H = 8500;

    p.thrust = p.thrust_kN * 1000; 
    p.mdot = p.thrust / (p.Isp * p.g0);
    p.mdot_hour = p.mdot * 3600;

    t_span = [0 200];
    y0 = [0; 0; p.m_initial];

    options = odeset('RelTol', 1e-6, 'AbsTol', 1e-8);
    [t, Y] = ode45(@(t, Y) rocket_dynamics(t, Y, p), t_span, y0, options);

    altitude = Y(:, 1) / 1000;
    velocity = Y(:, 2);
    mass = Y(:, 3) / 1000;

    fprintf('\n========== Advanced Rocket Burn Simulation Results ==========\n');
    fprintf('Fuel consumption per second:\t\t%.2f kg/s\n', p.mdot);
    fprintf('Theoretical consumption per hour:\t%.2f ton/h\n', p.mdot_hour / 1000);
    
    burn_time = p.m_propellant / p.mdot;
    fprintf('Actual engine burn time:\t\t%.2f s (approx. %.1f min)\n', burn_time, burn_time/60);
    fprintf('Altitude at engine cut-off:\t\t%.2f km\n', interp1(t, altitude, burn_time));
    fprintf('Max velocity at engine cut-off:\t\t%.2f m/s\n', interp1(t, velocity, burn_time));
    fprintf('=================================================================\n');

    figure('Name', 'Rocket Flight Data', 'Position', [100, 100, 900, 600]);
    
    subplot(3,1,1);
    plot(t, altitude, 'b', 'LineWidth', 2);
    xline(burn_time, 'r--');
    ylabel('Altitude (km)'); title('Rocket Altitude over Time'); grid on;

    subplot(3,1,2);
    plot(t, velocity, 'g', 'LineWidth', 2);
    xline(burn_time, 'r--');
    ylabel('Velocity (m/s)'); title('Rocket Velocity over Time'); grid on;

    subplot(3,1,3);
    plot(t, mass, 'k', 'LineWidth', 2);
    xline(burn_time, 'r--');
    ylabel('Mass (ton)'); xlabel('Time (s)'); title('Rocket Mass over Time'); grid on;
end

function dYdt = rocket_dynamics(~, Y, p)
    y = Y(1);
    v = Y(2);
    m = Y(3);

    rho = p.rho0 * exp(-y / p.H); 
    g = p.g0 * (p.Re / (p.Re + y))^2; 

    if y < 0, rho = p.rho0; end
    drag = 0.5 * rho * v^2 * p.Cd * p.A * sign(v);

    if m > p.m_dry
        T = p.thrust;
        mdot_current = p.mdot;
    else
        T = 0;
        mdot_current = 0;
    end

    dydt = v;
    dvdt = (T - drag) / m - g;
    dmdt = -mdot_current;

    if y <= 0 && dvdt < 0
        dydt = 0;
        dvdt = 0;
    end

    dYdt = [dydt; dvdt; dmdt];
end