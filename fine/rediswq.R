library(R6)
library(redux)
library(uuid)
library(digest)

RedisWQ <- R6Class("RedisWQ", list(
  name <- NULL,
  initialize <- function(name) {
    self$name <- name
    self$db <- redux::hiredis()
    self$session <- UUIDgenerate()
    self$main_q_key <- name
    self$processing_q_key <- paste0(name, "processing")
    self$lease_key_prefix <- paste0(name, "leased_by_session)
  },
  sessionID <- function() {
    return(self$session) 
  },
  main_qsize <- function() {
    return(self$db$LLEN(self$main_q_key))
  },
  processing_qsize <- function() {
    return(self$db$LLEN(self$processing_q_key))
  },
  empty <- function() {
    return(self$main_qsize() == 0 &
           self$processing_qsize() == 0)
  },
  itemkey <- function(item) {
    return(digest(item, algo="sha224", serialize=FALSE))
  },
  lease_exists <- function(item) {
    return(self$db$EXISTS(paste0(self$lease_key_prefix, self$itemkey(item))))
  },
  lease <- function(lease_secs = 60, block = TRUE, timeout = NA) {
    if (block) {
      item <- self$db$BRPOPLPUSH(self$main_q_key,
                         self$processing_q_key,
                         timeout = timeout)
    } 
    else {
      item <- self$db$RPOPLPUSH(self$main_q_key,
                         self$processing_q_key)
    }
    if (item) {
      itemkey <- self$itemkey(item)
      self$db$setex(paste0(self$lease_key_prefix,itemkey), lease_secs, self$session)
    }
    return(item)
  },
  complete <- function(value) {
    self$db$LREM(self$processing_q_key, 0 , value)
    itemkey <- self$itemkey(value)
    self$db$DEL(paste0(self$lease_key_prefix,
                       itemkey),
                self$session)
  }
)