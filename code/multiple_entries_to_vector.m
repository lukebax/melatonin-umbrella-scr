function myOutput = multiple_entries_to_vector(x)

x = string(x);
x_new = char;
for i = 1 : length(x)
    str = x(i);
    newStr = split(str,',');
    x_new = char(x_new, char(newStr));
end
x = strtrim(string(x_new));
empty_entries = cellfun('isempty', x);
x(empty_entries) = [];
x(strcmp(x, 'NI')) = [];

myOutput = x;

end