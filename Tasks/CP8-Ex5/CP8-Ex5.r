require(lmtest)

problem_data <- function() {
    mer <- c(4.0, 4.0, 5.0, 0.5, 3.0, 5.0, 6.0, 2.0, 4.0, 4.0, 4.5, 4.0, 3.5, 2.0, 3.0, 2.5, 4.0, 6.5, 4.5, 4.0, 4.0, 4.0, 3.5, 2.0, 4.0)
    rtd <- c(2.6, 2.8, 5.0, 0.0, 2.4, 6.4, 6.4, 2.3, 4.2, 4.0, 3.3, 1.4, 1.8, -1.9, -7.6, 3.1, 5.0, 6.6, 2.7, 6.3, 0.0, 0.4, 0.6, -4.0, -6.3)
    dif <- abs(mer - rtd)

    days <- c('D1', 'D2', 'D3', 'D4', 'D5')
    all_days <- c(rep(days, 5))
    silo <- c(rep('A', 5), rep('B', 5), rep('C', 5), rep('D', 5), rep('E', 5))

    return(data.frame(silo, days, mer, rtd, dif))
}

box_plot <- function(x, df, label) {
    title <- 'Box-plot de las medias diarias'
    png(paste('images/box-', label, '-ByBlock.png', sep = ''))
    boxplot(
        x ~ df$days, 
        ylab=paste('Medida - ', label, sep=''), 
        xlab='Días', 
        main=title
    )
    dev.off()

    title2 <- 'Box-plot de las medias por silo'
    png(paste('images/box-', label, '-ByFactor.png', sep = ''))
    boxplot(
        x ~ df$silo, 
        ylab=paste('Medida - ', label, sep=''), 
        xlab='Silo', 
        main=title2
    )
    dev.off()
}

qq_plot <- function(residuals, label) {
    png(paste('images/qq-', label, '.png', sep=''))
    qqnorm(residuals)
    qqline(residuals)
    dev.off()
}

hist_plot <- function(residuals, label) {
    png(paste('images/hist-', label, '.png', sep=''))
    hist(residuals)
    dev.off()
}

std_plot <- function(anova, label) {
    png(paste('images/std-', label, '.png', sep=''))
    plot(
        anova$fitted.values, 
        rstudent(anova), 
        ylab='Residuals',
        xlab='Predictions',
        main='Anova Residuals'
    )
    abline(h = 0, lty = 2)
    dev.off()
}

plot_assumptions <- function(anova, label) {
    png(paste('images/all-', label, '.png', sep=''))
    layout(matrix(c(1,2,3,4), 2, 2, byrow=T))
    plot(
        anova$fitted.values, 
        rstudent(anova), 
        ylab='Residuals',
        xlab='Predictions',
        main='Anova Residuals'
    )
    abline(h = 0, lty = 2)
    residuals <- anova$residuals
    hist(residuals)
    qqnorm(residuals)
    qqline(residuals)
    dev.off()
}

test_assumptions <- function(anova, df) {
    print("    ++ Shapiro ++     ")
    print(shapiro.test(anova$residuals))

    print("    ++ Bartlett ++     ")
    print(bartlett.test(anova$residuals, df$silo))

    print("    ++ Durbin-Watson ++     ")
    print(dwtest(anova))
}

make_model <- function(df, x, label) {
    # Box Plot
    box_plot(x, df, label)

    # Anova analysis
    anova <- aov(x ~ df$silo + df$days)
    res <- anova$residuals

    print(paste('---------', label, '---------'))
    print('    ++ Anova ++    ')
    print(summary(anova))

    # Check anova residual assumptions
    # Test
    test_assumptions(anova, df)

    # Plots
    plot_assumptions(anova, label)
    # Plot in separated images
    std_plot(anova, label)
    hist_plot(res, label)
    qq_plot(res, label)
    
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