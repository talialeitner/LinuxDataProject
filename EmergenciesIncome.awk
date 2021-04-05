# this program returns the zip code, number of mental health related emergencies per population, and the average income
BEGIN{
    FS = "|"
    # field 1 is zip and field 3 is the mean income
    data = "IncomePop.gz"
    while (("zcat " data | getline)>0){
	# create an array with zip codes as keys and holds the avg income
	inc[$1] = $3
    }

    inputData = "EmergencyPerCap.txt"
    while ((status = getline < inputData) > 0){
	# if no average income, then can't plot data so disregard
	if (inc[$1] > 0)
	    # print the zip code, emergencies per capita and income
	    print $1 "|" $2 "|" inc[$1] > "ZIPEmergencyIncome.txt"
    }
}
