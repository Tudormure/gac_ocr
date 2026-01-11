function [X_train,Y_train,X_test,Y_test] = gen_in()
    % Generare input
    fun_path = fileparts(mfilename('fullpath'));
    scripts_path = fileparts(fun_path);
    proiect_path = fileparts(scripts_path);
    cd(proiect_path);
    
    timg_file = fullfile(proiect_path,'mnist','train-images.idx3-ubyte');   %'...proiect-ocr\mnist\train-images.idx3-ubyte';
    tlab_file = fullfile(proiect_path,'mnist','train-labels.idx1-ubyte');
    bimg_file = fullfile(proiect_path,'mnist','t10k-images.idx3-ubyte');
    blab_file = fullfile(proiect_path,'mnist','t10k-labels.idx1-ubyte');
    [X_train,Y_train,X_test,Y_test] = vectorizare_mnist(timg_file,tlab_file,bimg_file,blab_file);
   
end