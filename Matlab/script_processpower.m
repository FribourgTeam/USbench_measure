%script load powermat and process data

load('power.mat')

%transform data into 3D matrix
A = [];
B = [];
for fi = 1:length(Isppa)
    A(coordi(fi,1),coordi(fi,2),coordi(fi,3)) = Isppa(fi);
    B(coordi(fi,1),coordi(fi,2),coordi(fi,3)) = dP(fi);
end

%patch method
x_vals = flipud(unique(coord(:,1)));
y_vals = unique(coord(:,2));
z_vals = unique(coord(:,3));
[x,y,z] = meshgrid(x_vals,y_vals,z_vals);
%[x,y,z] = ndgrid(x_vals,y_vals,z_vals);
AA = permute(B,[2 1 3]);
%need to process volume for missing data
AA(isnan(AA)) = 0;


%rings
figure, 
view(3)
for zz = 2 %[-6:1:6 6:-1:-6]
    hSlice = slice(x,y,z,AA,-5,zz,0);
    set(hSlice,'EdgeColor','none','FaceColor','interp')
    drawnow
    pause(0.1)
end

%find max amplitude -> get the focal length at half amplitude
maxamp = max(AA(:));
cutoffamp = maxamp/4;

figure,view(3)
[ff] = isosurface(x,y,z,AA,maxamp*0.9);
hiso1 = patch(ff);alpha(0.5)
set(hiso1,'CData',1,'Facecolor','r','EdgeColor','k')
[ff] = isosurface(x,y,z,AA,maxamp*0.6);
hiso1 = patch(ff);alpha(0.5)
set(hiso1,'CData',1,'Facecolor','y','EdgeColor','none')
xlim([-100 0]),ylim([-6 6]),zlim([-6 6])
%hiso2 = patch(ff);
%set(hiso2,'CData',cutoffamp,'Facecolor','flat','EdgeColor','none')


lvls = min(AA(:)):0.05:max(AA(:));
figure,hSlice = contourslice(x,y,z,AA,-1*[5:5:50],[],[],lvls,'nearest');view(3)

%for volume or 2D plot the max of each plane
maxA = [];
ucordi1 = unique(coordi(:,1))';
for ii = ucordi1
    Aplane = B(ii,:,:);
    maxA(ii) = max(Aplane(:));

end
figure, plot(x_vals,maxA)
