function [ output_args ] = prob( Hypothesis, Humanandpc )
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明
output_args=combination(Humanandpc)* (Hypothesis(1)^Humanandpc(1))*(Hypothesis(2)^Humanandpc(2));

end

