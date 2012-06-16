log <- c(
	'$GPGGA,150102.000,2400.0000,N,12100.0000,E,0,00,0.0,0.0,M,0.0,M,,0000*6E',
	'$GPGSA,A,1,,,,,,,,,,,,,0.0,0.0,0.0*30',
	'$GPGSV,1,1,04,20,00,000,32,01,00,000,34,14,00,000,28,32,00,000,29*7D',
	'$GPRMC,150102.000,V,2400.0000,N,12100.0000,E,000.0,000.0,140612,,,N*75',
	'$GPVTG,000.0,T,,M,000.0,N,000.0,K,N*02',
	'$GPGGA,150103.262,3752.3669,N,12215.8688,W,1,03,2.4,31.4,M,-31.3,M,,0000*53',
	'$GPGSA,A,2,20,01,14,,,,,,,,,,2.4,2.4,0.0*35',
	'$GPGSV,2,1,05,01,52,245,34,20,44,311,33,14,16,063,28,22,07,120,*75',
	'$GPGSV,2,2,05,32,00,000,30*4E',
	'$GPRMC,150103.262,A,3752.3669,N,12215.8688,W,000.0,000.0,140612,,,A*7E',
	'$GPVTG,000.0,T,,M,000.0,N,000.0,K,A*0D',
	'$GPGGA,150104.262,3752.3666,N,12215.8689,W,1,03,2.2,31.4,M,-31.3,M,,0000*5C',
	'$GPGSA,A,2,20,01,14,,,,,,,,,,2.3,2.2,0.8*3C',
	'$GPGSV,2,1,05,01,52,245,33,20,44,311,35,14,16,063,26,22,07,120,*7A',
	'$GPGSV,2,2,05,32,00,000,31*4F',
	'$GPRMC,150104.262,A,3752.3666,N,12215.8689,W,000.0,000.0,140612,,,A*77',
	'$GPVTG,000.0,T,,M,000.0,N,000.0,K,A*0D'
)

# Parse just the GPGGA sentences
GPGGA <- log[grepl('\\$GPGGA', log)]

# Must supply a date (in UTC) since none is provided 
GPS <- parse.GPGGA(sentences, date='2012-06-14')

# Convert timestamps from UTC to local
GPS$datetime <- convert.tz(GPS$datetime, to="America/Los_Angeles")

# Filter out records with no GPS fix
head(valid <- subset(GPS, quality != 'invalid'))
