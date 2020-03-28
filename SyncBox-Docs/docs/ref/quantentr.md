#### quantentr.m

`function xquant = quantentr(x,quantlvl)`

Helper function for `timeseriesTE_rank.m`. The function quantentr quantizes the signal x into quantlvl levels using a codebook defined by [0:1:quantlvl-1].