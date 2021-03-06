% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/kpPlotBAMDensity.R
\name{kpPlotBAMDensity}
\alias{kpPlotBAMDensity}
\title{kpPlotBAMDensity}
\usage{
kpPlotBAMDensity(karyoplot, data=NULL, window.size=1e6, normalize=FALSE, ymin=NULL, ymax=NULL, data.panel=1, r0=NULL, r1=NULL, col="gray80", border=NA, ...)
}
\arguments{
\item{karyoplot}{(a \code{KaryoPlot} object) This is the first argument to all data plotting functions of \code{karyoploteR}. A KaryoPlot object referring to the currently active plot.}

\item{data}{(a \code{BamFile} or character) The path to a bam file (must be indexed) or a \code{BamFile} object.}

\item{window.size}{(numeric) The size of the windows for wich the density is computed. (Defaults to 1e6, one megabase windows)}

\item{normalize}{(boolean) Specifies if the density values should be normalized by the total number of mapped reads in the bam file. (Defaults to FALSE)}

\item{ymin}{(numeric) The minimum value to be plotted on the data panel. If NULL, it is set to 0. (deafults to NULL)}

\item{ymax}{(numeric) The maximum value to be plotted on the data.panel. If NULL the maximum density is used. (defaults to NULL)}

\item{data.panel}{(numeric) The identifier of the data panel where the data is to be plotted. The available data panels depend on the plot type selected in the call to \code{\link{plotKaryotype}}. (defaults to 1)}

\item{r0}{(numeric) r0 and r1 define the vertical range of the data panel to be used to draw this plot. They can be used to split the data panel in different vertical ranges (similar to tracks in a genome browser) to plot differents data. If NULL, they are set to the min and max of the data panel, it is, to use all the available space. (defaults to NULL)}

\item{r1}{(numeric) r0 and r1 define the vertical range of the data panel to be used to draw this plot. They can be used to split the data panel in different vertical ranges (similar to tracks in a genome browser) to plot differents data. If NULL, they are set to the min and max of the data panel, it is, to use all the available space. (defaults to NULL)}

\item{col}{(color) The background color to plot. If NULL, it will be a lighter version of 'border' or 'black' if border is null. (Defaults to "gray80")}

\item{border}{(color) The color to use to plot the borders of the bars. If NULL, it will be a darker version of 'col'. If NA, no border will be plotted. (Defaults to NULL)}

\item{...}{The ellipsis operator can be used to specify any additional graphical parameters. Any additional parameter will be passed to the internal calls to the R base plotting functions. In particular \code{col} and \code{border} can be used to set the colors used.}
}
\value{
Returns the original karyoplot object with the data computed (windows and density) stored at \code{karyoplot$latest.plot}
}
\description{
Plots the density of features along the genome
}
\details{
\code{kpPlotBAMDensity} plots the read density of a BAM file. It does not
plot the coverage but the read density as the number of reads overlapping 
a every window. It uses \code{\link{Rsamtools}} to efficiently access the
BAM file. The BAM file must be indexed.
}
\examples{

library(pasillaBamSubset) #A package with 2 example bam files
un1.bam.file <- untreated1_chr4() # get the name of the first bam
un3.bam.file <- untreated3_chr4() #and the name of the second

window.size <- 1e4 #compute the density with 10kb windows

kp <- plotKaryotype(genome="dm6", chromosomes="chr4") #The pasilla data comes from drosophila
kp <- kpAddBaseNumbers(kp, tick.dist = 1e5)
kp <- kpPlotBAMDensity(kp, data = un1.bam.file, window.size = window.size, r0=0.5, r1=1, ymax=50000, col="darkorange")
kp <- kpPlotBAMDensity(kp, data = un3.bam.file, window.size = window.size, r0=0.5, r1=0, ymax=50000, col="darkorchid") #using r0>r1 we can flip the plot
kpAxis(kp, ymin=0, ymax=50000, r0=0.5, r1=1, labels = c("0", "25K", "50K"))
kpAxis(kp, ymin=0, ymax=50000, r0=0.5, r1=0, labels = c("0", "25K", "50K"))

kpText(kp, chr = "chr4", x=7e5, y=0.85, labels = paste0("Untreated 1 (reads per ", window.size, " bases)"))
kpText(kp, chr = "chr4", x=7e5, y=0.15, labels = paste0("Untreated 3 (reads per ", window.size, " bases)"))



#Or normalizing by the number of mapped reads
kp <- plotKaryotype(genome="dm6", chromosomes="chr4") #The pasilla data comes from drosophila
kp <- kpAddBaseNumbers(kp, tick.dist = 1e5)
kp <- kpPlotBAMDensity(kp, data = un1.bam.file, window.size = window.size, normalize=TRUE, r0=0.5, r1=1, ymax=0.2, col="darkorange")
kp <- kpPlotBAMDensity(kp, data = un3.bam.file, window.size = window.size, normalize=TRUE, r0=0.5, r1=0, ymax=0.2, col="darkorchid") #using r0>r1 we can flip the plot


}
\seealso{
\code{\link{plotKaryotype}}, \code{\link{kpPlotRibbon}}, \code{\link{kpPlotCoverage}}
}
