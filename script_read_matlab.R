tr.dat <- simNoise[,1:40]
tst.dat <- simNoise[,41:50]
result.tr <- RFLLat(tr.dat,J=5,lam1=1,lam2=9)
tr.pred <- predict(result.tr)
tst.pred <- predict(result.tr,newY=tst.dat)
plot(tst.dat[,1],xlab="Probe",ylab="Y")
lines(tst.pred$pred.Y[,1],col="red",lwd=3)
fllat=tst.pred$pred.Y
writeMat(con="RFLLat.mat", x=fllat)



