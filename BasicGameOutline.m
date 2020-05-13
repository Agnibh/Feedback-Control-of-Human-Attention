 
close all;
clear all;
clc;

% Setting up the visual screen 
l=figure(6);
set(gcf,'position',[0 0 1950 1000]);

set(gcf,'Color','k')

global tar;         % Number of times Targer appears
global ScrTar;      % Entered Key and Reaction time stored here
ScrTar=zeros(100,2);
tar=0;                      

global nontar;         % Number of times Non-Targer appears
global ScrNonTar;      % Entered Key and Reaction time stored here
ScrNonTar=zeros(100,2);
nontar=0;

str=tic;                % Start of Task
stp=toc(str);
while stp<10
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


Scr = (cTrgCrc*cTrgCrcTm+cNTrgCrc*cNTrgCrcTm)/(cTrgCrc+cNTrgCrc)...
-2*(cTrgNcrc*cTrgNcrcTm+cNTrgNcrc*cNTrgNcrcTm)/(cTrgNcrc+cNTrgNcrc+1);

if Scr<0.5
    Att_scr=0;
elseif  Scr>=0.5 && Scr<0.9
    Att_scr=1;
elseif Scr>=0.9 && Scr<1.3
    Att_scr=2;
elseif Scr>=1.3 && Scr<1.7
    Att_scr=3;
elseif Scr>=1.7 && Scr<2.1
    Att_scr=4;
else
    Att_scr=5; 
end