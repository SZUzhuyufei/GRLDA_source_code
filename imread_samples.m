function [row,column,dimension,reshape_faces,projected_matrix,people_num,pic_num_of_each,train_pic_num_of_each,test_pic_num_of_each] = imread_samples(faces_database)
reshape_faces = [];
if(faces_database=="ORL")
    for i=1:40
        for j=1:10
            a = imread(strcat('C:\Users\administrator2\Desktop\ORL56_46\orl',num2str(i),'_',num2str(j),'.bmp'));
            b = reshape(a,2576,1);
            b = double(b);
            reshape_faces = [reshape_faces,b];
        end
    end
    row = 56;
    column = 46;
    dimension = row * column;
    people_num = 40;
    pic_num_of_each = 10;
    train_pic_num_of_each = 7;
    test_pic_num_of_each = pic_num_of_each - train_pic_num_of_each;
    load('.\ORL_dataset\projected_matrix.mat')
%     set(0,'defaultfigurecolor','w');
    % fig = show_faces(reshape_faces,row,column);
end

if(faces_database=="AR")
    for i=1:100
        for j=1:20
            if(i<10)
               a = imread(strcat('C:\Users\administrator2\Desktop\AR_Gray_50by40\AR00',num2str(i),'-',num2str(j),'.tif'));
            elseif(i<100)
               a = imread(strcat('C:\Users\administrator2\Desktop\AR_Gray_50by40\AR0',num2str(i),'-',num2str(j),'.tif'));
            else
               a = imread(strcat('C:\Users\administrator2\Desktop\AR_Gray_50by40\AR',num2str(i),'-',num2str(j),'.tif'));
            end
            temp = round(rand(1,1)*24)+16;
            for k = temp-15:temp
                for m = temp - 15:temp
                    temp1 = round(rand(1,1)*255);
                    a(k,m) = temp1;
                end
            end
            b = reshape(a,2000,1);
            b = double(b);
            reshape_faces = [reshape_faces,b];
        end
    end
    row = 50;
    column = 40;
    dimension = row * column;
    people_num = 50;
    pic_num_of_each = 20;
    train_pic_num_of_each = 6;
    test_pic_num_of_each = pic_num_of_each - train_pic_num_of_each;
%     projected_matrix = zeros(1,1);
    load('.\AR_dataset\projected_matrix.mat');
%     fig = show_face(reshape_faces(:,1),row,column);
%     fig = show_faces(reshape_faces,row,column);
end

if(faces_database=="FERET")
    for i=1:80
        for j=1:7
            a = imread(strcat('C:\Users\administrator2\Desktop\FERET_80\ff',num2str(i),'_',num2str(j),'.tif'));
            b = reshape(a,6400,1);
            b = double(b);
            reshape_faces = [reshape_faces,b];
        end
    end
    row = 80;
    column = 80;
    dimension = row * column;
    people_num = 80;
    pic_num_of_each = 7;
    train_pic_num_of_each = 6;
    test_pic_num_of_each = pic_num_of_each - train_pic_num_of_each;
    load('.\FERET_dataset\projected_matrix.mat')
    load('.\FERET_dataset\Xtrain_label.mat')
%     fig = show_faces(reshape_faces,row,column);
end

if(faces_database=="face")
    for i=1:15
        for j=1:11
            if i<10
            a = imread(strcat('C:\Users\administrator2\Desktop\face10080\subject0',num2str(i),'_',num2str(j),'.bmp'));
            else
                a = imread(strcat('C:\Users\administrator2\Desktop\face10080\subject',num2str(i),'_',num2str(j),'.bmp'));
            end
            b = reshape(a,8000,1);
            b = double(b);
            reshape_faces = [reshape_faces,b];
        end
    end
    row = 100;
    column = 80;
    dimension = row * column;
    people_num = 15;
    pic_num_of_each = 11;
    train_pic_num_of_each = 3;
    test_pic_num_of_each = pic_num_of_each - train_pic_num_of_each;
%     fig = show_faces(reshape_faces,row,column);
    load('.\face10080_dataset\projected_matrix.mat');
end

if(faces_database=="coil")
    for i=1:20
        for j=0:71
            a = imread(strcat('C:\Users\administrator2\Desktop\coil-20-proc\obj',num2str(i),'__',num2str(j),'.png'));
            b = reshape(a,128*128,1);
            b = double(b);
            reshape_faces = [reshape_faces,b];
        end
    end
    row = 128;
    column = 128;
    dimension = row * column;
    people_num = 20;
    pic_num_of_each = 72;
    train_pic_num_of_each = 10;
    test_pic_num_of_each = pic_num_of_each - train_pic_num_of_each;
%     projected_matrix = zeros(1,1);
    load('.\coil_dataset\projected_matrix.mat');
%     fig = show_faces(reshape_faces,row,column);
end

if(faces_database=="PIE")
    k = 1;
    for i=1:68
        for j=1:24
            a = imread(strcat('C:\Users\administrator2\Desktop\Pose29_64x64_files\',num2str(k),'.jpg'));
            k = k+1;
            b = reshape(a,64*64,1);
            b = double(b);
            reshape_faces = [reshape_faces,b];
        end
    end
    row = 64;
    column = 64;
    dimension = row * column;
    people_num = 68;
    pic_num_of_each = 24;
    train_pic_num_of_each = 14;
    test_pic_num_of_each = pic_num_of_each - train_pic_num_of_each;
%     projected_matrix = zeros(1,1);
    load('.\PIE_dataset\projected_matrix.mat');
%     fig = show_faces(reshape_faces,row,column);
end

