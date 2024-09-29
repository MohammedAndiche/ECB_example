function T = explicitEulerDirichlet(Nx,Ny,t,dt,T_initial)
    hx = 1/(Nx+1);
    hy = 1/(Ny+1);
    
    T = T_initial; % Initial condition of inner surface
    B = dt*[0      1/hy^2             0;
            1/hx^2 1/dt-2/hx^2-2/hy^2 1/hx^2;
            0      1/hy^2             0]; % Define convolution matrix


    for q = 0:t/dt
        T = conv2(T,B,'same'); % Explicit Euler with for loop is
                               % equivalent to convoluting with heat
                               % convolution matrix
                               % NOTE: conv2 automatically pads with
                               % zeros, which is equivalent to our
                               % boundary condition
    end
end
   % If using the conv function is not allowed this is equivalent
   %T_new = zeros(Nx + 2, Ny + 2);
   % for q = 0:t/dt
   %      for i = 2:Nx + 1
   %          for j = 2:Ny + 1
   %              T_new(i, j) = T(i, j) + dt * ((T(i - 1, j) - 2 * T(i, j) + T(i + 1, j)) / hx^2 + (T(i, j - 1) - 2 * T(i, j) + T(i, j + 1)) / hy^2);
   %          end
   %      end
   %      T=T_new;
   %  end