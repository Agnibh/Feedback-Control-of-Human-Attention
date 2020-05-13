function[]= Target(b)
global tar;
global ScrTar;

%Target
while b>0
tar=tar+1;
l1=figure(b);
x = [4 6 6 4 4];
y = [7 7 9 9 7];
plot(x,y);
fill(x,y,'k');
axis([0 10 0 10]);
set(gca,'color','w');
set(gca,'XTick',[], 'YTick', []);
set(gcf,'position',[0 0 1950 1000]);
set(gca,'position',[0.45 0.6 0.15 0.15]);
set(gca,'DataAspectRatio',[1 1 1]);
set(gcf,'Color','k');

pause(0.0001);            % Time for display
close(l1);
b=b-1;

[Q,T1] = getkey(1);
ScrTar(tar,1)=Q;
ScrTar(tar,2)=T1;
end
end
