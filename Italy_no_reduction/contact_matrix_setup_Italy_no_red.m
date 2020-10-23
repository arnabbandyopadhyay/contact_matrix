
% javaaddpath('/Users/Arnab/projects/poi_library/poi-3.8-20120326.jar');
% javaaddpath('/Users/Arnab/projects/poi_library/poi-ooxml-3.8-20120326.jar');
% javaaddpath('/Users/Arnab/projects/poi_library/poi-ooxml-schemas-3.8-20120326.jar');
% javaaddpath('/Users/Arnab/projects/poi_library/xmlbeans-2.3.0.jar');
% javaaddpath('/Users/Arnab/projects/covid-19/poi_library/dom4j-1.6.1.jar');
% 

clear all
home_dir=pwd;
agroup={'a1','a2','a3','a4'};
stvar={'init_sus_','init_exp_','init_ci_','init_cr_','init_ih_','init_ir_','init_hu_','init_hr_',...
        'init_ud_','init_ur_','init_rz_','init_dead_','init_rx_','init_ix_'};
    
cmit=csvread('Data/CM_Italy_Polymod.csv');    
    
shift=5.2;
datapoints=7;
npertu=300;
parstosave=46;

[num,txt,raw]=xlsread('Data/Italy_CM.xls');


% seq=[3:length(raw)-datapoints+1];
    seq=[3:5]; % for testing

savinit=zeros(length(stvar)*length(agroup),length(seq)+1);
savpars=zeros(parstosave,length(seq)+1);
savchi2=zeros(1,length(seq)+1);
% savr0=zeros(1,length(seq)+1);
toplot=zeros(1000,12*(length(seq)+1));

% savr0per=zeros(npertu,length(seq));
% savchi2per=zeros(100,length(seq)+1);
% savfrac=zeros(100,length(seq)+1);

% paramsperturb=zeros(npertu,length(seq)+1);

first_wind=15;


interval=(first_wind);
for i=2:interval+1
    raw(i,1)=mat2cell(cell2mat(raw(i,1))+shift-1,1);
end
raw(interval+1:end,1:50)={[]};

%save the new dataset to fit
xlwrite('Data/dat_italy_contact_matrix.xls', raw);

%% Load D2D framework

%arSetPars(pLabel, [p], [qFit], [qLog10], [lb], [ub], [type], [meanp], [stdp])

datafile='dat_italy_contact_matrix';

arInit;
arLoadModel('contact_matrix_Italy_four_age');
arLoadData(datafile);

arCompileAll;

arSetPars('r1_a1', log10(0.58),1,1,-5,5);
arSetPars('r1_a2', log10(0.58),1,1,-5,5);
arSetPars('r1_a3', log10(0.58),1,1,-5,5);
arSetPars('r1_a4', log10(0.58),1,1,-5,5);
%     arSetPars('r11', log10(0.58),1,1,log10(0.001),5);
%     arSetPars('r12', log10(0.58),1,1,log10(0.001),5);

arSetPars('r4', log10(1/10),1,1,log10(1/14),log10(1/7));
%     arSetPars('r5', log10(1/10),1,1,log10(1/16),log10(1/7));
arSetPars('r5', log10(1/10),1,1,log10(1/16),log10(1/5));
arSetPars('r6', log10(1/5),1,1,log10(1/7),log10(0.9));
%     arSetPars('r6', log10(1/5),1,1,log10(0.001),log10(1));
arSetPars('r7', log10(1/2.5),1,1,log10(1/3.5),log10(1));
arSetPars('r8', log10(1/8),1,1,log10(1/16),log10(1/3));

arSetPars('d_a1', log10(0.5),1,1,log10(0.3),log10(0.9));
arSetPars('d_a2', log10(0.5),1,1,log10(0.3),log10(0.9));
arSetPars('d_a3', log10(0.5),1,1,log10(0.3),log10(0.9));
arSetPars('d_a4', log10(0.5),1,1,log10(0.3),log10(0.9));

%     arSetPars('rho', log10(1/5),1,1,log10(0.1),log10(0.35));
arSetPars('rho_a1', log10(1/5),1,1,log10(0.01),log10(0.9));
arSetPars('rho_a2', log10(1/5),1,1,log10(0.01),log10(0.9));
arSetPars('rho_a3', log10(1/5),1,1,log10(0.01),log10(0.9));
arSetPars('rho_a4', log10(1/5),1,1,log10(0.01),log10(0.9));

%     arSetPars('thet', log10(0.2),1,1,log10(0.15),log10(0.4));
arSetPars('thet_a1', log10(0.2),1,1,log10(0.01),log10(0.7));
arSetPars('thet_a2', log10(0.2),1,1,log10(0.01),log10(0.7));
arSetPars('thet_a3', log10(0.2),1,1,log10(0.01),log10(0.7));
arSetPars('thet_a4', log10(0.2),1,1,log10(0.01),log10(0.7));

%     arSetPars('alpha', log10(1/11.1),1,1,log10(0.01),log10(0.16));
arSetPars('alpha', log10(0.4),2,1,log10(0.01),log10(0.4));
%     arSetPars('alpha', log10(0.5),1,1,log10(0.01),log10(0.7));
arSetPars('bet', log10(1/4),1,1,log10(0.05),log10(1));
%     arSetPars('delta', log10(0.15),1,1,log10(0.15),log10(0.77));
arSetPars('delta_a1', log10(0.15),1,1,log10(0.0001),log10(0.9));
arSetPars('delta_a2', log10(0.15),1,1,log10(0.0001),log10(0.9));
arSetPars('delta_a3', log10(0.15),1,1,log10(0.0001),log10(0.9));
arSetPars('delta_a4', log10(0.15),1,1,log10(0.0001),log10(0.9));

arSetPars('r3', log10(1/4.2),1,1,log10(1/4.2),log10(2/5.2));

%arSetPars('icum', log10(icum),2,1,-5,5);
arSetPars('ki', log10(1),2,1,log10(10^-8),log10(1));
arSetPars('und', log10(0.93),2,1,log10(0.002),log10(0.99));

% contact matrix

arSetPars('zcm11',log10(cmit(1,1)),2,1,-5,5);
arSetPars('zcm12',log10(cmit(1,2)),2,1,-5,5);
arSetPars('zcm13',log10(cmit(1,3)),2,1,-5,5);
arSetPars('zcm14',log10(cmit(1,4)),2,1,-5,5);

arSetPars('zcm21',log10(cmit(2,1)),2,1,-5,5);
arSetPars('zcm22',log10(cmit(2,2)),2,1,-5,5);
arSetPars('zcm23',log10(cmit(2,3)),2,1,-5,5);
arSetPars('zcm24',log10(cmit(2,4)),2,1,-5,5);

arSetPars('zcm31',log10(cmit(3,1)),2,1,-5,5);
arSetPars('zcm32',log10(cmit(3,2)),2,1,-5,5);
arSetPars('zcm33',log10(cmit(3,3)),2,1,-5,5);
arSetPars('zcm34',log10(cmit(3,4)),2,1,-5,5);

arSetPars('zcm41',log10(cmit(4,1)),2,1,-5,5);
arSetPars('zcm42',log10(cmit(4,2)),2,1,-5,5);
arSetPars('zcm43',log10(cmit(4,3)),2,1,-5,5);
arSetPars('zcm44',log10(cmit(4,4)),2,1,-5,5);


ar.config.optimizers=1;
%ar.config.showFitting = true;
%     arFitLHS(50)
arFitLHS(1)
arPlot;

close all

delete *mexa64


N0=ar.model.condition.xFineSimu(1,1);

time=ar.model.data.tFine;

qua_a1=ar.model.data.yFineSimu(:,1);
qua_a2=ar.model.data.yFineSimu(:,2);
qua_a3=ar.model.data.yFineSimu(:,3);
qua_a4=ar.model.data.yFineSimu(:,4);
hos=ar.model.data.yFineSimu(:,5);
icu=ar.model.data.yFineSimu(:,6);
rec=ar.model.data.yFineSimu(:,7);
dead_a1=ar.model.data.yFineSimu(:,8);
dead_a2=ar.model.data.yFineSimu(:,9);
dead_a3=ar.model.data.yFineSimu(:,10);
dead_a4=ar.model.data.yFineSimu(:,11);


datatoplot=[time,qua_a1,qua_a2,qua_a3,qua_a4,hos,icu,rec,dead_a1,dead_a2,dead_a3,dead_a4];

toplot(1:length(datatoplot),1:12)=datatoplot;

closevalue=[shift,ones(1,length(seq))];

se=[13:12:(length(seq)+1)*12];
params=10.^ar.p;
label=ar.pLabel;
% R0=R0calc(params,label,1);


savpars(:,1)=params';


arfixed=ar;

%% Reset before looping

params=10.^arfixed.p;

% frac=arfixed.model.condition.xFineSimu(1,1)/N0;
% R0=R0calc(params,label,frac);
savpars(:,1)=params';
savchi2(:,1)=arfixed.chi2;
% savr0(:,1)=R0;

clear ar;
ar=arfixed;


k=0;
for i=seq
    disp(i)
   
    k=k+1;
    %         undetected=uu(k);
    
    %             params=10.^ar.p;
    label=ar.pLabel;
    
    
    [minValue,closestIndex] = min(abs(ar.model.condition.tFine-closevalue(k)));
    
    
    repl=[];
    for rep=1:length(agroup)
        repl=[repl,strcat(stvar,agroup{rep})];
    end
    
    
    %take the simulation's population at that index and save it in file for the
    %next fit (Models/last_model_t_loop_2.def)
    initcond = ar.model.condition.xFineSimu(closestIndex,1:length(stvar)*length(agroup));
    savinit(:,k)=[initcond]';
    rl=sprintf(strcat(repl{1},'      "%d"'),initcond(1));
    
    
    Copy_of_func_replace_string('Models/contact_matrix_Italy_four_age_loop.def',...
        'Models/contact_matrix_Italy_four_age_loop_2.def',repl{1},rl)
    
    for j=2:length(repl)
%         il=sprintf('init_x%d',j);
        rl=sprintf(strcat(repl{j},'      "%d"'),initcond(j));
        %disp(rl)
        Copy_of_func_replace_string('Models/contact_matrix_Italy_four_age_loop_2.def',...
            'Models/contact_matrix_Italy_four_age_loop_2.def',repl{j},rl)
    end
    
    
    [num,txt,raw]=xlsread('Data/Italy_CM.xls');
    minshift=0;
    for ii=i:i+datapoints-1;
        minshift=minshift+1;
        raw(ii,1)=mat2cell(cell2mat(raw(ii,1))-cell2mat(raw(ii,1))+minshift,1);
    end
    
    dlrows=[2:i-1,i+datapoints:length(raw)];
    
    raw(dlrows,1:50)={[]};
    raw2=raw(setdiff(1:length(raw),dlrows),:);
    %save the best dataset to fit
    
    
    filename=sprintf('Data/cmat_italy_d2d_%d.xls',i);
    filenamed2d=sprintf('cmat_italy_d2d_%d',i);
    xlwrite(filename, raw2);
    
    
    %start the job ...
    arInit;
    arLoadModel('contact_matrix_Italy_four_age_loop_2');
    arLoadData(filenamed2d);
    arCompileAll;
    
    arSetPars('alpha', log10(params(1)),2,1,-5,5);
    arSetPars('bet', log10(params(2)),2,1,-5,5);
    arSetPars('ki', log10(1),2,1,-5,5);
    arSetPars('r3', log10(params(7)),2,1,-5,5);
    arSetPars('r4', log10(params(8)),2,1,-5,5);
    arSetPars('r5', log10(params(9)),2,1,-5,5);
    arSetPars('r6', log10(params(10)),2,1,-5,5);
    arSetPars('r7', log10(params(11)),2,1,-5,5);
    arSetPars('r8', log10(params(12)),2,1,-5,5);
    
    
    arSetPars('r1_a1', log10(0.58),1,1,log10(0.001),log10(3));
    arSetPars('r1_a1', log10(0.58),1,1,log10(0.001),log10(3));
    arSetPars('r1_a1', log10(0.58),1,1,log10(0.001),log10(3));
    arSetPars('r1_a1', log10(0.58),1,1,log10(0.001),log10(3));
    
    arSetPars('rho_a1', log10(1/5),1,1,log10(0.01),log10(0.9));
    arSetPars('rho_a2', log10(1/5),1,1,log10(0.01),log10(0.9));
    arSetPars('rho_a3', log10(1/5),1,1,log10(0.01),log10(0.9));
    arSetPars('rho_a4', log10(1/5),1,1,log10(0.01),log10(0.9));
    
    arSetPars('thet_a1', log10(0.2),1,1,log10(0.01),log10(0.7));
    arSetPars('thet_a2', log10(0.2),1,1,log10(0.01),log10(0.7));
    arSetPars('thet_a3', log10(0.2),1,1,log10(0.01),log10(0.7));
    arSetPars('thet_a4', log10(0.2),1,1,log10(0.01),log10(0.7));
    
    arSetPars('delta_a1', log10(0.15),1,1,log10(0.01),log10(0.9));
    arSetPars('delta_a2', log10(0.15),1,1,log10(0.01),log10(0.9));
    arSetPars('delta_a3', log10(0.15),1,1,log10(0.01),log10(0.9));
    arSetPars('delta_a4', log10(0.15),1,1,log10(0.01),log10(0.9));
    
    arSetPars('d_a1', log10(0.5),1,1,log10(0.3),log10(0.9));
    arSetPars('d_a2', log10(0.5),1,1,log10(0.3),log10(0.9));
    arSetPars('d_a3', log10(0.5),1,1,log10(0.3),log10(0.9));
    arSetPars('d_a4', log10(0.5),1,1,log10(0.3),log10(0.9));
    
    arSetPars('und', log10(0.93),2,1,log10(0.002),log10(0.99));
    
    % contact matrix

    arSetPars('zcm11',log10(cmit(1,1)),2,1,-5,5);
    arSetPars('zcm12',log10(cmit(1,2)),2,1,-5,5);
    arSetPars('zcm13',log10(cmit(1,3)),2,1,-5,5);
    arSetPars('zcm14',log10(cmit(1,4)),2,1,-5,5);
    
    arSetPars('zcm21',log10(cmit(2,1)),2,1,-5,5);
    arSetPars('zcm22',log10(cmit(2,2)),2,1,-5,5);
    arSetPars('zcm23',log10(cmit(2,3)),2,1,-5,5);
    arSetPars('zcm24',log10(cmit(2,4)),2,1,-5,5);
    
    arSetPars('zcm31',log10(cmit(3,1)),2,1,-5,5);
    arSetPars('zcm32',log10(cmit(3,2)),2,1,-5,5);
    arSetPars('zcm33',log10(cmit(3,3)),2,1,-5,5);
    arSetPars('zcm34',log10(cmit(3,4)),2,1,-5,5);
    
    arSetPars('zcm41',log10(cmit(4,1)),2,1,-5,5);
    arSetPars('zcm42',log10(cmit(4,2)),2,1,-5,5);
    arSetPars('zcm43',log10(cmit(4,3)),2,1,-5,5);
    arSetPars('zcm44',log10(cmit(4,4)),2,1,-5,5);

    
    arFitLHS(1)
    
    arPlot
    close all
    
    
    time=ar.model.data.tFine;
    
    qua_a1=ar.model.data.yFineSimu(:,1);
    qua_a2=ar.model.data.yFineSimu(:,2);
    qua_a3=ar.model.data.yFineSimu(:,3);
    qua_a4=ar.model.data.yFineSimu(:,4);
    hos=ar.model.data.yFineSimu(:,5);
    icu=ar.model.data.yFineSimu(:,6);
    rec=ar.model.data.yFineSimu(:,7);
    dead_a1=ar.model.data.yFineSimu(:,8);
    dead_a2=ar.model.data.yFineSimu(:,9);
    dead_a3=ar.model.data.yFineSimu(:,10);
    dead_a4=ar.model.data.yFineSimu(:,11);
    
    
    datatoplot=[time,qua_a1,qua_a2,qua_a3,qua_a4,hos,icu,rec,dead_a1,dead_a2,dead_a3,dead_a4];
    
    toplot(1:length(datatoplot),se(k):se(k)+11)=datatoplot;

    
    
    
    
    %     close all
    
    %
    %         %%%%%%%%%%%%%%%%%%%%%%%%%%% pertubation analysis Saham r0 sensitive vary
    %
    arloop=ar;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%% End
    
    
    params=10.^arloop.p;
    
%     frac=arloop.model.condition.xFineSimu(1,1)/(N0-arloop.model.condition.xFineSimu(1,12));
%     R0=R0calc(params,label,frac);
%     disp([params(1:end),label,N0,R0])
    savpars(:,k+1)=params';
    savchi2(:,k+1)=arfixed.chi2;
%     savr0(:,k+1)=R0;
    %
%     savr0per(perturb,k)=R0;
    %             paramsperturb(perturb,k)=params;
    
    %         clear ar
    ar=arloop;
    
end
TP.toplot=toplot;
TP.params=savpars;
TP.plabel=arfixed.pLabel;
% TP.r0=savr0per;

delete Data/cmat_italy_d2d_*.*
delete *mexmaci64




cd(home_dir);
%     csvwrite(sprintf('area_spec_%s.csv',cityname),toplot)
save(['contact_matrix.mat'],'TP')
%

%     folder=pwd;

%     rmdir(strcat(cityname),'s');

