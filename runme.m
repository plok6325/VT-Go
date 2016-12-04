%% run me
clear all
close all
current_run_me_version='1.0.0';
page=urlread('https://github.com/plok6325/VT-Go');
image_V=regexp(page,'imgpatch\d\.\d\.\d\.7z');
run_me_version=page(regexp(page,'runme_version')+16:regexp(page,'runme_version')+20);
if strcmp(current_run_me_version,run_me_version)
else
    display('updating')
    websave('runme.m','https://github.com/plok6325/VT-Go/raw/master/runme.m');
end
main_version=page(regexp(page,'script_version')+17:regexp(page,'script_version')+21);
image_version=page(image_V(1)+8:image_V(1)+12);

[currentmainversion ,currentimageversion]=version_check;

if strcmp(currentimageversion,image_version) && strcmp(main_version,currentmainversion)
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
    ifi = Screen('GetFlipInterval', window);
    %ifi=0.0167;
    % Get the centre coordinate of the window
    [xCenter, yCenter] = RectCenter(windowRect);
    % Set up alpha-blending for smooth (anti-aliased) lines
    Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
    Screen('TextSize', window, 100);
    thearrow=imread('.\content\arrow.png');
    imageTexture = Screen('MakeTexture', window, thearrow);
    Screen('DrawTexture', window, imageTexture, [], [], 0);
    
    Screen('Flip', window);
    [clicks,x,y,whichButton] = GetClicks()
    
    if x>(screenXpixels*0.5)
        
        thearrow=imread('.\content\timepick.png');
        imageTexture = Screen('MakeTexture', window, thearrow);
        Screen('DrawTexture', window, imageTexture, [], [], 0);
        Screen('Flip', window);
        
        [clicks,x,y,whichButton] = GetClicks();
        x=x/xCenter/2;
        y=y/yCenter/2;
        
        if x <0.3 && y <0.55
            pt=50;
        elseif x <0.4 && y >0.55
            pt=100;
        elseif (0.65>x) && (x>0.3) && y <0.55
            pt=500
        elseif x >0.5 && y >0.55
            pt = 1000
        elseif x>0.5 && y<0.55
            pt = 2000
        end
        main(image_version,1,'s',screenNumber,window, windowRect,pt);
    else
        main(image_version,1,'e',screenNumber,window, windowRect,0);
    end
    
    
else
    rmdir(['images',currentimageversion],'s')
    display('new version found, updating ')
    zipname=['imgpatch',image_version,'.zip'];
    websave(zipname,['https://github.com/plok6325/VT-Go/raw/master/',zipname]);
    unzip(zipname,['.\images',image_version]);
    websave('main.m','https://github.com/plok6325/VT-Go/raw/master/main.m');
    display('done run script again');
end