function [X,Y,M] = alg4(T,omega,alp,bet,gam,tol)
    M = {[],[],[]};
    Y = omega .* T;
    X = omega .* T;
    Tnorm = norm(T,'fro');
    k = 0;
    while true
        for i = 1:3
            tau = gam(i)/(alp(i)+bet(i));
            M{i} = D(X,Y,tau,i,alp(i),bet(i));
        end
        X = alp(1) * M{1} + alp(2) * M{2} + alp(3) * M{3};
        X = X/sum(alp);

        Y = omega .* T +((1-omega).*(bet(1) * M{1} + bet(2) * M{2} + bet(3) * M{3}))/sum(bet);
        error = norm(omega.*(X-T),'fro')/Tnorm;
        if error < tol
            break
        end

        if k > 60
            break
        end
        
        k = k+1;
        fprintf("\ttimestep k: %d, e: %e\n",k,error);

    end
end

