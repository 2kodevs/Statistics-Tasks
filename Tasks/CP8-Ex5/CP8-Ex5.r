problem_data <- function() {
    mer <- c(4.0, 4.0, 5.0, 0.5, 3.0, 5.0, 6.0, 2.0, 4.0, 4.0, 4.5, 4.0, 3.5, 2.0, 3.0, 2.5, 4.0, 6.5, 4.5, 4.0, 4.0, 4.0, 3.5, 2.0, 4.0)
    rtd <- c(2.6, 2.8, 5.0, 0.0, 2.4, 6.4, 6.4, 2.4, 4.2, 4.0, 3.3, 1.4, 1.8, -1.9, -7.6, 3.1, 5.0, 6.6, 2.7, 6.3, 0.0, 0.4, 0.6, -4.0, -6.3)
    dif <- mer - rtd

    days <- c('D1', 'D2', 'D3', 'D4', 'D5')
    all_days <- c(rep(days, 5))
    silo <- c(rep('A', 5), rep('B', 5), rep('C', 5), rep('D', 5), rep('E', 5))

    return(data.frame(silo, days, mer, rtd, dif))
}

box_plot <- function(x, y, label) {
    title <- 'Box-plot de las mediciones diarias'
    png(paste('images/box-', label, '.png', sep = ''))
    boxplot(x ~ y, ylab=paste('Medida - ', label, sep=''), xlab='Días', main=title)
    dev.off()
}

qq_plot <- function(residuals, label) {
    png(paste('images/qq-', label, '.png', sep=''))
    qqnorm(residuals)
    qqline(residuals)
    dev.off()
}

std_plot <- function(x, residuals, label) {
    res_mean <- mean(residuals)
    res_sd <- sd(residuals)
    std_res <- (residuals - res_mean) / res_sd

    png(paste('images/std-', label, '.png', sep=''))
    plot(x, std_res)
    abline(h = 0, lty = 2)
    dev.off()
}

hist_plot <- function(residuals, label) {
    png(paste('images/hist-', label, '.png', sep=''))
    hist(residuals)
    dev.off()
}

make_model <- function(df, x, label) {
    # Box Plot
    box_plot(x, df$days, label)

    # Anova analysis
    anova <- aov(x ~ df$silo + df$days)
    res <- anova$residuals

    # Check anova residual assumptions
    # 1 - standardized Residuals
    std_plot(x, res, label)

    # 2 - Histogram 
    hist_plot(res, label)

    # 3 - Normal Q-Q plot
    qq_plot(res, label)

    print(paste('---------', label, '---------'))
    print(summary(anova))
    
    return()
}

main <- function() {
    df <- problem_data()

    make_model(df, df$mer, 'Mer')
    make_model(df, df$rtd, 'Rtd')
    make_model(df, df$dif, 'Diferencia')
    
    return()
}

main()