
C = 10;
B = -10;
x = [1 2 3 4; 5 6 7 8; 9 10 11 12; 13 14 15 16];
x_uint16 = uint16(x);

I = C.*x + B;
I_double = double(I);
I_double_shifted = I_double - min(min(I_double));
I_double_norm_2 = I_double_shifted.*(255/max(max(I_double_shifted)));

% I_norm_255_3 = I_double.*(255/max(max(I_double)));
% 
% 255.*(I_double-min(min(I_double)))/(max(max(I_double))-min(min(I_double)))

figure
subplot(1,2,1)
hold on
imshow(x,[0 255])
colorbar('eastoutside')
hold off
subplot(1,2,2)
hold on
imshow(I_double_norm, [0 255])
colorbar('eastoutside')
hold off