#!/usr/bin/env Rscript

mean_change = 1.001 
volatility = 0.01 
opening_price = 100 

getClosingPrice <- function(days) { 
        movement <- rnorm(days, mean=mean_change, sd=volatility) 
        path <- cumprod(c(opening_price, movement)) 
        closingPrice <- path[days] 
        return(closingPrice) 
} 

replicate(100000, getClosingPrice(365)) 
