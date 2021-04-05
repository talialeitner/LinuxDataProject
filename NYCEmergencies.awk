# this program checks whether each of the zip codes colleceted from the EMS records is indeed a zip code in NYC
BEGIN{
    FS = "|"
    data = "NYCZipCodes.txt"
    # create an array with all of the NYC zip codes
    while ((status = (getline < data)) > 0){
	zips[$1] = 1
    }
    inputData = "ZipEmergencyFreq.txt"
    # create a new file with only the NYC zip codes
    while ((status = (getline < inputData)) > 0){
	if ($1 in zips)
	    # prints zip code | number of emergencies
	    print $1 "|" $2 > "NYCZipEmergencyFreq.txt"
    }
}
