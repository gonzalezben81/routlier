## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
library(knitr)
hook_output <- knit_hooks$get("output")
knit_hooks$set(output = function(x, options) {
  lines <- options$output.lines
  if (is.null(lines)) {
    return(hook_output(x, options))  # pass to default hook
  }
  x <- unlist(strsplit(x, "\n"))
  more <- "..."
  if (length(lines)==1) {        # first n lines
    if (length(x) > lines) {
      # truncate the output, but add ....
      x <- c(head(x, lines), more)
    }
  } else {
    x <- c(more, x[lines], more)
  }
  # paste these lines together
  x <- paste(c(x, ""), collapse = "\n")
  hook_output(x, options)
})

## ----detroit-------------------------------------------------------------
library(routlier)

routlier::routlier_simple(data = detroit,sd = 1)


## ---- output.lines=16----------------------------------------------------

routlier_simple(data = student,sd = 2)


## ------------------------------------------------------------------------

routlier_dt_sd(data = detroit,sd = 1)

## ------------------------------------------------------------------------

routlier_rh_sd(data = detroit,sd = 1)

## ------------------------------------------------------------------------

routlier_formattable(data = detroit,sd = 2)

## ------------------------------------------------------------------------

routlier_mad(data = detroit,MAD = 3)

