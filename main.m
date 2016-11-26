function [ version ] = main( image_version, op,soe,screenNumber, window, windowRect)
if op==0
    version='1.3.0';
elseif   soe=='s'
    KbName('UnifyKeyNames')
    escapeKey = KbName('ESCAPE');
    leftKey = KbName('LeftArrow');
    rightKey = KbName('RightArrow');
    downKey = KbName('DownArrow');
    upKey = KbName('UpArrow');
    path=['.\images',image_version,'\'];
    imagebase=dir(path);
    imagebase(1)=[];
    imagebase(1)=[];
    %sca;
    
    %clearvars;
    
    % Here we call some defazult settings for setting up Psychtoolbox
    %PsychDefaultSetup(2);
    
    % Get the screen numbers
    %screens = Screen('Screens');
    
    % Draw to the external screen if avaliable
    %screenNumber = max(screens);
    
    % Define black and white
    white = WhiteIndex(screenNumber);
    black = BlackIndex(screenNumber);
    grey = white / 2;
    inc = white - grey;
    result=[];
    % Open an on screen window
    %Screen('Preference', 'SkipSyncTests', 1)
    %[window, windowRect] = PsychImaging('OpenWindow', screenNumber, white);
    
    % Get the size of the on screen window
    [screenXpixels, screenYpixels] = Screen('WindowSize', window);
    display('keyboard');
    % Query the frame duration
    %ifi = Screen('GetFlipInterval', window);
    ifi=0.0167;
    % Get the centre coordinate of the window
    [xCenter, yCenter] = RectCenter(windowRect);
    display('keyboard2');
    % Set up alpha-blending for smooth (anti-aliased) lines
    %Screen('BlendFunction', window, 'GL_SRC_ALPHA', 'GL_ONE_MINUS_SRC_ALPHA');
    result=[];
    % Here we load in an image from file. This one is a image of rabbits that
    % is included with PTB
    
    earlyleave=false
    for x=1:length(imagebase)
        while earlyleave==false && length(imagebase)~=0
            imagename=[];
            randimageindex=1+floor(rand(1)*length(imagebase));
            imagename=imagebase(randimageindex).name;
            
            locations=regexp(imagename,'\w#');
            exp_name='E',result(index).file(1:locations(1));
            k=result(index).file(locations(1)+1:locations(2));
            pi=result(index).file(locations(2)+1:locations(3));
            
            imagebase(randimageindex)=[];
            
            theImage=imread([path,imagename]);
            theImage=uint8(theImage);
%             if max(max(theImage))==255
%             else
%                 theImage(theImage<6000)=0;
%                 theImage(theImage~=0)=255;
%                 %         theImage(:,:,2)=theImage;
%                 %         theImage(:,:,3)=theImage(:,:,2);
%                 %imagebase.name()
%                 % Get the size of the image
%             end
            [s1, s2, s3] = size(theImage);
            
            % Here we check if the image is too big to fit on the screen and abort if
            % it is. See ImageRescaleDemo to see how to rescale an image.
            
            % i=regexp(imagename,'.jpg')
            % imagename=imagename(1:i)
            % Make the image into a texture
            imageTexture = Screen('MakeTexture', window, theImage);
            
            % Draw the image to the screen, unless otherwise specified PTB will draw
            % the texture full size in the center of the screen. We first draw the
            % image in its correct orientation.
            Screen('DrawTexture', window, imageTexture, [], [], 0);
            
            % Flip to the screen
            
            %         Screen('TextSize', window, 60);
            %         DrawFormattedText(window, 'Human',screenXpixels * 0.10,...
            %             screenYpixels * 0.20, [0.5 0.5 0.5]);
            %
            %         Screen('TextSize', window, 60);
            %         DrawFormattedText(window, 'Computer',screenXpixels * 0.70,...
            %             screenYpixels * 0.20, [0.5 0.5 0.5]);
            Screen('Flip', window);
            display_time=now;
            %escape_sec=second(display_time)+60*minute(display_time)+60*hour(display_time);
            % Wait for two seconds
            exitDemo = false;
            x=404;
            y=404;
            [keyIsDown,secs, keyCode] = KbCheck;
            tic;
            while exitDemo == false
                %             display_time=now;
                %             current_sec=second(display_time)+60*minute(display_time)+60*hour(display_time);
                if toc>1 %time%
                    exitDemo = true;
                    y=408; %timeout
                end
            end
            exitDemo = false;
            Screen('TextSize', window, 80);
            DrawFormattedText(window, 'Human ?/ Computer ?',screenXpixels * 0.20,...
                screenYpixels * 0.40, [0.5 0.5 0.5]);
            Screen('Flip', window);
            while exitDemo == false
                while ~(keyCode(leftKey)==0 && keyCode(rightKey)==0&&keyCode(downKey)==0 )
                    [keyIsDown,secs, keyCode] = KbCheck;
                end
                [keyIsDown,secs, keyCode] = KbCheck;
                if keyCode(leftKey)
                    x = screenXpixels/4;
                    y=0;
                    %Screen('DrawTexture', window, imageTexture, [], [], 0);
                    Screen('TextSize', window, 80);
                    DrawFormattedText(window, 'Human',screenXpixels * 0.20,...
                        screenYpixels * 0.45, [0.5 0.5 0.5]);
                    Screen('Flip', window);
                    %exitDemo = true;
                elseif keyCode(rightKey)
                    x = 3*screenXpixels/4;
                    y=0;
                    %Screen('DrawTexture', window, imageTexture, [], [], 0);
                    Screen('TextSize', window, 80);
                    DrawFormattedText(window, 'Computer',screenXpixels * 0.55,...
                        screenYpixels * 0.45, [0.5 0.5 0.5]);
                    Screen('Flip', window);
                    %exitDemo = true;
                elseif keyCode(upKey)
                    x = 2*screenXpixels/4;
                    y=0;
                    %Screen('DrawTexture', window, imageTexture, [], [], 0);
                    Screen('TextSize', window, 80);
                    DrawFormattedText(window, 'I D K',screenXpixels * 0.45,...
                        screenYpixels * 0.45, [0.5 0.5 0.5]);
                    Screen('Flip', window);
                    %exitDemo = true;
                elseif keyCode(downKey)
                    
                    exitDemo = true;
                elseif keyCode(escapeKey)
                    sca;
                    earlyleave=true;
                    exitDemo = true;
                end
            end
            
            %y=screenYpixels;
            this_result.file=imagename;
            this_result.xy=[x,y];
            this_result.limit=[screenXpixels,screenYpixels];
            result=[result,this_result];
            stats.(exp_name)
            % Now fill the screen balck
            %                 Screen('FillRect', window, [1 1 1]);
            %                 % Flip to the screen
            %                 Screen('Flip', window);
            
        end
        
    end
    
    
    sca;
    time=now;
    mkdir('result')
    path=['.\result\',num2str(time),'.mat'];
    save(path);
    %upload(path);
    version='1';
elseif  soe=='e'
    sca;
end

end