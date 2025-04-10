% Function to import text from a markdown file
function importMarkdown()

    % Prompt the user to enter the filename (with extension)
    filename = input('Enter the markdown filename (including .md extension): ', 's');

    % Check if the file exists
    if isfile(filename)
        % Read the entire content of the markdown file into a string
        fileContent = fileread(filename);
        % Display the imported text
        disp('Content of the markdown file:');
        disp(fileContent);
    else
        % Display an error message if the file doesn't exist
        disp('File not found. Please check the filename and try again.');
    end

end
