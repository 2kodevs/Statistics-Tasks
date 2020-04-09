x = c(-1, 0, 3, 7)
y = c(2, 0, 4, 7)

n = length(x)

num = sum(x * y) - sum(x) * sum(y) / n
den = sum(x * x) - sum(x) * sum(x) / n

B1 = num / den
B0 = (sum(y) - (B1 * sum(x))) / n

png('disp_diagram.png')

plot(x, y)

dev.off()

B0
B1

print('For x = 1 predicted value is')
print(B1 * 1 + B0)