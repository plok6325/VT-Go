function [currentmainversion ,currentimageversion]  = version_check(  )
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明

imageversion=dir('*image*');
currentimageversion=imageversion(1).name(7:11);
currentmainversion=main(1,0);
version={currentmainversion ,currentimageversion} ;
end

