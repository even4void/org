display.cell <- function(x, bgcol="#DAE6F2", ...) {
  opar <- par(bg=bgcol, mar=rep(0,4))
  plot(c(0,1), c(0,1), type="n", axes=FALSE, xlab="", ylab="")
  text(.5, .5, as.character(x), ...)
  lines(c(-0.1,1.1), c(0,0))
  par(opar)
}

format.digits <- function(x) as.character(paste("$", as.character(x), sep="   "))

display.sparkline <- function(x, y, bgcol="#DAE6F2", ...) {
  opar <- par(bg=bgcol, mar=rep(0,4))
  plot(c(0,1), c(0,1), type="n", axes=FALSE, xlab="", ylab="")
  lines(x, y, ...)
  lines(c(-0.1,1.1), c(0,0))
  par(opar)
}


cell.layout <- c(1,2,3,4,
                 5,6,7,14,
                 8,9,10,15,
                 11,12,13,16,
                 0,17,18,0)

table.content <- c("Company", "Revenue", "Profit", "Stock",
                   "A", format.digits("35.0"), format.digits("28.0"),
                   "B", format.digits("20.0"), format.digits("35.0"),
                   "C", format.digits("50.0"), format.digits("29.0"))
xx <- replicate(3, sort(runif(100)))

layout(matrix(cell.layout, 5, 4, byrow=TRUE))

for (i in 1:length(table.content))
  display.cell(table.content[i], cex=3)

for (i in 1:3) 
  display.sparkline(seq(0, 1, length=100), xx[,i])

barplot(c(35,20,50), axes=FALSE, border=NA, col="darkblue")
barplot(c(28,35,29), axes=FALSE, border=NA, col="darkblue")
