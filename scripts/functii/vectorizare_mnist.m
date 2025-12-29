function [timages,tlabels,bimages,blabels] = vectorizare_mnist(timg_file,tlab_file,bimg_file,blab_file)
    %timages,tlabels = train     images/labels
    %bimages,blabels = benchmark images/labels
    %   out: (28 * 28 * nr_imagini) pentru tests si benchmark
    %   out: (nr_imagini)           vector labels pt t si b
    
    %------------------------------------TRAIN---------------------------------------------------------
        %-------------------------------TRAIN-IMAGES---------------------------------------------------
            % citim timg_file ca fisier binar
            fid = fopen(timg_file, 'r', 'b'); %'b' - inseamna pentru Big-Endian format
        
            if fid == -1
                 fprintf("test");
                 error("Nu s-a putut deschide fisierul: %s", timg_file);
            end
            
            % citim header-ul 4 int pe 32 bits
            magic_num_timg  = fread(fid,1,'int32'); %semantura digitala care ne spune ca avem 08*03 (2051), utila cand nu stim ce tip de date sunt
            num_timg        = fread(fid,1,'int32');
            rows_timg       = fread(fid,1,'int32');
            cols_timg       = fread(fid,1,'int32');
            % disp(num_timg);
            % disp(rows_timg);
            % disp(cols_timg);

            %citeste fiecare pixel in parte
            timg_raw_data = fread(fid,inf,'unsigned char');
            fclose(fid);
        
            % din matrice de 1 x 784*num_images facem matrice de num_images x 784
            timages = reshape(timg_raw_data,[rows_timg *cols_timg ,num_timg]);
        
            % din valori de 0-255 facem valori intre 0 si 1
            timages = double(timages)/255;
    
    
        %-------------------------------TRAIN-LABELS---------------------------------------------------
            % citim tlab_file ca fisier binar
            fid = fopen(tlab_file,'r','b');
            if fid == -1
                error("Nu s-a putut deschide fisierul: %s", tlab_file);
            end
            
            magic_num_tlab  = fread(fid,1,'int32'); %semantura digitala care ne spune ca avem 08*01 (2049)
            num_tlab        = fread(fid,1,'int32'); %numarul de etichete
            
            %citim etichtele
            tlabels         = fread(fid,inf,'unsigned char');
            fclose(fid);
            tlabels = double(tlabels');
        
            if size(timages,2) ~= size(tlabels,2)
                error('nr de imagini e diferit de numarul de etichete la train')
            end
    %-------------------------------------BENCHMARK-----------------------------------------------------
        %------------------------------BENCHMARK-IMAGES-------------------------------------------------
            % citim bimg_file ca fisier binar
            fid = fopen(bimg_file, 'r', 'b'); %'b' - inseamna pentru Big-Endian format
        
            if fid == -1
                 error("Nu s-a putut deschide fisierul: %s", bimg_file);
            end
            
            % citim header-ul 4 int pe 32 bits
            magic_num_bimg  = fread(fid,1,'int32'); %semantura digitala care ne spune ca avem 08*03 (2051)
            num_bimg        = fread(fid,1,'int32');
            rows_bimg       = fread(fid,1,'int32');
            cols_bimg       = fread(fid,1,'int32');
        
            %citeste fiecare pixel in parte
            bimg_raw_data = fread(fid,inf,'unsigned char');
            fclose(fid);
        
            % din matrice de 1 x 784*num_images facem matrice de num_images x 784
            bimages = reshape(bimg_raw_data,[rows_bimg *cols_bimg ,num_bimg]);
        
            % din valori de 0-255 facem valori intre 0 si 1
            bimages = double(bimages)/255;
                
        %---------------------------------BENCHMARK-LABELS----------------------------------------------
            % citim blab_file ca fisier binar
            fid = fopen(blab_file,'r','b');
            if fid == -1
                error("Nu s-a putut deschide fisierul: %s", blab_file);
            end
            
            magic_num_blab  = fread(fid,1,'int32'); %semantura digitala care ne spune ca avem 08*01 (2049)
            num_blab        = fread(fid,1,'int32'); %numarul de etichete
            
            %citim etichtele
            blabels         = fread(fid,inf,'unsigned char');
            fclose(fid);
            blabels = double(blabels');
        
            if size(bimages,2) ~= size(blabels,2)
                error('nr de imagini e diferit de numarul de etichete la benchmark')
            end