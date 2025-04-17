NumDrops = 120;

C = cell(1,NumDrops);
for k = 1:NumDrops
    C{k} = k;
end

datastore='Interp10';
Fig_Ims='Figures_and_Images_V11';

Fpath=["/Users/graesongriffin/Library/Mobile Documents/com~apple~CloudDocs/Chondrule/Exp2/" 
    "/Users/graesongriffin/Library/Mobile Documents/com~apple~CloudDocs/Chondrule/Exp2Rec/" 
    "/Users/graesongriffin/Library/Mobile Documents/com~apple~CloudDocs/Chondrule/Exp2Rec2/"];

%%
for qq=1:3
runNum=qq
%%
PH=zeros(15,1);

rootdir = Fpath(qq);
filelist3 = dir(fullfile(rootdir, 'Drop*/*_Top_V*.avi'));  %get list of files and folders in any subfolder
filelist3 = filelist3(~[filelist3.isdir]);  %remove folders from list
numfiles=size(filelist3,1);

kk=0;

for k = 1 :  numfiles-kk
    thisFileName = filelist3(k-kk); % Get the full or base file name somehow.
    if startsWith(thisFileName.name, '._')
        % Skip this file if it starts with dot underline
    %goof(k,1)=1;
    filelist3(k-kk)=[];
    kk=kk+1;
    continue; % Jump to the bottom of the loop
    end 
end

Fun = {filelist3.name};
str = natsortfiles(string(Fun));
File= {filelist3.folder};
fold= natsortfiles(string(File));

%% PARAMETERS

for k=1:120

a = num2str(C{k});

Numm=k
dirMainfold=regexprep(join([rootdir, 'Drop'])," ","");
dirMain = [dirMainfold,a];
objectName = ['Figs_num_V',a];
imgFormat = '.png';
os = 'macos';
figVisibility = true;

switch lower(os)
    case 'windows'
        slh = '\';
    case 'macos'
        slh = '/';
end


% CREATE DIRECTORIES TO STORE FIGURES AND VIDEOS
dirFigs1 = regexprep(join([dirMain slh Fig_Ims])," ","");
dirFigs=regexprep(dirFigs1,"Mobile","Mobile ");
mkdir(dirFigs,objectName)

%% READ VIDEOS 


% Top View ---------------------------------------------------------------%
subimfold = regexprep(join([rootdir 'SubIm2.jpg'])," ","");
subim=imread(regexprep(subimfold,"Mobile","Mobile "));

%subimfold
%subim=imread('/Volumes/GraesonEXP2/Chondrule/Exp2Rec2/SubIm2.jpg');
%subim=im2uint8(mat2gray(imbinarize(subim,0.05)));
subim=im2uint8(mat2gray(subim));

filetemp=regexprep(join([fold(k), '/', str(k)])," ","");

tv_vid2=extract_frames2(regexprep(filetemp,"Mobile","Mobile "));

%tv_vid2 = extract_frames2(regexprep(join([dirMain, '/', str(k)])," ",""));
f1_tv=max(tv_vid2.NumFrames);
%tv_vid=tv_vid.Frames/155;
tv_vid=tv_vid2.Frames;
tv_vid1=tv_vid/160;
tv_vid2=tv_vid/150;

tv_data1 = imsAdd(tv_vid1(:,:,1:f1_tv),'plain');
tv_data2 = imsAdd(tv_vid2(:,:,1:f1_tv),'plain');

tv_full_Or=logical(tv_data1)-logical(subim);
tv_full_Or1=max(tv_full_Or,0);

tv_full_Or=logical(tv_data2)-logical(subim);
tv_full_Or2=max(tv_full_Or,0);

%%

% Noise Sub W/ Dil Images
se=strel('disk',0);
tv_full1=logical(imerode(tv_full_Or1,se));
tv_full1=uint8(tv_full1)*255;

% Noise Sub W/ Dil Images
se=strel('disk',0);
tv_full2=logical(imdilate(tv_full_Or2,se));
tv_full2=uint8(tv_full2)*255;

se=strel("disk",3);
tv_sub=logical(imdilate(tv_full_Or1,se));
tv_sub=uint8(tv_sub)*255;

tv2=tv_full2-tv_sub;
tv_full=tv2+tv_full1;

se=strel("disk",2);
tv_sub_full=logical(imdilate(tv_full,se));
tv_sub_full=uint8(tv_sub_full)*255;


% ESTIMATION OF THE DEPTH-------------------------------------------------%
% Estimation of the depth in frames from TV


% figure ('Name','tv_Eval_full')
% imshow(tv_full)
% 
% figure ('Name','tv_Evalsub_full')
% imshow(tv_sub_full)


%% SAVE FIGURES
save1=regexprep(join([dirFigs slh objectName slh sprintf(['tv_Eval_full_' objectName '.mat'])])," ","");
save(regexprep(save1,"Mobile","Mobile "),'tv_full')

save2=regexprep(join([dirFigs slh objectName slh sprintf(['tv_Evalsub_full_' objectName '.mat'])])," ","");
save(regexprep(save2,"Mobile","Mobile "),'tv_sub_full')


% figs = findall(groot,'Type','figure');
% for i = 1:numel(figs)
%     name = sprintf([objectName '_%03d'...
%                     lower(replace(figs(i).Name,' ','_')) imgFormat],i);
%     save3=regexprep(join([dirFigs slh objectName slh sprintf(name)])," ","");
% 
%     imwrite(getframe(figs(i)).cdata,regexprep(save3,"Mobile","Mobile "))
% end
% 
% 
% close all

end

