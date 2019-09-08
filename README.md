# FortuneU

We also applied R for data analysis.
```r
library(forecast)
vector = c(10,0,20,50,100,0,200,5,5,5,20,100,10, 10, 0, 5, 5, 20, 50, 0, 20 )
myts <- ts(vector, frequency = 7)
fit <- stl(myts, s.window="period")
plot(fit)
plot(forecast(fit))
```
