% -----Rounak Nayee----------1613091-------
%
% Encryption and Decryption of image 
% using RSA cryptosystem in Matlab
clc;
clear all;
close all;

%----P and Q can be Prime Numbers only
p = input('Enter the value of p: ');
q = input('Enter the value of q: ');

[n,Phi,d,e] = intialize(p,q);
% public key <- (e,n)
% private key <- d

%Input Image
input = double(imread('cameraman.tif'));

% optional input of array
% "this" translates to [19 7 8 18]
% a = 00 ... to ... z = 25
% input = [19 7 8 18]

inputsize = size(input);
cipher = ones(inputsize);

%Function to Encrypt
for u=1:numel(input)
    cipher(u) = exponentmod(input(u),e,n);
end

output = ones(inputsize);

%Function to Decrypt
for u=1:numel(cipher)
    output(u) = exponentmod(cipher(u),d,n);
end

%Display 3 Images
%plain encrypted and decrypted
subplot(1,3,1);
imshow(uint8(input));
title('Input Image')
 
subplot(1,3,2);
imshow(uint8(cipher));
title('Encrypted Image')
 
subplot(1,3,3);
imshow(uint8(output));
title('Decrypted Image')
 
function [n,Phi,d,e] = intialize(p,q)
%calculate n
n=p*q;

%calculate Phi
Phi=eulerPhi(p*q);

%Calculate the value of e
x=2;e=1;
while x > 1
    e=e+1;
    x=gcd(Phi,e);
end

%Calculate the value of d
d=exponentmod(e,eulerPhi(Phi)-1,Phi);

disp(['The value of (N) is:    ' num2str(n)]);
disp(['The public key (e) is:  ' num2str(e)]);
disp(['The value of Phi(N) is: ' num2str(Phi)]);
disp(['The private key (d)is:  ' num2str(d)]);
end

function a=exponentmod(b,e,m)
% This fucntion calculates 
% [ b^e (mod m)]
if m==1
    a=0;
    return
end
i=1;
a=1;
while i<=e
    a = mod(a*b,m);
    i = i+1;
end
end
