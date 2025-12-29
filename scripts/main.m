    % vectorizare_mnist(timg_file,tlab_file,bimg_file,blab_file)
   addpath('functii');

    timg_file = 'D:\matlab_proiecte\proiect_ocr\mnist\train-images.idx3-ubyte';
    tlab_file = 'D:\matlab_proiecte\proiect_ocr\mnist\train-labels.idx1-ubyte';
    bimg_file = 'D:\matlab_proiecte\proiect_ocr\mnist\t10k-images.idx3-ubyte';
    blab_file = 'D:\matlab_proiecte\proiect_ocr\mnist\t10k-labels.idx1-ubyte';
    
    % X = "pozele", Y = labels
    
    [X_train,Y_train,X_test,Y_test] = vectorizare_mnist(timg_file,tlab_file,bimg_file,blab_file);
    
    % X_train = gpuArray(X_train);
    % Y_train = gpuArray(Y_train);
    % X_test  = gpuArray(X_test );
    % Y_test  = gpuArray(Y_test );
    % 


%% ----------------------------------CHECK-DATA(si vizualizare poze)--------------------------------------------------------

    % idx = randi(size(X_train, 2)); 
    % img_vector = X_train(:, idx);
    % img_matrix = reshape(img_vector, 28, 28)';
    % figure;
    % imshow(img_matrix);
    % title(sprintf('Index: %d | Label Real: %d', idx, Y_train(idx)));
    % fprintf('Daca vezi cifra %d, totul e corect!\n', Y_train(idx));


%% ----------------------------------Transformare-Y-in-One-Hot--------------------------------------------------

    num_clases = 10;                        % avem 10 cifre in repertoriu
    tnum_samples = size(Y_train,2);         % doar dimensiunea a 2-a adk 60k
    bnum_samples = size(Y_test ,2);         % doar dimensiunea a 2-a adk 10k
    Y_train_one_hot = zeros(num_clases,tnum_samples);   % matrice 10 x 60k
    Y_test_one_hot  = zeros(num_clases,bnum_samples);   % matrice 10 x 10k
    
    for i = 1:tnum_samples
        cif = Y_train(i) + 1; % + 1 deoarece matlab indexeaza de la 1 vectorii
        Y_train_one_hot(cif,i) = 1;
    end
    
    for i = 1:bnum_samples
        cif = Y_test(i)  + 1; % + 1 deoarece matlab indexeaza de la 1 vectorii
        Y_test_one_hot(cif,i) = 1;
    end
       
%% ----------------------------------Initializare Parametrii Retea--------------------------------------------------
    
    %function params= init_params(in_size,hidden_size,out_size)
    input_nodes = 784;  % 28 * 28
    hidden_nodes = 128; % modificabil
    output_nodes = 10;  
    
    % parameters = init_params(input_nodes,hidden_nodes,output_nodes);
    % verificare
    % disp('dimensiune w1: '); disp(size(parameters.W1));



 %% ----------------------------------Antrenarea----------------------------------------------------------------------
    
    fprintf('Incepem antrenarea\n');
    epoci = 1000;
    learning_rate = 0.5;

    cost_history = zeros(1,epoci); %pentru grafic final daca fac gui pt antrenare
    tic
    for i = 1 : epoci


        [A2,cache] = forw_prop(X_train, parameters);
        cost = costcalc(A2, Y_train_one_hot);
        cost_history(i) = cost;
        grads = back_prop(parameters,cache,X_train,Y_train_one_hot);
        parameters = update_par(parameters,grads,learning_rate);

        if mod(i,1) == 0
            acc = accuracy(A2,Y_train);
            fprintf('Epoca %d Cost = %f | Acuratete = %.4f%%| Learn_rate = %.4f ',i,cost,acc,learning_rate);
        end

        if mod(i,500) == 0
            learning_rate = learning_rate / 2;

        end
        
        [A2_test,~] = forw_prop(X_test,parameters);
        final_acc = accuracy(A2_test, Y_test);
    
        fprintf('Acuratetea finala pe 10k imagini noi %.2f%%\n',final_acc);    
        

    end

    toc


    fprintf('Rulam  acum testul pe datele de test\n');
   
    [A2_test,~] = forw_prop(X_test,parameters);
    final_acc = accuracy(A2_test, Y_test);

    fprintf('Acuratetea finala pe 10k imagini noi %.2f%%\n',final_acc);






