% Function to display and edit a string of text
function editText()

    % Prompt the user to enter a string of text
    inputString = input('Enter the text: ', 's');

    % Display the entered text
    disp('Original Text:');
    disp(inputString);

    % Display options for editing the text
    disp('Choose an option to edit the text:');
    disp('1. Replace a substring');
    disp('2. Append text');
    disp('3. Convert to uppercase');
    disp('4. Convert to lowercase');
    disp('5. Exit');

    % Loop to allow multiple edits
    while true
        option = input('Enter your choice: ');

        switch option
            case 1
                % Replace a substring
                oldSubstring = input('Enter the substring to replace: ', 's');
                newSubstring = input('Enter the new substring: ', 's');
                inputString = strrep(inputString, oldSubstring, newSubstring);
                disp('Updated Text:');
                disp(inputString);

            case 2
                % Append text
                appendString = input('Enter the text to append: ', 's');
                inputString = [inputString appendString];
                disp('Updated Text:');
                disp(inputString);

            case 3
                % Convert to uppercase
                inputString = upper(inputString);
                disp('Updated Text:');
                disp(inputString);

            case 4
                % Convert to lowercase
                inputString = lower(inputString);
                disp('Updated Text:');
                disp(inputString);

            case 5
                % Exit the loop
                disp('Exiting...');
                break;

            otherwise
                disp('Invalid option. Please choose again.');
        end
    end

end
