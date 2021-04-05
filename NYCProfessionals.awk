# this program returns the number of mental health professionals by NYC zip code recorded in the NPI data
BEGIN{
    FS = "|"
    data = "npi.gz"
    while (("zcat " data | getline) > 0) {
	
	# field 48 is the taxonomy code for professional's specialization
	# 101Y = counselor; 102L = psychoanalyst; 102X = poetry therapist; 103G = clinical neuropsychologist;
	# 103T = psychologist; 1041 = social worker; 106H = marriage/family therapist; 2084P0800X = psychiatry;
	# 225600000X = dance therapist;
	if (($48 ~ /^101Y/) || ($48 ~ /^102L/) || ($48 ~ /^102X/) || ($48 ~ /^103G/) || ($48 ~ /^103T/) || ($48 ~ /^1041/) || ($48 ~ /^106H/) || ($48 ~ /^2084P0800X/) || ($48 ~ /^225600000X/))
	    # the first five digits of field 25 are the zip code 
	    zip[substr($25,1,5)]++
    }
    testData = "NYCZipCodes.txt"
    # create an array with all NYC zip codes
    while ((status = (getline < testData)) > 0){
	NYCzips[$1] = 1
    }
    # create a new file with only NYC zip codes and the number of mental health professionals
    for (key in zip){
	if (key in NYCzips)
	    # prints zip code | number of professionals
	    print key "|" zip[key] > "NYCProfFreq.txt"
    }
}
