source("rediswq.R")
source("functions.R")

# connect to redis host
host <- Sys.getenv("REDIS_SERVICE_HOST")
db <- redis_init(host = host)
vars_init("test")

# authenticate gcs
library(googleCloudStorageR)

print(paste0("Worker with sessionID: ", session))
print(paste0("Initial queue state: empty=", as.character(empty())))

while (!empty()) {
        item <- lease(lease_secs=10,
                        block = TRUE,
                        timeout = 2)
        if (!is.null(item)) {
                print(paste0("working on: ", item))
                # actual work
                run_save_model(item)
                complete(item)
        } else {
          print("waiting for work")       
        }
}
print("queue emtpy, finished")
