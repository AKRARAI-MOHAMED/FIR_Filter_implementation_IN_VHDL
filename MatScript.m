% ce script récupère le résultat de matlab pour deux sous bande différentes
% à partir des deux fichiers corr_symb1.txt et corr_symb2.txt
% en plus on récupère le résultat de modelsim pour la bande simulé
% Le nombre de point est n = 3000 qui peut être changé

n = 3000;
fid = fopen('C:\Users\Morya\Desktop\TP5\OutputE.txt','r');
[Result,n]= fscanf(fid,'%6d\n',n);

figure;
plot(Result);
title('Result of Filtering');
grid;

% figure;
% plot(Input);
% title('Filter Input Data');
% grid;