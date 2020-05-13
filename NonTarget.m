function[]=NonTarget(b)
global nontar;
global ScrNonTar;
%NonTarget
while b>0
nontar=nontar+1;
l2=figure(b);
x = [4 6 6 4 4];
y = [1 1 3 3 1];
plot(x,y);
fill(x,y,'k');
axis([0 10 0 10]);
set(gca,'color','w');
set(gca,'XTick',[], 'YTick', []);
set(gcf,'position',[0 0 1950 1000]);
set(gca,'position',[0.45 0.6 0.15 0.15]);
set(gca,'DataAspectRatio',[1 1 1]);
set(gcf,'Color','k');
pause(0.0001);
close(l2);
b=b-1;
%pause(2)
[P,T2] = getkey(1);
ScrNonTar(nontar,1)=P;
ScrNonTar(nontar,2)=T2;
end
end