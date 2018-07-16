#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)
n <- as.double(args[1])

pbirthdaysim <- function(n) { 
        ntests <- 100000 
        pop <- 1:365 
        anydup <- function(i) 
                any(duplicated( 
                    sample(pop, n, replace=TRUE)))
        sum(sapply(seq(ntests), anydup)) / ntests 
}

pbirthdaysim(n)
