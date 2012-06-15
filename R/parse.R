parse.HMS <- function(x, date, digits.secs=3) {
	options(digits.secs=digits.secs)
	strptime(paste(date, x), '%Y-%m-%d %H%M%OS', tz='UTC')
}

parse.latitude <- function(x) {
	(parts <- parse.named('(?<deg>[0-9]{2})(?<min>[0-9]{2})\\.(?<sec>[0-9]{3}),(?<dir>[NS])', x))
	decimal <- with(parts, as.numeric(deg) + as.numeric(min) / 60 + as.numeric(sec) / 3600)
	decimal * ifelse(parts$dir == 'N', yes=1, no=-1)
}

parse.longitude <- function(x) {
	(parts <- parse.named('(?<deg>[0-9]{3})(?<min>[0-9]{2})\\.(?<sec>[0-9]{3}),(?<dir>[EW])', x))
	decimal <- with(parts, as.numeric(deg) + as.numeric(min) / 60 + as.numeric(sec) / 3600)
	decimal * ifelse(parts$dir == 'E', yes=1, no=-1)
}

#' parse.GPGGA
#'
#' Parse NMEA sentences of type GPGGA (fix data).
#'
#' @param x		character
#' @param date	use this when dates are missing from timestamps	
#' @return		data.frame
#' @export
parse.GPGGA <- function(x, date) {
	pattern <- '\\$GPGGA,(?<time>[0-9.]+),(?<latitude>[0-9.]+),N,(?<longitude>[0-9.]+),W'
	records <- parse.named(pattern, x)
	if (missing(date)) {
		warning("Defaulting to today's date for timestamps with no date.")
		date <- as.Date(Sys.time())
	}
	with(records, data.frame(
		datetime = parse.HMS(time, date=date),
		latitude = parse.latitude(latitude),
		longitude = parse.longitude(longitude)
	))
}