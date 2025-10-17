function X,Y,M1,M2,M3 = alg4(T,omega,alp,bet,gam)
    M = {[],[],[]};
    Y = omega .* T;
    X = Y;
    tau = gam/(alp*bet);

    while true
        for i = 1:3
            M{i} = D(X,Y,tau,i,alp,bet);
        end


        
        







        if convergence
            break
        end
    end

end

