%% list of genes of interest
varnames={'gene'}; % protein name
myds=dataset(char(zeros(46,1)),'VarNames',varnames);
[~,text]=xlsread('fba_irl_Search2','A1:A46');
myds.gene=text;
var={'cre'}; % all gene designations
my = dataset(char(zeros(33,7)), 'VarNames',var);
[~,text]=xlsread('fba_irl_Search2','B1:H46');
my.cre=text;
%% import dataset
varnam={'newname'};  %gene names
myss = dataset(char(zeros(17737,1)),'VarNames',varnam);
varnam2={'matchedvalue','matchedvalue2'}; %light, dark values
mydd=dataset(zeros(17737,28),zeros(17737,28),'VarNames',varnam2);
mydd.matchedvalue=xlsread('fba_dataset','B1:AC17737');
mydd.matchedvalue2=xlsread('fba_dataset','AD1:BE17737');
[~,text]=xlsread('fba_dataset','A1:A17737');
myss.newname=text;
%%
genegroup=7; %up to 7 genes per protein
x=[1 2 3 4 5 6 7 8 9 10 11 11.5 12 12.5 13 13.5 14 14.5 15 16 17 18 19 20 21 22 23 24]; % time units of expression measurements
timeunit=size(x);
copies=2; % replications 
no=size(myds.gene);
total=1;        
for i=1:no %number of prtoein
   for k=1:genegroup
       tf2=strcmp(my.cre(i,k),'');
       if (tf2==1)
           continue   
       else 
            j=1;
            while j <17738
                tf=strcmp(my.cre(i,k),myss.newname(j));
                if (tf == 1)
                    for q=1:13 % light condition
                        plot(x(q),mydd.matchedvalue(j,q),'or','LineWidth',2);
                        hold all
                        plot(x(q),mydd.matchedvalue2(j,q),'or','LineWidth',2);
                    end
                    for r =1:15 % dark condition 
                        plot(x(r+13),mydd.matchedvalue(j,13+r),'ok','LineWidth',2);
                        plot(x(13+r),mydd.matchedvalue2(j,13+r),'ok','LineWidth',2);
                    end
                    j=17738; % quit looking
                end
            end
       end
   end
str=sprintf('gene: %s',myds.gene{i}); % print protein name on title
title(str);
str=sprintf('%s.jpg',myds.gene{i}); % export image
saveas(gcf,str);
clf  
end