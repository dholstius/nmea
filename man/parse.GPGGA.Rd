\name{parse.GPGGA}
\alias{parse.GPGGA}
\title{parse.GPGGA}
\usage{
  parse.GPGGA(x, date)
}
\arguments{
  \item{x}{character}

  \item{date}{use this when dates are missing from
  timestamps}
}
\value{
  data.frame
}
\description{
  Parse NMEA sentences of type GPGGA (fix data).
}

