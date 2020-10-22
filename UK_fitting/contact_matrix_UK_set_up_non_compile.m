
javaaddpath('/Users/Arnab/projects/poi_library/poi-3.8-20120326.jar');
javaaddpath('/Users/Arnab/projects/poi_library/poi-ooxml-3.8-20120326.jar');
javaaddpath('/Users/Arnab/projects/poi_library/poi-ooxml-schemas-3.8-20120326.jar');
javaaddpath('/Users/Arnab/projects/poi_library/xmlbeans-2.3.0.jar');
javaaddpath('/Users/Arnab/projects/poi_library/dom4j-1.6.1.jar');


clear all
agroup={'a1','a2','a3','a4','a5','a6','a7'};
stvar={'init_sus_','init_exp_','init_ci_','init_cr_','init_ih_','init_ir_','init_hu_','init_hr_',...
        'init_ud_','init_ur_','init_rz_','init_dead_','init_rx_','init_ix_'};
    
cmit=csvread('Data/CM_UK_Polymod.csv');
    
shift=5.2;
datapoints=7;
npertu=300;
parstosave=94+98;

[num,txt,raw]=xlsread('Data/UK_data.xls');


seq=[3:length(raw)-datapoints+1];
%     seq=[3:5]; % for testing

savinit=zeros(length(stvar)*length(agroup),length(seq)+1);
savpars=zeros(parstosave,length(seq)+1);
savchi2=zeros(1,length(seq)+1);
savr0=zeros(1,length(seq)+1);
toplot=zeros(1000,14*(length(seq)+1));

savr0per=zeros(npertu,length(seq));
savchi2per=zeros(100,length(seq)+1);
savfrac=zeros(100,length(seq)+1);

paramsperturb=zeros(npertu,length(seq)+1);

first_wind=40;


interval=(first_wind);
for i=2:interval+1
    raw(i,1)=mat2cell(cell2mat(raw(i,1))+shift-1,1);
end
raw(interval+1:end,1:50)={[]};

%save the new dataset to fit
xlwrite('Data/dat_UK_contact_matrix.xls', raw);

%% Load D2D framework

%arSetPars(pLabel, [p], [qFit], [qLog10], [lb], [ub], [type], [meanp], [stdp])

datafile='dat_UK_contact_matrix';

arInit;
arLoadModel('contact_matrix_UK_non_compile');
arLoadData(datafile);

arCompileAll;

arSetPars('r1_a1', log10(0.58),1,1,-5,5);
arSetPars('r1_a2', log10(0.58),1,1,-5,5);
arSetPars('r1_a3', log10(0.58),1,1,-5,5);
arSetPars('r1_a4', log10(0.58),1,1,-5,5);
arSetPars('r1_a5', log10(0.58),1,1,-5,5);
arSetPars('r1_a6', log10(0.58),1,1,-5,5);
arSetPars('r1_a7', log10(0.58),1,1,-5,5);

%     arSetPars('r11', log10(0.58),1,1,log10(0.001),5);
%     arSetPars('r12', log10(0.58),1,1,log10(0.001),5);

arSetPars('r4', log10(1/10),1,1,log10(1/14),log10(1/7));
% arSetPars('r4_a2', log10(1/10),1,1,log10(1/14),log10(1/7));
% arSetPars('r4_a3', log10(1/10),1,1,log10(1/14),log10(1/7));
% arSetPars('r4_a4', log10(1/10),1,1,log10(1/14),log10(1/7));
%     arSetPars('r5', log10(1/10),1,1,log10(1/16),log10(1/7));
arSetPars('r5', log10(1/10),1,1,log10(1/16),log10(1/5));
% arSetPars('r5_a2', log10(1/10),1,1,log10(1/16),log10(1/5));
% arSetPars('r5_a3', log10(1/10),1,1,log10(1/16),log10(1/5));
% arSetPars('r5_a4', log10(1/10),1,1,log10(1/16),log10(1/5));

arSetPars('r6', log10(1/5),1,1,log10(1/7),log10(0.9));
% arSetPars('r6_a2', log10(1/5),1,1,log10(1/7),log10(0.9));
% arSetPars('r6_a3', log10(1/5),1,1,log10(1/7),log10(0.9));
% arSetPars('r6_a4', log10(1/5),1,1,log10(1/7),log10(0.9));

%     arSetPars('r6', log10(1/5),1,1,log10(0.001),log10(1));
arSetPars('r7', log10(1/2.5),1,1,log10(1/3.5),log10(1));
% arSetPars('r7_a2', log10(1/2.5),1,1,log10(1/3.5),log10(1));
% arSetPars('r7_a3', log10(1/2.5),1,1,log10(1/3.5),log10(1));
% arSetPars('r7_a4', log10(1/2.5),1,1,log10(1/3.5),log10(1));

arSetPars('r8', log10(1/8),1,1,log10(1/16),log10(1/3));
% arSetPars('r8_a2', log10(1/8),1,1,log10(1/16),log10(1/3));
% arSetPars('r8_a3', log10(1/8),1,1,log10(1/16),log10(1/3));
% arSetPars('r8_a4', log10(1/8),1,1,log10(1/16),log10(1/3));

arSetPars('d_a1', log10(0.5),1,1,log10(0.3),log10(0.9));
arSetPars('d_a2', log10(0.5),1,1,log10(0.3),log10(0.9));
arSetPars('d_a3', log10(0.5),1,1,log10(0.3),log10(0.9));
arSetPars('d_a4', log10(0.5),1,1,log10(0.3),log10(0.9));
arSetPars('d_a5', log10(0.5),1,1,log10(0.3),log10(0.9));
arSetPars('d_a6', log10(0.5),1,1,log10(0.3),log10(0.9));
arSetPars('d_a7', log10(0.5),1,1,log10(0.3),log10(0.9));

%     arSetPars('rho', log10(1/5),1,1,log10(0.1),log10(0.35));
arSetPars('rho_a1', log10(1/5),1,1,log10(0.01),log10(0.9));
arSetPars('rho_a2', log10(1/5),1,1,log10(0.01),log10(0.9));
arSetPars('rho_a3', log10(1/5),1,1,log10(0.01),log10(0.9));
arSetPars('rho_a4', log10(1/5),1,1,log10(0.01),log10(0.9));
arSetPars('rho_a5', log10(1/5),1,1,log10(0.01),log10(0.9));
arSetPars('rho_a6', log10(1/5),1,1,log10(0.01),log10(0.9));
arSetPars('rho_a7', log10(1/5),1,1,log10(0.01),log10(0.9));

%     arSetPars('thet', log10(0.2),1,1,log10(0.15),log10(0.4));
arSetPars('thet_a1', log10(0.2),1,1,log10(0.01),log10(0.7));
arSetPars('thet_a2', log10(0.2),1,1,log10(0.01),log10(0.7));
arSetPars('thet_a3', log10(0.2),1,1,log10(0.01),log10(0.7));
arSetPars('thet_a4', log10(0.2),1,1,log10(0.01),log10(0.7));
arSetPars('thet_a5', log10(0.2),1,1,log10(0.01),log10(0.7));
arSetPars('thet_a6', log10(0.2),1,1,log10(0.01),log10(0.7));
arSetPars('thet_a7', log10(0.2),1,1,log10(0.01),log10(0.7));

%     arSetPars('alpha', log10(1/11.1),1,1,log10(0.01),log10(0.16));
arSetPars('alpha', log10(0.4),2,1,log10(0.01),log10(0.4));
%     arSetPars('alpha', log10(0.5),1,1,log10(0.01),log10(0.7));
arSetPars('bet', log10(1/4),1,1,log10(0.05),log10(1));
%     arSetPars('delta', log10(0.15),1,1,log10(0.15),log10(0.77));
arSetPars('delta_a1', log10(0.15),1,1,log10(0.0001),log10(0.9));
arSetPars('delta_a2', log10(0.15),1,1,log10(0.0001),log10(0.9));
arSetPars('delta_a3', log10(0.15),1,1,log10(0.0001),log10(0.9));
arSetPars('delta_a4', log10(0.15),1,1,log10(0.0001),log10(0.9));
arSetPars('delta_a5', log10(0.15),1,1,log10(0.0001),log10(0.9));
arSetPars('delta_a6', log10(0.15),1,1,log10(0.0001),log10(0.9));
arSetPars('delta_a7', log10(0.15),1,1,log10(0.0001),log10(0.9));

arSetPars('r3', log10(1/4.2),1,1,log10(1/4.2),log10(2/5.2));

%arSetPars('icum', log10(icum),2,1,-5,5);
arSetPars('ki', log10(1),2,1,log10(10^-8),log10(1));
arSetPars('und', log10(0.99),2,1,log10(0.002),log10(0.99));

% contact matrix

arSetPars('cm11',log10(cmit(1,1)),2,1,-5,5);
arSetPars('cm12',log10(cmit(1,2)),2,1,-5,5);
arSetPars('cm13',log10(cmit(1,3)),2,1,-5,5);
arSetPars('cm14',log10(cmit(1,4)),2,1,-5,5);
arSetPars('cm15',log10(cmit(1,5)),2,1,-5,5);
arSetPars('cm16',log10(cmit(1,6)),2,1,-5,5);
arSetPars('cm17',log10(cmit(1,7)),2,1,-5,5);

arSetPars('cm21',log10(cmit(2,1)),2,1,-5,5);
arSetPars('cm22',log10(cmit(2,2)),2,1,-5,5);
arSetPars('cm23',log10(cmit(2,3)),2,1,-5,5);
arSetPars('cm24',log10(cmit(2,4)),2,1,-5,5);
arSetPars('cm25',log10(cmit(2,5)),2,1,-5,5);
arSetPars('cm26',log10(cmit(2,6)),2,1,-5,5);
arSetPars('cm27',log10(cmit(2,7)),2,1,-5,5);

arSetPars('cm31',log10(cmit(3,1)),2,1,-5,5);
arSetPars('cm32',log10(cmit(3,2)),2,1,-5,5);
arSetPars('cm33',log10(cmit(3,3)),2,1,-5,5);
arSetPars('cm34',log10(cmit(3,4)),2,1,-5,5);
arSetPars('cm35',log10(cmit(3,5)),2,1,-5,5);
arSetPars('cm36',log10(cmit(3,6)),2,1,-5,5);
arSetPars('cm37',log10(cmit(3,7)),2,1,-5,5);


arSetPars('cm41',log10(cmit(4,1)),2,1,-5,5);
arSetPars('cm42',log10(cmit(4,2)),2,1,-5,5);
arSetPars('cm43',log10(cmit(4,3)),2,1,-5,5);
arSetPars('cm44',log10(cmit(4,4)),2,1,-5,5);
arSetPars('cm45',log10(cmit(4,5)),2,1,-5,5);
arSetPars('cm46',log10(cmit(4,6)),2,1,-5,5);
arSetPars('cm47',log10(cmit(4,7)),2,1,-5,5);

arSetPars('cm51',log10(cmit(5,1)),2,1,-5,5);
arSetPars('cm52',log10(cmit(5,2)),2,1,-5,5);
arSetPars('cm53',log10(cmit(5,3)),2,1,-5,5);
arSetPars('cm54',log10(cmit(5,4)),2,1,-5,5);
arSetPars('cm55',log10(cmit(5,5)),2,1,-5,5);
arSetPars('cm56',log10(cmit(5,6)),2,1,-5,5);
arSetPars('cm57',log10(cmit(5,7)),2,1,-5,5);

arSetPars('cm61',log10(cmit(6,1)),2,1,-5,5);
arSetPars('cm62',log10(cmit(6,2)),2,1,-5,5);
arSetPars('cm63',log10(cmit(6,3)),2,1,-5,5);
arSetPars('cm64',log10(cmit(6,4)),2,1,-5,5);
arSetPars('cm65',log10(cmit(6,5)),2,1,-5,5);
arSetPars('cm66',log10(cmit(6,6)),2,1,-5,5);
arSetPars('cm67',log10(cmit(6,7)),2,1,-5,5);

arSetPars('cm71',log10(cmit(7,1)),2,1,-5,5);
arSetPars('cm72',log10(cmit(7,2)),2,1,-5,5);
arSetPars('cm73',log10(cmit(7,3)),2,1,-5,5);
arSetPars('cm74',log10(cmit(7,4)),2,1,-5,5);
arSetPars('cm75',log10(cmit(7,5)),2,1,-5,5);
arSetPars('cm76',log10(cmit(7,6)),2,1,-5,5);
arSetPars('cm77',log10(cmit(7,7)),2,1,-5,5);


arSetPars('i0_sus_a1',log10(15620000),2,1,-5,5);
arSetPars('i0_exp_a1',log10(266),2,1,-5,5);
arSetPars('i0_ci_a1',log10(0),2,1,-5,5);
arSetPars('i0_cr_a1',log10(0),2,1,-5,5);
arSetPars('i0_ih_a1',log10(0),2,1,-5,5);
arSetPars('i0_ir_a1',log10(0),2,1,-5,5);
arSetPars('i0_hu_a1',log10(0),2,1,-5,5);
arSetPars('i0_hr_a1',log10(0),2,1,-5,5);
arSetPars('i0_ud_a1',log10(0),2,1,-5,5);
arSetPars('i0_ur_a1',log10(0),2,1,-5,5);
arSetPars('i0_rz_a1',log10(0),2,1,-5,5);
arSetPars('i0_dead_a1',log10(0),2,1,-5,5);
arSetPars('i0_rx_a1',log10(0),2,1,-5,5);
arSetPars('i0_ix_a1',log10(0),2,1,-5,5);

arSetPars('i0_sus_a2',log10(8660000),2,1,-5,5);
arSetPars('i0_exp_a2',log10(804),2,1,-5,5);
arSetPars('i0_ci_a2',log10(0),2,1,-5,5);
arSetPars('i0_cr_a2',log10(0),2,1,-5,5);
arSetPars('i0_ih_a2',log10(0),2,1,-5,5);
arSetPars('i0_ir_a2',log10(0),2,1,-5,5);
arSetPars('i0_hu_a2',log10(0),2,1,-5,5);
arSetPars('i0_hr_a2',log10(0),2,1,-5,5);
arSetPars('i0_ud_a2',log10(0),2,1,-5,5);
arSetPars('i0_ur_a2',log10(0),2,1,-5,5);
arSetPars('i0_rz_a2',log10(0),2,1,-5,5);
arSetPars('i0_dead_a2',log10(0),2,1,-5,5);
arSetPars('i0_rx_a2',log10(0),2,1,-5,5);
arSetPars('i0_ix_a2',log10(0),2,1,-5,5);

arSetPars('i0_sus_a3',log10(8900000),2,1,-5,5);
arSetPars('i0_exp_a3',log10(915),2,1,-5,5);
arSetPars('i0_ci_a3',log10(0),2,1,-5,5);
arSetPars('i0_cr_a3',log10(0),2,1,-5,5);
arSetPars('i0_ih_a3',log10(0),2,1,-5,5);
arSetPars('i0_ir_a3',log10(0),2,1,-5,5);
arSetPars('i0_hu_a3',log10(0),2,1,-5,5);
arSetPars('i0_hr_a3',log10(0),2,1,-5,5);
arSetPars('i0_ud_a3',log10(0),2,1,-5,5);
arSetPars('i0_ur_a3',log10(0),2,1,-5,5);
arSetPars('i0_rz_a3',log10(0),2,1,-5,5);
arSetPars('i0_dead_a3',log10(0),2,1,-5,5);
arSetPars('i0_rx_a3',log10(0),2,1,-5,5);
arSetPars('i0_ix_a3',log10(0),2,1,-5,5);

arSetPars('i0_sus_a4',log10(8420000),2,1,-5,5);
arSetPars('i0_exp_a4',log10(963),2,1,-5,5);
arSetPars('i0_ci_a4',log10(0),2,1,-5,5);
arSetPars('i0_cr_a4',log10(0),2,1,-5,5);
arSetPars('i0_ih_a4',log10(0),2,1,-5,5);
arSetPars('i0_ir_a4',log10(0),2,1,-5,5);
arSetPars('i0_hu_a4',log10(0),2,1,-5,5);
arSetPars('i0_hr_a4',log10(0),2,1,-5,5);
arSetPars('i0_ud_a4',log10(0),2,1,-5,5);
arSetPars('i0_ur_a4',log10(0),2,1,-5,5);
arSetPars('i0_rz_a4',log10(0),2,1,-5,5);
arSetPars('i0_dead_a4',log10(0),2,1,-5,5);
arSetPars('i0_rx_a4',log10(0),2,1,-5,5);
arSetPars('i0_ix_a4',log10(0),2,1,-5,5);

arSetPars('i0_sus_a5',log10(9070000),2,1,-5,5);
arSetPars('i0_exp_a5',log10(1099),2,1,-5,5);
arSetPars('i0_ci_a5',log10(0),2,1,-5,5);
arSetPars('i0_cr_a5',log10(0),2,1,-5,5);
arSetPars('i0_ih_a5',log10(0),2,1,-5,5);
arSetPars('i0_ir_a5',log10(0),2,1,-5,5);
arSetPars('i0_hu_a5',log10(0),2,1,-5,5);
arSetPars('i0_hr_a5',log10(0),2,1,-5,5);
arSetPars('i0_ud_a5',log10(0),2,1,-5,5);
arSetPars('i0_ur_a5',log10(0),2,1,-5,5);
arSetPars('i0_rz_a5',log10(0),2,1,-5,5);
arSetPars('i0_dead_a5',log10(0),2,1,-5,5);
arSetPars('i0_rx_a5',log10(0),2,1,-5,5);
arSetPars('i0_ix_a5',log10(0),2,1,-5,5);

arSetPars('i0_sus_a6',log10(7130000),2,1,-5,5);
arSetPars('i0_exp_a6',log10(698),2,1,-5,5);
arSetPars('i0_ci_a6',log10(0),2,1,-5,5);
arSetPars('i0_cr_a6',log10(0),2,1,-5,5);
arSetPars('i0_ih_a6',log10(0),2,1,-5,5);
arSetPars('i0_ir_a6',log10(0),2,1,-5,5);
arSetPars('i0_hu_a6',log10(0),2,1,-5,5);
arSetPars('i0_hr_a6',log10(0),2,1,-5,5);
arSetPars('i0_ud_a6',log10(0),2,1,-5,5);
arSetPars('i0_ur_a6',log10(0),2,1,-5,5);
arSetPars('i0_rz_a6',log10(0),2,1,-5,5);
arSetPars('i0_dead_a6',log10(0),2,1,-5,5);
arSetPars('i0_rx_a6',log10(0),2,1,-5,5);
arSetPars('i0_ix_a6',log10(0),2,1,-5,5);

arSetPars('i0_sus_a7',log10(9020000),2,1,-5,5);
arSetPars('i0_exp_a7',log10(2152),2,1,-5,5);
arSetPars('i0_ci_a7',log10(0),2,1,-5,5);
arSetPars('i0_cr_a7',log10(0),2,1,-5,5);
arSetPars('i0_ih_a7',log10(0),2,1,-5,5);
arSetPars('i0_ir_a7',log10(0),2,1,-5,5);
arSetPars('i0_hu_a7',log10(0),2,1,-5,5);
arSetPars('i0_hr_a7',log10(0),2,1,-5,5);
arSetPars('i0_ud_a7',log10(0),2,1,-5,5);
arSetPars('i0_ur_a7',log10(0),2,1,-5,5);
arSetPars('i0_rz_a7',log10(0),2,1,-5,5);
arSetPars('i0_dead_a7',log10(0),2,1,-5,5);
arSetPars('i0_rx_a7',log10(0),2,1,-5,5);
arSetPars('i0_ix_a7',log10(0),2,1,-5,5);











ar.config.optimizers=1;
%ar.config.showFitting = true;
%     arFitLHS(50)
arFitLHS(5)
arPlot;

close all

delete *mexa64


N0=ar.model.condition.xFineSimu(1,1);

time=ar.model.data.tFine;

qua_a1=ar.model.data.yFineSimu(:,1);
qua_a2=ar.model.data.yFineSimu(:,2);
qua_a3=ar.model.data.yFineSimu(:,3);
qua_a4=ar.model.data.yFineSimu(:,4);
qua=ar.model.data.yFineSimu(:,5);
hos=ar.model.data.yFineSimu(:,6);
icu=ar.model.data.yFineSimu(:,7);
rec=ar.model.data.yFineSimu(:,8);
ddead_a1=ar.model.data.yFineSimu(:,9);
ddead_a2=ar.model.data.yFineSimu(:,10);
ddead_a3=ar.model.data.yFineSimu(:,11);
ddead_a4=ar.model.data.yFineSimu(:,12);
ddead=ar.model.data.yFineSimu(:,13);


datatoplot=[time,qua_a1,qua_a2,qua_a3,qua_a4,qua,hos,icu,rec,ddead_a1,ddead_a2,ddead_a3,ddead_a4,ddead];

toplot(1:length(datatoplot),1:14)=datatoplot;

closevalue=[shift,ones(1,length(seq))];

se=[15:14:(length(seq)+1)*14];
params=10.^ar.p;
label=ar.pLabel;
% R0=R0calc(params,label,1);


savpars(:,1)=params';


arfixed=ar;

%% Reset before looping

params=10.^arfixed.p;

frac=arfixed.model.condition.xFineSimu(1,1)/N0;
% R0=R0calc(params,label,frac);
savpars(:,1)=params';
savchi2(:,1)=arfixed.chi2;
% savr0(:,1)=R0;

clear ar;
ar=arfixed;

%arInit;
%arLoadModel('contact_matrix_UK_non_compile');
%arLoadData(filenamed2d);
%arCompileAll;


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
    
    
    Copy_of_func_replace_string('Models/contact_matrix_UK_loop.def',...
        'Models/contact_matrix_UK_loop_2.def',repl{1},rl)
    
    for j=2:length(repl)
%         il=sprintf('init_x%d',j);
        rl=sprintf(strcat(repl{j},'      "%d"'),initcond(j));
        %disp(rl)
        Copy_of_func_replace_string('Models/contact_matrix_UK_loop_2.def',...
            'Models/contact_matrix_UK_loop_2.def',repl{j},rl)
    end
    
    
    [num,txt,raw]=xlsread('Data/UK_data.xls');
    minshift=0;
    for ii=i:i+datapoints-1;
        minshift=minshift+1;
        raw(ii,1)=mat2cell(cell2mat(raw(ii,1))-cell2mat(raw(ii,1))+minshift,1);
    end
    
    dlrows=[2:i-1,i+datapoints:length(raw)];
    
    raw(dlrows,1:50)={[]};
    raw2=raw(setdiff(1:length(raw),dlrows),:);
    %save the best dataset to fit
    
    
    filename=sprintf('Data/cmat_UK_d2d_%d.xls',i);
    filenamed2d=sprintf('cmat_UK_d2d_%d',i);
    xlwrite(filename, raw2);
    
ar.model.data.tExp=raw2(:,1);
ar.model.data.yExp=raw2(:,2:end);
ar.model.data.yExpRaw=raw2(:,2:end);
ar.model.data.yExpStd=arfixed.model.data.yExpStd(1:7,:);
ar.model.data.yExpStdRaw=arfixed.model.data.yExpStdRaw(1:7,:);
%ar.model.data.yExpSimu=zeros(4,2);




    %start the job ...

    
    arSetPars('alpha', log10(params(1)),2,1,-5,5);
    arSetPars('bet', log10(params(2)),2,1,-5,5);
    arSetPars('ki', log10(1),2,1,-5,5);
    arSetPars('r3', log10(params(strcmp(label,'r3'))),2,1,-5,5);
    arSetPars('r4', log10(params(strcmp(label,'r4'))),2,1,-5,5);
    arSetPars('r5', log10(params(strcmp(label,'r5'))),2,1,-5,5);
    arSetPars('r6', log10(params(strcmp(label,'r6'))),2,1,-5,5);
    arSetPars('r7', log10(params(strcmp(label,'r7'))),2,1,-5,5);
    arSetPars('r8', log10(params(strcmp(label,'r8'))),2,1,-5,5);
    
    
    arSetPars('r1_a1', log10(0.58),1,1,-5,5);
    arSetPars('r1_a2', log10(0.58),1,1,-5,5);
    arSetPars('r1_a3', log10(0.58),1,1,-5,5);
    arSetPars('r1_a4', log10(0.58),1,1,-5,5);
    arSetPars('r1_a5', log10(0.58),1,1,-5,5);
    arSetPars('r1_a6', log10(0.58),1,1,-5,5);
    arSetPars('r1_a7', log10(0.58),1,1,-5,5);
 
    arSetPars('d_a1', log10(0.5),1,1,log10(0.3),log10(0.9));
    arSetPars('d_a2', log10(0.5),1,1,log10(0.3),log10(0.9));
    arSetPars('d_a3', log10(0.5),1,1,log10(0.3),log10(0.9));
    arSetPars('d_a4', log10(0.5),1,1,log10(0.3),log10(0.9));
    arSetPars('d_a5', log10(0.5),1,1,log10(0.3),log10(0.9));
    arSetPars('d_a6', log10(0.5),1,1,log10(0.3),log10(0.9));
    arSetPars('d_a7', log10(0.5),1,1,log10(0.3),log10(0.9));

    %     arSetPars('rho', log10(1/5),1,1,log10(0.1),log10(0.35));
    arSetPars('rho_a1', log10(1/5),1,1,log10(0.01),log10(0.9));
    arSetPars('rho_a2', log10(1/5),1,1,log10(0.01),log10(0.9));
    arSetPars('rho_a3', log10(1/5),1,1,log10(0.01),log10(0.9));
    arSetPars('rho_a4', log10(1/5),1,1,log10(0.01),log10(0.9));
    arSetPars('rho_a5', log10(1/5),1,1,log10(0.01),log10(0.9));
    arSetPars('rho_a6', log10(1/5),1,1,log10(0.01),log10(0.9));
    arSetPars('rho_a7', log10(1/5),1,1,log10(0.01),log10(0.9));

    %     arSetPars('thet', log10(0.2),1,1,log10(0.15),log10(0.4));
    arSetPars('thet_a1', log10(0.2),1,1,log10(0.01),log10(0.7));
    arSetPars('thet_a2', log10(0.2),1,1,log10(0.01),log10(0.7));
    arSetPars('thet_a3', log10(0.2),1,1,log10(0.01),log10(0.7));
    arSetPars('thet_a4', log10(0.2),1,1,log10(0.01),log10(0.7));
    arSetPars('thet_a5', log10(0.2),1,1,log10(0.01),log10(0.7));
    arSetPars('thet_a6', log10(0.2),1,1,log10(0.01),log10(0.7));
    arSetPars('thet_a7', log10(0.2),1,1,log10(0.01),log10(0.7));
    
    
    arSetPars('delta_a1', log10(0.15),1,1,log10(0.0001),log10(0.9));
    arSetPars('delta_a2', log10(0.15),1,1,log10(0.0001),log10(0.9));
    arSetPars('delta_a3', log10(0.15),1,1,log10(0.0001),log10(0.9));
    arSetPars('delta_a4', log10(0.15),1,1,log10(0.0001),log10(0.9));
    arSetPars('delta_a5', log10(0.15),1,1,log10(0.0001),log10(0.9));
    arSetPars('delta_a6', log10(0.15),1,1,log10(0.0001),log10(0.9));
    arSetPars('delta_a7', log10(0.15),1,1,log10(0.0001),log10(0.9));
    
    
    arSetPars('und', log10(0.99),2,1,log10(0.002),log10(0.99));
    
    % contact matrix

    arSetPars('cm11',log10(cmit(1,1)),2,1,-5,5);
    arSetPars('cm12',log10(cmit(1,2)),2,1,-5,5);
    arSetPars('cm13',log10(cmit(1,3)),2,1,-5,5);
    arSetPars('cm14',log10(cmit(1,4)),2,1,-5,5);
    arSetPars('cm15',log10(cmit(1,5)),2,1,-5,5);
    arSetPars('cm16',log10(cmit(1,6)),2,1,-5,5);
    arSetPars('cm17',log10(cmit(1,7)),2,1,-5,5);
    
    arSetPars('cm21',log10(cmit(2,1)),2,1,-5,5);
    arSetPars('cm22',log10(cmit(2,2)),2,1,-5,5);
    arSetPars('cm23',log10(cmit(2,3)),2,1,-5,5);
    arSetPars('cm24',log10(cmit(2,4)),2,1,-5,5);
    arSetPars('cm25',log10(cmit(2,5)),2,1,-5,5);
    arSetPars('cm26',log10(cmit(2,6)),2,1,-5,5);
    arSetPars('cm27',log10(cmit(2,7)),2,1,-5,5);
    
    arSetPars('cm31',log10(cmit(3,1)),2,1,-5,5);
    arSetPars('cm32',log10(cmit(3,2)),2,1,-5,5);
    arSetPars('cm33',log10(cmit(3,3)),2,1,-5,5);
    arSetPars('cm34',log10(cmit(3,4)),2,1,-5,5);
    arSetPars('cm35',log10(cmit(3,5)),2,1,-5,5);
    arSetPars('cm36',log10(cmit(3,6)),2,1,-5,5);
    arSetPars('cm37',log10(cmit(3,7)),2,1,-5,5);
    
    
    arSetPars('cm41',log10(cmit(4,1)),2,1,-5,5);
    arSetPars('cm42',log10(cmit(4,2)),2,1,-5,5);
    arSetPars('cm43',log10(cmit(4,3)),2,1,-5,5);
    arSetPars('cm44',log10(cmit(4,4)),2,1,-5,5);
    arSetPars('cm45',log10(cmit(4,5)),2,1,-5,5);
    arSetPars('cm46',log10(cmit(4,6)),2,1,-5,5);
    arSetPars('cm47',log10(cmit(4,7)),2,1,-5,5);
    
    arSetPars('cm51',log10(cmit(5,1)),2,1,-5,5);
    arSetPars('cm52',log10(cmit(5,2)),2,1,-5,5);
    arSetPars('cm53',log10(cmit(5,3)),2,1,-5,5);
    arSetPars('cm54',log10(cmit(5,4)),2,1,-5,5);
    arSetPars('cm55',log10(cmit(5,5)),2,1,-5,5);
    arSetPars('cm56',log10(cmit(5,6)),2,1,-5,5);
    arSetPars('cm57',log10(cmit(5,7)),2,1,-5,5);
    
    arSetPars('cm61',log10(cmit(6,1)),2,1,-5,5);
    arSetPars('cm62',log10(cmit(6,2)),2,1,-5,5);
    arSetPars('cm63',log10(cmit(6,3)),2,1,-5,5);
    arSetPars('cm64',log10(cmit(6,4)),2,1,-5,5);
    arSetPars('cm65',log10(cmit(6,5)),2,1,-5,5);
    arSetPars('cm66',log10(cmit(6,6)),2,1,-5,5);
    arSetPars('cm67',log10(cmit(6,7)),2,1,-5,5);
    
    arSetPars('cm71',log10(cmit(7,1)),2,1,-5,5);
    arSetPars('cm72',log10(cmit(7,2)),2,1,-5,5);
    arSetPars('cm73',log10(cmit(7,3)),2,1,-5,5);
    arSetPars('cm74',log10(cmit(7,4)),2,1,-5,5);
    arSetPars('cm75',log10(cmit(7,5)),2,1,-5,5);
    arSetPars('cm76',log10(cmit(7,6)),2,1,-5,5);
    arSetPars('cm77',log10(cmit(7,7)),2,1,-5,5);


arSetPars('i0_sus_a1',log10(initcond(1)),2,1,-5,5);
arSetPars('i0_exp_a1',log10(initcond(2)),2,1,-5,5);
arSetPars('i0_ci_a1',log10(initcond(3)),2,1,-5,5);
arSetPars('i0_cr_a1',log10(initcond(4)),2,1,-5,5);
arSetPars('i0_ih_a1',log10(initcond(5)),2,1,-5,5);
arSetPars('i0_ir_a1',log10(initcond(6)),2,1,-5,5);
arSetPars('i0_hu_a1',log10(initcond(7)),2,1,-5,5);
arSetPars('i0_hr_a1',log10(initcond(8)),2,1,-5,5);
arSetPars('i0_ud_a1',log10(initcond(9)),2,1,-5,5);
arSetPars('i0_ur_a1',log10(initcond(10)),2,1,-5,5);
arSetPars('i0_rz_a1',log10(initcond(11)),2,1,-5,5);
arSetPars('i0_dead_a1',log10(initcond(12)),2,1,-5,5);
arSetPars('i0_rx_a1',log10(initcond(13)),2,1,-5,5);
arSetPars('i0_ix_a1',log10(initcond(14)),2,1,-5,5);

arSetPars('i0_sus_a2',log10(initcond(15)),2,1,-5,5);
arSetPars('i0_exp_a2',log10(initcond(16)),2,1,-5,5);
arSetPars('i0_ci_a2',log10(initcond(17)),2,1,-5,5);
arSetPars('i0_cr_a2',log10(initcond(18)),2,1,-5,5);
arSetPars('i0_ih_a2',log10(initcond(19)),2,1,-5,5);
arSetPars('i0_ir_a2',log10(initcond(20)),2,1,-5,5);
arSetPars('i0_hu_a2',log10(initcond(21)),2,1,-5,5);
arSetPars('i0_hr_a2',log10(initcond(22)),2,1,-5,5);
arSetPars('i0_ud_a2',log10(initcond(23)),2,1,-5,5);
arSetPars('i0_ur_a2',log10(initcond(24)),2,1,-5,5);
arSetPars('i0_rz_a2',log10(initcond(25)),2,1,-5,5);
arSetPars('i0_dead_a2',log10(initcond(26)),2,1,-5,5);
arSetPars('i0_rx_a2',log10(initcond(27)),2,1,-5,5);
arSetPars('i0_ix_a2',log10(initcond(28)),2,1,-5,5);

arSetPars('i0_sus_a3',log10(initcond(29)),2,1,-5,5);
arSetPars('i0_exp_a3',log10(initcond(30)),2,1,-5,5);
arSetPars('i0_ci_a3',log10(initcond(31)),2,1,-5,5);
arSetPars('i0_cr_a3',log10(initcond(32)),2,1,-5,5);
arSetPars('i0_ih_a3',log10(initcond(33)),2,1,-5,5);
arSetPars('i0_ir_a3',log10(initcond(34)),2,1,-5,5);
arSetPars('i0_hu_a3',log10(initcond(35)),2,1,-5,5);
arSetPars('i0_hr_a3',log10(initcond(36)),2,1,-5,5);
arSetPars('i0_ud_a3',log10(initcond(37)),2,1,-5,5);
arSetPars('i0_ur_a3',log10(initcond(38)),2,1,-5,5);
arSetPars('i0_rz_a3',log10(initcond(39)),2,1,-5,5);
arSetPars('i0_dead_a3',log10(initcond(40)),2,1,-5,5);
arSetPars('i0_rx_a3',log10(initcond(41)),2,1,-5,5);
arSetPars('i0_ix_a3',log10(initcond(42)),2,1,-5,5);

arSetPars('i0_sus_a4',log10(initcond(43)),2,1,-5,5);
arSetPars('i0_exp_a4',log10(initcond(44)),2,1,-5,5);
arSetPars('i0_ci_a4',log10(initcond(45)),2,1,-5,5);
arSetPars('i0_cr_a4',log10(initcond(46)),2,1,-5,5);
arSetPars('i0_ih_a4',log10(initcond(47)),2,1,-5,5);
arSetPars('i0_ir_a4',log10(initcond(48)),2,1,-5,5);
arSetPars('i0_hu_a4',log10(initcond(49)),2,1,-5,5);
arSetPars('i0_hr_a4',log10(initcond(50)),2,1,-5,5);
arSetPars('i0_ud_a4',log10(initcond(51)),2,1,-5,5);
arSetPars('i0_ur_a4',log10(initcond(52)),2,1,-5,5);
arSetPars('i0_rz_a4',log10(initcond(53)),2,1,-5,5);
arSetPars('i0_dead_a4',log10(initcond(54)),2,1,-5,5);
arSetPars('i0_rx_a4',log10(initcond(55)),2,1,-5,5);
arSetPars('i0_ix_a4',log10(initcond(56)),2,1,-5,5);

arSetPars('i0_sus_a5',log10(initcond(57)),2,1,-5,5);
arSetPars('i0_exp_a5',log10(initcond(58)),2,1,-5,5);
arSetPars('i0_ci_a5',log10(initcond(59)),2,1,-5,5);
arSetPars('i0_cr_a5',log10(initcond(60)),2,1,-5,5);
arSetPars('i0_ih_a5',log10(initcond(61)),2,1,-5,5);
arSetPars('i0_ir_a5',log10(initcond(62)),2,1,-5,5);
arSetPars('i0_hu_a5',log10(initcond(63)),2,1,-5,5);
arSetPars('i0_hr_a5',log10(initcond(64)),2,1,-5,5);
arSetPars('i0_ud_a5',log10(initcond(65)),2,1,-5,5);
arSetPars('i0_ur_a5',log10(initcond(66)),2,1,-5,5);
arSetPars('i0_rz_a5',log10(initcond(67)),2,1,-5,5);
arSetPars('i0_dead_a5',log10(initcond(68)),2,1,-5,5);
arSetPars('i0_rx_a5',log10(initcond(69)),2,1,-5,5);
arSetPars('i0_ix_a5',log10(initcond(70)),2,1,-5,5);

arSetPars('i0_sus_a6',log10(initcond(71)),2,1,-5,5);
arSetPars('i0_exp_a6',log10(initcond(72)),2,1,-5,5);
arSetPars('i0_ci_a6',log10(initcond(73)),2,1,-5,5);
arSetPars('i0_cr_a6',log10(initcond(74)),2,1,-5,5);
arSetPars('i0_ih_a6',log10(initcond(75)),2,1,-5,5);
arSetPars('i0_ir_a6',log10(initcond(76)),2,1,-5,5);
arSetPars('i0_hu_a6',log10(initcond(77)),2,1,-5,5);
arSetPars('i0_hr_a6',log10(initcond(78)),2,1,-5,5);
arSetPars('i0_ud_a6',log10(initcond(79)),2,1,-5,5);
arSetPars('i0_ur_a6',log10(initcond(80)),2,1,-5,5);
arSetPars('i0_rz_a6',log10(initcond(81)),2,1,-5,5);
arSetPars('i0_dead_a6',log10(initcond(82)),2,1,-5,5);
arSetPars('i0_rx_a6',log10(initcond(83)),2,1,-5,5);
arSetPars('i0_ix_a6',log10(initcond(84)),2,1,-5,5);

arSetPars('i0_sus_a7',log10(initcond(85)),2,1,-5,5);
arSetPars('i0_exp_a7',log10(initcond(86)),2,1,-5,5);
arSetPars('i0_ci_a7',log10(initcond(87)),2,1,-5,5);
arSetPars('i0_cr_a7',log10(initcond(88)),2,1,-5,5);
arSetPars('i0_ih_a7',log10(initcond(89)),2,1,-5,5);
arSetPars('i0_ir_a7',log10(initcond(90)),2,1,-5,5);
arSetPars('i0_hu_a7',log10(initcond(91)),2,1,-5,5);
arSetPars('i0_hr_a7',log10(initcond(92)),2,1,-5,5);
arSetPars('i0_ud_a7',log10(initcond(93)),2,1,-5,5);
arSetPars('i0_ur_a7',log10(initcond(94)),2,1,-5,5);
arSetPars('i0_rz_a7',log10(initcond(95)),2,1,-5,5);
arSetPars('i0_dead_a7',log10(initcond(96)),2,1,-5,5);
arSetPars('i0_rx_a7',log10(initcond(97)),2,1,-5,5);
arSetPars('i0_ix_a7',log10(initcond(98)),2,1,-5,5);

    

    
    arFitLHS(5)
    
    arPlot
    close all
    
    
    time=ar.model.data.tFine;
    
    qua_a1=ar.model.data.yFineSimu(:,1);
    qua_a2=ar.model.data.yFineSimu(:,2);
    qua_a3=ar.model.data.yFineSimu(:,3);
    qua_a4=ar.model.data.yFineSimu(:,4);
    qua=ar.model.data.yFineSimu(:,5);
    hos=ar.model.data.yFineSimu(:,6);
    icu=ar.model.data.yFineSimu(:,7);
    rec=ar.model.data.yFineSimu(:,8);
    ddead_a1=ar.model.data.yFineSimu(:,9);
    ddead_a2=ar.model.data.yFineSimu(:,10);
    ddead_a3=ar.model.data.yFineSimu(:,11);
    ddead_a4=ar.model.data.yFineSimu(:,12);
    ddead=ar.model.data.yFineSimu(:,13);
    
    
    datatoplot=[time,qua_a1,qua_a2,qua_a3,qua_a4,qua,hos,icu,rec,ddead_a1,ddead_a2,ddead_a3,ddead_a4,ddead];
   
    toplot(1:length(datatoplot),se(k):se(k)+13)=datatoplot;

        
    
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

delete Data/cmat_UK_d2d_*.*
delete *mexmaci64




cd '/Users/Arnab/projects/BRICS/COVID-19/COVID-19-italy/contact_matrix/perturbation/UK_fitting'

%     csvwrite(sprintf('area_spec_%s.csv',cityname),toplot)
save(['contact_matrix.mat'],'savr0per','TP')
%

%     folder=pwd;

%     rmdir(strcat(cityname),'s');

