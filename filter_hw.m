[input, fs] = audioread('audio.wav');

% Define the frequency boundiries of the elements 
coff_kick = 500;
coff_cymbal = 4000;

% Normalize the frequencies
calced_coff_kick = coff_kick / (fs / 2);
calced_coff_cymbal = coff_cymbal / (fs / 2);
calced_coff_piano = [calced_coff_kick calced_coff_cymbal];

% Define orders (more the number is better the filter is)
order_kick = 5000; 
order_cymbal = 180;
order_piano = 5000;
order_second_piano = 100000;

% Define the FIR filters
kick = fir1(order_kick, calced_coff_kick, 'low');
cymbal = fir1(order_cymbal, calced_coff_cymbal, 'high');
piano = fir1(order_piano, calced_coff_piano, 'bandpass');
piano2 = fir1(order_second_piano, calced_coff_kick, 'high');


% Apply the filters to the audio signal
kick_out = filter(kick, 100, input);
cymbal_out = filter(cymbal, 1, input);
piano_out = filter(piano, 1, input);

% Defining a second FIR filter for piano for a better output
piano_out2 = filter(piano2, 1, piano_out);

% Write the output files
%audiowrite('kick.wav', kick_out, fs);
%audiowrite('cymbal.wav', cymbal_out, fs);
%audiowrite('piano.wav', piano_out2, fs);

%fvtool(kick, 100);
%fvtool(cymbal, 1);
%fvtool(piano, 1);
%fvtool(piano2, 1);

t = (0:length(cymbal_out)-1) / fs;
figure;
plot(t, piano_out2);
xlabel('Time (s)');
ylabel('Amplitude');
title('Waveform of the Audio Signal');
