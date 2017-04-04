%%
% Uniform Local Binary Patterns 
% Params. im: color or grayscale image
% Return. lbp: LBP image [0-58]
%
function lbp = LBPu(im)
    %nn = 8;    %number of neighbours taken 
    
    %check if rgb image to convert to greyscale
    if size(im,3)==3
        im = rgb2gray(im);
    end
    im = uint8(im);     %cast to 0-256 values
    
    %create new image with padding 1, in centre put 'im' and edges equal to
    %this one average
    [nrow ncol] = size(im);
    lbp = zeros([nrow, ncol], 'uint8');
    imEdge = zeros([nrow+2, ncol+2], 'uint8');
    imEdge(:,:) = round( mean2(im) );
    imEdge(2:nrow+1,2:ncol+1) = im;
    
    %%%%%% Map creation with LBP labels %%%%%%%%
    cont=0;      %label conter
    labelMap = containers.Map('KeyType', 'int32', 'ValueType', 'any');
    for n = 0:255
        u = 0;
        u = u + (bitget(n,1) ~= bitget(n,2));   %count nomber of transitions
        u = u + (bitget(n,2) ~= bitget(n,3));
        u = u + (bitget(n,3) ~= bitget(n,4));
        u = u + (bitget(n,4) ~= bitget(n,5));
        u = u + (bitget(n,5) ~= bitget(n,6));
        u = u + (bitget(n,6) ~= bitget(n,7));
        u = u + (bitget(n,7) ~= bitget(n,8));
        u = u + (bitget(n,8) ~= bitget(n,1));
        
        if u==0 || u==2     %asign new label
            labelMap(n) = cont;
            cont = cont+1;
        else                %asign last label
            labelMap(n) = 58;
        end
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %transform imEdge to an image with LBP values [0-58]
    for i = 1:nrow
        for j = 1:ncol
            iE = i+1;   jE=j+1;     %transformed coords from original image to edged image
            neighbours = [ imEdge(iE-1,jE-1), imEdge(iE-1,jE), imEdge(iE-1,jE+1), ...
                          imEdge(iE,jE+1), imEdge(iE+1,jE+1), ...
                          imEdge(iE+1,jE), imEdge(iE+1,jE-1), imEdge(iE,jE-1) ];
            neighbours = neighbours(:) >= imEdge(iE,jE);    %check if higher or lower than centre
            neighbours = num2str(neighbours);               %logical to character vector to let me join
            lbpCode = strcat(neighbours(1),neighbours(2),neighbours(3),neighbours(4),...
                neighbours(5),neighbours(6),neighbours(7),neighbours(8));   %join neighbours in unique binary number
            lbpCode = uint8(bin2dec(lbpCode));              %transform binary to decimal LBP value
            lbp(i,j) = labelMap(lbpCode);                   %transform LBP to uniform LBP value
        end
    end
end
