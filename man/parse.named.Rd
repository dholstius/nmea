\name{parse.named}
\alias{parse.named}
\title{parse.named}
\usage{
  parse.named(pattern, x, ...)
}
\arguments{
  \item{pattern}{regular expression (see \link{regexpr})}

  \item{x}{character vector to match against}
}
\value{
  named list (or NULL if no matches)
}
\description{
  Extract named groups via Perl-style regular expression.
}

