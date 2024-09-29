function T = implicitEulerDirichlet(Nx,Ny,t,dt,T_initial)
    T_old = zeros(Ny+2,Nx+2);
    T_old(2:end-1,2:end-1) = T_initial;

    T_initial = T_old;
    T = T_old;

    hx = 1/(Nx+1);
    hy = 1/(Ny+1);
    c = dt*(2/hx^2 + 2/hy^2); % Inverse coefficient of T(i,j)

    for q = 0:t/dt
        while 1
            for i = 2:Ny+1
                for j = 2:Nx+1
                    T(i,j) = (T_initial(i,j)...
                    +dt*(T(i-1,j)+T_old(i+1,j))/hy^2 ...
                    +dt*(T(i,j+1)+T_old(i,j-1))/hx^2)/(1+c);
                end
            end

            if sqrt(norm(T_old-T, 'fro')/(Nx*Ny)) < 1e-6 % Tolerance
                T_old = T;
                break;
            end

            T_old = T; % Store T to calculate residual norm
        end

        T_initial = T; % Update RHS after every timestep
    end

    T = T(2:Ny+1, 2:Nx+1);
end
