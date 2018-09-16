

clc;clear all;close all;

addpath(genpath('C:\Users\jay\Desktop\Speech Techn\Reconstruction'));
addpath(genpath('C:\Users\jay\Desktop\Speech Techn\MSR Identity Toolkit v1.0\code'));
addpath(genpath('C:\Users\jay\Desktop\Speech Techn\GMM'));
pathToDatabase = fullfile('C:\Users\jay\Desktop\Speech Techn\DS_10283_3035\ASVspoof2017_V2_dev\ASVspoof2017_V2_dev');


fileID = fopen('C:\Users\jay\Desktop\Speech Techn\DS_10283_3035\ASVspoof2017_V2_dev\ASVspoof2017_V2_dev\ASVspoof2017_V2_dev.trl.txt');
protocol = textscan(fileID, '%s%s%s%s%s%s%s');
fclose(fileID);

% get file and label lists
filelist=protocol{1};
labels=protocol{2};
speaker=protocol{3};
phrase=protocol{4};
% get indices of genuine and spoof files
genuineIdx = find(strcmp (labels,'genuine'));
spoofIdx = find(strcmp (labels,'spoof'));

%% Feature extraction for training data

disp('Extracting features from training data...');
% frameg=zeros(40,282);
% framer=zeros(40,282);

fratio=zeros(40,1);
genuineFeature = [];
genuineFeatureCell = cell(size(genuineIdx));
spoofFeature = [];
for i=1:length(genuineIdx)%(1:1))%(1500:length(genuineIdx)))
    filePathg = fullfile(pathToDatabase,filelist{genuineIdx(i)});
    %filePathr = fullfile(pathToDatabase,filelist{spoofIdx(i)});
    %display(speaker(i));
    display(i);
    %if(strcmp(phrase(i),'S01'))
    [xg,fsg]=audioread(filePathg);
    %[xr,fsr]=audioread(filePathr);
    [X,ag,b]=melfcc(xg,fsg);
    %[ar,b]=melfcc(xr,fsr);
     genuineFeature=[genuineFeature ag];
     %spoofFeature=[spoofFeature ar];
%      ug=mean(ag')';
%      ur=mean(ar')';
%      for j=1:size(ag,1)
%          sg=0;
%          sr=0;
%          for k=1:(size(ag,2))
%              sg = sg + (ag(j,k)-ug(j))*(ag(j,k)-ug(j));
%          end;
%          for k=1:(size(ar,2))
%              sr = sr + (ar(j,k)-ur(j))*(ar(j,k)-ur(j));
%          end;
%          sg =sg /size(ag,2);
%          sr =sr /size(ar,2);
%          fratio(j)=fratio(j)+((ug(j)-ur(j))*(ug(j)-ur(j)))/(sg+sr);
%      end
   % end
%    if(find(isnan(X)))
%        disp('no');
%    else
%     genuineFeatureCell{i}=X;
%    end
end
spoofFeatureCell = cell(size(spoofIdx));

for i=1:length(spoofIdx)%(1:100))%(1500:length(genuineIdx)))
    filePathr = fullfile(pathToDatabase,filelist{spoofIdx(i)});
    %display(speaker(i));
    display(i);
    %if(strcmp(phrase(i),'S01'))
    [xr,fsr]=audioread(filePathr);
    [X,ar,b]=melfcc(xr,fsr);
     spoofFeature=[spoofFeature ar];
%      ug=mean(ag')';
%      ur=mean(ar')';
%      for j=1:size(ag,1)
%          sg=0;
%          sr=0;
%          for k=1:(size(ag,2))
%              sg = sg + (ag(j,k)-ug(j))*(ag(j,k)-ug(j));
%          end;
%          for k=1:(size(ar,2))
%              sr = sr + (ar(j,k)-ur(j))*(ar(j,k)-ur(j));
%          end;
%          sg =sg /size(ag,2);
%          sr =sr /size(ar,2);
%          fratio(j)=fratio(j)+((ug(j)-ur(j))*(ug(j)-ur(j)))/(sg+sr);
%      end
   % end
%    spoofFeatureCell{i}=X;
end


display('Done');
ug=mean(genuineFeature')';
ur=mean(spoofFeature')';
display('Done');
save('C:\Users\jay\Desktop\Speech Techn\genmeanod.mat','ug');
save('C:\Users\jay\Desktop\Speech Techn\spomeanod.mat','ur');
% fratio = fratio / 1507;
% 
% 
% figure(1);
% plot(fratio);

% index=cellfun(@isnan,genuineFeatureCell,'uni',false);
% index1=cellfun(@isinf,genuineFeatureCell,'uni',false);
% 
% 
% nworkers=2;
% nmix = 256;
% final_niter = 10;
% ds_factor = 1;
% ubm = gmm_em(genuineFeatureCell, nmix, final_niter, ds_factor, nworkers);


% disp('Training GMM for GENUINE...');
% [genuineGMM.m, genuineGMM.s, genuineGMM.w] = vl_gmm([genuineFeatureCell{:}], 128, 'verbose', 'MaxNumIterations',100);
% disp('Done!');
% 
% disp('Training GMM for SPOOF...');
% [spoofGMM.m, spoofGMM.s, spoofGMM.w] = vl_gmm([spoofFeatureCell{:}],128, 'verbose', 'MaxNumIterations',100);
% disp('Done!');
% 
% save('C:\Users\jay\Desktop\Speech Techn\genuineGMMl.mat','genuineGMM');
% save('C:\Users\jay\Desktop\Speech Techn\spoofGMMl.mat','spoofGMM');
