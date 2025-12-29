function out = softmax(x)
    
    % in softmax se introduce output layer si se obtine
    % distributia de probabilitate
    % prob_i = (e^xi)/(sum(e^xj)
    exps    = exp(x);
    sum_exp = sum(exps,1);

    out = exps ./ sum_exp;
   
end