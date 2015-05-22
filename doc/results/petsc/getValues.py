import glob
import zipfile
import os
import re


def getFromFile(filePath, regexExpr):

    file = open(filePath, 'r')
    regex = re.compile(regexExpr)

    for line in file:
        matches = regex.findall(line)
        for match in matches:
            return match

costSmall = 0.08;
costVeryLarge = 0.64;
costA8 = 2.45;

            
machineSize = 'cluster' #name of the machine Type
machineCost = 0.00; # cost per hour for this machine type

basePath = 'D:/Experiments/Results/'+machineSize
outputFile = 'output-'+machineSize+'.dat'
f = open(os.path.join(basePath,outputFile),'w')
f.write('machineSize ')
f.write('numNodes ')
f.write('numCores ')
f.write('totNumCores ')
f.write('totCost ')
f.write('mpiThroughput ')
f.write('mpiThroughputDeviation ')
f.write('mpiLatency ')
f.write('mpiLatencyDeviation ')

f.write('tStage1Ruepel ')
f.write('tMatLoadRuepel ')

f.write('tKSPSolveRuepel ')
f.write('nIterationRuepel ')
f.write('tIterationRuepel ')
f.write('mFlopsRuepel ')

f.write('tStage1Nordborg ')
f.write('tMatLoadNordborg ')

f.write('tKSPSolveNordborg ')
f.write('nIterationNordborg ')
f.write('tIterationNordborg ')
f.write('mFlopsNordborg ')

f.write('winhpcgGFlops ')
f.write('\n')

#go trough each folder
os.chdir(basePath)
for folder in glob.glob('*'):

    print(folder+':')

    match = re.match('(\d+)n-(\d+)c', folder)

    if(match == None):
        continue
    
    
    numNodes = match.group(1)
    numCores = match.group(2)
    totNumCores = str(int(numNodes)*int(numCores))
    totCost = int(numNodes) * machineCost;
    mpiThroughput = 'NA'
    mpiThroughputDeviation = 'NA'
    mpiLatency = 'NA'
    mpiLatencyDeviation = 'NA'

    tStage1Ruepel = 'NA'
    tMatLoadRuepel = 'NA'
    
    tKSPSolveRuepel = 'NA'
    nIterationRuepel = 'NA'
    tIterationRuepel = 'NA'   
    mFlopsRuepel = 'NA'
    
    tStage1Nordborg = 'NA'
    tMatLoadNordborg = 'NA'
    
    tKSPSolveNordborg = 'NA'
    nIterationNordborg = 'NA'
    tIterationNordborg = 'NA'   
    mFlopsNordborg = 'NA'

    winhpcgGFlops = 'NA'
    
    #get MPI results if any
    file = os.path.join(basePath,folder,"mpi.log")
    if os.path.isfile(file):
        mpiLatency = getFromFile(file,'LatencyInfo.+Average=\"([\d\.]+)\"')
        mpiLatencyDeviation = getFromFile(file,'LatencyInfo.+StdDev=\"([\d\.]+)\"')

        mpiThroughput = getFromFile(file,'ThroughputInfo.+Average=\"([\d\.]+)\"')
        mpiThroughputDeviation = getFromFile(file,'ThroughputInfo.+StdDev=\"([\d\.]+)\"')

    
    #get petsc results if any
    file = os.path.join(basePath,folder,"nordborg.log")
    if os.path.isfile(file):
        tStage1Nordborg = getFromFile(file,'0:.+Main Stage: ([\d\.e+-]+).+$')
        tMatLoadNordborg = getFromFile(file,'MatLoad\s+\d+ \d+.\d+ ([\d\.e+-]+)')

        tKSPSolveNordborg = getFromFile(file,'KSPSolve\s+\d+ \d+.\d+ ([\d\.e+-]+)')
        nIterationNordborg = getFromFile(file,'KSPGMRESOrthog\s+(\d+)') #kspmgresorthog is executed once per iteration
        tIterationNordborg = float(tKSPSolveNordborg)/float(nIterationNordborg)
        mFlopsNordborg  = getFromFile(file,'KSPSolve .+?(\d+)$')
     
        
    file = os.path.join(basePath,folder,"ruepel.log")
    if os.path.isfile(file):
        tStage1Ruepel = getFromFile(file,'0:.+Main Stage: ([\d\.e+-]+).+$')
        tMatLoadRuepel = getFromFile(file,'MatLoad\s+\d+ \d+.\d+ ([\d\.e+-]+)')

        tKSPSolveRuepel = getFromFile(file,'KSPSolve\s+\d+ \d+.\d+ ([\d\.e+-]+)')
        nIterationRuepel = getFromFile(file,'KSPGMRESOrthog\s+(\d+)') #kspmgresorthog is executed once per iteration
        tIterationRuepel = float(tKSPSolveRuepel)/float(nIterationRuepel)
        mFlopsRuepel  = getFromFile(file,'KSPSolve .+?(\d+)$')
        print(mFlopsRuepel)
    #get winhpcg results if any
    file = os.path.join(basePath,folder,"hpcg.log")
    if os.path.isfile(file):
       winhpcgGFlops = getFromFile(file,'HPCG.+VALID.+: (\d*\.\d*)')


    f.write(machineSize+' ')
    f.write(numNodes+' ')
    f.write(numCores+' ')
    f.write(totNumCores+' ')
    f.write(str(totCost)+' ')
    f.write(mpiThroughput+' ')
    f.write(mpiThroughputDeviation+' ')
    f.write(mpiLatency+' ')
    f.write(mpiLatencyDeviation+' ')

    f.write(tStage1Ruepel+' ')
    f.write(tMatLoadRuepel+' ')
    
    f.write(tKSPSolveRuepel+' ')
    f.write(nIterationRuepel+' ')
    f.write(str(tIterationRuepel)+' ')
    f.write(mFlopsRuepel+' ')
    
    f.write(tStage1Nordborg+' ')
    f.write(tMatLoadNordborg+' ')
    
    f.write(tKSPSolveNordborg+' ')
    f.write(nIterationNordborg+' ')
    f.write(str(tIterationNordborg)+' ')
    f.write(mFlopsNordborg+' ')

    f.write(winhpcgGFlops+' ')
    f.write('\n')

f.close()
os.chdir(basePath)

