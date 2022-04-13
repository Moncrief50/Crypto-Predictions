setwd("~/Desktop/Intro to Data Science/")
install.packages("prophet")
install.packages("lubridate")
install.packages("ggplot2")
library(prophet)
library(lubridate)
library(ggplot2)
library(dplyr)
library(lubridate)

data <- read.csv(file.choose("2015-2021"))
str(data)
head(data)

qplot(Date, Open, data = data,
      main = 'Cardano Opening prices 2015-2021')
ds <- data$Date
y <- log(data$Open)
df <- data.frame(ds, y)

class(data$Date)

df$JoiningDate <- as.Date(df$JoiningDate, format = "%m/%d/%y")
df[order(df$JoiningDate ),]
data$newDate <- strptime(as.character(data$Date), "%Y-%m-%d")                                 

?strptime
?POSIXlt

qplot(ds, y, data = df,
      main = 'Cardano opening prices in log scale')
m <- prophet(df)
str(m)
future <- make_future_dataframe(m, periods = 360)
tail(future)
forecast <- predict(m, future)
plot(m, forecast)
dyplot.prophet(m, forecast)
prophet_plot_components(m, forecast)
