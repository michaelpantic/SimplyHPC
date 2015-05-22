#!/usr/bin/python
# ZipFiles


def extractHPCG(f):
     with zipfile.ZipFile(file,'r') as zip:
        benchmarkFile = [x for x in zip.namelist() if x.endswith('yaml')]
        zip.extract(benchmarkFile[0])
        os.replace(benchmarkFile[0],'hpcg.log')

def extractPETSC(f,n):
    with zipfile.ZipFile(file,'r') as zip:
        benchmarkFile = [x for x in zip.namelist() if x.endswith('summary.txt')]
        zip.extract(benchmarkFile[0])
        os.replace(benchmarkFile[0],n+'.log')

def extractMPI(f):
    with zipfile.ZipFile(file,'r') as zip:
        benchmarkFile = [x for x in zip.namelist() if x.endswith('result.xml')]
        zip.extract(benchmarkFile[0])
        os.replace(benchmarkFile[0],'mpi.log')
    


import glob
import zipfile
import os
basePath = 'D:/Experiments/Results/cluster'

#go trough each folder
os.chdir(basePath)
for folder in glob.glob('*'):

    print(folder+':')
    os.chdir(os.path.join(basePath, folder))

    for file in glob.glob('*.zip'):
       if 'hpcg' in file: extractHPCG(file)
       if 'ruepel' in file: extractPETSC(file,'ruepel')
       if 'nordborg' in file: extractPETSC(file,'nordborg')
       if 'mpipingpong' in file: extractMPI(file)
