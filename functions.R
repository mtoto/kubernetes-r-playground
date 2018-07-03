create_subscription <- function(sub, topic) {
        command <- sprintf('gcloud pubsub subscriptions create %s --topic %s --ack-deadline=60', 
                           sub, topic)
        system(command)
}

create_topic <- function(topic) {
        command <- sprintf('gcloud pubsub topics create %s', topic)
        system(command)
}


pull_messages <- function(sub) {
        command <- sprintf('gcloud pubsub subscriptions pull --auto-ack --limit=%s %s',
                           limit, sub)
        system(command)
        
}

# publish_messages <- function(topic, messages) {
#         for (i in 1:length(messages)) {
#                 command <- sprintf('gcloud pubsub topics publish %s --message %s', 
#                                    topic, messages[i])
#                 system(command)
#         }
# }


