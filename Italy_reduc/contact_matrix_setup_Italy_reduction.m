
% javaaddpath('/home/abp19/poi_library/poi-3.8-20120326.jar');
% javaaddpath('/home/abp19/projects/poi_library/poi-ooxml-3.8-20120326.jar');
% javaaddpath('/home/abp19/projects/poi_library/poi-ooxml-schemas-3.8-20120326.jar');
% javaaddpath('/home/abp19/projects/poi_library/xmlbeans-2.3.0.jar');
% javaaddpath('/home/abp19/Users/Arnab/projects/covid-19/poi_library/dom4j-1.6.1.jar');
% 

clear all
home_dir=pwd;
to_evaluate={'work_75_red','work_90_red','school_75_red','school_90_red','work_school_50_red','work_school_75_red','work_school_90_red'};
% to_evaluate={'work_75_red','work_90_red'};

parfor key=1:length(to_evaluate)
    
    javaaddpath('/home/abp19/poi_library/poi-3.8-20120326.jar');
    javaaddpath('/home/abp19/projects/poi_library/poi-ooxml-3.8-20120326.jar');
    javaaddpath('/home/abp19/projects/poi_library/poi-ooxml-schemas-3.8-20120326.jar');
    javaaddpath('/home/abp19/projects/poi_library/xmlbeans-2.3.0.jar');
    javaaddpath('/home/abp19/Users/Arnab/projects/covid-19/poi_library/dom4j-1.6.1.jar');

%     javaaddpath('/Users/Arnab/projects/poi_library/poi-3.8-20120326.jar');
%     javaaddpath('/Users/Arnab/projects/poi_library/poi-ooxml-3.8-20120326.jar');
%     javaaddpath('/Users/Arnab/projects/poi_library/poi-ooxml-schemas-3.8-20120326.jar');
%     javaaddpath('/Users/Arnab/projects/poi_library/xmlbeans-2.3.0.jar');
%     javaaddpath('/Users/Arnab/projects/poi_library/dom4j-1.6.1.jar');

    
    cd(home_dir)
    subfolder=to_evaluate{key};
    deffile1='contact_matrix_Italy_four_age';
    deffile2='contact_matrix_Italy_four_age_loop';
    
    savpars=load('contact_matrix.mat');
    paramfile=savpars.TP.params;
    paramlabel=savpars.TP.plabel;
    
    cm=csvread(strcat('Data/Reduced_cm/',to_evaluate{key},'.csv'));
    
    ar=reduction_loop(home_dir,subfolder,deffile1,deffile2,cm,paramfile,paramlabel)
end