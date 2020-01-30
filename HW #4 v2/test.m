% Test and verification script

%% Initialization

w_bits = 32
f_bits = 16
diff = w_bits - f_bits

%% Read from stim file

fileID = fopen('stim.txt','r');

a = []

for i = 1:100
    
    int = 0
    frac = 0
    
a = fgetl(fileID)
    
    for k = f_bits+1:w_bits
        int = int + a(k)*2^(k-17);
    end
    
    for j = 1:f_bits
        frac = frac + a(j)/(2^(-j+15));
    end
    
    float = int + frac;
    
    a = [a fi(float,0,w_bits,f_bits)];
end
fclose(fileID);

%%