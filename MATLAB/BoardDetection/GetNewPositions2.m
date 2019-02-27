%-==========================================-
% Chess Vision - Image Processing 
% 
% Maor Assayag     Eyal Zuckerman   
% Refahel Shetrit  Yaniv Okavi
%-==========================================-
function [ pices_old_board,move_from,move_to,flag_castle,flag_real_change] = GetNewPositions2(only_old_board,only_new_board,pices_old_board,imagePoints_end,turn,clear_board, board, m1, m2)
%the function get:
%only_old_board - [N*M*3] or [N*M] - image with the old board
%only_new_board - [N*M*3] or [N*M] - image with the new board
%pices_old_board - [8*8] the pices in the old board
%imagePoints_end [49*2] - corrner pts
%turn - who have to move


%to overcome on gray/rgb
%if size(only_old_board,3)==3
%    old_board=rgb2gray(only_old_board);
%else
%    old_board=only_old_board;
%end 

old_board=double(img2gray(only_old_board));

new_board=img2gray(only_new_board);
new_board=double(new_board);

turn=mod(turn,2);
if turn==0
    turn=2;
end
%
change_img=abs ((old_board-new_board));
change_mat_th1=img2meansquares(change_img,imagePoints_end);
change_mat_th2=change_mat_th1;
change_mat_th2(1:2:7,1:2:7)=2*change_mat_th1(1:2:7,1:2:7);
change_mat_64 = change_mat_th2;
% clear_board_gray = double(img2gray(clear_board));
% mean1=img2meansquares(old_board,imagePoints_end);
% mean2=img2meansquares(new_board,imagePoints_end);
% mean_clear = img2meansquares(abs(clear_board_gray-new_board), imagePoints_end);
% change_mat_63=abs(mean1-mean2);
% change_mat_64=change_mat_63;
% change_mat_64(1:2:7,1:2:7)=2*change_mat_63(1:2:7,1:2:7);
% change_mat_64 = 3*change_mat_64 + change_mat_th2;

%% 
th = 17;
if max(change_mat_th2(:)) < th
    flag_real_change=false;
    flag_real_change
    pices_old_board = 0;
    move_from = 0;
    move_to = 0;
    flag_castle = 0;
    return;
else
    % detrimine the from square
change_mat_64_turn = change_mat_64.*(pices_old_board==turn);
change_mat_64_turn_maybe_max = change_mat_64_turn > (max(change_mat_64_turn(:)) * 0.6);
index_maybe_from = find(change_mat_64_turn_maybe_max == 1);
if (length(index_maybe_from) > 1)
    empty_maybe_from(1:length(index_maybe_from)) = "";
    for i = 1:length(index_maybe_from)
        empty_maybe_square = GetSquareNum(only_new_board, index_maybe_from(i));
        temp_cell =  classif(empty_maybe_square, m1);
        empty_maybe_from(i) = temp_cell{1};
    end
    index_maybe_empty_from = [find(empty_maybe_from == "ee"), find(empty_maybe_from == 'e')];
    if (~isempty(index_maybe_empty_from))
        move_from = max(index_maybe_from(index_maybe_empty_from));
    else
      move_from=find(max(max(change_mat_64.*(pices_old_board==turn)))==change_mat_64);
    end
else
     move_from=find(max(max(change_mat_64.*(pices_old_board==turn)))==change_mat_64);
end
%%
% detrimine the to square
change_mat_64_turn_to = change_mat_64.*(1-(pices_old_board==turn));
change_mat_64_turn_to_maybe_max = change_mat_64_turn_to > (max(change_mat_64_turn_to(:)) * 0.6);
index_maybe_to = find(change_mat_64_turn_to_maybe_max == 1);
if length(index_maybe_to) > 1
    type_square_from = board(move_from);
    if (isempty(type_square_from)) %debug only
        type_square_from = "p";
    end
    empty_maybe_to = zeros(1,length(index_maybe_to));
    for i = 1:length(index_maybe_to)
        empty_maybe_to_square = GetSquareNum(only_new_board, index_maybe_to(i));
        empty_maybe_to(i) = classif_score(empty_maybe_to_square, m2, type_square_from);
    end
    move_to = index_maybe_to(find(max(empty_maybe_to(:))== empty_maybe_to));  
else
    move_to = find(max(max(change_mat_64.*(1-(pices_old_board==turn))))==change_mat_64); 
end

%%
flag_castle=false;
flag_real_change=true;
% was 10
%king side castle
if (move_from==33 || move_from==57 ) && (move_to==41 || move_to==49)
    check_mat_64=change_mat_64>10;
    if check_mat_64(33) && check_mat_64(41) && check_mat_64(49) && check_mat_64(57)
       pices_old_board(33)=0;
       pices_old_board(57)=0;
       pices_old_board(41)=2;
       pices_old_board(49)=2;
       move_from=33;
       move_to=49;
       flag_castle=true;
    end    
end

if (move_from==40 || move_from==64) && (move_to==48 || move_to==56)
    check_mat_64=change_mat_64>th;
     if check_mat_64(40) && check_mat_64(48) && check_mat_64(56) && check_mat_64(64)
        pices_old_board(40)=0;
        pices_old_board(64)=0;
        pices_old_board(48)=1;
        pices_old_board(56)=1;
        move_from=40;
        move_to=56;
        flag_castle=true;
     end
end

%queen side castle
if (move_from==33 || move_from==1 ) && (move_to==17 || move_to==25)
    check_mat_64=change_mat_64>th;
    if check_mat_64(33) && check_mat_64(1) && check_mat_64(17) && check_mat_64(25)
       % refael will be here :)
       pices_old_board(33)=0;
       pices_old_board(1)=0;
       pices_old_board(17)=2;
       pices_old_board(25)=2;
       move_from=33;
       move_to=17;
       flag_castle=true;
    end    
end

if (move_from==40 || move_from==8 ) && (move_to==24 || move_to==32)
    check_mat_64=change_mat_64>12;
    if check_mat_64(40) && check_mat_64(8) && check_mat_64(24) && check_mat_64(32)
       % refael will be here :)
       pices_old_board(40)=0;
       pices_old_board(8)=0;
       pices_old_board(24)=2;
       pices_old_board(32)=2;
       move_from=40;
       move_to=24;
       flag_castle=true;
    end    
end

pices_old_board(move_from)=0;
pices_old_board(move_to)=turn;

end
end