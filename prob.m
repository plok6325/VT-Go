function [ output_args ] = prob( Hypothesis, Humanandpc )
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
output_args=combination(Humanandpc)* (Hypothesis(1)^Humanandpc(1))*(Hypothesis(2)^Humanandpc(2));

end

