function [currentmainversion ,currentimageversion]  = version_check(  )
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

imageversion=dir('*images*');
if length(imageversion)~=1
    mkdir images1.1.0\
    currentimageversion='1.1.0'
    currentmainversion=main(1,0);
else
currentimageversion=imageversion(1).name(7:11);
currentmainversion=main(1,0,0);main( 1, 0,0,0, 0, 0)
version={currentmainversion ,currentimageversion} ;
end
end

