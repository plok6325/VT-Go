function [ version ] = main( image_version, op )
if op==0
    version='1.3.0';
else 
path=['.\images',image_version,'\'];
imagebase=dir(path);
imagebase(1)=[];
imagebase(1)=[];
sca;

%clearvars;

% Here we call some defazult settings for setting up Psychtoolbox
PsychDefaultSetup(2);

% Get the screen numbers
screens = Screen('Screens');

% Draw to the external screen if avaliable
screenNumber = max(screens);

% Define black and white
white = WhiteIndex(screenNumber);
black = BlackIndex(screenNumber);
grey = white / 2;
inc = white - grey;

% Open an on screen window
Screen('Preference', 'SkipSyncTests', 1)
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, white);

% Get the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Query the frame duration
%ifi = Screen('GetFlipInterval', window);
ifi=0.0167;
% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);

% Set up alpha-blending for smooth (anti-aliased) lines
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
result=[];
% Here we load in an image from file. This one is a image of rabbits that
% is included with PTB
for x=1:length(imagebase)
    
    imagename=[];
    randimageindex=1+floor(rand(1)*length(imagebase));
    imagename=imagebase(randimageindex).name;
    imagebase(randimageindex)=[];
    
    theImage=imread([path,imagename]);
    %imagebase.name()
    % Get the size of the image
    [s1, s2, s3] = size(theImage);
    
    % Here we check if the image is too big to fit on the screen and abort if
    % it is. See ImageRescaleDemo to see how to rescale an image.
    if s1 > screenYpixels || s2 > screenYpixels
        disp('ERROR! Image is too big to fit on the screen');
        sca;
        return;
    end
    % i=regexp(imagename,'.jpg')
    % imagename=imagename(1:i)
    % Make the image into a texture
    imageTexture = Screen('MakeTexture', window, theImage);
    
    % Draw the image to the screen, unless otherwise specified PTB will draw
    % the texture full size in the center of the screen. We first draw the
    % image in its correct orientation.
    Screen('DrawTexture', window, imageTexture, [], [], 0);
    
    % Flip to the screen
    
    Screen('TextSize', window, 60);
    DrawFormattedText(window, 'Real',screenXpixels * 0.10,...
    screenYpixels * 0.20, [1 0 0]);

    Screen('TextSize', window, 60);
    DrawFormattedText(window, 'Generated',screenXpixels * 0.70,...
    screenYpixels * 0.20, [1 0 0]);
    Screen('Flip', window);
    
    % Wait for two seconds
    WaitSecs(1);
    [x,y,buttons,focus,valuators,valinfo] = GetMouse();
    this_result.file=imagename;
    this_result.xy=[x,y];
    this_result.limit=[screenXpixels,screenYpixels];
    result=[result,this_result];
    % Now fill the screen balck
    Screen('FillRect', window, [1 1 1]);
    
    % Flip to the screen
    Screen('Flip', window);
    
    % Wait for two seconds
    %WaitSecs(2);
    
end
sca;
time=now;
mkdir('result')
path=['.\result\',num2str(time),'.mat'];
save(path);
upload(path);

version='1';
end

end