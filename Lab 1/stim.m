% Generate Stimulus File

%% Initialize fixed-point toolbox settings

%% Define Generics

w_bits = 32;
f_bits = 16;

diff = w_bits - f_bits;

%% Generate stimulus file

fileID = fopen('stim.txt','w');

% Define acceptable operators in advance.
operators = {'0', '1'};


for i = 1:100
    
indexes = randi(length(operators), 1, w_bits)
s = cell2mat(operators(indexes));

fprintf(fileID,"%s\r\n",s);
    
end
fclose(fileID);