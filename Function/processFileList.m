function [sortedNames, sortedFolders] = processFileList(rootdir, textPattern)
    % processFileList - Process file paths and filter based on criteria
    % 
    % Syntax: [sortedNames, sortedFolders] = processFileList(rootdir, textPattern)
    %
    % Inputs:
    %    rootdir - Root directory containing the files
    %    textPattern - Text pattern to filter the files
    %
    % Outputs:
    %    sortedNames - Sorted list of file names
    %    sortedFolders - Sorted list of folder paths for the files
    %
    % Requirements:
    %    The function `natsortfiles` must be in the MATLAB path.
    % Get list of files in the root directory and its subdirectories
    filelist = dir(fullfile(rootdir, '**', ['*', textPattern, '*.avi']));  
    filelist = filelist(~[filelist.isdir]);  % Remove folders from the list
    
    numfiles = size(filelist, 1);
    kk = 0;  % Counter to adjust indexing when removing elements
    
    for k = 1:numfiles - kk
        thisFileName = filelist(k - kk); % Current file being processed
        
        if startsWith(thisFileName.name, '._') || startsWith(thisFileName.name, 'BCO')
            % Skip files starting with '._' or 'BCO'
            filelist(k - kk) = [];
            kk = kk + 1;
            continue;
        end
    end
    
    % Extract file names and sort them naturally
    Fun = {filelist.name};
    sortedNames = natsortfiles(string(Fun));
    
    % Extract folder paths and sort them naturally
    File = {filelist.folder};
    sortedFolders = natsortfiles(string(File));
end
