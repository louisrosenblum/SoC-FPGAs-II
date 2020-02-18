% Generate Stimulus File

%% Initialize fixed-point toolbox settings

%% Define Generics

w_bits = 32;
f_bits = 16;

diff = w_bits - f_bits;

%% Generate stimulus file

fileID = fopen('stim.txt','w');

for i = 1:100
    rand_int = randi((2^diff)- 1);
    rand_frac = randi((2^f_bits)-1)/(2^f_bits);
    
    float = rand_int + rand_frac;
    
    fp = fi(float,0,w_bits,f_bits)
    
    fprintf(fileID,"%x\r\n",fp);
    
end
fclose(fileID);