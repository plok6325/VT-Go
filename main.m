clear all;



appeared=0
imagebase=dir('.\images');

sca;
close all;
%clearvars;

% Here we call some default settings for setting up Psychtoolbox
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
[window, windowRect] = PsychImaging('OpenWindow', screenNumber, white);

% Get the size of the on screen window
[screenXpixels, screenYpixels] = Screen('WindowSize', window);

% Query the frame duration
ifi = Screen('GetFlipInterval', window);

% Get the centre coordinate of the window
[xCenter, yCenter] = RectCenter(windowRect);

% Set up alpha-blending for smooth (anti-aliased) lines
Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');

% Here we load in an image from file. This one is a image of rabbits that
% is included with PTB
for x=1:length(imagebase)
[imagename,imagebase]=get_image(imagebase);
theImage=imread(['./images/',imagename]);
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
Screen('Flip', window);

% Wait for two seconds
WaitSecs(5);
[x,y,buttons,focus,valuators,valinfo] = GetMouse()
appeared=appeared+1
result(appeared).file=(imagename)
result(appeared).loc=([x,y])
% Now fill the screen balck
Screen('FillRect', window, [1 1 1]);

% Flip to the screen
Screen('Flip', window);

% Wait for two seconds
%WaitSecs(2);

end

% Clear the screen
sca;