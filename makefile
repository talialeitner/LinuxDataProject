# all of the text files created by the awk scripts and the pdf file created by the python program
all: ScatterPlot.pdf ZipEmergencyFreq.txt NYCZipCodes.txt NYCZipEmergencyFreq.txt NYCProfFreq.txt EmergencyPerCap.txt ProfPerCap.txt ZIPEmergencyIncome.txt ZIPProfIncome.txt ScatterPlot.pdf

# remove all of the files created by the awk scripts and python program
clean:
	rm ZipEmergencyFreq.txt NYCZipCodes.txt NYCZipEmergencyFreq.txt NYCProfFreq.txt EmergencyPerCap.txt ProfPerCap.txt ZIPEmergencyIncome.txt ZIPProfIncome.txt ScatterPlot.pdf

# use the files created in order to create the scatter plot pdf
ScatterPlot.pdf: ZIPProfIncome.txt ZIPEmergencyIncome.txt ScatterPlot.py
	python3 ScatterPlot.py

# use the income data in order to create the file with zip | number of professionals per capita | average income of the zip
ZIPProfIncome.txt: IncomePop.gz ProfPerCap.txt ProfessionalsIncome.awk
	gawk -f ProfessionalsIncome.awk

# use the income data in order to create the file with zip | number of emergencies per capita | average income of the zip
ZIPEmergencyIncome.txt: IncomePop.gz EmergencyPerCap.txt EmergenciesIncome.awk
	gawk -f EmergenciesIncome.awk

# use the population data in order to create the file with zip | number of professionals per capita (/population)
ProfPerCap.txt: ZIPcodes.gz NYCProfFreq.txt ProfessionalsPerCap.awk
	gawk -f ProfessionalsPerCap.awk

# use the population data in order to create the file with zip | number of emergencies per capita (/population)
EmergencyPerCap.txt: ZIPcodes.gz NYCZipEmergencyFreq.txt EmergenciesPerCap.awk
	gawk -f EmergenciesPerCap.awk

# use the NPI data and created NYC zip codes file in order to create the file with (NYC) zip | number of mental health professionals in the zip
NYCProfFreq.txt: npi.gz NYCZipCodes.txt NYCProfessionals.awk
	gawk -f NYCProfessionals.awk

# use the created NYC zip codes file in order to create the file with (NYC) zip | number of emergencies in the zip
NYCZipEmergencyFreq.txt: NYCZipCodes.txt ZipEmergencyFreq.txt NYCEmergencies.awk
	gawk -f NYCEmergencies.awk

# use the zip code/ county data in order to create the file with all zips in NYC
NYCZipCodes.txt: uszipsv1.4.csv.gz NYCZips.awk
	gawk -f NYCZips.awk

# use the EMS data in order to create the file with zip | number of mental health emergencies in the zip
ZipEmergencyFreq.txt: EMS_Incident_Dispatch_Data.tsv.gz Emergencies.awk
	gawk -f Emergencies.awk
