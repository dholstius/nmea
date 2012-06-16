\name{convert.tz}
\alias{convert.tz}
\title{convert.tz}
\usage{
  convert.tz(x, from, to)
}
\arguments{
  \item{x}{POSIXt object}

  \item{from}{source timezone. If not supplied, attempts to
  use attr(x, 'tzone').}

  \item{to}{target timezone. If not supplied, attempts to
  use Sys.timezone().}
}
\value{
  POSIXt object with new timezone
}
\description{
  Convert a POSIXt object from one timezone to another
}

