%--------------------------------------------------------------------------
% The 
faces_database="PIE";
sub_dim = 10;
[row,column,dimension,reshape_faces,projected_matrix,people_num,pic_num_of_each,train_pic_num_of_each,test_pic_num_of_each] = imread_samples(faces_database);
test_data_index = [];
train_data_index = [];
Y = [];
ite_max = 7;
%--------------------------------------------------------------------------
% The number of training samples is fixed.
for i=0:people_num-1
    test_data_index = [test_data_index pic_num_of_each*i+train_pic_num_of_each+1:pic_num_of_each*(i+1)];
    train_data_index = [train_data_index pic_num_of_each*i+1:pic_num_of_each*i+train_pic_num_of_each];
end
%--------------------------------------------------------------------------
% The number of training samples is randomly selected
% for i=0:people_num-1
%     train_data_index = [train_data_index randperm(pic_num_of_each,train_pic_num_of_each) + pic_num_of_each*i];
% end
% n = 1;
% for i=0:people_num-1
%     for j=1:test_pic_num_of_each
%         for k = pic_num_of_each*i+1:pic_num_of_each*(i+1)
%             mark = 1;
%             for m = train_pic_num_of_each*i+1:train_pic_num_of_each*(i+1)
%                 if train_data_index(m)==k
%                     mark = 0;
%                 end
%             end
%             if n>1
%                for q=1:n-1
%                    if k==test_data_index(q)
%                        mark = 0;
%                    end
%                end
%             end
%             if mark==1
%                 test_data_index(n) = k;
%             end
%         end
%         n = n+1;
%     end
% end
%--------------------------------------------------------------------------
sample_label = [];
k=1;
for i=1:people_num
    for j=1:train_pic_num_of_each
        sample_label(k) = i;
        k = k+1;
    end
end

train_data = reshape_faces(:,train_data_index);
test_data = reshape_faces(:,test_data_index);
K = 5;
% for K = 25:25
% for t = 4:100
[Ww,Wb] = local_Wb_Ww((projected_matrix'*train_data)',sample_label,K,2,5);
% beita_index = [10^-9,10^-8,10^-7,10^-6,10^-5,10^-4,10^-3,10^-2,10^-1,1,10^1,10^2,10^3,10^4,10^5,10^6,10^7,10^8,10^9];
% for beita = beita_index
beita = 10^-3;
% for dim = 1:10:199
%     projected_matrix = PCA_preprocess(reshape_faces,dim,people_num);
[W0,obj] = GRLDA(projected_matrix'*train_data,ite_max,Ww,Wb,sub_dim,beita);
% set(0,'defaultfigurecolor','w');
% heatmap(W0(1:30,1:5));
% colormap(gca, 'Jet')
% caxis([-0.4 0.6])
% set(0,'defaultfigurecolor','w');
% for i = 0:10:200
    W1 = W0(:,1:50);
%     fig = show_face(W0(:,1),row,column);
%     fig = rebuild(reshape_faces,W0,row,column);
    projected_train_data = W1'*projected_matrix'*train_data;
    projected_test_data = W1'*projected_matrix'*test_data;
    correct_rate = KNN(1,projected_test_data,projected_train_data,train_data_index,pic_num_of_each,test_data_index);
    fprintf("数据集：%s，正确率：%1f\n",faces_database,correct_rate*100);
    Y = [Y,correct_rate*100];
% end

