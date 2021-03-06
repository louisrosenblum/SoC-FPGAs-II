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
    
line_a = fgetl(fileID)
    
    for k = f_bits+1:w_bits
        int = int + line_a(k)*2^(k-17);
    end
    
    for j = 1:f_bits
        frac = frac + line_a(j)/(2^(-j+15));
    end
    
    float = int + frac;
    
    a = [a fi(float,0,w_bits,f_bits)];
end
fclose(fileID);

%% Perform Newton's block on STIM

c = []

for i = 1:100
    d = (3-a(i))/2;
    e = fi(d,0,w_bits,f_bits);
    c = [c e]
end

%% Read from ModelSIM output file

fileID = fopen('output.txt','r');

b = []

for i = 1:100
    
    int = 0
    frac = 0
    
line_b = fgetl(fileID)
    
    for k = f_bits+1:w_bits
        int = int + line_b(k-1)*2^(k-18);
    end
    
    for j = 1:f_bits
        frac = frac + line_b(j)/(2^(-j+15));
    end
    
    float = int + frac;
    
    b = [b fi(float,0,w_bits,f_bits)];
end
fclose(fileID);

%% Verification

result = []

for i = 1:100
    p = (c(i) - b(i));
    k = fi(p,0,w_bits,f_bits);
    result = [result k]
end

