x = c(-3, -1, 1, 3, 5, 7)
y = c(14, 4, 2, 8, 22, 44)

n = length(x)

num = sum(x * y) - sum(x) * sum(y) / n
den = sum(x * x) - sum(x) * sum(x) / n

B1 = num / den
B0 = (sum(y) - (B1 * sum(x))) / n

png('images/disp_diagram.png')
plot(x, y)
dev.off()

B0
B1

print('For x = 0 predicted value is')
print(B1 * 0 + B0)

print('For x = 2 predicted value is')
print(B1 * 2 + B0)
