function grads = back_prop(parameters,cache,X,Y)

    m = size(X,2); %numarul de exemple = 60k
    
    Z1 = cache.Z1;
    A1 = cache.A1;
    A2 = cache.A2;

    W2 = parameters.W2;

    %--------------------------Derivatele pentru stratul 2--------------------------
    % dZ2 - eroarea directa = Predictie - Realitate
    dZ2 = A2 - Y;
    grads.dW2 = (1/m) * (dZ2 * A1');
    grads.db2 = (1/m) * sum(dZ2,2);
    
    error_hidden = W2' * dZ2;

    dZ1 = error_hidden.*(Z1>0);

    % disp(size(dZ1));
    % disp(size(X));
    
    grads.dW1 = (1/m) *(dZ1* X');
    grads.db1 = (1/m) * sum(dZ1,2);

end