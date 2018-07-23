FROM rocker/r-base

RUN apt-get update && apt-get install -y build-essential tcl \
    libhiredis-dev

RUN install2.r -e redux nycflights13 uuid digest stringi utf8

COPY ./worker.R /worker.R
COPY ./rediswq.R /rediswq.R

CMD Rscript worker.R