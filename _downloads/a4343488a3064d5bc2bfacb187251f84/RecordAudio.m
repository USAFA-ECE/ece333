%% Function for recording audio
% Use this function to record your audio impulse response(s) in F1 and
% audio of you speaking in a normal classroom.  Try to reduce the amount of
% background noise as much as possible before recording.
function [y,Fs] = RecordAudio()
info = audiodevinfo; % Get audio input device information
target = info.input(1); % Based on information in the 'info' structure, pick Field Number in 'info.input' of the device you wish to use. For my laptop, it is 2.
Fs = 44100;        % sample rate
nBits = 16;        % bit depth
nChan = 1;         % mono is typical for voice/IRs
recObj = audiorecorder(Fs, nBits, nChan, target.ID);  % <- explicit device
% recObj = audiorecorder; % create audio object
% Query user for desired recording time
RecordTime = input('Please input how many seconds you would like to record: ');
disp('Start recording.') % Prompt user to start recording
recordblocking(recObj, RecordTime); % record audio
disp('End of Recording.'); % Tell user that recording if finished
%%  Extract relevant values from audio object
y = getaudiodata(recObj); % save audio to vector of size (# sec)(Fs) x 1
Fs = recObj.SampleRate; % save sample rate
disp('Recording will play back after pushing any key.'); % Tell user recording will play back
pause
playerObj = audioplayer(recObj);
play(playerObj);
pause(length(y)/Fs);
