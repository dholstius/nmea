#' convert.tz
#'
#' Convert a POSIXt object from one timezone to another
#'
#' @param x		POSIXt object
#' @param from	source timezone. If not supplied, attempts to use attr(x, 'tzone').
#' @param to	target timezone. If not supplied, attempts to use Sys.timezone().
#' @return		POSIXt object with new timezone
#' @export
convert.tz <- function(x, from, to) {
	if (missing(from)) {
		from <- attr(x, 'tzone')
		if (is.null(from)) stop('No "from" timezone specified and none found')
	}
	if (missing(to)) {
		to <- Sys.timezone()
		if (to == "") stop('No "to" timezone specified and none found')
	}
	options(digits.secs=3)
	fmt <- '%Y-%m-%d %H:%M:%OS %z'
	formatted <- format(x, fmt)
	converted <- strptime(formatted, fmt, tz=to)
	as.POSIXct(converted)
}