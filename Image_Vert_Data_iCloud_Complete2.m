NumDrops = 20;
%This is a push. We are going to try and revise.
C = cell(1,NumDrops);
for k = 1:NumDrops
    C{k} = k;
end

Fpath=["/Users/graesongriffin/Library/Mobile Documents/com~apple~CloudDocs/Chondrule/Exp2/" 
    "/Users/graesongriffin/Library/Mobile Documents/com~apple~CloudDocs/Chondrule/Exp2Rec/" 
    "/Users/graesongriffin/Library/Mobile Documents/com~apple~CloudDocs/Chondrule/Exp2Rec2/"];

%%
for qq=1:3
runNum=qq
%%
PH=zeros(15,1);

rootdir = Fpath(qq);
filelist3 = dir(fullfile(rootdir, 'Drop*/Figures_and_Images_V4/**/tv_Eval_full*.mat'));  %get list of files and folders in any subfolder
filelist3 = filelist3(~[filelist3.isdir]);  %remove folders from list
numfiles=size(filelist3,1);

filelist2 = dir(fullfile(rootdir, 'Drop*/Figures_and_Images_V10/**/tv_Eval_full*.mat'));  %get list of files and folders in any subfolder
filelist2 = filelist2(~[filelist2.isdir]);  %remove folders from list
numfiles2=size(filelist2,1);

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

kk=0;

for k = 1 :  numfiles2-kk
    thisFileName = filelist2(k-kk); % Get the full or base file name somehow.
    if startsWith(thisFileName.name, '._')
        % Skip this file if it starts with dot underline
    %goof(k,1)=1;
    filelist2(k-kk)=[];
    kk=kk+1;
    continue; % Jump to the bottom of the loop
    end 
end

Fun = {filelist3.name};
str = natsortfiles(string(Fun));
File= {filelist3.folder};
fold= natsortfiles(string(File));

Fun2 = {filelist2.name};
str2 = natsortfiles(string(Fun2));
File2= {filelist2.folder};
fold2= natsortfiles(string(File2));

%% PARAMETERS

for k=1:120

a = num2str(C{k});

Numm=k
dirMainfold=regexprep(join([rootdir, 'Drop'])," ","");
dirMain = [dirMainfold,a];
objectName = ['Comb4and10_Figs_num',a];
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

filetemp=regexprep(join([fold(k), '/', str(k)])," ","");
filetemp2=regexprep(join([fold2(k), '/', str2(k)])," ","");

tv_vid=load(regexprep(filetemp,"Mobile","Mobile "));
tv_vid2=load(regexprep(filetemp2,"Mobile","Mobile "));


tv_vid=tv_vid.tv_full;
tv_vid2=tv_vid2.tv_full;

%%

% Noise Sub W/ Dil Images
se=strel('disk',7);
tv_vid_Dil=logical(imdilate(tv_vid,se));
tv_vid_DilF=uint8(tv_vid_Dil)*255;

tv2=tv_vid2-imcomplement(tv_vid_DilF);



end


if qq<3
%% --------------------------------------------------------------------------
   

for k=1:119
    %-------------------------------------------------------------------------
    
       kkg=k
        if (1<=kkg)&&(kkg<20)
            datadrop = 'Interp7/surf10.5_Data';
            elseif (21<=kkg)&&(kkg<40)
                datadrop = [datastore '/surf11.5_Data'];
            elseif (41<=kkg)&&(kkg<60)
                datadrop = [datastore '/surf12.5_Data'];
            elseif (61<=kkg)&&(kkg<80)
                datadrop = [datastore '/surf13.5_Data'];
            elseif (81<=kkg)&&(kkg<100)
                datadrop = [datastore '/surf14.5_Data'];
            elseif (101<=kkg)&&(kkg<120)
                datadrop = [datastore '/surf15.5_Data'];
            %elseif (79<=k)&&(k<90)
                %datadrop = 'Interp1/surf16.5_Data';
            %elseif (92<=k)&&(k<103)
                %datadrop = 'Interp1/surf17.5_Data';
            
          % elseif ismember(k,[13 26 39 52 65 78 91])
          elseif ismember(kkg,[20 40 60 80 100 120])
                datadrop = [datastore '/surfBetween_Data'];
            
            Irec2 = zeros(2048, 2048);
            %Rescale your matrix in 0-255 range
            Irec2 = rescale(Irec2, 0, 255);
            % Typecasted to uint8 
             Irec2 = uint8(Irec2); 
            % Display your image
    
            % Reset------------------------------------------------------------
            Irec3 = zeros(2048, 2048);
    
             %Rescale your matrix in 0-255 range
            Irec3 = rescale(Irec3, 0, 255);
            % Typecasted to uint8 
            Irec3 = uint8(Irec3); 
            % Display your image
        end
    
    
    FilePlace = regexprep(join([rootdir datadrop '/Total_Move/'])," ","");
    FilePlace2 = regexprep(join([rootdir datadrop '/Move/'])," ","");
    FilePlace3 = regexprep(join([rootdir datadrop '/AddEst/'])," ","");
    
    %--------------------------------------------------------------------------
    
    
        a = num2str(C{k});
    
        objectName = ['surf', a];
        objectName2 = ['surfAdd', a];
        objectName3 = ['DataSub', a];
        objectName4 = ['DataAdd', a];
       
        %imgFormat = '.png';
        os = 'macos';
        %figVisibility = true;
    
        switch lower(os)
        case 'windows'
            slh = '\';
        case 'macos'
            slh = '/';
        end
    
        I2=matfile(regexprep(regexprep(join([File_str(k+1), '/', str(k+1)])," ",""),"Mobile","Mobile "));
        I2=I2.tv_full;
    
      % Rescale your matrix in 0-255 range
        I2 = rescale(I2, 0, 255);
        % Typecasted to uint8 
        I2 = uint8(I2); 
    
        I3=matfile(regexprep(regexprep(join([File_str2(k), '/', str2(k)])," ",""),"Mobile","Mobile "));
        I3=I3.tv_sub_full;
    
         % Rescale your matrix in 0-255 range
        I3 = rescale(I3, 0, 255);
        % Typecasted to uint8 
        I3 = uint8(I3); 
    
        Irec = imsubtract(I2,I3);
    
        Iadd = Irec;
    
        %Irec2 = imadd(Iadd,Irec2);
    
       
    %--------------------------------------------------------------------------
    
        objectName5 = ['surfMove', a];
        objectName6 = ['surfAddMove', a];
        objectName7 = ['DataSubMove', a];
        objectName8 = ['DataAddMove', a];
        objectName9 = ['DataAddEst', a];
       
        I4=matfile(regexprep(regexprep(join([File_str(k), '/', str(k)])," ",""),"Mobile","Mobile "));
        I4=I4.tv_full;
    
        %Rescale your matrix in 0-255 range
        I4 = rescale(I4, 0, 255);
        % Typecasted to uint8 
        I4 = uint8(I4); 
    
    
        I5=matfile(regexprep(regexprep(join([File_str2(k+1), '/', str2(k+1)])," ",""),"Mobile","Mobile "));
        I5=I5.tv_sub_full;
    
        %Rescale your matrix in 0-255 range
        I5 = rescale(I5, 0, 255);
        % Typecasted to uint8 
        I5 = uint8(I5); 
        Irec4 = imsubtract(I4,I5);
    
        Iadd2 = Irec4;
    
        Irec3 = imadd(Iadd2,Irec3);
    
         
    
    %--------------------------------------------------------------------------
    % Identify individual blobs by seeing which pixels are connected to each other.  This is called "Connected Components Labeling".
    % Each group of connected pixels will be given a label, a number, to identify it and distinguish it from the other blobs.
    % Do connected components labeling with either bwlabel() or bwconncomp().
    [labeledImage, ~ ] = bwlabel(Irec, 8);     % Label each blob so we can make measurements of it
    % labeledImage is an integer-valued image where all pixels in the blobs have values of 1, or 2, or 3, or ... etc.
    % MAIN PART IS RIGHT HERE!!!
    % Get all the blob properties.
    props = regionprops(labeledImage, Irec, 'all');
    % Or, if you want, you can ask for only a few specific measurements.  This will be faster since we don't have to compute everything.
    % props = regionprops(labeledImage, originalImage, 'MeanIntensity', 'Area', 'Perimeter', 'Centroid', 'EquivDiameter');
    numberOfBlobs1 = numel(props); % Will be the same as we got earlier from bwlabel().
    % PLOT BOUNDARIES.
    % Plot the borders of all the coins on the original grayscale image using the coordinates returned by bwboundaries().
    % bwboundaries() returns a cell array, where each cell contains the row/column coordinates for an object in the image.
    %subplot(3, 3, 6);
    boundaries = bwboundaries(Irec); % Note: this is a cell array with several boundaries -- one boundary per cell.
    % boundaries is a cell array - one cell for each blob.
    % In each cell is an N-by-2 list of coordinates in a (row, column) format.  Note: NOT (x,y).
    % Column 1 is rows, or y.    Column 2 is columns, or x.
    numberOfBoundaries = size(boundaries, 1); % Count the boundaries so we can use it in our for loop
    % Here is where we actually plot the boundaries of each blob in the overlay.
     % Don't let boundaries blow away the displayed image.
        for i = 1 : numberOfBoundaries
	        thisBoundary = boundaries{i}; % Get boundary for this specific blob.
	        x = thisBoundary(:,2); % Column 2 is the columns, which is x.
	        y = thisBoundary(:,1); % Column 1 is the rows, which is x.
        end
    % Extract all the mean diameters into an array.
    % The "diameter" is the "Equivalent Circular Diameter", which is the diameter of a circle with the same number of pixels as the blob.
    % Enclosing in brackets is a nice trick to concatenate all the values from all the structure fields (every structure in the props structure array).
    blobECD1 = [props.EquivDiameter];
    % Loop over all blobs printing their measurements to the command window.
    
    if numberOfBlobs1 == 0
        D = zeros(1,1);
       
        else
            D = zeros(1,numberOfBlobs1);
            for j = 1 : numberOfBlobs1           % Loop through all blobs.
	        % Find the individual measurements of each blob.  They are field of each structure in the props strucutre array.
	        % You could use the bracket trick (like with blobECD above) OR you can get the value from the field of this particular structure.
	        % I'm showing you both ways and you can use the way you like best.
	             meanGL = props(j).MeanIntensity;		% Get average intensity.
	            blobArea = props(j).Area;				% Get area.
	            blobPerimeter = props(j).Perimeter;		% Get perimeter.
	            blobCentroid = props(j).Centroid;       % Get centroid one at a time
    
                D(j)=props(j).Area;
    
            end
                D(1)=[];
                Mean1 = mean(D);
                MeanECD1 = mean(blobECD1);
                Mode1 = mode(D);
    end
    
    %--------------------------------------------------------------------------
    % Identify individual blobs by seeing which pixels are connected to each other.  This is called "Connected Components Labeling".
    % Each group of connected pixels will be given a label, a number, to identify it and distinguish it from the other blobs.
    % Do connected components labeling with either bwlabel() or bwconncomp().
    [labeledImage, ~ ] = bwlabel(Irec4, 8);     % Label each blob so we can make measurements of it
    % labeledImage is an integer-valued image where all pixels in the blobs have values of 1, or 2, or 3, or ... etc.
    % MAIN PART IS RIGHT HERE!!!
    % Get all the blob properties.
    props = regionprops(labeledImage, Irec4, 'all');
    % Or, if you want, you can ask for only a few specific measurements.  This will be faster since we don't have to compute everything.
    % props = regionprops(labeledImage, originalImage, 'MeanIntensity', 'Area', 'Perimeter', 'Centroid', 'EquivDiameter');
    numberOfBlobs2 = numel(props); % Will be the same as we got earlier from bwlabel().
    % PLOT BOUNDARIES.
    % Plot the borders of all the coins on the original grayscale image using the coordinates returned by bwboundaries().
    % bwboundaries() returns a cell array, where each cell contains the row/column coordinates for an object in the image.
    %subplot(3, 3, 6);
    boundaries = bwboundaries(Irec4); % Note: this is a cell array with several boundaries -- one boundary per cell.
    % boundaries is a cell array - one cell for each blob.
    % In each cell is an N-by-2 list of coordinates in a (row, column) format.  Note: NOT (x,y).
    % Column 1 is rows, or y.    Column 2 is columns, or x.
    numberOfBoundaries = size(boundaries, 1); % Count the boundaries so we can use it in our for loop
    % Here is where we actually plot the boundaries of each blob in the overlay.
     % Don't let boundaries blow away the displayed image.
        for i = 1 : numberOfBoundaries
	        thisBoundary = boundaries{i}; % Get boundary for this specific blob.
	        x = thisBoundary(:,2); % Column 2 is the columns, which is x.
	        y = thisBoundary(:,1); % Column 1 is the rows, which is x.
        end
    % Extract all the mean diameters into an array.
    % The "diameter" is the "Equivalent Circular Diameter", which is the diameter of a circle with the same number of pixels as the blob.
    % Enclosing in brackets is a nice trick to concatenate all the values from all the structure fields (every structure in the props structure array).
    blobECD2 = [props.EquivDiameter];
    % Loop over all blobs printing their measurements to the command window.
    
    if numberOfBlobs2 == 0
        E = zeros(1,1);
       
        else
            E = zeros(1,numberOfBlobs2);
            for l = 1 : numberOfBlobs2           % Loop through all blobs.
	        % Find the individual measurements of each blob.  They are field of each structure in the props strucutre array.
	        % You could use the bracket trick (like with blobECD above) OR you can get the value from the field of this particular structure.
	        % I'm showing you both ways and you can use the way you like best.
	             meanGL = props(l).MeanIntensity;		% Get average intensity.
	            blobArea = props(l).Area;				% Get area.
	            blobPerimeter = props(l).Perimeter;		% Get perimeter.
	            blobCentroid = props(l).Centroid;       % Get centroid one at a time
    
                E(l)=props(l).Area;
    
            end
                E(1)=[];
                Mean2 = mean(E);
                MeanECD2 = mean(blobECD2);
                Mode2 = mode(E);
    end
    
    %--------------------------------------------------------------------------
    % Identify individual blobs by seeing which pixels are connected to each other.  This is called "Connected Components Labeling".
    % Each group of connected pixels will be given a label, a number, to identify it and distinguish it from the other blobs.
    % Do connected components labeling with either bwlabel() or bwconncomp().
    [labeledImage, ~ ] = bwlabel(I2, 8);     % Label each blob so we can make measurements of it
    % labeledImage is an integer-valued image where all pixels in the blobs have values of 1, or 2, or 3, or ... etc.
    % MAIN PART IS RIGHT HERE!!!
    % Get all the blob properties.
    props = regionprops(labeledImage, I2, 'all');
    % Or, if you want, you can ask for only a few specific measurements.  This will be faster since we don't have to compute everything.
    % props = regionprops(labeledImage, originalImage, 'MeanIntensity', 'Area', 'Perimeter', 'Centroid', 'EquivDiameter');
    numberOfBlobs3 = numel(props); % Will be the same as we got earlier from bwlabel().
    % PLOT BOUNDARIES.
    % Plot the borders of all the coins on the original grayscale image using the coordinates returned by bwboundaries().
    % bwboundaries() returns a cell array, where each cell contains the row/column coordinates for an object in the image.
    %subplot(3, 3, 6);
    boundaries = bwboundaries(I2); % Note: this is a cell array with several boundaries -- one boundary per cell.
    % boundaries is a cell array - one cell for each blob.
    % In each cell is an N-by-2 list of coordinates in a (row, column) format.  Note: NOT (x,y).
    % Column 1 is rows, or y.    Column 2 is columns, or x.
    numberOfBoundaries = size(boundaries, 1); % Count the boundaries so we can use it in our for loop
    % Here is where we actually plot the boundaries of each blob in the overlay.
     % Don't let boundaries blow away the displayed image.
        for i = 1 : numberOfBoundaries
	        thisBoundary = boundaries{i}; % Get boundary for this specific blob.
	        x = thisBoundary(:,2); % Column 2 is the columns, which is x.
	        y = thisBoundary(:,1); % Column 1 is the rows, which is x.
        end
    % Extract all the mean diameters into an array.
    % The "diameter" is the "Equivalent Circular Diameter", which is the diameter of a circle with the same number of pixels as the blob.
    % Enclosing in brackets is a nice trick to concatenate all the values from all the structure fields (every structure in the props structure array).
    blobECD3 = [props.EquivDiameter];
    % Loop over all blobs printing their measurements to the command window.
    
    if numberOfBlobs3 == 0
        F2 = zeros(1,1);
       
        else
            F2 = zeros(1,numberOfBlobs3);
            for j = 1 : numberOfBlobs3           % Loop through all blobs.
	        % Find the individual measurements of each blob.  They are field of each structure in the props strucutre array.
	        % You could use the bracket trick (like with blobECD above) OR you can get the value from the field of this particular structure.
	        % I'm showing you both ways and you can use the way you like best.
	             meanGL = props(j).MeanIntensity;		% Get average intensity.
	            blobArea = props(j).Area;				% Get area.
	            blobPerimeter = props(j).Perimeter;		% Get perimeter.
	            blobCentroid = props(j).Centroid;       % Get centroid one at a time
    
                F2(j)=props(j).Area;
    
            end
                F2(k)=[];
                Mean3 = mean(F2);
                MeanECD3 = mean(blobECD3);
                Mode3 = mode(F2);
    end
    %--------------------------------------------------------------------------
    
    if ismember(kkg,[20 40 60 80 100 120])
                k3=kkg
        elseif (1<=kkg)&&(kkg<=120)
    
    
    PH(kkg,1) = kkg;
    PH(kkg,2) = 0;%a
    PH(kkg,3) = 0;%b
    PH(kkg,4) = 0;%c
    PH(kkg,5) = 0;%d
    PH(kkg,6) = 0;%e
    PH(kkg,7) = 0;%f
    PH(kkg,8) = 0;%g
    PH(kkg,9) = 0;%h
    PH(kkg,10) = 0;%i
    PH(kkg,11) = Mode1;%j
    PH(kkg,12) = Mode2;%k
    PH(kkg,13) = Mode3;%l
    PH(kkg,14) = numberOfBlobs1;%m
    PH(kkg,15) = Mean1;%n
    PH(kkg,16) = MeanECD1;%o
    PH(kkg,17) = numberOfBlobs2;%p
    PH(kkg,18) = Mean2;%q
    PH(kkg,19) = MeanECD2;%r
    PH(kkg,20) = PH(kkg,5)- PH(kkg,6);%s
    PH(kkg,21) = PH(kkg,5)/PH(kkg,6);%t
    PH(kkg,22) = PH(kkg,11)- PH(kkg,12);%u
    PH(kkg,23) = PH(kkg,11)/PH(kkg,12);%v
    PH(kkg,24) = 0;%w
    PH(kkg,25) = 0;%x
    PH(kkg,26) = Mean3;%y
    PH(kkg,27) = MeanECD3;%z
    PH(kkg,28) = numberOfBlobs3;%bb
    
    end
    
    
        close all
       
     if ismember(kkg,[20 40 60 80 100 120])
            
            Irec2 = zeros(2048, 2048);
            %Rescale your matrix in 0-255 range
            Irec2 = rescale(Irec2, 0, 255);
            % Typecasted to uint8 
             Irec2 = uint8(Irec2); 
            % Display your image
    
            % Reset------------------------------------------------------------
            Irec3 = zeros(2048, 2048);
    
             %Rescale your matrix in 0-255 range
            Irec3 = rescale(Irec3, 0, 255);
            % Typecasted to uint8 
            Irec3 = uint8(Irec3); 
            % Display your image
      end
    
        
end
    
    
    PH(isinf(PH)|isnan(PH)) = 0;
    
    savefilest=regexprep(regexprep(join([rootdir datastore '/PH2_0Errod_flit.mat'])," ",""),"Mobile", "Mobile ");
    %savefile = sprintf([rootdir 'Interp4/PH2_0Errod_flit155.mat']);
    
    save(savefilest, 'PH');

else

    for k=1:119
    %-------------------------------------------------------------------------
    
       kkg=k
        if (1<=kkg)&&(kkg<=20)
            datadrop = 'Interp7/surf15.5_Data';
            elseif (21<=kkg)&&(kkg<=40)
                datadrop = [datastore '/surf14.5_Data'];
            elseif (41<=kkg)&&(kkg<=60)
                datadrop = [datastore '/surf13.5_Data'];
            elseif (61<=kkg)&&(kkg<=80)
                datadrop = [datastore '/surf12.5_Data'];
            elseif (81<=kkg)&&(kkg<=100)
                datadrop = [datastore '/surf11.5_Data'];
            elseif (101<=kkg)&&(kkg<=120)
                datadrop = [datastore '/surf10.5_Data'];
            %elseif (79<=k)&&(k<90)
                %datadrop = 'Interp1/surf16.5_Data';
            %elseif (92<=k)&&(k<103)
                %datadrop = 'Interp1/surf17.5_Data';
            
          % % elseif ismember(k,[13 26 39 52 65 78 91])
          % elseif ismember(kkg,[20 40 60 80 100 120])
          %       datadrop = [datastore '/surfBetween_Data'];
          % 
            Irec2 = zeros(2048, 2048);
            %Rescale your matrix in 0-255 range
            Irec2 = rescale(Irec2, 0, 255);
            % Typecasted to uint8 
             Irec2 = uint8(Irec2); 
            % Display your image
    
            % Reset------------------------------------------------------------
            Irec3 = zeros(2048, 2048);
    
             %Rescale your matrix in 0-255 range
            Irec3 = rescale(Irec3, 0, 255);
            % Typecasted to uint8 
            Irec3 = uint8(Irec3); 
            % Display your image
        end
    
    
    FilePlace = regexprep(join([rootdir datadrop '/Total_Move/'])," ","");
    FilePlace2 = regexprep(join([rootdir datadrop '/Move/'])," ","");
    FilePlace3 = regexprep(join([rootdir datadrop '/AddEst/'])," ","");
    
    %--------------------------------------------------------------------------
    
    
        a = num2str(C{k});
    
        objectName = ['surf', a];
        objectName2 = ['surfAdd', a];
        objectName3 = ['DataSub', a];
        objectName4 = ['DataAdd', a];
       
        %imgFormat = '.png';
        os = 'macos';
        %figVisibility = true;
    
        switch lower(os)
        case 'windows'
            slh = '\';
        case 'macos'
            slh = '/';
        end
    
        I2=matfile(regexprep(regexprep(join([File_str(k+1), '/', str(k+1)])," ",""),"Mobile","Mobile "));
        I2=I2.tv_full;
    
      % Rescale your matrix in 0-255 range
        I2 = rescale(I2, 0, 255);
        % Typecasted to uint8 
        I2 = uint8(I2); 
    
        I3=matfile(regexprep(regexprep(join([File_str2(k), '/', str2(k)])," ",""),"Mobile","Mobile "));
        I3=I3.tv_sub_full;
    
         % Rescale your matrix in 0-255 range
        I3 = rescale(I3, 0, 255);
        % Typecasted to uint8 
        I3 = uint8(I3); 
    
        Irec = imsubtract(I2,I3);
    
        Iadd = Irec;
    
        Irec2 = imadd(Iadd,Irec2);
    
       
    %--------------------------------------------------------------------------
    
        objectName5 = ['surfMove', a];
        objectName6 = ['surfAddMove', a];
        objectName7 = ['DataSubMove', a];
        objectName8 = ['DataAddMove', a];
        objectName9 = ['DataAddEst', a];
       
        I4=matfile(regexprep(regexprep(join([File_str(k), '/', str(k)])," ",""),"Mobile","Mobile "));
        I4=I4.tv_full;
    
        %Rescale your matrix in 0-255 range
        I4 = rescale(I4, 0, 255);
        % Typecasted to uint8 
        I4 = uint8(I4); 
    
    
        I5=matfile(regexprep(regexprep(join([File_str2(k+1), '/', str2(k+1)])," ",""),"Mobile","Mobile "));
        I5=I5.tv_sub_full;
    
        %Rescale your matrix in 0-255 range
        I5 = rescale(I5, 0, 255);
        % Typecasted to uint8 
        I5 = uint8(I5); 
        Irec4 = imsubtract(I4,I5);
    
        Iadd2 = Irec4;
    
        Irec3 = imadd(Iadd2,Irec3);
    
         
    
    %--------------------------------------------------------------------------
    % Identify individual blobs by seeing which pixels are connected to each other.  This is called "Connected Components Labeling".
    % Each group of connected pixels will be given a label, a number, to identify it and distinguish it from the other blobs.
    % Do connected components labeling with either bwlabel() or bwconncomp().
    [labeledImage, ~ ] = bwlabel(Irec, 8);     % Label each blob so we can make measurements of it
    % labeledImage is an integer-valued image where all pixels in the blobs have values of 1, or 2, or 3, or ... etc.
    % MAIN PART IS RIGHT HERE!!!
    % Get all the blob properties.
    props = regionprops(labeledImage, Irec, 'all');
    % Or, if you want, you can ask for only a few specific measurements.  This will be faster since we don't have to compute everything.
    % props = regionprops(labeledImage, originalImage, 'MeanIntensity', 'Area', 'Perimeter', 'Centroid', 'EquivDiameter');
    numberOfBlobs1 = numel(props); % Will be the same as we got earlier from bwlabel().
    % PLOT BOUNDARIES.
    % Plot the borders of all the coins on the original grayscale image using the coordinates returned by bwboundaries().
    % bwboundaries() returns a cell array, where each cell contains the row/column coordinates for an object in the image.
    %subplot(3, 3, 6);
    boundaries = bwboundaries(Irec); % Note: this is a cell array with several boundaries -- one boundary per cell.
    % boundaries is a cell array - one cell for each blob.
    % In each cell is an N-by-2 list of coordinates in a (row, column) format.  Note: NOT (x,y).
    % Column 1 is rows, or y.    Column 2 is columns, or x.
    numberOfBoundaries = size(boundaries, 1); % Count the boundaries so we can use it in our for loop
    % Here is where we actually plot the boundaries of each blob in the overlay.
     % Don't let boundaries blow away the displayed image.
        for i = 1 : numberOfBoundaries
	        thisBoundary = boundaries{i}; % Get boundary for this specific blob.
	        x = thisBoundary(:,2); % Column 2 is the columns, which is x.
	        y = thisBoundary(:,1); % Column 1 is the rows, which is x.
        end
    % Extract all the mean diameters into an array.
    % The "diameter" is the "Equivalent Circular Diameter", which is the diameter of a circle with the same number of pixels as the blob.
    % Enclosing in brackets is a nice trick to concatenate all the values from all the structure fields (every structure in the props structure array).
    blobECD1 = [props.EquivDiameter];
    % Loop over all blobs printing their measurements to the command window.
    
    if numberOfBlobs1 == 0
        D = zeros(1,1);
       
        else
            D = zeros(1,numberOfBlobs1);
            for j = 1 : numberOfBlobs1           % Loop through all blobs.
	        % Find the individual measurements of each blob.  They are field of each structure in the props strucutre array.
	        % You could use the bracket trick (like with blobECD above) OR you can get the value from the field of this particular structure.
	        % I'm showing you both ways and you can use the way you like best.
	             meanGL = props(j).MeanIntensity;		% Get average intensity.
	            blobArea = props(j).Area;				% Get area.
	            blobPerimeter = props(j).Perimeter;		% Get perimeter.
	            blobCentroid = props(j).Centroid;       % Get centroid one at a time
    
                D(j)=props(j).Area;
    
            end
                D(1)=[];
                Mean1 = mean(D);
                MeanECD1 = mean(blobECD1);
                Mode1=mode(D);
    end
    
    %--------------------------------------------------------------------------
    % Identify individual blobs by seeing which pixels are connected to each other.  This is called "Connected Components Labeling".
    % Each group of connected pixels will be given a label, a number, to identify it and distinguish it from the other blobs.
    % Do connected components labeling with either bwlabel() or bwconncomp().
    [labeledImage, ~ ] = bwlabel(Irec4, 8);     % Label each blob so we can make measurements of it
    % labeledImage is an integer-valued image where all pixels in the blobs have values of 1, or 2, or 3, or ... etc.
    % MAIN PART IS RIGHT HERE!!!
    % Get all the blob properties.
    props = regionprops(labeledImage, Irec4, 'all');
    % Or, if you want, you can ask for only a few specific measurements.  This will be faster since we don't have to compute everything.
    % props = regionprops(labeledImage, originalImage, 'MeanIntensity', 'Area', 'Perimeter', 'Centroid', 'EquivDiameter');
    numberOfBlobs2 = numel(props); % Will be the same as we got earlier from bwlabel().
    % PLOT BOUNDARIES.
    % Plot the borders of all the coins on the original grayscale image using the coordinates returned by bwboundaries().
    % bwboundaries() returns a cell array, where each cell contains the row/column coordinates for an object in the image.
    %subplot(3, 3, 6);
    boundaries = bwboundaries(Irec4); % Note: this is a cell array with several boundaries -- one boundary per cell.
    % boundaries is a cell array - one cell for each blob.
    % In each cell is an N-by-2 list of coordinates in a (row, column) format.  Note: NOT (x,y).
    % Column 1 is rows, or y.    Column 2 is columns, or x.
    numberOfBoundaries = size(boundaries, 1); % Count the boundaries so we can use it in our for loop
    % Here is where we actually plot the boundaries of each blob in the overlay.
     % Don't let boundaries blow away the displayed image.
        for i = 1 : numberOfBoundaries
	        thisBoundary = boundaries{i}; % Get boundary for this specific blob.
	        x = thisBoundary(:,2); % Column 2 is the columns, which is x.
	        y = thisBoundary(:,1); % Column 1 is the rows, which is x.
        end
    % Extract all the mean diameters into an array.
    % The "diameter" is the "Equivalent Circular Diameter", which is the diameter of a circle with the same number of pixels as the blob.
    % Enclosing in brackets is a nice trick to concatenate all the values from all the structure fields (every structure in the props structure array).
    blobECD2 = [props.EquivDiameter];
    % Loop over all blobs printing their measurements to the command window.
    
    if numberOfBlobs2 == 0
        E = zeros(1,1);
       
        else
            E = zeros(1,numberOfBlobs2);
            for l = 1 : numberOfBlobs2           % Loop through all blobs.
	        % Find the individual measurements of each blob.  They are field of each structure in the props strucutre array.
	        % You could use the bracket trick (like with blobECD above) OR you can get the value from the field of this particular structure.
	        % I'm showing you both ways and you can use the way you like best.
	             meanGL = props(l).MeanIntensity;		% Get average intensity.
	            blobArea = props(l).Area;				% Get area.
	            blobPerimeter = props(l).Perimeter;		% Get perimeter.
	            blobCentroid = props(l).Centroid;       % Get centroid one at a time
    
                E(l)=props(l).Area;
    
            end
                E(1)=[];
                Mean2 = mean(E);
                MeanECD2 = mean(blobECD2);
                Mode2 = mode(E);
    end
    
    %--------------------------------------------------------------------------
    % Identify individual blobs by seeing which pixels are connected to each other.  This is called "Connected Components Labeling".
    % Each group of connected pixels will be given a label, a number, to identify it and distinguish it from the other blobs.
    % Do connected components labeling with either bwlabel() or bwconncomp().
    [labeledImage, ~ ] = bwlabel(I2, 8);     % Label each blob so we can make measurements of it
    % labeledImage is an integer-valued image where all pixels in the blobs have values of 1, or 2, or 3, or ... etc.
    % MAIN PART IS RIGHT HERE!!!
    % Get all the blob properties.
    props = regionprops(labeledImage, I2, 'all');
    % Or, if you want, you can ask for only a few specific measurements.  This will be faster since we don't have to compute everything.
    % props = regionprops(labeledImage, originalImage, 'MeanIntensity', 'Area', 'Perimeter', 'Centroid', 'EquivDiameter');
    numberOfBlobs3 = numel(props); % Will be the same as we got earlier from bwlabel().
    % PLOT BOUNDARIES.
    % Plot the borders of all the coins on the original grayscale image using the coordinates returned by bwboundaries().
    % bwboundaries() returns a cell array, where each cell contains the row/column coordinates for an object in the image.
    %subplot(3, 3, 6);
    boundaries = bwboundaries(I2); % Note: this is a cell array with several boundaries -- one boundary per cell.
    % boundaries is a cell array - one cell for each blob.
    % In each cell is an N-by-2 list of coordinates in a (row, column) format.  Note: NOT (x,y).
    % Column 1 is rows, or y.    Column 2 is columns, or x.
    numberOfBoundaries = size(boundaries, 1); % Count the boundaries so we can use it in our for loop
    % Here is where we actually plot the boundaries of each blob in the overlay.
     % Don't let boundaries blow away the displayed image.
        for i = 1 : numberOfBoundaries
	        thisBoundary = boundaries{i}; % Get boundary for this specific blob.
	        x = thisBoundary(:,2); % Column 2 is the columns, which is x.
	        y = thisBoundary(:,1); % Column 1 is the rows, which is x.
        end
    % Extract all the mean diameters into an array.
    % The "diameter" is the "Equivalent Circular Diameter", which is the diameter of a circle with the same number of pixels as the blob.
    % Enclosing in brackets is a nice trick to concatenate all the values from all the structure fields (every structure in the props structure array).
    blobECD3 = [props.EquivDiameter];
    % Loop over all blobs printing their measurements to the command window.
    
    if numberOfBlobs3 == 0
        F2 = zeros(1,1);
       
        else
            F2 = zeros(1,numberOfBlobs3);
            for j = 1 : numberOfBlobs3           % Loop through all blobs.
	        % Find the individual measurements of each blob.  They are field of each structure in the props strucutre array.
	        % You could use the bracket trick (like with blobECD above) OR you can get the value from the field of this particular structure.
	        % I'm showing you both ways and you can use the way you like best.
	             meanGL = props(j).MeanIntensity;		% Get average intensity.
	            blobArea = props(j).Area;				% Get area.
	            blobPerimeter = props(j).Perimeter;		% Get perimeter.
	            blobCentroid = props(j).Centroid;       % Get centroid one at a time
    
                F2(j)=props(j).Area;
    
            end
                F2(k)=[];
                Mean3 = mean(F2);
                MeanECD3 = mean(blobECD3);
                Mode3 = mode(F2);
    end
    %--------------------------------------------------------------------------
    
    if ismember(kkg,[20 40 60 80 100 120])
                k3=kkg
        elseif (1<=kkg)&&(kkg<=120)
    
    
    PH(kkg,1) = kkg;
    PH(kkg,2) = 0;%a
    PH(kkg,3) = 0;%b
    PH(kkg,4) = 0;%c
    PH(kkg,5) = 0;%d
    PH(kkg,6) = 0;%e
    PH(kkg,7) = 0;%f
    PH(kkg,8) = 0;%g
    PH(kkg,9) = 0;%h
    PH(kkg,10) = 0;%i
    PH(kkg,11) = Mode1;%j
    PH(kkg,12) = Mode2;%k
    PH(kkg,13) = Mode3;%l
    PH(kkg,14) = numberOfBlobs1;%m
    PH(kkg,15) = Mean1;%n
    PH(kkg,16) = MeanECD1;%o
    PH(kkg,17) = numberOfBlobs2;%p
    PH(kkg,18) = Mean2;%q
    PH(kkg,19) = MeanECD2;%r
    PH(kkg,20) = PH(kkg,5)- PH(kkg,6);%s
    PH(kkg,21) = PH(kkg,5)/PH(kkg,6);%t
    PH(kkg,22) = PH(kkg,11)- PH(kkg,12);%u
    PH(kkg,23) = PH(kkg,11)/PH(kkg,12);%v
    PH(kkg,24) = 0;%w
    PH(kkg,25) = 0;%x
    PH(kkg,26) = Mean3;%y
    PH(kkg,27) = MeanECD3;%z
    PH(kkg,28) = numberOfBlobs3;%bb
    
    end
    
    
        close all
       
     if ismember(kkg,[20 40 60 80 100 120])
            
            Irec2 = zeros(2048, 2048);
            %Rescale your matrix in 0-255 range
            Irec2 = rescale(Irec2, 0, 255);
            % Typecasted to uint8 
             Irec2 = uint8(Irec2); 
            % Display your image
    
            % Reset------------------------------------------------------------
            Irec3 = zeros(2048, 2048);
    
             %Rescale your matrix in 0-255 range
            Irec3 = rescale(Irec3, 0, 255);
            % Typecasted to uint8 
            Irec3 = uint8(Irec3); 
            % Display your image
      end
    
        
    end
    
    
    PH(isinf(PH)|isnan(PH)) = 0;
    
    savefilest=regexprep(regexprep(join([rootdir datastore '/PH2_0Errod_flitRec2.mat'])," ",""),"Mobile", "Mobile ");
    %savefile = sprintf([rootdir 'Interp4/PH2_0Errod_flit155.mat']);
    
    save(savefilest, 'PH');

end

end

