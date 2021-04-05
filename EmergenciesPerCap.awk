# this program returns the number of mental health related emergencies per (capita) the zip code's population
BEGIN{
    FS = "|"
    # field 1 is the zip and field 15 is the estimated population
    data = "ZIPcodes.gz"
    while (("zcat " data | getline)>0){
	# create an array with zip codes as keys and holds the pop
	pop[$1] = $15
    }
    inputData = "NYCZipEmergencyFreq.txt"
    while ((status = getline < inputData) >0){
	# find the number of emergencies per population
	# field 1 is the zip and field 2 is the number of emergencies
	# check whether the population of that zip code is greater than 0 - if it's 0 then nobody lives in that neighborhood so disregard the data
	if (pop[$1] > 0){
	    # find the number of emergencies / population
	    cap = ($2 / pop[$1])
	    # print the zip code and the emergencies per capita
	    print $1 "|" cap > "EmergencyPerCap.txt"
	}
    }
}
