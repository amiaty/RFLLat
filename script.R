tr.dat <- simNoiseBeta25[,1:40]
tst.dat <- simNoiseBeta25[,41:50]
result.tr <- FLLat(tr.dat,J=5,lam1=5,lam2=49)
tr.pred <- predict(result.tr)
tst.pred <- predict(result.tr,newY=tst.dat)
plot(tst.dat[,1],xlab="Probe",ylab="Y")
lines(tst.pred$pred.Y[,1],col="red",lwd=3)
fllat=tst.pred$pred.Y
writeMat(con="RFLLat.mat", x=fllat)
