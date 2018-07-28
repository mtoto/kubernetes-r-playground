FROM rocker/r-base

RUN apt-get update && apt-get install -y -t unstable \
    build-essential \
    tcl \
    libhiredis-dev \
    libcurl4-gnutls-dev \
    libssl-dev \
    && apt-get clean \ 
    && rm -rf /var/lib/apt/lists/ 
        
RUN Rscript -e "install.packages(c('redux', 'uuid', 'digest', 'caret', 'mlbench', 'googleCloudStorageR', 'httr', 'openssl','googleAuthR', 'randomForest', 'brnn', 'monomvn'), repos='https://cran.rstudio.com/')" \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds
    
RUN Rscript -e "install.packages(c('elasticnet', 'gbm'), repos='https://cran.rstudio.com/')" \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds

COPY ./worker.R /worker.R
COPY ./rediswq.R /rediswq.R
COPY ./functions.R /functions.R