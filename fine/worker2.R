# modeling function
source("rediswq.R")
library(stringi)
library(utf8)
               
host <- "redis"

q <- RedisWQ(name = "test", host = "redis")

print(paste0("Worker with sessionID: ", q$sessionID()))

print(paste0("Initial queue state: empty=", as.character(q$empty())))

while (!q.empty()) {
    item <- q$lease(lease_secs=10,
                    block = TRUE,
                    timeout = 2)
    if (!is.na(item)) {
      itemstr <-intToUtf8(item)
      print(paste0("working on: ", itemstr))
      paste0(item, " yeah baby") # actual work
      q$complete
    }
    else {
      print("waiting for work")
    }
}
print("queue emtpy, finished")
