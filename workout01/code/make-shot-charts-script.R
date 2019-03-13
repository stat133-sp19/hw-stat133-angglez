## title: Data Visualization
## description: creation of visual shot charts using the data for each player and the collective
## input(s): x and y coordinates of where shots were made, color-coded for whether the shot was made or not for each player
## output(s): shot charts mapping locations of shots against a court background for a visual representation, separated by player

library(jpeg)
library(grid)
library(ggplot2)

court_file <- "../workout01/images/nba-court.jpg"
court_image <- rasterGrob( readJPEG(court_file), width=unit(1, "npc"), height=unit(1, "npc"))

curry_scatterplot <- ggplot(data=curry) + annotation_custom(court_image, -250, 250, -50, 420) + geom_point(aes(x=x, y=y, color=shot_made_flag)) + ylim(-50, 420) + ggtitle('Shot Chart: Stephen Curry (2016 season)') + theme_minimal()
thompson_scatterplot <- ggplot(data=thompson) + annotation_custom(court_image, -250, 250, -50, 420) + geom_point(aes(x=x, y=y, color=shot_made_flag)) + ylim(-50, 420) + ggtitle('Shot Chart: Klay Thompson (2016 season)') + theme_minimal()
durant_scatterplot <- ggplot(data=durant) + annotation_custom(court_image, -250, 250, -50, 420) + geom_point(aes(x=x, y=y, color=shot_made_flag)) + ylim(-50, 420) + ggtitle('Shot Chart: Kevin Durant (2016 season)') + theme_minimal()
green_scatterplot <- ggplot(data=green) + annotation_custom(court_image, -250, 250, -50, 420) + geom_point(aes(x=x, y=y, color=shot_made_flag)) + ylim(-50, 420) + ggtitle('Shot Chart: Draymond Green (2016 season)') + theme_minimal()
iguodala_scatterplot <- ggplot(data=iguodala) + annotation_custom(court_image, -250, 250, -50, 420) + geom_point(aes(x=x, y=y, color=shot_made_flag)) + ylim(-50, 420) + ggtitle('Shot Chart: Andre Iguodala (2016 season)') + theme_minimal()

pdf(file='../workout01/images/andre-iguodala-shot-chart.pdf', width=6.5, height=5)
iguodala_scatterplot
pdf(file='../workout01/images/draymond-green-shot-chart.pdf', width=6.5, height=5)
green_scatterplot
pdf(file='../workout01/images/kevin-durant-shot-chart.pdf', width=6.5, height=5)
durant_scatterplot
pdf(file='../workout01/images/klay-thompson-shot-chart.pdf', width=6.5, height=5)
thompson_scatterplot
pdf(file='../workout01/images/stephen-curry-shot-chart.pdf', width=6.5, height=5)
curry_scatterplot

all_plots <- ggplot(data=total) + annotation_custom(court_image, -250, 250, -50, 420) + geom_point(aes(x=x, y=y, color=shot_made_flag)) + ylim(-50, 420) + ggtitle('Shot Charts: GSW (2016 season)') + theme_minimal() + facet_wrap(~name)
png(file='../workout01/images/gsw-shot-charts.png', width=8, height=7, units='in', res=200)
all_plots