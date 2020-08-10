library(shiny)
library(shinydashboard)
library(tidyverse)
library(DT)
library(arules)
library(arulesViz)
library(ggplot2)
library(visNetwork)
library(ggpubr)

target = read.csv('data/clean_join_target.csv')[,-1]
maptarget = read.csv('data/map_target.csv')[,-1]
target_mba = read.transactions('data/tag.csv',format = 'basket', sep=',')
