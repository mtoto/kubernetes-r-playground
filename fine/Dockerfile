FROM rocker/r-base
RUN install2.r -e redux caret nycflights13 uuid digest stringi utf8
COPY ./worker2.R /worker2.R

CMD Rscript worker2.R