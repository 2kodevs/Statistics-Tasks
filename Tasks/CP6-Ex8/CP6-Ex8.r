x = c(46000, 45000, 35000, 32000, 42000, 36000, 41000, 56000, 73000, 53000)
y = c(34000, 27000, 30000, 26000, 30000, 28000, 34000, 34000, 43000, 36000)

n = length(x)

num = sum(x * y) - sum(x) * sum(y) / n
den = sum(x * x) - sum(x) * sum(x) / n

B1 = num / den
B0 = (sum(y) - (B1 * sum(x))) / n

#png('disp_diagram.png')
plot(x, y)

#png('line_diagram.png')
plot(x, y)
abline(B0, B1)

#dev.off()

B0
B1

print('Pendiente: ')
print(B1)

print('Estime el costo de un vehículo “semejante” comparable a uno de lujo de $60 000.')
print(B1 * 60000 + B0)

print('Estime el costo de un vehículo “semejante” comparable a uno de lujo de $40 000')
print(B1 * 40000 + B0)