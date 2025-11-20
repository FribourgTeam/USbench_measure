% User-defined limits and steps
xmin = -30; xmax = 0; stepx = 2;
ymin = -10; ymax = 10; stepy = 1;
zmin = -10; zmax = 10; stepz = 1;

% Output file
outputFile = 'scan_coordinates_test';
fid = fopen([outputFile '.txt'], 'w');

% Generate coordinate arrays
x_vals = xmax:-stepx:xmin;
y_vals = ymin:stepy:ymax;
z_vals = zmin:stepz:zmax;

% Initialize last position
reverseYZ = false;

coord = zeros(length(x_vals)*length(y_vals)*length(z_vals),3);
flag = 1;
for xi = 1:length(x_vals)
    x = x_vals(xi);

    % Depending on reverseYZ flag, snake in normal or reversed Y-Z order
    if ~reverseYZ
        y_loop = y_vals;
    else
        y_loop = fliplr(y_vals);
    end

    for yi = 1:length(y_loop)
        y = y_loop(yi);

        % Alternate Z direction for each Y step
        if mod(yi,2)==1
            z_loop = z_vals;
        else
            z_loop = fliplr(z_vals);
        end

        for zi = 1:length(z_loop)
            z = z_loop(zi);
            fprintf(fid, '%.3f\t%.3f\t%.3f\n', x, y, z);
            coord(flag,:) = [x y z];
            flag = flag+1;
        end
    end

    % Flip the Y-Z snaking direction for next X plane to continue path
    reverseYZ = ~reverseYZ;
end

fclose(fid);
fprintf('Optimized snake-pattern scan written to %s\n', outputFile);

[~,xi] = ismember(coord(:,1),x_vals);
[~,yi] = ismember(coord(:,2),y_vals);
[~,zi] = ismember(coord(:,3),z_vals);
coordi = [xi, yi, zi];%coordinate in index of x y z vals
save([outputFile '.mat'],'coord','coordi','x_vals','y_vals','z_vals')

%plot volume scanned
%figure, plot3(coord(:,1),coord(:,2),coord(:,3),'.')
%k = boundary(coord);
%hold on, trisurf(k,coord(:,1),coord(:,2),coord(:,3),'Facecolor','red','FaceAlpha',0.1)
%or alpha shape: ahp =
%alphashape(coord(:,1),coord(:,2),coord(:,3),1);plot(ahp)


%isocaps isosurface
% D = rand(length(x_vals),length(y_vals),length(z_vals));
  
% [X,Y,Z] = ndgrid(x_vals,y_vals,z_vals);
% [fo,vo] = isosurface(X,Y,Z,D,0.1);               
% [fe,ve,ce] = isocaps(X,Y,Z,D,0.1);               
% figure
% p1 = patch('Faces', fo, 'Vertices', vo); 
% p1.FaceColor = 'red';
% p1.EdgeColor = 'none';
% p2 = patch('Faces', fe, 'Vertices', ve, ...    
%    'FaceVertexCData', ce);
% p2.FaceColor = 'interp';
% p2.EdgeColor = 'none';
% 
% view(-40,24)
% daspect([1 1 0.3])                             
% colormap(gray(100))
% box on
% 
% camlight(40,40)                                
% camlight(-20,-10)
% lighting gouraud
