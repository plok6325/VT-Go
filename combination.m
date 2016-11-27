function [ cb ] = combination( Humanandpc )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明

cb=factorial(sum(Humanandpc))/factorial(Humanandpc(1))/factorial(Humanandpc(2));
end

