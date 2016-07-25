function [adv] = getAdversarial(net, im, label, eps)
%GETADVERSARIAL Summary of this function goes here
%   Detailed explanation goes here

dzdy = 1;
res = vl_simplenn(net, im);
% dzdx = vl_nnsoftmaxloss(res(end).x, label, dzdy);
dzdx = vl_nnloss(res(end).x, label, dzdy);
res = vl_simplenn(net, im, dzdx);

adv = res(1).x + eps*sign(res(1).dzdx);

end