# modeling function
run_save_model <- function(method) {
        library(mlbench)
        library(caret)
        data("BostonHousing")
        # split data
        set.seed(123)
        train_index <- createDataPartition(BostonHousing$medv,1, p = .7)
        train <- BostonHousing[train_index[[1]],]
        # train model
        model <- train(medv ~., 
                       data = train, 
                       method = method)
        
        # upload to storage bucket
        file <- sprintf("%s_model.rds", method)
        saveRDS(model, file)
        googleCloudStorageR::gcs_upload(file, 
                   name = file,
                   bucket = "bostonmodels")
}
