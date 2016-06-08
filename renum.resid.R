#!/bin/Rscript
# This script reads a pdb file and re-enumerates the residue numbers from one
# and in a sequence. It is needed, for example, when several pdb files have been merged
# together with "cat" and therefore the resid is non-sequential. You may also use it when
# your PDB has residue ID (resid) is in some base other than 10 to convert it to ten.
# You also have the option to convert from decimal to base 36

# Use it from a terminal as 
# $ Rscript renumber.resid.R "membrane_ions.pdb" TRUE
# or 
# $ Rscript renumber.resid.R "membrane_ions.pdb" FALSE
# or uncomment the function wrapper and use it interactively as a function from 
# within R.

args <- commandArgs(TRUE)
pdbfileRead = args[1]
base36 = args[2]   # the second argument has to be TRUE is you want resids to be base36
					# else false
#if (is.na(pdbfileWrite)){
#	pdbfileWrite = "output.pdb"
#}
#renumber.resid <- function(pdbfileRead, base36=F){

    pdbfileWrite = "temp.pdb"
	source("~/03-codes/generalScripts/as.base.36.R")
	conread <- file(pdbfileRead, open="rt")
	conwrite <- file(pdbfileWrite, open="wt")
	
	# Read/write first line
	header <- readLines(conread,n=1)
	writeLines(header,con=conwrite)

    # Read/write each new line
    newInputLine <- readLines(conread, n = 1)
    resid <- substring(newInputLine, 23, 26)
    newResid <- 1
    oldResid <- resid   
    while (length(newInputLine) > 0) {
	    if (!is.na(resid)){
    		if (resid==oldResid){
    			newResidOut <- newResid
    		} else {
    			newResid <- newResid+1
				oldResid <- resid
				newResidOut <- newResid    			   			
    		}
    		if (base36){
    			newResidOut <- as.base.36(newResid)
    		} else if (newResidOut==10000) {
 				newResid <- 1
 				oldResid <- resid
 				newResidOut <- newResid	   		
    		}
    		newOutputLine <- paste(substr(newInputLine, 1, 22),
    					sprintf("%4s", newResidOut), substr(newInputLine, 27, nchar(newInputLine)), sep="")
    		writeLines(newOutputLine, con=conwrite)    	
    	} else {    		
   			# Read/write last line
			writeLines(newInputLine,con=conwrite)
    	}    	
    	newInputLine <- readLines(conread, n = 1)
	    resid <- substring(newInputLine, 23, 26)
    }
 	closeAllConnections()	
 	system(paste("mv ", pdbfileRead, " \\#", pdbfileRead, "#", sep=""))
 	system(paste("mv ", pdbfileWrite, " ", pdbfileRead, sep=""))
#}
