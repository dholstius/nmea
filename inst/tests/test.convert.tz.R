test_that('timezones are converted correctly', {
	t0 <- ISOdate(1999, 1, 1, 1, 1, 1, tz='UTC') 
	UTC <- seq(t0, by=3600, length.out=60)
	LA <- convert.tz(times, to="America/Los_Angeles")
	expect_equal(as.numeric(UTC - LA), rep(0, length(UTC)))
	expect_equal(format(LA[1], '%Y-%m-%d %H:%M:%S %z'), "1998-12-31 17:01:01 -0800")
})