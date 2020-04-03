% -----Rounak Nayee----------1613091-------
%
% Encryption and Decryption of image 
% using RSA cryptosystem in Matlab

clc;
clear all;
close all;

%----P and Q can be Prime Numbers only
p = input('\nEnter the value of p: ');
q = input('\nEnter the value of q: ');
[Pk,Phi,d,e] = intialize(p,q);

%Input Image
in = imread('cameraman.tif');
% converting uint8 to double
%inImg = double(in);
inImg = [1 2 3; 8 8 8; 20 15 10];

se     = size(inImg);
enImg = ones(se);
 
 for u=1:numel(inImg)
     disp(u);
     enImg(u) = crypt(inImg(u),Pk,e);
 end
 
 enout = enImg;
 
 sd = size(enImg);
 deImg = ones(sd);
 
 for u=1:numel(enImg)
     disp(u);
     deImg(u) = crypt(enImg(u),Pk,d);
 end
 
 % converting back double to uint8
 deout = uint8(deImg); 
 
 subplot(1,3,1);
 imshow(in);
 title('Input Image')
 
 subplot(1,3,2);
 imshow(enout);
 title('Encrypted Image')
 
 subplot(1,3,3);
 imshow(deout);
 title('Decrypted Image')
 
 function [Pk,Phi,d,e] = intialize(p,q)
clc;
disp('Intaializing:');
Pk=p*q;
Phi=(p-1)*(q-1);
%Calculate the value of e
x=2;e=1;
while x > 1
    e=e+1;
    x=gcd(Phi,e);
end
%Calculate the value of d
i=1;
r=1;
while r > 0
    k=(Phi*i)+1;
    r=rem(k,e);
    i=i+1;
end
d=k/e;
clc;
disp(['The value of (N) is: ' num2str(Pk)]);
disp(['The public key (e) is: ' num2str(e)]);
disp(['The value of (Phi) is: ' num2str(Phi)]);
disp(['The private key (d)is: ' num2str(d)]);
 end

 function a = dec2bin(d)
i=1;
a=zeros(1,65535);
while d >= 2
    r=rem(d,2);
    if r==1
        a(i)=1;
    else
        a(i)=0;
    end
    i=i+1;
    d=floor(d/2);
end
if d == 2
    a(i) = 0;
else
    a(i) = 1;
end
x=[a(16) a(15) a(14) a(13) a(12) a(11) a(10) a(9) a(8) a(7) a(6) a(5) a(4) a(3) a(2) a(1)];
end

function mc = crypt(M,N,e)
e=dec2bin(e);
k = 65535;
c  = M;

cf = 1;
cf=mod(c*cf,N);
for i=k-1:-1:1
    c = mod(c*c,N);
    j=k-i+1;
     if e(j)==1
         cf=mod(c*cf,N);
     end
end
mc=cf;
end
