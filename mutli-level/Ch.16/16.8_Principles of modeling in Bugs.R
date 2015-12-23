## Read the data
# Data are at http://www.stat.columbia.edu/~gelman/arm/examples/radon

# The R codes & data files should be saved in the same directory for
# the source command to work
library ("R2WinBUGS")

source("../Ch.12/12.6_Group-level predictors.R") # where variables were defined
# close the Bugs window to proceed

## Set up and call Bugs
radon.data <- list ("n", "J", "x", "y", "county", "u")

radon.inits <- function (){
  list (a=rnorm(J), b=rnorm(1), g.0=rnorm(1), g.1=rnorm(1),
        sigma.y=runif(1), sigma.a=runif(1))
}

radon.parameters <- c ("a", "b", "sigma.y", "sigma.a", "g.0", "g.1")

# Ridiculous hack needed when this file is sourced from a different directory.
# Otherwise radon.3.bug believes it's in Ch12, not 16
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)

radon.3 <- openbugs (radon.data, radon.inits, radon.parameters, "radon.3.bug", n.chains=3, n.iter=500)

## Define parameters and include them in the data
sigma.y <- .7
sigma.alpga <- .4
radon.data <- list ("n", "J", "x", "y", "county", "u", "sigma.y", "sigma.alpha")

radon.inits <- function (){
  list (a=rnorm(J), b=rnorm(1), g.0=rnorm(1), g.1=rnorm(1))
}


