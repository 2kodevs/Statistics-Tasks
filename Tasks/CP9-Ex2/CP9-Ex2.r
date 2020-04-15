load_data <- function() {
    data <- read.csv('files/Employee data.csv')
    return(data)
}

main <- function(){
    data <- load_data()

    png('images/correlation-plot.png')
    plot(data)
    dev.off()

    matrix <- cor(data)
    print("     --- Corelation Matrix ---")
    print(matrix)

    print("")
    print("     --- Corelation Summary ---")
    print(symnum(matrix))
}

main()