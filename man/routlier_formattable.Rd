% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/routlier_formattable.R
\name{routlier_formattable}
\alias{routlier_formattable}
\title{routlier_formattable}
\usage{
routlier_formattable(data,sd)
}
\arguments{
\item{data}{filepath to data.}

\item{sd}{number of standard deviations to check the data against.}
}
\value{
Returns an outlier dataset from the original dataset in a DT table
}
\description{
Routlier: Outlier in DT Table
}
\details{
The outlier will be highlighted in green and the word 'Outlier' will replace the value in the cell.

\if{html}{\figure{routlier.png}{options: width=100\% alt="R logo"}}
\if{latex}{\figure{routlier.png}{options: width=0.5in}}
}
\examples{


  routlier_formattable(data = iris,sd = 2)

}
\keyword{routlier_formattable}