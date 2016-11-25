function  result = vl_nnsoftmaxloss_custom(net, res, class, i, eps, alfa)
%VL_NNSOFTMAXLOSS_CUSTOM Summary of this function goes here
%   Detailed explanation goes here

Y = vl_nnsoftmax(res(i).x);
dY = vl_nnsoftmaxloss(Y, class, 1);
adv_res = vl_simplenn(net, res(1).x, dY, res, 'skipForward', true);
adv_res(1).x = res(1).x + eps*sign(adv_res(1).dzdx);
adv_res = vl_simplenn(net, adv_res(1).x);

result = alfa*vl_nnsoftmaxloss(res(i).x, class) + (1 - alfa)*adv_res(i+1).x;

end