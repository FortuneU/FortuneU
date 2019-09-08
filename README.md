# FortuneU

## User Stories

The following functionality is completed:

- [x] User can sign up to create a new account using Parse authentication
- [x] User can log in and log out of his or her account
- [x] The current signed in user is persisted across app restarts
- [x] User can record income/expense/saving to the app
- [x] User can view his/her previous records of income/expense/saving in a timeline
- [x] User can pull to refresh the to see the previous records
- [x] User can set a saving goal for a product that he or she wants to buy
- [x] User can track his/her performance as well as how he or she is doing towards accomplishing the saving goal
- [x] User can edit his/her goal
- [x] User can see his/her profile and logout

The following functionality is in progress:
- [x] User can post and see their friends' posts about good tips or their stories on saving
- [x] User can see a weekly analyasis for their financial performance
Below is one chunk of R code that we used for analysis:
```r
library(forecast)
vector = c(10,0,20,50,100,0,200,5,5,5,20,100,10, 10, 0, 5, 5, 20, 50, 0, 20 )
myts <- ts(vector, frequency = 7)
fit <- stl(myts, s.window="period")
plot(fit)
plot(forecast(fit))
```

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://g.recordit.co/WgZCOUOYUw.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

