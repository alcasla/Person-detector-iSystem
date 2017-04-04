%%
% Local Binary Patterns
% Params. im: color or grayscale image
% Return. lbp: LBP image [0-255]
%
function lbp = LBP(im)
    %check if rgb image to convert to greyscale
    if size(im,3)==3
        im = rgb2gray(im);
    end
    im = uint8(im);     %cast to 0-256 values
    
    %create new image with padding 1, in centre put 'im' and edges equal to
    %this one average, and final img with lbp codes
    [nrow ncol] = size(im);
    lbp = zeros([nrow, ncol], 'uint8');
    imEdge = zeros([nrow+2, ncol+2], 'uint8');
    imEdge(:,:) = round( mean2(im) )
    imEdge(2:nrow+1,2:ncol+1) = im;
    
    %transform imEdge to an image with LBP values [0-255]
    for i = 1:nrow
        for j = 1:ncol
            iE = i+1;   jE=j+1;     %transformed coords from original image to edged image
            neighbours = [ imEdge(iE-1,jE-1), imEdge(iE-1,jE), imEdge(iE-1,jE+1), ...
                          imEdge(iE,jE+1), imEdge(iE+1,jE+1), ...
                          imEdge(iE+1,jE), imEdge(iE+1,jE-1), imEdge(iE,jE-1) ];
            neighbours = neighbours(:) >= imEdge(iE,jE);        %check if higher or lower than centre
            neighbours = num2str(neighbours);                   %logical to character vector to let me join
            lbpCode = strcat(neighbours(1),neighbours(2),neighbours(3),neighbours(4),...
                        neighbours(5),neighbours(6),neighbours(7),neighbours(8));   %join neighbours in unique binary number
            lbpCode = uint8(bin2dec(lbpCode));                  %transform binary to decimal LBP value
            lbp(i,j) = lbpCode;         %insert value to create LBP image
        end
    end
end
