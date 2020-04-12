months = seq(1, 6)
profit = c(1.2, 1.5, 2, 3.5, 4.1, 5.6)
sales = c(24, 25, 25, 28, 27, 29)
price = c(0.95, 0.93, 0.92, 0.9, 0.87, 0.86)

d = data.frame(months=months, profit=profit, sales=sales, price=price)

png('images/cor.png')
pairs(d)
dev.off()

cor(d)

model.fit = lm(profit ~ months + sales + price, data=d)
print(summary(model.fit))

d_scaled = data.frame(
    months=scale(d$months),
    profit=scale(d$profit),
    sales=scale(d$sales),
    price=scale(d$price)
)

model.fit_scaled = lm(profit ~ months + sales + price, data=d_scaled)

print(summary(model.fit_scaled))

print('Media de error residual (scaled)')
print(mean(model.fit_scaled$residuals))

print('Suma de error residual (scaled)')
print(sum(model.fit_scaled$residuals))

png('images/plots.png', width=800, height=400)
par(mfrow=c(1,2))

hist(model.fit_scaled$residuals, xlab='Residuals')
qqnorm(model.fit_scaled$residuals)
qqline(model.fit_scaled$residuals)

dev.off()

require(lmtest)
dwtest(model.fit_scaled)

print(d_scaled)

pred = predict(model.fit_scaled, data=data.frame(
    months=scale(d$months),
    sales=scale(d$sales),
    price=scale(d$price)
))

print('Predicciones en modelo escalado')
print(pred)

print('Errores residuales')
print(residuals(model.fit_scaled))

png('images/homo.png')
plot(pred, residuals(model.fit_scaled), xlab='Predictions', ylab='Residuals of scaled model')
abline(h=0, lty=2)
dev.off()
