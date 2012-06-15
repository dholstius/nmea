#' parse.named
#'
#' Extract named groups via Perl-style regular expression.
#'
#' @param pattern	regular expression (see \link{regexpr})
#' @param x			character vector to match against
#' @return			named list (or NULL if no matches)
#' @export
parse.named <- function(pattern, x, ...) {
	matches <- regexpr(pattern, x, perl=TRUE, ...)
	first <- attr(matches, "capture.start")
	last <- first + attr(matches, "capture.length") - 1
	extract <- function(i) mapply(substring, x, first[,i], last[,i], USE.NAMES=FALSE)
	groupnames <- colnames(first)
	extracted <- sapply(groupnames, extract)
	reshaped <- matrix(extracted, ncol=length(groupnames))
	colnames(reshaped) <- groupnames
	data.frame(reshaped, stringsAsFactors=FALSE)
}
