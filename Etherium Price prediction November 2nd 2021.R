getwd()
setwd("/Users/robertmoncrief/Desktop/Group Project/SVM/Etherium Dataset")
install.packages("prophet")
install.packages("lubridate")
install.packages("ggplot2")
library(prophet)
library(lubridate)
library(ggplot2)

data <- read.csv(file.choose("2015-2021.csv"))
str(data)
head(data)
data$high <- as.numeric(gsub(",","", data$high))
data$low <- as.numeric(gsub(",","", data$low))
data$close <- as.numeric(gsub(",","", data$close))
head(data)

data$high[is.na(data$high)] <- mean(data$high, na.rm = TRUE)
data$low[is.na(data$low)] <- mean(data$low, na.rm = TRUE)
data$close[is.na(data$close)] <- mean(data$close, na.rm = TRUE)

data$timestamp <- as.POSIXct(data$timestamp, origin = "1970-01-01")
qplot(timestamp, open, data = data,
      main = 'Etherium Opening prices 2019-2021')
ds <- data$timestamp
y <- log(data$open)
df <- data.frame(ds, y)

qplot(ds, y, data = df,
      main = 'Etherium opening prices in log scale')
m <- prophet(df)
str(m)
future <- make_future_dataframe(m, periods = 200)
tail(future)
forecast <- predict(m, future)
plot(m, forecast)
dyplot.prophet(m, forecast)
prophet_plot_components(m, forecast)

