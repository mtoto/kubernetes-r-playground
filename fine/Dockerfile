FROM rocker/r-base
RUN install2.r -e  RMySQL redux caret 
COPY ./worker.py /worker.py

CMD Rscript worker.py