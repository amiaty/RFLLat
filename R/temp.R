# Description: Example file for aggregate

# main idea: aggregate is R for SQL "group by"

# grab some data to work with
data("ChickWeight")

# let's say I want the median weight of each chick
# basic format
aggregate(ChickWeight$weight,  by=list(chkID = ChickWeight$Chick), FUN=median)
aggregate(ChickWeight$weight,  by=list(chkID = ChickWeight$Diet), FUN=median)
