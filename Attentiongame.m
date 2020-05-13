function attention_game()
%%%%%%%%%%%%%%%%%%  Press 'Q' TO EXIT GAME %%%%%%%%%%%
%%%% Written by Morgan Ketchum
%%%% Last Update 11/11/2018
close all

%%%%%%%%%%%%%%%%%%  OPTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%

difficulty=9;  %Sets difficulty from 1-10
axis_limit = 30; %size of the map
player_name = 'Morgan';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

d=0; %direction
%Tracking starting coordinates and direction
x = round(axis_limit/2); %starting point random
y = round(axis_limit/2)' %starting point random
d = randi([1,4]); %Random starting direction
%Target starting coordinates
a = randi([1 axis_limit-1],1); %x coordinate for target
b = randi([1 axis_limit-1],1); %y coordinate for target

player(1,1:2)=[x y]; %defines snake in x and y
%Snake is the target you control to get to the food
size_player=1; 
ate=0; %snake ate food
ex=0; %used to exit the game
target=[a b]; %defines food coordinates
hold on 

score = 0; %Sets initial score to zero
i=score; %Counter for the score
focus = 60;
timer = 0; %Game timer

draw_map(player,target,i,axis_limit,focus,difficulty)
%Makes the graph (see below)
figure('KeyPressFcn',@my_callback);
%defines interactive figure based on key presses
    function my_callback(alpha,event) %callback for movement
        switch event.Character 
            case 'q'
                ex = 1;
            case 30
                if(d~=2) %if not going down, can go up
                    d = 1; %up d = 1
                end
            case 31
                if(d~=1) %if not going up, can go down
                    d = 2; %down d = 2
                end
            case 29
                if(d~=4) %if not going left
                    d = 3; %go right d = 3
                end
            case 28
                if(d~=3)  %if not going right
                    d = 4; %go left d=4
                end
                %I.E. cannot reverse directions.  If going up, can only
                %go left or right.
        end
    end

while (ex~=1) %As long as q isn't pressed
    size_player = size(player); %defines the size of the tracker
    focus = 60;
    switch d %calling callback function - allows you to move
        case 1
            player(1,2)=player(1,2)+1; %add to y direction
        case 2
            player(1,2)=player(1,2)-1; %subtract from y direction
        case 3
            player(1,1)=player(1,1)+1; %add value to x position
        case 4
            player(1,1)=player(1,1)-1; %subtract from x position
    end
    
    draw_map(player,target,i,axis_limit,focus,difficulty)
    %draws the snake & distracters
    pause(max([(105-difficulty*10)/(10*axis_limit) .001])); %difficulty makes game faster
    %pauses and reforms in certain # of seconds.  See "difficulty" and "axis limit" to
    %calculate speed
    timer = timer + 1;
    if (timer == 25)
        a = randi([1 axis_limit-1],1); %x coordinate for target
        b = randi([1 axis_limit-1],1); %y coordinate for target
        target=[a b]; %defines food coordinates
        timer = 0;
    end
    
    if player(1,1)==target(1) && player(1,2)==target(2) %if snake and food in same coordinates
        ate = 1; %Says you hit the target
        i = i + 1; %Adds point to your score.
        target(1) = randi([1 axis_limit-1]);
        target(2) = randi([1 axis_limit-1]); %new food coordinates    
    else
        ate = 0; %if you haven't hit the target, ate is zero.
    end
 
    if bounds==1
          player(1,:)
          if player(1,1)==0 %if snake exceeds boundaries display message box
              scorekeeper(score)
              msgbox({player_name;'Stay Determined!'},'Game Over')
              ex=1 %exit game
          elseif player(1,2)==0%if snake exceeds boundaries display message box
              scorekeeper(score)
              msgbox({player_name;'Stay Determined!'},'Game Over')
              ex=1 %exit game
          elseif player(1,1)==axis_limit%if snake exceeds boundaries display message box
              scorekeeper(score)
              msgbox({player_name;'Stay Determined!'},'Game Over')
              ex=1
          elseif player(1,2)==axis_limit%if snake exceeds boundaries display message box
              scorekeeper(score)
              msgbox({player_name;'Stay Determined!'},'Game Over')
              ex=1
          end
         
    else %If boundaries are off, can cross back over to other side
          player=player-((player>axis_limit).*(axis_limit+1));
          player=player+((player<0).*(axis_limit+1));
    end
    
end
close all
end


function draw_map(player,target,i,axis_limit,focus,difficulty)
    
    %Focus

    plot(player(1,1),player(1,2),'wo')
        %plots the thing you're controlling
    if focus <=30
        plot(player(1,1),player(1,2),'yo', 'MarkerSize',10)
            %Makes the controlled object bigger and yellow if 
            %focus is above 30
    end
    hold on
    
    if focus <= 30
        plot(target(1,1),target(1,2), 'o','MarkerSize',50,'MarkerEdgeColor','red','MarkerFaceColor','Red')
        %Increases size of target if focus is below 30.
    else
        plot(target(1,1),target(1,2), 'ro')
        %Makes game harder for higher focus
    end
    

    whitebg([0 0 0]) %makes background black
    
    %Generates distractors that change every sample
    z = 0; % counter
    while z <= difficulty/2
        distracter_generator(axis_limit) % see function
        z = z + 1;
    end
    %Generates harmless white distracters
    
    axis([0, axis_limit, 0, axis_limit]) %creates the axis for gameplay
    if focus >=50
        score = 2*i;
        %Double score to reward high focus
    else
        score = i;
        %Low score if focus is low.
    end
    title(score)
    hold off
end

function distracter_generator(axis_limit)
    %Generates white distracters every frame
    j = randi([1 axis_limit-1],1); %x random
    k = randi([1 axis_limit-1],1); %y random
    l = randi([1 axis_limit-1],1); %x random
    m = randi([1 axis_limit-1],1); %y random
    
    distracter_white=[j k];
    distracter_red=[l m]; 
    %Coordinates of distracters
    plot(distracter_white(1,1),distracter_white(1,2), 'wo')
    %Plots them as white circles.
    plot(distracter_red(1,1),distracter_red(1,2), 'ro')
    %Plots red triangles
end

function scorekeeper(score)
    csvwrite('scoreboard.csv',score)
end

