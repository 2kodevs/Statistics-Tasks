require(lmtest)
#Set absolute path to file
data <- read.csv("./Advertising.csv")

data$X <- NULL

png('cor.png')
pairs(data)
dev.off()

print(cor(data))

model.fitRTN <- lm(data$sales ~  data$radio + data$TV + data$newspaper, data=data)
model.fitTN <- lm(data$sales ~   data$TV + data$newspaper, data=data)
model.fitRN <- lm(data$sales ~  data$radio + data$newspaper, data=data)
model.fitRT <- lm(data$sales ~  data$radio + data$TV, data=data)

print('Radio + TV + Newspaper')

print(summary(model.fitRTN))

print('Media de error residual')
print(mean(model.fit$residuals))

print('Suma de error residual')
print(sum(model.fit$residuals))

png('plotsRTN.png', width=800, height=400)
par(mfrow=c(1,2))

hist(model.fitRTN$residuals, xlab='Residuals', main='Radio + TV + Newspaper')
qqnorm(model.fitRTN$residuals)
qqline(model.fitRTN$residuals)

dev.off()

print(dwtest(model.fitRTN))

pred = predict(model.fitRTN, data=data.frame(
  tv=data$TV,
  radio=data$radio,
  newspaper=data$newspaper
))


png('homoRTN.png')
plot(pred, residuals(model.fitRTN), xlab='Predictions', ylab='Residuals of model')
abline(h=0, lty=2)
dev.off()


print('TV + Newspaper')

print(summary(model.fitTN))

print('Media de error residual')
print(mean(model.fitTN$residuals))

print('Suma de error residual')
print(sum(model.fitTN$residuals))

png('plotsTN.png', width=800, height=400)
par(mfrow=c(1,2))

hist(model.fitTN$residuals, xlab='Residuals', main='TV + Newspaper')
qqnorm(model.fitTN$residuals)
qqline(model.fitTN$residuals)

dev.off()

print(dwtest(model.fitTN))

pred = predict(model.fitTN, data=data.frame(
  tv=data$TV,
  radio=data$radio,
  newspaper=data$newspaper
))


png('homoTN.png')
plot(pred, residuals(model.fitTN), xlab='Predictions', ylab='Residuals of model')
abline(h=0, lty=2)
dev.off()


print('Radio + TV')

print(summary(model.fitRT))

print('Media de error residual')
print(mean(model.fitRT$residuals))

print('Suma de error residual')
print(sum(model.fitRT$residuals))

png('plotsRT.png', width=800, height=400)
par(mfrow=c(1,2))

hist(model.fitRT$residuals, xlab='Residuals', main='Radio + TV')
qqnorm(model.fitRT$residuals)
qqline(model.fitRT$residuals)

dev.off()

print(dwtest(model.fitRT))

pred = predict(model.fitRT, data=data.frame(
  tv=data$TV,
  radio=data$radio,
  newspaper=data$newspaper
))


png('homoRT.png')
plot(pred, residuals(model.fitRT), xlab='Predictions', ylab='Residuals of model')
abline(h=0, lty=2)
dev.off()


print('Radio + Newspaper')

print(summary(model.fitRN))

print('Media de error residual')
print(mean(model.fitRN$residuals))

print('Suma de error residual')
print(sum(model.fitRN$residuals))

png('plotsRN.png', width=800, height=400)
par(mfrow=c(1,2))

hist(model.fitRN$residuals, xlab='Residuals', main='Radio + Newspaper')
qqnorm(model.fitRN$residuals)
qqline(model.fitRN$residuals)

dev.off()

print(dwtest(model.fitRN))

pred = predict(model.fitRN, data=data.frame(
  tv=data$TV,
  radio=data$radio,
  newspaper=data$newspaper
))


png('homoRN.png')
plot(pred, residuals(model.fitRN), xlab='Predictions', ylab='Residuals of model')
abline(h=0, lty=2)
dev.off()
