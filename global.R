
library(tidyverse)
library(DT)
library(arules)
#library(arulesViz)
library(ggplot2)
#library(plotly)

target = read.csv('/Users/judy/Desktop/rshiny/data/clean_join_target.csv')[,-1]
maptarget = read.csv('/Users/judy/Desktop/rshiny/data/map_target.csv')[,-1]
target_mba = read.transactions('/Users/judy/Desktop/rshiny/data/tag.csv',format = 'basket', sep=',')
