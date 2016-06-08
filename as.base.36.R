as.base.36 <- function(x){

        alphabet <- c("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l",
                                        "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z")
        helper <- function(y){
                # y has to be smaller or equal to 35
                if (y<10){
                return(y)
                } else {
                return(alphabet[y-9])
                }
        }

        myDecimalNumber <- x
        my36cimal <- ""
        while (myDecimalNumber > 35){
                myMod <- myDecimalNumber%%36
                myDecimalNumber <- myDecimalNumber%/%36
                my36cimal <- paste(helper(myMod), my36cimal, sep="")
        }
        my36cimal <- paste(helper(myDecimalNumber), my36cimal, sep="")
        return(my36cimal)
}
