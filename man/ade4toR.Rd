\name{ade4toR}
\alias{ade4toR}
\alias{Rtoade4}
\title{Format Change Utility}
\description{
  Exchange objects between \R and ADE4 (classic version) \url{http://pbil.univ-lyon1.fr/ADE-4/} 
}
\usage{
ade4toR (fictab, ficcolnames = NULL, ficrownames = NULL)
Rtoade4 (x)
}
\arguments{
  \item{fictab}{a name of ADE4 text file.  A data frame with the same name is created in the \R environment.} 
  \item{ficcolnames}{the column names label file}
  \item{ficrownames}{the row names label file}
  \item{x}{a data frame}
}
\value{
 'ade4toR' gives data frames.\cr
  'Rtoade4' gives text files.
}
\details{
"xxx" is the name of object x (\code{(deparse(substitute(x)))})\cr
For any table :\cr
	creates a file "xxx.txt"\cr
	creates a file "xxx\_row\_lab.txt" with row names\cr
	creates a file "xxx\_col\_lab.txt" with column names\cr\cr

if x has the 'col.blocks' attribute\cr
creates a file "xxx\_col\_bloc\_lab.txt" with blocks names\cr
creates a file "xxx\_col\_bloc.txt" with blocks sizes\cr\cr

For a table which all columns are factors : \cr
creates a file "xxx.txt"\cr
creates a file "xxx\_var\_lab.txt" with row names\cr
creates a file "xxx\_moda\_lab.txt" with categories names\cr\cr

Files are created in the current working directory. \cr
}
\examples{
data(tarentaise)
traits <- tarentaise$traits
Rtoade4(traits)
# File creation traits.txt 
# File creation traits_col_lab.txt 
# File creation traits_row_lab.txt 
# File creation traits_col_bloc.txt 
# File creation traits_col_bloc_lab.txt  

mil <- tarentaise$envir
Rtoade4(mil)
#File creation mil.txt 
#File creation mil_var_lab.txt 
#File creation mil_moda_lab.txt 
}
\keyword{utilities}
