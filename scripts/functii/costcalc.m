function cost = costcalc(A2,Y)
    % Y  = etichetele reale
    % A2 = iesirea retelei
    
    m = size(Y,2); %nr de exemple = 60k
    
    logprob = log(A2 + 1e-8); % 1e-8 in caz ca A2 e 0
    
    cost_mat = Y .*logprob;
    cost = - (1/m)* sum(cost_mat, 'all');
    cost = squeeze(cost);

end