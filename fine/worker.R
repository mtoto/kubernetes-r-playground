library(stringi)
library(utf8)
source("rediswq.R")

host <- Sys.getenv("REDIS_SERVICE_HOST")
db <- redis_init(host = host)
vars_init("test")

print(paste0("Worker with sessionID: ", session))

print(paste0("Initial queue state: empty=", as.character(empty())))

while (!empty()) {
        item <- lease(lease_secs=10,
                        block = TRUE,
                        timeout = 2)
        if (!is.null(item)) {
                print(paste0("working on: ", item))
                paste0(item, " yeah baby") # actual work, this does not save only print statements
                complete(item)
        }
}
print("queue emtpy, finished")
