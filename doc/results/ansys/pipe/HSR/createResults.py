import string
import csv
import re
import numpy
import os
import itertools
from os import listdir
from os.path import isfile, join, isdir



resultsFolder = '.'
sequentialConfiguration = "1-1"
#load problem definitions
problem_configs = numpy.genfromtxt(join(resultsFolder,'problems.dat'), delimiter='\t',dtype='str')


#get available core configurations (format X-Y, x = num machines, Y = number/core per machine)
core_configs = [re.split("-",d) for d in next(os.walk(resultsFolder))[1]]

#sort by number of cores
core_configs = sorted(core_configs, key=lambda config:int(config[0])*int(config[1]))

#array for sequential Values (in order to compare with other values)
sequential_data = {}

#set column headers for definite output
column_headers = [["NumCores"]] + \
				 [ [str(problem[0])+"_time", \
				    str(problem[0])+"_totalSize", \
				    str(problem[0])+"_processorSize", \
				    str(problem[0])+"_speedup", \
				    str(problem[0])+"_efficiency_strong", \
				    str(problem[0])+"_sizeup", \
				    str(problem[0])+"_efficiency_weak" ] \
				       for problem in problem_configs] 

#flaten list
column_headers = list(itertools.chain(*column_headers))
print(column_headers)



column_per_problem = 7;

column_type = ['f4' for header in column_headers]

#create array for all data and set core sizes
complete_data = numpy.zeros(len(core_configs), dtype={'names': column_headers, \
									  			'formats':column_type})

complete_data["NumCores"] = [int(config[0])*int(config[1]) for config in core_configs]


# go trough each available config

for index,config in enumerate(core_configs):

	numberHosts = int(config[0])
	numberCores = int(config[1])
	configName = str(config[0])+"-"+str(config[1]);
	totalCores  = numberHosts * numberCores
	configFolder = os.path.join(resultsFolder,configName)

	#read each config, and load data of this config for each problem
	for pindex,problem in enumerate(problem_configs):
		problemName = str(problem[0])
		problemSize = float(problem[1])

		#get file this folder (resultsFolder/configName) that starts with problem name
		
		fileName = [f for f in [d for d in next(os.walk(configFolder))][2] if re.match(r''+problemName+'_\d+\.out',f)]
		
		foundResult = []

		#load data
		if(len(fileName) == 1):
			fileName = os.path.join(resultsFolder,configName,fileName[0])
			#parse time information using regex 
			#(               or:  (       Days:     Hours:   Minutes:   Seconds ))
			regexExpr = r'             or: \( *([\d,.]+) *: *([\d,.]+) *: *([\d,.]+) *: *([\d,.]+) *\)'
			foundResult = [re.findall(regexExpr, line) 
							for line in open(fileName)]
			foundResult= list(filter(lambda x: len(x)>0,foundResult))


		#write tables
		#zero results = no data
		if(len(foundResult) == 0):
			print("nodata - "+problemName+" - "+configName)
			continue

		#one time result in a file = no partitioner, only solver, must be sequential
		elif(len(foundResult) == 1 and configName == sequentialConfiguration):
			
			#get result in seconds
			totalWallClockTime = 	float(foundResult[0][0][0])*60*60*24  + \
									float(foundResult[0][0][1])*60*60 + \
									float(foundResult[0][0][2])*60 + \
									float(foundResult[0][0][3])
			

			sequential_data[problemName] = totalWallClockTime


		#regular case: 2 time results in a file (partitioner and solver)
		elif(len(foundResult) == 2):
			#get result in seconds
			totalWallClockTime = 	float(foundResult[1][0][0])*60*60*24  + \
									float(foundResult[1][0][1])*60*60 + \
									float(foundResult[1][0][2])*60 + \
									float(foundResult[1][0][3])
			

			
			

		else:
			#shouldn't happen
			raise('wrong number of wall clock times in out file')



		# set data point in array
		complete_data[index][pindex*column_per_problem+1] = totalWallClockTime # 1. time
		complete_data[index][pindex*column_per_problem+2] = problemSize # 2. totalSize
		complete_data[index][pindex*column_per_problem+3] = problemSize/totalCores # 3. processorSite

		if(problemName in sequential_data):
			complete_data[index][pindex*column_per_problem+4] = sequential_data[problemName]/totalWallClockTime # 4. speedup
			complete_data[index][pindex*column_per_problem+5] = sequential_data[problemName]/totalWallClockTime/totalCores # 5. efficiency strong
			complete_data[index][pindex*column_per_problem+6] = (problemSize/totalCores)/problemSize * sequential_data[problemName]/totalWallClockTime # 6. sizeup
			complete_data[index][pindex*column_per_problem+7] = (problemSize/totalCores)/problemSize * sequential_data[problemName]/totalWallClockTime/totalCores # 7. efficiency weak
		else:
			complete_data[index][pindex*column_per_problem+4] = numpy.NaN
			complete_data[index][pindex*column_per_problem+5] = numpy.NaN
			complete_data[index][pindex*column_per_problem+6] = numpy.NaN
			complete_data[index][pindex*column_per_problem+7] = numpy.NaN
			
			#if this are the sequential values, store them in an array for later use
			#if(configName == sequentialConfiguration):
				#sequential_data.append()





numpy.savetxt('results.dat',complete_data,delimiter="\t", header="\t".join(complete_data.dtype.names), comments='')
