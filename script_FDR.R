## Load simulated aCGH data.
data(tempname)
## Run FLLat for J = 5, lam1 = 1 and lam2 = 9.
result <- FLLat(tempname,J=10,lam1=1,lam2=9)
#result <- RFLLat(simaCGH,alphaHuber=,J=5,lam1=1,lam2=9)
#result <- SFLLat(simaCGH,J=5,lam1=1,lam2=9)
## Estimate the FDRs.
result.fdr <- FLLat.FDR(tempname,result)
## Plotting the FDRs against the threshold values.
plot(result.fdr)
## The threshold value which controls the FDR at 0.05.
result.fdr$thresh.control
