function gui(parameters,X_test,Y_test)
    % nargin - numaru de argumente input
    % if nargin < 4
    %     fprintf('Parametrii random/n');
    %     W1 = randn(128, 784) * 0.01; b1 = zeros(128, 1);
    %     W2 = randn(10, 128) * 0.01;  b2 = zeros(10, 1);
    % end

    W1 = parameters.W1;
    b1 = parameters.b1;
    W2 = parameters.W2;
    b2 = parameters.b2;

    f = figure('Name', 'Proiect GAC OCR', ...
               'NumberTitle', 'off', ...
               'MenuBar', 'none', ...
               'ToolBar', 'none', ...
               'Resize', 'off', ...
               'Position', [300, 300, 800, 400], ... 
               'Color', [0.5 0.5 0.5]);

    isDrawing = false;

   
    ax_draw = axes('Parent', f, ...
                   'Units', 'pixels', ...
                   'Position', [50, 50, 300, 300], ...
                   'Color', 'black', ...
                   'XLim', [0 28], ...
                   'YLim', [0 28], ...
                   'XTick', [], 'YTick', [], ...% sa ascunda gradatiile
                   'XColor', 'none','YColor','none',...
                   'Box', 'off');
    hold(ax_draw, 'on');                        % sa nu-si dea update dupa fiecare pixel
    title(ax_draw, 'Deseneaza cifra intre 0 si 9');

    
    ax_preview = axes('Parent', f, ...
                      'Units', 'pixels', ...
                      'Position', [450, 150, 140, 140], ... 
                      'XTick', [], 'YTick', [], ...
                      'Box', 'on');
    title(ax_preview, 'Matricea Input');
    
    % rezultat
    lbl_rezultat = uicontrol('Style', 'text', ...
                             'Parent', f, ...
                             'Units', 'pixels', ...
                             'Position', [450, 330, 300, 40], ...
                             'String', 'Predictie: -', ...
                             'FontSize', 16, ...
                             'FontWeight', 'bold', ...
                             'BackgroundColor', [0.5 0.5 0.5], ...
                             'HorizontalAlignment', 'left');

    
    % buton forward
    uicontrol('Style', 'pushbutton', 'String', 'Calculeaza', ...
              'Position', [450, 80, 120, 40], ...
              'FontSize', 12, ...
              'Callback', @predict_callback);

    % reset
    uicontrol('Style', 'pushbutton', 'String', 'Reset', ...
              'Position', [600, 80, 100, 40], ...
              'FontSize', 12, ...
              'Callback', @clear_callback);

    % desen
    set(f, 'WindowButtonDownFcn', @start_draw);
    set(f, 'WindowButtonUpFcn', @stop_draw);
    set(f, 'WindowButtonMotionFcn', @drag_draw);


    function start_draw(~, ~)
        % Verificam daca click-ul a fost in zona de desen
        coords = get(ax_draw, 'CurrentPoint');
        x = coords(1,1);
        y = coords(1,2);
        if x > 0 && x < 28 && y > 0 && y < 28
            isDrawing = true;
            plot_point(x, y);
        end
    end

    function stop_draw(~, ~)
        isDrawing = false;
    end

    function drag_draw(~, ~)
        if isDrawing
            coords = get(ax_draw, 'CurrentPoint');
            x = coords(1,1);
            y = coords(1,2);
            % Desenam doar daca suntem inca in chenar
            if x > 0 && x < 28 && y > 0 && y < 28
                plot_point(x, y);
            end
        end
    end

    function plot_point(x, y)
        
        plot(ax_draw, x, y, 'o', 'MarkerFaceColor', 'white', ...
             'MarkerEdgeColor', 'white', 'MarkerSize', 18);
    end

    function clear_callback(~, ~)
        cla(ax_draw);
        % Resetam limitele axei (cla le sterge uneori)
        set(ax_draw, 'XLim', [0 28], 'YLim', [0 28], 'Color', 'black');
        cla(ax_preview);
        set(lbl_rezultat, 'String', 'Predictie: -');
    end

    function predict_callback(~, ~)
     
        frame = getframe(ax_draw);
        img = frame.cdata;
        
        if size(img, 3) == 3
            img = rgb2gray(img);
        end
        

        img_resized = imresize(img, [28, 28]);
        img_final = double(img_resized) / 255;
        img_final(img_final<0.4) = 0;
        

        [rows,cols] = find(img_final>0.1);
        
        if isempty(rows)
            img_final = zeros(28,28);
        end
        % incearca si cu poza nescalata
        % gasit 'kernel'
        sus = min(rows);
        jos = max(rows);
        stanga = min(cols);
        dreapta= max(cols);
        
        cropped = img_final(sus:jos,stanga:dreapta);
        
        [h,w] = size(cropped);
        img_final = zeros(28,28);
        
        %centrare poza

        stanga_cent  = floor(28/2 - w/2)+1;
        dreapta_cent = stanga_cent + w - 1;
        sus_cent     = floor(28/2 - h/2)+1;
        jos_cent     = sus_cent    + h - 1;
        
        img_final(sus_cent:jos_cent,stanga_cent:dreapta_cent) = cropped;
        
       
        x_input = reshape(img_final', 784, 1);

        imagesc(ax_preview, img_final);
        colormap(ax_preview, gray);
        axis(ax_preview, 'off');
        
        %% img_matrix = reshape(img_vector, 28, 28)';
        %% figure;
        %% imshow(img_matrix);

        [A2,~] = forw_prop(x_input,parameters);
        [poz,val] = max(A2);
       
        fprintf('Predictie: %d Siguranta: %.1f%%\n', val-1, poz*100);
        
        set(lbl_rezultat, 'String', ...
              sprintf('Predictie: %d (Siguranta: %.1f%%)', val-1, poz*100));
        
    end
    

    %test daca ruleaza corect reteaua
    % poza = 10;
    % [A2,~] = forw_prop(X_test(:,poza),parameters);
    % [poz,val] = max(A2);
    % fprintf('Ati introdus cifra: %d cu acuratete de: %.2f\n',val-1,poz*100)
    % fprintf('Valoarea asteptata este de %d\n',Y_test(poza));
end