function [W0,obj] = GRLDA(X,ite_max,Ww,Wb,sub_dim,beita)
%--------------------------------------------------------------------------
%title: Generalized Robust Linear Discriminant Analysis for Joint Sparse Learning
%authors: Yufei Zhu,Zhihui Lai
%--------------------------------------------------------------------------
%X:training data matrix(d*n),each column is a sample
%Ww,Wb:within-class scatter matrix and between-class scatter matrix with locality
%beita,alpha,gama are parameters
%ite_max is the iteration times
%sub_dim is the subspace dimension
    dimension = size(X,1);
    msmp = size(X,2);
    [U1,~,~] = svd(X);
    U1 = U1(:,1:sub_dim);
    
    I_m = eye(sub_dim);
    alpha = 100;
    gama = 100;
    obj = [];
    for ite = 1:ite_max
        Sgw = zeros(size(X,1));
        Sgb = zeros(size(X,1));
        for i= 1:msmp
            for j= 1:msmp
                if Ww(i,j)~=0
                    Xw_diff = (X(:,i)-X(:,j)).*Ww(i,j);
                    Xw_U = Xw_diff'*U1;
                    if sqrt(sum(Xw_U.*Xw_U,2))==0
                        dw_i= 10^8;
                    else
                        dw_i = 0.5./sqrt(sum(Xw_U.*Xw_U,2));
                    end
                    Sgw = Sgw + Xw_diff'.*dw_i*Xw_diff;
                end

                 if Wb(i,j)~=0
                    Xb_diff = (X(:,i)-X(:,j)).*Wb(i,j);
                    Xb_U = Xb_diff'*U1;
                    if sqrt(sum(Xb_U.*Xb_U,2))==0
                        db_i=  10^8;
                    else
                        db_i = 0.5./sqrt(sum(Xb_U.*Xb_U,2));
                    end
                    Sgb = Sgb + Xb_diff'*db_i*Xb_diff;
                 end
            end
        end

        I_d = eye(dimension,dimension);
        for j = 1:dimension
            D(j) = norm(U1(j,:));
            D(j) = 0.5./ D(j);
        end
        D = diag(D);
        s = sqrt(trace(U1'*Sgb*U1))/trace(U1'*Sgw*U1);
        D_temp = beita*(gama*I_d - D);
        S_temp = alpha*I_d-Sgw;
        t = trace(U1'*Sgb*U1);
        B_temp = s*Sgb*U1/trace(U1'*Sgb*U1);
        M_temp = 2*s*s*S_temp*U1+2*B_temp + 2*D_temp*U1;
        [U,~,V] = svd(M_temp);
        U1 = U*[I_m;zeros(dimension-sub_dim,sub_dim)]*V';
        obj(ite) = -(s*s)*trace(U1'*Sgw*U1) + 2*sqrt(s*trace(U1'*Sgb*U1)) - beita*trace(U1'*D*U1);
%         obj = [obj objval];
    end
        W0 = U1;
