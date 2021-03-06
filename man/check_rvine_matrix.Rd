% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rvine_matrix.R
\name{check_rvine_matrix}
\alias{check_rvine_matrix}
\title{R-vine matrices}
\usage{
check_rvine_matrix(matrix)
}
\arguments{
\item{matrix}{a quadratic matrix, see \emph{Details}.}
}
\value{
Throws an error if \code{matrix} is not a valid R-vine matrix, otherwise
\code{TRUE} is returned invisibly.
}
\description{
R-vine matrices are compressed representations of the vine structure. It
needs to satisfy several properties that can be checked by
\code{check_rvine_matrix()}, see \emph{Details}.
}
\details{
The R-vine matrix notation in vinecopulib is different from the one in
the VineCopula package. An example matrix is\preformatted{1 1 1 1
2 2 2 0
3 3 0 0
4 0 0 0
}

which encodes the following pair-copulas:

\tabular{lll}{
tree \tab  edge \tab pair-copulas   \cr
0    \tab  0    \tab \code{(4, 1)}       \cr
\tab  1    \tab \code{(3, 1)}       \cr
\tab  2    \tab \code{(2, 1)}       \cr
1    \tab  0    \tab \code{(4, 2; 1)}    \cr
\tab  1    \tab \code{(3, 2; 1)}    \cr
2    \tab  0    \tab \code{(4, 3; 2, 1)}
}

Denoting by \code{M[i, j]} the matrix entry in row \code{i} and column \code{j} (the
pair-copula index for edge \code{e} in tree \code{t} of a \code{d} dimensional vine is
\code{(M[d - 1 - t, e], M[t, e]; M[t - 1, e], ..., M[0, e])}. Less formally,
\enumerate{
\item Start with the counter-diagonal element of column \code{e} (first conditioned
variable).
\item Jump up to the element in row \code{t} (second conditioned variable).
\item Gather all entries further up in column \code{e} (conditioning set).
}

A valid R-vine matrix must satisfy several conditions which are checked
when \code{RVineMatrix()} is called:
\enumerate{
\item The lower right triangle must only contain zeros.
\item The upper left triangle can only contain numbers between 1 and d.
\item The anti-diagonal must contain the numbers 1, ..., d.
\item The anti-diagonal entry of a column must not be contained in any
column further to the right.
\item The entries of a column must be contained in all columns to the left.
\item The proximity condition must hold: For all t = 1, ..., d - 2 and
e = 0, ..., d - t - 1 there must exist an index j > d, such that
\code{(M[t, e], {M[0, e], ..., M[t-1, e]})} equals either
\code{(M[d-j-1, j], {M[0, j], ..., M[t-1, j]})} or
\code{(M[t-1, j], {M[d-j-1, j], M[0, j], ..., M[t-2, j]})}.
}

Condition 6 already implies conditions 2-5, but is more difficult to
check by hand.
}
\examples{
mat <- matrix(c(1, 2, 3, 4, 1, 2, 3, 0, 1, 2, 0, 0, 1, 0, 0, 0), 4, 4)
check_rvine_matrix(mat)

# throws an error
mat[4, 4] <- 5
try(check_rvine_matrix(mat))

}
