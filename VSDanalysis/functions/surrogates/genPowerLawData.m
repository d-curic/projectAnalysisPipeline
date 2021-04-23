function x = genPowerLawData(numdatapoints, exp)

x = (1-rand(numdatapoints,1)).^(-1/(exp-1));

end