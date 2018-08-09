library(R6)
library(redux)
library(uuid)
library(digest)

redis_init <- function(host) {
        hiredis(host = host, port = 6379)
}

vars_init <- function(name) {
        session <<- UUIDgenerate()
        main_q_key <<- name
        processing_q_key <<- paste0(name, "processing")
        lease_key_prefix <<- paste0(name, "leased_by_session")
}

main_qsize <- function(db) {
        return(db$LLEN(main_q_key))
}

processing_qsize <- function(db) {
        return(db$LLEN(processing_q_key))
}

empty <- function() {
        main_qsize(db) == 0 & processing_qsize(db) == 0
}

itemkey <- function(item) {
        return(digest(item, algo="sha256", serialize=FALSE))
}

# lease_exists = function(item) {
#         return(db$EXISTS(paste0(lease_key_prefix, itemkey(item))))
# }

lease <- function(lease_secs = 60, block = TRUE, timeout = NA) {
        if (block) {
                item <- db$BRPOPLPUSH(main_q_key,
                                      processing_q_key,
                                      timeout = timeout)
        } 
        else {
                item <- db$RPOPLPUSH(main_q_key,
                                     processing_q_key)
        }
        if (!is.null(item)) {
                itemkey <- itemkey(item)
                db$SETEX(paste0(lease_key_prefix, itemkey), 
                         lease_secs, session)
        }
        return(item)
}

complete <- function(value) {
        db$LREM(processing_q_key, 0, value)
        itemkey <- itemkey(value)
        db$DEL(paste0(lease_key_prefix,
                      itemkey))
}
