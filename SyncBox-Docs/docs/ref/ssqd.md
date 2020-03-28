#### ssqd.m

`function d = ssqd(X)`

Helper function for `timeseriesMI_kernel.m`. Computes pairwise sum of squared differences between rows of X
Uses squareform(.) to convert to square symmetric distance matrix. Taken from Matlab pdist.m.