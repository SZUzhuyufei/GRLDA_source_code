function [Wb Ww]  = C_LDA_local_Wb_Ww(X,gnd, Kneighbor,form,t)
% Construct Adjacency Graph with k neighbor 
%--------------------------------------------------------------------------
% Input
% X: is the data matrix. Each row vector of X is a data point.
% gnd: is the label information 11...1122...2233...33...nn...nn
% Kneighbor: the K neighbor
% form: You can construct it by your own or use the default one (5-nearest neighbor, 0-1 weight)
%--------------------------------------------------------------------------
% Output
% Wb is the weight matrix of between-class. 
% Ww is the weight matrix of within-class.
%attention: use the in_class information in W
% the weight of the data pairs that in the K neighbors with the same class is 1
% modified by modm 
% 12 Sep.2022 ShenZhen University
%--------------------------------------------------------------------------

NData = size(X,1); %sample number
distance = zeros(NData, NData);
Ww = zeros(NData, NData);
Wb = zeros(NData, NData); 

% compute the L2-norm distance of echa point against the others
for i = 1 : NData
    for j = 1 : NData
        distance(i, j) = norm(X(i, :) - X(j, :));
    end
end
[dumb idx] = sort(distance, 2); % sort each row
if Kneighbor+1>NData
     Kneighbor=NData;%Kneighbor can't more than NData
end

if form==0 
    for i = 1 : NData
        for j = 1 : Kneighbor+1 %a point itself is seen as first neighbor distance(i,i)=0
            if gnd(idx(i,j))==gnd(i) %in the same class
                Ww(i,idx(i,j))=1;
                Ww(idx(i,j),i)=1;
            else 
                Wb(i,idx(i,j))=1;
                Wb(idx(i,j),i)=1;
            end
        end
    end
    Wb=max(Wb,Wb');
    for i=1 : NData
        Wb(i,i)=0;
    end
    
    Ww=max(Ww,Ww');
    for i=1 : NData
        Ww(i,i)=0;
    end
    
elseif form==1
    for i = 1 : NData
        for j = 1 : Kneighbor+1 %a point itself is seen as first neighbor distance(i,i)=0
            if gnd(idx(i,j))==gnd(i)
                Ww(i, idx(i, j)) =exp( -norm(X(i, :) - X(idx(i, j), :))/t);
                Ww(idx(i, j),i) =exp( -norm(X(i, :) - X(idx(i, j), :))/t);
            else
                Wb(i, idx(i, j)) =exp( -norm(X(i, :) - X(idx(i, j), :))/t);
                Wb(idx(i, j),i ) =exp( -norm(X(i, :) - X(idx(i, j), :))/t);
            end
        end
    end
     Wb=max(Wb,Wb');
    for i=1 : NData
        Wb(i,i)=0;
    end
    
    Ww=max(Ww,Ww');
    for i=1 : NData
        Ww(i,i)=0;
    end
elseif form==2
    for i = 1 : NData
        for j = 1 : Kneighbor+1 %a point itself is seen as first neighbor distance(i,i)=0
            if gnd(idx(i,j))==gnd(i) %in the same class
                Ww(i,idx(i,j))= sqrt(sum((X(i, :)-X(j, :)).^2));
                Ww(idx(i,j),i)= sqrt(sum((X(i, :)-X(j, :)).^2));
            else 
                Wb(i,idx(i,j))= sqrt(sum((X(i, :)-X(j, :)).^2));
                Wb(idx(i,j),i)= sqrt(sum((X(i, :)-X(j, :)).^2));
            end
        end
    end
    Wb=max(Wb,Wb');
    for i=1 : NData
        Wb(i,i)=0;
    end
    
    Ww=max(Ww,Ww');
    for i=1 : NData
        Ww(i,i)=0;
    end
                
elseif form=='cos'
    for i = 1 : NData
        for j = 1 : Kneighbor+1 
            if gnd(idx(i,j))==gnd(i)
                Ww(i, idx(i, j)) = acos(X(i, :)*X(idx(i, j), :)'/(norm(X(i, :))*norm(X(idx(i, j), :))));
                Ww(idx(i, j),i) = acos(X(i, :)*X(idx(i, j), :)'/(norm(X(i, :))*norm(X(idx(i, j), :))));
            else
                Wb(i, idx(i, j)) = acos(X(i, :)*X(idx(i, j), :)'/(norm(X(i, :))*norm(X(idx(i, j), :))));
                Wb(idx(i, j),i) = acos(X(i, :)*X(idx(i, j), :)'/(norm(X(i, :))*norm(X(idx(i, j), :))));
            end
        end
    end
     Wb=max(Wb,Wb');
    for i=1 : NData
        Wb(i,i)=0;
    end
    
    Ww=max(Ww,Ww');
    for i=1 : NData
        Ww(i,i)=0;
    end
end