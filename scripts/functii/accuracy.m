function acc = accuracy(A2,Y)
    
    [~,poz] = max(A2);

    poz = poz-1;%matlab indexeaza de la 1, dec trb decalat la stanga
    predict = (poz==Y);
    acc = mean(predict)*100;
end