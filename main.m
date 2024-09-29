mkdir('explicit_plots');

for t = arrayfun(@(x) x/8, 1:4) % t = 1/8 -> 4/8
    tiledPlot = figure;
    set(gcf, 'Name', strcat('t=',num2str(8*t),'/8'))
    tiledlayout(4, 7, 'TileSpacing', 'Compact');
    colormap('hot');

    for N = arrayfun(@(x) 2^x-1, 2:5) % N = 3 -> 31
        for dt = arrayfun(@(x) 2^-x, 6:12) % dt = 1/64 -> 1/4096
            T = zeros(N+2,N+2);
            T_initial = ones(N,N);
            T(2:end-1,2:end-1) = explicitEulerDirichlet(N,N,t,dt,T_initial); % Pad T for plotting

            x = linspace(0,1,N+2);
            y = linspace(0,1,N+2);
            [X,Y] = meshgrid(x,y); % Create mesh to plot surface

            figure(tiledPlot);
            nexttile;
            surf(X,Y,T);
            title(strcat('Nx=',num2str(N),' Ny=',num2str(N),' dt=1/',num2str(1/dt)));
            
            s = figure('visible','off'); % Create invisible figure to export
            surf(X,Y,T); % Surface plot of heat distribution
            title(strcat('Nx=',num2str(N),' Ny=',num2str(N),' dt=1/',num2str(1/dt)));

            fn = strcat('Nx=',num2str(N),' Ny=',num2str(N),' dt=2^',num2str(log2(dt)),' t=',num2str(8*t),'.jpg');
            full_fn = fullfile(pwd,'explicit_plots',fn);
            exportgraphics(s,full_fn); % Save plot to folder
        end
    end
end

for t = arrayfun(@(x) x/8, 1:4) % t = 1/4 -> 4/4
    tiledPlot = figure;
    tiledlayout(4, 1, 'TileSpacing', 'Compact');
    colormap('hot');

    for N = arrayfun(@(x) 2^x-1, 2:5) % N = 3 -> 31
        for dt = arrayfun(@(x) 2^-x, 6:6) % dt = 1/64 -> 1/64
            T = zeros(N+2,N+2);
            T_initial = ones(N,N);
            T(2:end-1,2:end-1) = implicitEulerDirichlet(N,N,t,dt,T_initial); % Pad T for plotting

            x = linspace(0,1,N+2);
            y = linspace(0,1,N+2);
            [X,Y] = meshgrid(x,y); % Create mesh to plot surface

            figure(tiledPlot);
            set(gcf, 'Name', strcat("implicit Euler",'t=',num2str(8*t),'/8'))
            nexttile;
            surf(X,Y,T);
            title(strcat('Nx=',num2str(N),' Ny=',num2str(N),' dt=1/',num2str(1/dt)));
        end
    end
end

