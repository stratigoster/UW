[f freq Nbits] = wavread('train_bird.wav');

% plot original signal
subplot(221), plot(f), title('Original noisy signal'), xlabel('time');

% plot power spectrum for noisy signal
F=fft(f);
subplot(223), plot(abs(F)), title('Power spectrum for noisy signal');

% create denoised signal
G=F;
G(3000:10000)=0;

% plot power spectrum for denoised signal
subplot(224), plot(abs(G)), title('Power spectrum for denoised signal');

% plot denoised signal
g=real(ifft(G));
subplot(222), plot(g), title('Denoised signal'), xlabel('time');
