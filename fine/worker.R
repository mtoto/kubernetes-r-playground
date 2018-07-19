# modeling function
library(redux)
library(caret)

model_delay <- function(x) {
    train(dep_delay ~., 
          data = nycflights, 
          method = x$value)
}
               
res <- r$subscribe("mychannel",
                   transform = model_delay,
                   terminate = function(x) identical(x, "goodbye"))
                   
                   
