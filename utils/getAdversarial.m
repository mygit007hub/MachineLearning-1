function [adv] = getAdversarial(net, im, label, eps)
%GETADVERSARIAL Summary of this function goes here
%   Detailed explanation goes here

net.layers{end} = struct('type', 'softmax') ;
net = vl_simplenn_tidy(net);
dzdy = 1;
res = vl_simplenn(net, im);
dzdx = vl_nnsoftmaxloss(res(end).x, label, dzdy);
res = vl_simplenn(net, im, dzdx, res, 'skipForward', true);

adv = res(1).x + eps*sign(res(1).dzdx);

end
