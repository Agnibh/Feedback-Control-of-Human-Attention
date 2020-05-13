
close all;
clear all;
clc;

Scr=zeros(1,10);
Att_scr=zeros(1,10); %Based on number of iterations

global tar;         % Number of times Targer appears
global ScrTar;      % Entered Key and Reaction time stored here

ScrTar=zeros(100,2);
tar=0;  

global nontar;         % Number of times Non-Targer appears
global ScrNonTar;      % Entered Key and Reaction time stored here
ScrNonTar=zeros(100,2);
nontar=0;


for cnt=0:10
% Setting up the visual screen 
l=figure(6);
set(gcf,'position',[0 0 1950 1000]);

set(gcf,'Color','k')
    

str=tic;                % Start of Task
stp=toc(str);

while stp<10            % Time for each task
    a=randi(2);         % Randomly selecting Target and Non-Target
    e=randi(2);
    if a==1
        Target(e);
    else
        NonTarget(e);
    end
    stp=toc(str);
end
close(l);

ScrNonTar(nontar+1:end,:)=[];
ScrTar(tar+1:end,:)=[];

cTrgCrc = 0;  %Target Correct
cNTrgCrc = 0; %Non-Target Correct
cTrgNcrc = 0; %Target Not Correct 
cNTrgNcrc = 0;%Non-Target Not Correct

cTrgCrcTm = 0;  %Target Correct Time
cNTrgCrcTm = 0; %Non-Target Correct Time
cTrgNcrcTm = 0; %Target Not Correct Time
cNTrgNcrcTm = 0;%Non-Target Not Correct Time 

for i=1:length(ScrTar')
    
    if ScrTar(i,1)==32
      cTrgCrc = cTrgCrc +1;
      cTrgCrcTm = cTrgCrcTm + ScrTar(i,2);
    else
      cTrgNcrc = cTrgNcrc +1;
      cTrgNcrcTm = cTrgNcrcTm + ScrTar(i,2);
    end

end

for i=1:length(ScrNonTar')
    
    if ScrNonTar(i,1)==13
      cNTrgCrc = cNTrgCrc +1;
      cNTrgCrcTm = cNTrgCrcTm + ScrNonTar(i,2);
    else
      cNTrgNcrc = cNTrgNcrc +1;
      cNTrgNcrcTm = cNTrgNcrcTm + ScrNonTar(i,2);
    end

end


Scr(1,cnt+1) = (cTrgCrc*cTrgCrcTm+cNTrgCrc*cNTrgCrcTm)/(cTrgCrc+cNTrgCrc+1)...
-2*(cTrgNcrc*cTrgNcrcTm+cNTrgNcrc*cNTrgNcrcTm)/(cTrgNcrc+cNTrgNcrc+1);

if Scr(1,cnt+1)<1
    Att_scr(1,cnt+1)=0;
elseif  Scr(1,cnt+1)>=1 && Scr(1,cnt+1)<1.6
    Att_scr(1,cnt+1)=1;
elseif Scr(1,cnt+1)>=1.6 && Scr(1,cnt+1)<2.2
    Att_scr(1,cnt+1)=2;
elseif Scr(1,cnt+1)>=2.2 && Scr(1,cnt+1)<2.8
    Att_scr(1,cnt+1)=3;
elseif Scr(1,cnt+1)>=2.8 && Scr(1,cnt+1)<3.4
    Att_scr(1,cnt+1)=4;
else
    Att_scr(1,cnt+1 )=5;
end

tar=0;
nontar=0;
 
pause(1);
end