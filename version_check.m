function [currentmainversion ,currentimageversion]  = version_check(  )
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��


imageversion=textread('./image_database/version.txt', '%s', 'whitespace', '');
    imageversion=imageversion{1};
currentimageversion=imageversion(end-4:end);
currentmainversion=main(1,0,0);

version={currentmainversion ,currentimageversion} ;
end


