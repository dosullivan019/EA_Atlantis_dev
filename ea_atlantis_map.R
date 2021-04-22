library(SOmap)
library(ggplot2)
library(rbgm)     # for reading the .bgm file

bgm_file = box_sp(bgmfile('EA_model_files/Antarctica_28.bgm'))

SOmap(trim=-50)
SOplot(bgm_file)

