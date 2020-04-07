months = seq(1, 6)
profit = c(1.2, 1.5, 2, 3.5, 4.1, 5.6)
sales = c(24, 25, 25, 28, 27, 29)
price = c(0.95, 0.93, 0.92, 0.9, 0.87, 0.86)

d = data.frame(months=months, profit=profit, sales=sales, price=price)

pairs(d)
cor(d)

model.fit = lm(profit ~ months + sales + price, data=d)
summary(model.fit)

d$months_scaled = scale(d$months)
d$profit_scaled = scale(d$profit)
d$sales_scaled = scale(d$sales)
d$price_scaled = scale(d$price)

model.fit_scaled = lm(profit_scaled ~ months_scaled + sales_scaled + price_scaled, data=d)
summary(model.fit_scaled)

print('Media de error residual (scaled)')
print(mean(model.fit_scaled$residuals))

print('Suma de error residual (scaled)')
print(sum(model.fit_scaled$residuals))

png('plots.png', width=800, height=400)
par(mfrow=c(1,2))

hist(model.fit_scaled$residuals)
qqnorm(model.fit_scaled$residuals)
qqline(model.fit_scaled$residuals)

dev.off()

require(lmtest)
dwtest(model.fit_scaled)