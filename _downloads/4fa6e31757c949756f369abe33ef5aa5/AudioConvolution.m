%% Capture yourself talking in a regular room
[talking, Fs1] = RecordAudio(); % record normal talking
t = (1:length(talking))/Fs1; 
subplot(3,1,1)
plot(t, talking) % plot talking
xlabel('t (second)')
ylabel('Relative signal strength')
title('Talking')

%% Capture an impulse response from F1 or similarly large room with different acoustics
% Make sure your impulse response is as close to approximating a Dirac
% delta as you can get (i.e., very short, loud, and clean - like slamming a book on
% a table)
[impulseResponse, Fs2] = RecordAudio(); % import the impulse response
t1 = (1:length(impulseResponse))/Fs2; 
subplot(3, 1, 2) 
plot(t1, impulseResponse) % plot the impulse response
xlabel('t1 (second)')
ylabel('Relative signal strength')
title('Impulse Response')

%% Convolve the normal talking with your impulse response
% The convolved output should sound like you are talking in an auditorium
% instead of in a regular room. 
convolvedOutput = conv(talking,impulseResponse);
t2 = (1:length(convolvedOutput)); 
soundsc(convolvedOutput, Fs2);
subplot(3,1,3);
plot(t2,convolvedOutput); % plot the convolved output-note the length
xlabel('t2 (second)')
ylabel('Relative signal strength')
title('Convolved Signal')