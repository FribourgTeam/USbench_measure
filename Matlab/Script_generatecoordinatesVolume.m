% User-defined limits and steps
xmin = -40; xmax = 0; stepx = 2;
ymin = -10; ymax = 10; stepy = 2;
zmin = -10; zmax = 10; stepz = 2;

% Output file
outputFile = 'scan_coordinates.txt';
fid = fopen(outputFile, 'w');

% Generate coordinate grids
x_vals = xmax:-stepx:xmin;
y_vals = ymin:stepy:ymax;
z_vals = zmin:stepz:zmax;

coord = [];
% Scan plane-by-plane in X
for xi = 1:length(x_vals)
    x = x_vals(xi);
    
    % Snaking logic: alternate Y direction for efficiency
    y_dir = mod(xi, 2) == 1; % true if forward
    if y_dir
        y_loop = y_vals;
    else
        y_loop = fliplr(y_vals);
    end
    
    for yi = 1:length(y_loop)
        y = y_loop(yi);
        
        % Alternate Z direction within Y loop for better efficiency
        z_dir = mod(yi, 2) == 1; % true if forward
        if z_dir
            z_loop = z_vals;
        else
            z_loop = fliplr(z_vals);
        end
        
        for zi = 1:length(z_loop)
            z = z_loop(zi);
            fprintf(fid, '%.3f\t%.3f\t%.3f\n', x, y, z);
            coord = [coord;[x y z]];
        end
    end
end

fclose(fid);
fprintf('Scan coordinates written to %s\n', outputFile);