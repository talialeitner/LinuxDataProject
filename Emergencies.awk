# this program returns the number of psychiatric patient emergencies by zip code recorded in the EMS data
BEGIN{
    FS = "\t"
    data = "EMS_Incident_Dispatch_Data.tsv.gz"
    while (("zcat " data | getline)>0){
	# field 5 is the final (emergency) call type
	# check if call for EDP (Emotionally Disturbed Persons/psychiatric patient)
	# no other types of emergencies with "EDP" in them
	if ($5 ~ /EDP/){
	    # field 22 is the zipcode
	    # create an array that keeps track of the number of EDP emergencies in each zip code
	    # if there is a comma in zip code - get rid of it
	    if ($22 ~ /,/){
		ind = index($22, ",")
		temp = substr($22, 1, ind-1) substr($22, ind+1)
		zip[temp]++
	    }
	    else
		zip[$22]++
	}
    }
    # print the zip code and the number of EDP emergencies
    # new file is pipe delimited
    for (key in zip){
	# check if key is truly a zip code (and not empty)
	if (key ~ /[0-9]{5}/)
	    # prints zip code | number of emergencies
	    print key "|" zip[key] > "ZipEmergencyFreq.txt"
    }
}

# next step is to verify that these are all zip codes in NYC!

