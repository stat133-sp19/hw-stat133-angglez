## title: Data Preparation
## description: Manipulating individual player data frames and binding them together to assemble a master table
## input(s): data frames for each individual player
## output(s): total data frame including all the players, additional minute and name columns

col_types <- c('character','character','integer','integer','integer','integer','character','character','factor','integer','character','double','double')
curry <- read.csv("../Stat133/workout01/data/stephen-curry.csv", colClasses = col_types)
thompson <- read.csv("../Stat133/workout01/data/klay-thompson.csv", colClasses = col_types)
durant <- read.csv("../Stat133/workout01/data/kevin-durant.csv", colClasses = col_types)
green <- read.csv("../Stat133/workout01/data/draymond-green.csv", colClasses = col_types)
iguodala <- read.csv("../Stat133/workout01/data/andre-iguodala.csv", colClasses = col_types)

curry$name = rep('Stephen Curry', length(curry$team_name))
thompson$name = rep('Klay Thompson', length(thompson$team_name))
durant$name = rep('Kevin Durant', length(durant$team_name))
green$name = rep('Draymond Green', length(green$team_name))
iguodala$name = rep('Andre Iguodala', length(iguodala$team_name))

curry$shot_made_flag[curry$shot_made_flag=='n'] <- 'shot_no'
curry$shot_made_flag[curry$shot_made_flag=='y'] <- 'shot_yes'
thompson$shot_made_flag[thompson$shot_made_flag=='n'] <- 'shot_no'
thompson$shot_made_flag[thompson$shot_made_flag=='y'] <- 'shot_yes'
durant$shot_made_flag[durant$shot_made_flag=='n'] <- 'shot_no'
durant$shot_made_flag[durant$shot_made_flag=='y'] <- 'shot_yes'
green$shot_made_flag[green$shot_made_flag=='n'] <- 'shot_no'
green$shot_made_flag[green$shot_made_flag=='y'] <- 'shot_yes'
iguodala$shot_made_flag[iguodala$shot_made_flag=='n'] <- 'shot_no'
iguodala$shot_made_flag[iguodala$shot_made_flag=='y'] <- 'shot_yes'

curry$minute = curry$period * 12 - curry$minutes_remaining
thompson$minute = thompson$period * 12 - thompson$minutes_remaining
durant$minute = durant$period * 12 - durant$minutes_remaining
green$minute = green$period * 12 - green$minutes_remaining
iguodala$minute = iguodala$period * 12 - iguodala$minutes_remaining

sink(file='../Stat133/workout01/output/stephen-curry-summary.txt')
summary(curry)
sink(file='../Stat133/workout01/output/klay-thompson-summary.txt')
summary(thompson)
sink(file='../Stat133/workout01/output/kevin-durant-summary.txt')
summary(durant)
sink(file='../Stat133/workout01/output/draymond-green-summary.txt')
summary(green)
sink(file='../Stat133/workout01/output/andre-iguodala-summary.txt')
summary(iguodala)

total <- rbind(curry, thompson, durant, green, iguodala)
write.csv(x=total, file='../Stat133/workout01/data/shots-data.csv')
sink(file='../Stat133/workout01/output/shots-data-summary.txt')
summary(total)
