% ce script r�cup�re le r�sultat de matlab pour deux sous bande diff�rentes
% � partir des deux fichiers corr_symb1.txt et corr_symb2.txt
% en plus on r�cup�re le r�sultat de modelsim pour la bande simul�
% Le nombre de point est n = 3000 qui peut �tre chang�

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