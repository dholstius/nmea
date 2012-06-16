parse.HMS <- function(x, date, digits.secs=3) {
	options(digits.secs=digits.secs)
	strptime(paste(date, x), '%Y-%m-%d %H%M%OS', tz='UTC')
}

parse.latitude <- function(x) {
	(parts <- parse.named('(?<deg>[0-9]{2})(?<min>[0-9]{2}\\.[0-9]+),(?<dir>[NS])', x))
	decimal <- with(parts, as.numeric(deg) + as.numeric(min) / 60)
	decimal * ifelse(parts$dir == 'N', yes=1, no=-1)
}

parse.longitude <- function(x) {
	(parts <- parse.named('(?<deg>[0-9]{3})(?<min>[0-9]{2}\\.[0-9]+),(?<dir>[EW])', x))
	decimal <- with(parts, as.numeric(deg) + as.numeric(min) / 60)
	decimal * ifelse(parts$dir == 'E', yes=1, no=-1)
}

parse.quality <- function(x) {
	factor(x, levels=0:8, labels=c('invalid', 'GPS fix', 'DGPS fix', 'PPS fix', 'RT kinematic', 'float RTK', 'dead reckoning', 'manual input', 'simulation'))
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
	pattern <- '\\$GPGGA,(?<time>[0-9.]+),(?<latitude>[0-9.]+,[NS]),(?<longitude>[0-9.]+,[EW]),(?<quality>[0-8]),'
	records <- parse.named(pattern, x)
	if (missing(date)) {
		warning("Defaulting to today's date for timestamps with no date.")
		date <- as.Date(Sys.time())
	}
	with(records, data.frame(
		datetime = parse.HMS(time, date=date),
		latitude = parse.latitude(latitude),
		longitude = parse.longitude(longitude),
		quality = parse.quality(quality)
	))
}