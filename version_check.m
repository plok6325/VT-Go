function [currentmainversion ,currentimageversion]  = version_check(  )
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

imageversion=dir('*images*');
currentimageversion=imageversion(1).name(7:11);
currentmainversion=main(1,0);
version={currentmainversion ,currentimageversion} ;
end

