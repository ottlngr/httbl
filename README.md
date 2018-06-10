<!-- README.md is generated from README.Rmd. Please edit that file -->
httbl
=====

The goal of httbl is to ...

Installation
------------

``` r
devtools::install_github("ottlngr/httbl")
```

Example
-------

This is a basic example which shows you how to solve a common problem:

``` r
library(httbl)
library(dplyr)
library(tidyr)
library(gapminder)

data("gapminder")

gapminder %>% 
  group_by(continent, country, year) %>% 
  nest() %>% 
  group_by(continent, country) %>% 
  nest() %>% 
  group_by(continent) %>% 
  nest() %>% 
  httbl()
```
