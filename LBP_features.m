%%
% Calcule descriptors for LBP image
% Params. patch: LBP image, size 128x64
% Return. x: fuature vector from window(patch) (histogram by blocks)
%               block size 16x16 with 8 pixels of overlapping
%
function x = LBP_features(patch)
    blockSize = 16; %half would be overlapping
    high = 128;     %size(patch,2)
    width = 64;     %size(patch,1)
    
    vB = high/16*2 - 1;     %number of vertical blocks including overlapping
    hB = width/16*2 - 1;    %number of horizontal blocks including overlapping
    
    x = zeros(1, vB*hB*max(max(patch))+1);      %Preallocate data structure
    
    for v = 1:vB
        for h = 1:hB
            pixIv = blockSize/2*(v-1) + 1;  %row number pixel where start block
            pixIh = blockSize/2*(h-1) + 1;  %col number pixel where start block
            block = patch(pixIv:pixIv+15, pixIh:pixIh+15);  %lbp values of block
            
            hist = histogram(block,59);     %histogram for lbp block values, 59 bias
            histNorm = hist.Values/(blockSize^2);   %normalize, sum all values equal to 1
            
            i = ( (v-1)*hB + h-1 ) * 59;    %index block by block to save hist values
            x(i+1:i+59) = histNorm;      %save hist values block by block
        end
    end
    close all;      %close histogram window
end