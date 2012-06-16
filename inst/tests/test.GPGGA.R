context('GPGGA')

test_that('time is parsed correctly', {
	datetime <- parse.HMS('162947.108', date='1999-01-01')
	formatted <- format(datetime, "%Y-%m-%d %H:%M:%OS", usetz=TRUE)
	expect_equal(formatted, "1999-01-01 16:29:47.108 UTC")
})

test_that('longitude is parsed correctly', {
	expect_equal(round(parse.longitude("12215.8387,W"), digits=6), -122.263978)
})

test_that('latitude is parsed correctly', {
	expect_equal(round(parse.latitude('3752.3651,N'), digits=6), 37.872752)
})

test_that('GPGGA sentence is parsed correctly', {
	x <- c(
		'$GPGGA,162947.108,3752.3651,N,12215.8387,W,1,04,4.6,108.6,M,-31.3,M,,0000*6E',
		'$GPGGA,162948.108,3752.3656,N,12215.8368,W,1,04,4.6,109.0,M,-31.3,M,,0000*60'
	)	
	(object <- parse.GPGGA(x, date='2011-06-13'))
})

expect_warning(object <- parse.GPGGA(sentences))
