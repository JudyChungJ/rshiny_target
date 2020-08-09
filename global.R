
library(tidyverse)
library(plotly)
library(openintro) #state abb
library(dygraphs)
library(arules)
library(arulesViz)
library(igraph)
library(ggplot2)

target = read.csv('/Users/judy/Desktop/rshiny/data/clean_join_target.csv')[,-1]
maptarget = read.csv('/Users/judy/Desktop/rshiny/data/map_target.csv')[,-1]
target_mba = read.transactions('/Users/judy/Desktop/rshiny/data/tag.csv',format = 'basket', sep=',')
