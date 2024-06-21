#' Homicide in Detroit: The role of Firearms.
#'
#' This is the dataset called `DETROIT' in the book `Subset selection in
#' regression' by Alan J. Miller published in the Chapman & Hall series of
#' monographs on Statistics & Applied Probability, no. 40.   The data are
#' unusual in that a subset of three predictors can be found which gives a
#' very much better fit to the data than the subsets found from the Efroymson
#' stepwise algorithm, or from forward selection or backward elimination.

#' The original data were given in appendix A of `Regression analysis and its
#' application: A data-oriented approach' by Gunst & Mason, Statistics
#' textbooks and monographs no. 24, Marcel Dekker.   It has caused problems
#' because some copies of the Gunst & Mason book do not contain all of the data,
#' and because Miller does not say which variables he used as predictors and
#' which is the dependent variable.   (HOM was the dependent variable, and the
#' predictors were FTP ... WE)
#'
#' @format A data frame with 13 rows and 14 variables:
#' \itemize{
#'   \item FTP: Full-time police per 100,000 population
#'   \item UEMP: UEMP - \% unemployed in the population
#'   \item MAN: MAN - number of manufacturing workers in thousands
#'   \item LIC: LIC - Number of handgun licences per 100,000 population
#'   \item GR: GR - Number of handgun registrations per 100,000 population
#'   \item CLEAR: CLEAR - \% homicides cleared by arrests
#'   \item WM: WM - Number of white males in the population
#'   \item NMAN: NMAN - Number of non-manufacturing workers in thousands
#'   \item GOV: GOV - Number of government workers in thousands
#'   \item HE: HE - Average hourly earnings
#'   \item WE: WE - Average weekly earnings:
#'   \item HOM: HOM - Number of homicides per 100,000 of population
#'   \item ACC: ACC - Death rate in accidents per 100,000 population
#'   \item ASR: ASR - Number of assaults per 100,000 population
#' }
#' @source \url{http://lib.stat.cmu.edu/datasets/detroit}
"detroit"



#' Student Performance dataset .
#'
#'This data approach student achievement in secondary education of two Portuguese schools.
#'The data attributes include student grades, demographic, social and school related features) and it was collected by using school reports and questionnaires.
#'Two datasets are provided regarding the performance in two distinct subjects: Mathematics (mat) and Portuguese language (por).
#'In [Cortez and Silva, 2008], the two datasets were modeled under binary/five-level classification and regression tasks.
#'Important note: the target attribute G3 has a strong correlation with attributes G2 and G1. This occurs because G3 is the final year grade (issued at the 3rd period),
#'while G1 and G2 correspond to the 1st and 2nd period grades. It is more difficult to predict G3 without G2 and G1, but such prediction is much more useful (see paper source for more details)
#'
#' @format A data frame with 392 rows and 33 variables:
#' \itemize{
#' Attributes for both student-mat.csv (Math course) and student-por.csv (Portuguese language course) datasets:
#' \item school - student's school (binary: 'GP' - Gabriel Pereira or 'MS' - Mousinho da Silveira)
#' \item sex - student's sex (binary: 'F' - female or 'M' - male)
#' \item age - student's age (numeric: from 15 to 22)
#' \item address - student's home address type (binary: 'U' - urban or 'R' - rural)
#' \item famsize - family size (binary: 'LE3' - less or equal to 3 or 'GT3' - greater than 3)
#' \item Pstatus - parent's cohabitation status (binary: 'T' - living together or 'A' - apart)
#' \item Medu - mother's education (numeric: 0 - none, 1 - primary education (4th grade), 2 â€“ 5th to 9th grade, 3 â€“ secondary education or 4 â€“ higher education)
#' \item Fedu - father's education (numeric: 0 - none, 1 - primary education (4th grade), 2 â€“ 5th to 9th grade, 3 â€“ secondary education or 4 â€“ higher education)
#' \item Mjob - mother's job (nominal: 'teacher', 'health' care related, civil 'services' (e.g. administrative or police), 'at_home' or 'other')
#' \item Fjob - father's job (nominal: 'teacher', 'health' care related, civil 'services' (e.g. administrative or police), 'at_home' or 'other')
#' \item reason - reason to choose this school (nominal: close to 'home', school 'reputation', 'course' preference or 'other')
#' \item guardian - student's guardian (nominal: 'mother', 'father' or 'other')
#' \item traveltime - home to school travel time (numeric: 1 - <15 min., 2 - 15 to 30 min., 3 - 30 min. to 1 hour, or 4 - >1 hour)
#' \item studytime - weekly study time (numeric: 1 - <2 hours, 2 - 2 to 5 hours, 3 - 5 to 10 hours, or 4 - >10 hours)
#' \item failures - number of past class failures (numeric: n if 1<=n<3, else 4)
#' \item schoolsup - extra educational support (binary: yes or no)
#' \item famsup - family educational support (binary: yes or no)
#' \item paid - extra paid classes within the course subject (Math or Portuguese) (binary: yes or no)
#' \item activities - extra-curricular activities (binary: yes or no)
#' \item nursery - attended nursery school (binary: yes or no)
#' \item higher - wants to take higher education (binary: yes or no)
#' \item internet - Internet access at home (binary: yes or no)
#' \item romantic - with a romantic relationship (binary: yes or no)
#' \item famrel - quality of family relationships (numeric: from 1 - very bad to 5 - excellent)
#' \item freetime - free time after school (numeric: from 1 - very low to 5 - very high)
#' \item goout - going out with friends (numeric: from 1 - very low to 5 - very high)
#' \item Dalc - workday alcohol consumption (numeric: from 1 - very low to 5 - very high)
#' \item Walc - weekend alcohol consumption (numeric: from 1 - very low to 5 - very high)
#' \item health - current health status (numeric: from 1 - very bad to 5 - very good)
#' \item absences - number of school absences (numeric: from 0 to 93)
#' \item
#' These grades are related with the course subject, Math or Portuguese:
#' \item G1 - first period grade (numeric: from 0 to 20)
#' \item G2 - second period grade (numeric: from 0 to 20)
#' \item G3 - final grade (numeric: from 0 to 20, output target)
#' }
#' @source \url{http://archive.ics.uci.edu/ml/datasets/Student+Performance}
#' @author \url{http://www3.dsi.uminho.pt/pcortez/Home.html}
#' @references Citation Request:
#' Please include this citation if you plan to use this database:
#' P. Cortez and A. Silva. Using Data Mining to Predict Secondary School Student Performance. In A. Brito and J. Teixeira Eds., Proceedings of 5th FUture BUsiness TEChnology Conference (FUBUTEC 2008) pp. 5-12, Porto, Portugal, April, 2008, EUROSIS, ISBN 978-9077381-39-7.\cr
#' Available at: \url{http://www3.dsi.uminho.pt/pcortez/student.pdf}
#'
#' Relevant Papers:
#'
#' P. Cortez and A. Silva. Using Data Mining to Predict Secondary School Student Performance. In A. Brito and J. Teixeira Eds., Proceedings of 5th FUture BUsiness TEChnology Conference (FUBUTEC 2008) pp. 5-12, Porto, Portugal, April, 2008, EUROSIS, ISBN 978-9077381-39-7.
#' Available at: \url{http://www3.dsi.uminho.pt/pcortez/student.pdf}
"student"
