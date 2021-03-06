####Find XY coordinates to all cells on the earth's surface

droppath<-"/home1/02443/bw4sz/GlobalMammals/"

setwd(droppath)

#read in packages and source

source("Input/BrazilSourceFunctions.R")
require(reshape2)

#read in xy data with original rows
xytab<-read.csv("Output/xytable.csv",row.names=1)

#drop the id row
xytab<-xytab[,!colnames(xytab) %in% "id"]

#name the columns
xymat<-xydist(xytab[,c("x","y")])

print(dim(xymat))

#turn off diag and upper tri
diag(xymat)<-NA

xymat[upper.tri(xymat)]<-NA

xymelt<-melt(xymat)

xyout<-xymelt[!is.na(xymelt$value),]

#name the columns
colnames(xyout)<-c("To","From","km")

print(dim(xyout))

print(head(xyout))

write.table(xyout,"Output/xydist.txt")
