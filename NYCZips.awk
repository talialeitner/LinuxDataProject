# this program creates a list of all of the zip codes in NYC based on their county
BEGIN{
    FS = ","
    data = "uszipsv1.4.csv.gz"
    while (("zcat " data | getline) >0){
	# field 1 is the zip and field 11 is the county
	# convert field 11 to all uppercase
	field11 = toupper($11)
	if ((field11 ~ /NEW YORK/)|| (field11 ~ /BRONX/)|| (field11 ~ /KINGS/)|| (field11 ~ /QUEENS/)|| (field11 ~ /RICHMOND/))
	    zip[$1] = field11
    }
    for (key in zip)
	# get ride of the quotes that are in the zip code text
	print substr(key,2,5) "|" zip[key] > "NYCZipCodes.txt"
}
   

