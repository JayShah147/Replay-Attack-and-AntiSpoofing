clc;clear all;close all;

addpath(genpath('C:\Users\jay\Desktop\Speech Techn\Reconstruction'));

% pathToDatabase = fullfile('C:\Users\jay\Desktop\Speech Techn\DS_10283_3035\ASVspoof2017_V2_train\ASVspoof2017_V2_train');
% 
% 
% fileID = fopen('C:\Users\jay\Desktop\Speech Techn\DS_10283_3035\ASVspoof2017_V2_train\ASVspoof2017_V2_train\ASVspoof2017_V2_train.trn.txt');

pathToDatabase = fullfile('C:\Users\jay\Desktop\Speech Techn\DS_10283_3035\ASVspoof2017_V2_dev\ASVspoof2017_V2_dev');


fileID = fopen('C:\Users\jay\Desktop\Speech Techn\DS_10283_3035\ASVspoof2017_V2_dev\ASVspoof2017_V2_dev\ASVspoof2017_V2_dev.trl.txt');


protocol = textscan(fileID, '%s%s%s%s%s%s%s');
fclose(fileID);

% get file and label lists
filelist=protocol{1};
labels=protocol{2};
speaker=protocol{3};
phrase=protocol{4};
env=protocol{5};
pdevice=protocol{6};
rdevice=protocol{7};
% get indices of genuine and spoof files
genuineIdx = find(strcmp (labels,'genuine'));
spoofIdx = find(strcmp (labels,'spoof'));

%% Feature extraction for training data

disp('Extracting features from training data...');
% frameg=zeros(40,282);
% framer=zeros(40,282);

fratiod=zeros(40,1);

meang=load('genmeanod');
meanr=load('spomeanod');

ug=meang.ug;
ur=meanr.ur;

sg=zeros(40,1);
sr=zeros(40,1);

nfg=0;
nfr=0;

for i=1:length(genuineIdx)%(1:100))%(1500:length(genuineIdx)))
    
    %display(speaker(i));
    display(i);
    %if(strcmp(speaker(i),'M0011'));
   % if(strcmp(pdevice(i+1507),'P01') && strcmp(rdevice(i+1507),'R01'))
        
    filePathg = fullfile(pathToDatabase,filelist{genuineIdx(i)});
    %filePathr = fullfile(pathToDatabase,filelist{spoofIdx(i)});    
        
    [xg,fsg]=audioread(filePathg);
    %[xr,fsr]=audioread(filePathr);
    
    [X,ag,b]=melfcc(xg,fsg);
    %[ar,b]=melfcc(xr,fsr);

     for j=1:size(ag,1)
         for k=1:(size(ag,2))
             sg(j) = sg(j) +(ag(j,k)-ug(j))*(ag(j,k)-ug(j));
         end;
     end
     nfg=nfg + size(ag,2);
%      for j=1:size(ar,1)
%         for k=1:(size(ar,2))
%              sr(j) = sr(j) +(ag(j,k)-ug(j))*(ag(j,k)-ug(j));
%          end;
%      end
%      nfr=nfr + size(ar,2);
    %end
end

for i=1:length(spoofIdx)%(1:100))%(1500:length(genuineIdx)))
    
    %display(speaker(i));
    display(i);
    %if(strcmp(speaker(i),'M0011'));
   % if(strcmp(pdevice(i+1507),'P01') && strcmp(rdevice(i+1507),'R01'))
        
    
    filePathr = fullfile(pathToDatabase,filelist{spoofIdx(i)});    
        
    [xr,fsr]=audioread(filePathr);
    
    [X,ar,b]=melfcc(xr,fsr);
     for j=1:size(ar,1)
        for k=1:(size(ar,2))
             sr(j) = sr(j) +(ar(j,k)-ur(j))*(ar(j,k)-ur(j));
         end;
     end
     nfr=nfr + size(ar,2);
    %end
end


display('Done');
tsg=sg/nfg;
tsr=sr/nfr;
for j=1:40
    fratiod(j)=((ug(j)-ur(j))*(ug(j)-ur(j)))/(tsg(j)+tsr(j));
end
%x=linspace(0,40,40);

pathToDatabase = fullfile('C:\Users\jay\Desktop\Speech Techn\DS_10283_3035\ASVspoof2017_V2_train\ASVspoof2017_V2_train');


fileID = fopen('C:\Users\jay\Desktop\Speech Techn\DS_10283_3035\ASVspoof2017_V2_train\ASVspoof2017_V2_train\ASVspoof2017_V2_train.trn.txt');

protocol = textscan(fileID, '%s%s%s%s%s%s%s');
fclose(fileID);

% get file and label lists
filelist=protocol{1};
labels=protocol{2};
speaker=protocol{3};
phrase=protocol{4};
env=protocol{5};
pdevice=protocol{6};
rdevice=protocol{7};
% get indices of genuine and spoof files
genuineIdx = find(strcmp (labels,'genuine'));
spoofIdx = find(strcmp (labels,'spoof'));

%% Feature extraction for training data

disp('Extracting features from training data...');
% frameg=zeros(40,282);
% framer=zeros(40,282);

fratiot=zeros(40,1);

meang=load('genmeanot');
meanr=load('spomeanot');

ug=meang.ug;
ur=meanr.ur;

sg=zeros(40,1);
sr=zeros(40,1);

nfg=0;
nfr=0;

for i=1:length(genuineIdx)%(1:100))%(1500:length(genuineIdx)))
    
    %display(speaker(i));
    display(i);
    %if(strcmp(speaker(i),'M0002'))
   % if(strcmp(pdevice(i+1507),'P01') && strcmp(rdevice(i+1507),'R01'))
        
    filePathg = fullfile(pathToDatabase,filelist{genuineIdx(i)});
    %filePathr = fullfile(pathToDatabase,filelist{spoofIdx(i)});    
        
    [xg,fsg]=audioread(filePathg);
    %[xr,fsr]=audioread(filePathr);
    
    [X,ag,b]=melfcc(xg,fsg);
    %[ar,b]=melfcc(xr,fsr);

     for j=1:size(ag,1)
         for k=1:(size(ag,2))
             sg(j) = sg(j) +(ag(j,k)-ug(j))*(ag(j,k)-ug(j));
         end;
     end
     nfg=nfg + size(ag,2);
%      for j=1:size(ar,1)
%         for k=1:(size(ar,2))
%              sr(j) = sr(j) +(ag(j,k)-ug(j))*(ag(j,k)-ug(j));
%          end;
%      end
%      nfr=nfr + size(ar,2);
    %end
end

for i=1:length(spoofIdx)%(1:100))%(1500:length(genuineIdx)))
    
    %display(speaker(i));
    display(i);
    %if(strcmp(rdevice(i+760),'R06'))
   % if(strcmp(pdevice(i+1507),'P01') && strcmp(rdevice(i+1507),'R01'))
        
    
    filePathr = fullfile(pathToDatabase,filelist{spoofIdx(i)});    
        
    [xr,fsr]=audioread(filePathr);
    
    [X,ar,b]=melfcc(xr,fsr);
     for j=1:size(ar,1)
        for k=1:(size(ar,2))
             sr(j) = sr(j) +(ar(j,k)-ur(j))*(ar(j,k)-ur(j));
         end;
     end
     nfr=nfr + size(ar,2);
    %end
end


display('Done');
tsg=sg/nfg;
tsr=sr/nfr;
for j=1:40
    fratiot(j)=((ug(j)-ur(j))*(ug(j)-ur(j)))/(tsg(j)+tsr(j));
end

% fratioa=zeros(40,1);
% 
% %sg=zeros(40,1);
% sr=zeros(40,1);
% 
% %nfg=0;
% nfr=0;
% % 
% % for i=1:length(genuineIdx)%(1:100))%(1500:length(genuineIdx)))
% %     
% %     %display(speaker(i));
% %     display(i);
% %     if(strcmp(speaker(i),'M0004'));
% %    % if(strcmp(pdevice(i+1507),'P01') && strcmp(rdevice(i+1507),'R01'))
% %         
% %     filePathg = fullfile(pathToDatabase,filelist{genuineIdx(i)});
% %     %filePathr = fullfile(pathToDatabase,filelist{spoofIdx(i)});    
% %         
% %     [xg,fsg]=audioread(filePathg);
% %     %[xr,fsr]=audioread(filePathr);
% %     
% %     [X,ag,b]=melfcc(xg,fsg);
% %     %[ar,b]=melfcc(xr,fsr);
% % 
% %      for j=1:size(ag,1)
% %          for k=1:(size(ag,2))
% %              sg(j) = sg(j) +(ag(j,k)-ug(j))*(ag(j,k)-ug(j));
% %          end;
% %      end
% %      nfg=nfg + size(ag,2);
% % %      for j=1:size(ar,1)
% % %         for k=1:(size(ar,2))
% % %              sr(j) = sr(j) +(ag(j,k)-ug(j))*(ag(j,k)-ug(j));
% % %          end;
% % %      end
% % %      nfr=nfr + size(ar,2);
% %     end
% % end
% 
% for i=1:length(spoofIdx)%(1:100))%(1500:length(genuineIdx)))
%     
%     %display(speaker(i));
%     display(i);
%     if(strcmp(rdevice(i+760),'R07'))
%    % if(strcmp(pdevice(i+1507),'P01') && strcmp(rdevice(i+1507),'R01'))
%         
%     
%     filePathr = fullfile(pathToDatabase,filelist{spoofIdx(i)});    
%         
%     [xr,fsr]=audioread(filePathr);
%     
%     [X,ar,b]=melfcc(xr,fsr);
%      for j=1:size(ar,1)
%         for k=1:(size(ar,2))
%              sr(j) = sr(j) +(ar(j,k)-ur(j))*(ar(j,k)-ur(j));
%          end;
%      end
%      nfr=nfr + size(ar,2);
%     end
% end
% 
% 
% display('Done');
% %tsg=sg/nfg;
% tsr=sr/nfr;
% for j=1:40
%     fratioa(j)=((ug(j)-ur(j))*(ug(j)-ur(j)))/(tsg(j)+tsr(j));
% end
% 
% 
% fratiob=zeros(40,1);
% 
% %sg=zeros(40,1);
% sr=zeros(40,1);
% 
% %nfg=0;
% nfr=0;
% % 
% % for i=1:length(genuineIdx)%(1:100))%(1500:length(genuineIdx)))
% %     
% %     %display(speaker(i));
% %     display(i);
% %     if(strcmp(speaker(i),'M0005'));
% %    % if(strcmp(pdevice(i+1507),'P01') && strcmp(rdevice(i+1507),'R01'))
% %         
% %     filePathg = fullfile(pathToDatabase,filelist{genuineIdx(i)});
% %     %filePathr = fullfile(pathToDatabase,filelist{spoofIdx(i)});    
% %         
% %     [xg,fsg]=audioread(filePathg);
% %     %[xr,fsr]=audioread(filePathr);
% %     
% %     [X,ag,b]=melfcc(xg,fsg);
% %     %[ar,b]=melfcc(xr,fsr);
% % 
% %      for j=1:size(ag,1)
% %          for k=1:(size(ag,2))
% %              sg(j) = sg(j) +(ag(j,k)-ug(j))*(ag(j,k)-ug(j));
% %          end;
% %      end
% %      nfg=nfg + size(ag,2);
% % %      for j=1:size(ar,1)
% % %         for k=1:(size(ar,2))
% % %              sr(j) = sr(j) +(ag(j,k)-ug(j))*(ag(j,k)-ug(j));
% % %          end;
% % %      end
% % %      nfr=nfr + size(ar,2);
% %     end
% % end
% 
% for i=1:length(spoofIdx)%(1:100))%(1500:length(genuineIdx)))
%     
%     %display(speaker(i));
%     display(i);
%     if(strcmp(rdevice(i+760),'R03'))
%    % if(strcmp(pdevice(i+1507),'P01') && strcmp(rdevice(i+1507),'R01'))
%         
%     
%     filePathr = fullfile(pathToDatabase,filelist{spoofIdx(i)});    
%         
%     [xr,fsr]=audioread(filePathr);
%     
%     [X,ar,b]=melfcc(xr,fsr);
%      for j=1:size(ar,1)
%         for k=1:(size(ar,2))
%              sr(j) = sr(j) +(ar(j,k)-ur(j))*(ar(j,k)-ur(j));
%          end;
%      end
%      nfr=nfr + size(ar,2);
%     end
% end
% 
% 
% display('Done');
% %tsg=sg/nfg;
% tsr=sr/nfr;
% for j=1:40
%     fratiob(j)=((ug(j)-ur(j))*(ug(j)-ur(j)))/(tsg(j)+tsr(j));
% end
% 
% fratioc=zeros(40,1);
% 
% %sg=zeros(40,1);
% sr=zeros(40,1);
% 
% %nfg=0;
% nfr=0;
% 
% % for i=1:length(genuineIdx)%(1:100))%(1500:length(genuineIdx)))
% %     
% %     %display(speaker(i));
% %     display(i);
% %     if(strcmp(speaker(i),'M0010'));
% %    % if(strcmp(pdevice(i+1507),'P01') && strcmp(rdevice(i+1507),'R01'))
% %         
% %     filePathg = fullfile(pathToDatabase,filelist{genuineIdx(i)});
% %     %filePathr = fullfile(pathToDatabase,filelist{spoofIdx(i)});    
% %         
% %     [xg,fsg]=audioread(filePathg);
% %     %[xr,fsr]=audioread(filePathr);
% %     
% %     [X,ag,b]=melfcc(xg,fsg);
% %     %[ar,b]=melfcc(xr,fsr);
% % 
% %      for j=1:size(ag,1)
% %          for k=1:(size(ag,2))
% %              sg(j) = sg(j) +(ag(j,k)-ug(j))*(ag(j,k)-ug(j));
% %          end;
% %      end
% %      nfg=nfg + size(ag,2);
% % %      for j=1:size(ar,1)
% % %         for k=1:(size(ar,2))
% % %              sr(j) = sr(j) +(ag(j,k)-ug(j))*(ag(j,k)-ug(j));
% % %          end;
% % %      end
% % %      nfr=nfr + size(ar,2);
% %     end
% % end
% 
% for i=1:length(spoofIdx)%(1:100))%(1500:length(genuineIdx)))
%     
%     %display(speaker(i));
%     display(i);
%     if(strcmp(rdevice(i+760),'R01'))
%    % if(strcmp(pdevice(i+1507),'P01') && strcmp(rdevice(i+1507),'R01'))
%         
%     
%     filePathr = fullfile(pathToDatabase,filelist{spoofIdx(i)});    
%         
%     [xr,fsr]=audioread(filePathr);
%     
%     [X,ar,b]=melfcc(xr,fsr);
%      for j=1:size(ar,1)
%         for k=1:(size(ar,2))
%              sr(j) = sr(j) +(ar(j,k)-ur(j))*(ar(j,k)-ur(j));
%          end;
%      end
%      nfr=nfr + size(ar,2);
%     end
% end
% 
% 
% display('Done');
% tsg=sg/nfg;
% tsr=sr/nfr;
% for j=1:40
%     fratioc(j)=((ug(j)-ur(j))*(ug(j)-ur(j)))/(tsg(j)+tsr(j));
% end
% 


x=linspace(0,40,40);
figure(1);

plot(x,fratiod);
hold on;
plot(x,fratiot);
hold on;
legend('Training','Development');
title('F-ratio comparision on training and development sets on Outer Freq. Filter Bank.');