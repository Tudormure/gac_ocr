function params= init_params(in_size,hidden_size,out_size)
    
    %-------------------DOAR PENTRU UN HIDDEN LAYER-------------------
    %!sa mai pun pentru mai multe hidden layers si sa selctezi functia de
    %randomizare
    % in_size       = 784 pixeli
    % hidden_size   = cati neuroni hidden
    % out_size      = 10 cifre

    fprintf('Se initializeaza parametrii (input: %d, hidden: %d, output: %d)\n',...
        in_size,hidden_size,out_size);
    
    %--------------------Strat 1: poze->hidden layer--------------------
        % matricea pt weights * 0.01 
        params.W1 = randn(hidden_size,in_size,'gpuArray')*0.01;
        % matricea pt bias
        params.b1 = zeros(hidden_size,1,'gpuArray');
    %-------------------Strat 2: hidden layer-output-------------------
        params.W2 = randn(out_size,hidden_size,'gpuArray')*0.01;
        params.b2 = zeros(out_size,1,'gpuArray');
end