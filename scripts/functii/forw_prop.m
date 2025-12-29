function [A2, cache] = forw_prop(X, params)
    % returneaza ultimul layer sivalorile intermediare
    % avansarea efectiva prin retea
    W1 = params.W1;
    b1 = params.b1;
    W2 = params.W2;
    b2 = params.b2;
    
    % X = X(:,1);
   
    % disp(size(X));
    % disp(size(W2));
    
    Z1 = W1*X + b1; % valorile spre al doilea layer
    A1 = relu(Z1);  % activarea neuronilor din al doiela layer

    Z2 = W2*A1 + b2; % valorile spre ultimul layer
    A2 = softmax(Z2);  % activarea neuronilor in output + distributia de prob

    cache.Z1 = Z1;
    cache.A1 = A1;
    cache.Z2 = Z2;
    cache.A2 = A2;  %salvarea parametrilor

   
end