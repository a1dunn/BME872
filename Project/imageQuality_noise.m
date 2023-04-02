function [N] = imageQuality_noise(img , method,type)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

min_img = min(min(img));
max_img = max(max(img));
% figure
% imshow(img,[])
if max(max(img)) > 1 || min(min(img)) < 0
    img = (img-min_img)/(max_img-min_img);
end

if type == 0
    T = 0.1;
elseif type == 1
    T = 0.2;
end

if method ==1
    kernel = fspecial('gaussian', 3, 10);
    img_filt = imfilter(img,kernel,'symmetric');
    %img_filt = medfilt2(img, [5 5], 'symmetric');
%     figure
%     subplot(1,2,1)
%     hold on
%     imshow(img,[])
%     hold off
%     subplot(1,2,2)
%     hold on
%     imshow(img_filt,[])
%     hold off
    kernel = fspecial('gaussian', 3, 5);
    img_filt2 = imfilter(img,kernel,'symmetric');
    img_noise = img-img_filt;
    img_noise = img_noise(3:end-2,3:end-2);
    kernel = derivative_kernel('sobel', 'x');
    grad_x = imfilter(img_filt2,kernel,'symmetric');
    kernel = derivative_kernel('sobel', 'y');
    grad_y = imfilter(img_filt2,kernel,'symmetric');
    grad_mag = (grad_x.^2+ grad_y.^2).^(1/2);
    grad_mag_norm = normalize(grad_mag,'range');
    edge_map = image_threshold(grad_mag_norm, T);
    [num_row,num_col] = size(edge_map);
    for i = 1:num_row
        for j = 1:num_col
            if type == 0 && img(i,j) < 0.3
                edge_map(i,j) = 0;
            end
            if type == 1 && img(i,j) < 0.5
                edge_map(i,j) = 0;
            end
        end
    end
    edge_map = edge_map(3:end-2,3:end-2);
%     figure
%     subplot(1,2,1)
%     hold on
%     imshow(img,[])
%     title('Original Image')
%     hold off
%     subplot(1,2,2)
%     hold on
%     imshow(edge_map,[])
%     title('Edge Map')
%     hold off
        edge_map = ~edge_map;
    edge_map = double(edge_map);
    edge_map(edge_map == 0) = NaN;
    img_noise_masked = img_noise.*edge_map;
    N = mean(img_noise_masked,'all','omitnan');
elseif method == 2
        kernel = fspecial('gaussian', 3, 10);
    img_filt = imfilter(img,kernel,'symmetric');
%img_filt = medfilt2(img, [5 5], 'symmetric');
    kernel = fspecial('gaussian', 3, 5);
    img_filt2 = imfilter(img,kernel,'symmetric');
    img_noise = img-img_filt;
    img_noise = img_noise(3:end-2,3:end-2);
    kernel = derivative_kernel('sobel', 'x');
    grad_x = imfilter(img_filt2,kernel,'symmetric');
    kernel = derivative_kernel('sobel', 'y');
    grad_y = imfilter(img_filt2,kernel,'symmetric');
    grad_mag = (grad_x.^2+ grad_y.^2).^(1/2);
    grad_mag_norm = normalize(grad_mag,'range');
    edge_map = image_threshold(grad_mag_norm, T);
    [num_row,num_col] = size(edge_map);
    
%         figure
%     subplot(1,2,1)
%     hold on
%     imshow(img,[])
%     title('Original Image')
%     hold off
%     subplot(1,2,2)
%     hold on
%     imshow(edge_map,[])
%     title('Edge Map')
%     hold off
    
    for i = 1:num_row
        for j = 1:num_col
            if type == 0 && img(i,j) < 0.3
                edge_map(i,j) = 0;
            end
            if type == 1 && img(i,j) < 0.5
                edge_map(i,j) = 0;
            end
        end
    end
    edge_map = edge_map(3:end-2,3:end-2);
%     
%     figure
%     subplot(1,2,1)
%     hold on
%     imshow(img,[])
%     title('Original Image')
%     hold off
%     subplot(1,2,2)
%     hold on
%     imshow(edge_map,[])
%     title('Edge Map')
%     hold off
%     
    edge_map = ~edge_map;
    edge_map = double(edge_map);
    edge_map(edge_map == 0) = NaN;
    img_noise_masked = img_noise.*edge_map;
    
%         figure
%     subplot(1,2,1)
%     hold on
%     imshow(edge_map,[])
%     title('Edge Map')
%     hold off
%     subplot(1,2,2)
%     hold on
%     imshow(img_noise_masked,[])
%     title('IMG Masked')
%     hold off
    
    N = std(img_noise_masked,1,'all','omitnan');
elseif method == 3
  kernel = fspecial('gaussian', 3, 10);
    img_filt = imfilter(img,kernel,'symmetric');
    [num_row,num_col] = size(img);
%img_filt = medfilt2(img, [5 5], 'symmetric');
    kernel = fspecial('gaussian', 3, 5);
    img_filt2 = imfilter(img,kernel,'symmetric');
    img_noise = img-img_filt;
    img_noise = img_noise(3:end-2,3:end-2);
    
    edge_map = ones(num_row,num_col);
    
%         figure
%     subplot(1,2,1)
%     hold on
%     imshow(img,[])
%     title('Original Image')
%     hold off
%     subplot(1,2,2)
%     hold on
%     imshow(edge_map,[])
%     title('Edge Map')
%     hold off
    for i = 1:num_row
        for j = 1:num_col
            if type == 0 && img(i,j) > 0.2
                edge_map(i,j) = 0;
            end
            if type == 1 && img(i,j) < 20
                edge_map(i,j) = 0;
            end
        end
    end
    edge_map = edge_map(3:end-2,3:end-2);
%     figure
%     subplot(1,2,1)
%     hold on
%     imshow(img,[])
%     title('Original Image')
%     hold off
%     subplot(1,2,2)
%     hold on
%     imshow(edge_map,[])
%     title('Edge Map')
% %     hold off
%     edge_map = ~edge_map;
%     edge_map = double(edge_map);
    edge_map(edge_map == 0) = NaN;
    img_noise_masked = img_noise.*edge_map;
%         figure
%     subplot(1,2,1)
%     hold on
%     imshow(edge_map,[])
%     title('Edge Map')
%     hold off
%     subplot(1,2,2)
%     hold on
%     imshow(img_noise_masked,[])
%     title('IMG Masked')
%     hold off
    N = std(img_noise_masked,1,'all','omitnan');
end
end

