%script load trials to superpose traces


folds = 'trial';
foldi = 1:4;
homedir = pwd;


for i = foldi
    cd([folds num2str(i)])
    load('power.mat')
    %meme coord so no need to save separately
    dPall{i} = dP;
    Isppaall{i} = Isppa;
    I1all{i} = I1;

    xx = unique(coord(:,1))';
    maxdP0 = [];
    maxIsp = [];
    for xi = 1:length(xx)
        maxdP0(xi) = max(dP(coord(:,1)==xx(xi)));
        maxIsp(xi) = max(Isppa(coord(:,1)==xx(xi)));
    end
    maxdP1 = 1e-4*((2.667*maxdP0).^2)/1480*1000;

    maxdPall{2,i} = maxdP1;
    maxdPall{1,i} = xx;
    maxIspall{2,i} = maxIsp;
    maxIspall{1,i} = xx;
    cd ..
end


figure, hold on
for i = foldi
    plot(maxdPall{1,i},maxdPall{2,i})
end

figure, hold on
for i = foldi
    plot(maxIspall{1,i},maxIspall{2,i})
end