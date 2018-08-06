# Parallelizing R code on kubernetes

This repository contains all the code describes in my blog post about parallelizing R scripts on kubernetes. The idea is to demonstrate different approaches available in kubernetes for parallelization. 

The three methods are:

- single job with **static** parameters
- common template and multiple parameters using **expansion**
- **fine** parallel processing using a work queue


