The data in this folder is structured in the following way:

The first folder hierarchy ( A8/small/verylarge/cluster) denoninates the Machine Type used:
	* A8 = Azure 8 Core with Infiniband
	* VeryLarge = Azure 8 Core without Infiniband
	* Small = Azure 1 Core without Infinband
	* Cluster = HSR Cluster

The second folder hierarchy defines the configuration used, for example the folder

A8/8n-8c is the data for the testrun with A8-size, 8 nodes (8n) and 8 cores per node (8c) = 64 Cores
A8/1n-8c = A8-Size, 1 node, 8 cores per node = 8 cores
and so on.

On multi-core machines, there were also testruns with different core numbers (e.g. A8/1n-1c, 1n-2c, 1n-4c, 1n-8c), in order to test with
which amount of cores the memory bandwidth is satisfied.



In each folder, e.g. A8/1n-1c there are several zip files:
- one file with "winhpcg" in its name; these are the result files of the winhpcg run
- one file with "ruepel200" in its name; these are the result files of the petsc solver with the matrix "ruepel" (200 iterations)
- one file with "nordborg200", files for petsc solver with matrix "nordborg" (200 iterations)
- and, for some tests:  a zip file with the name "stream" - this is a memory bandwidth test



Additionally, 2 python scripts are included:

extract.py - which extracts the needed data files from each of the zip files of one machine type
		Note: adjust the basePath in the file (line 28) (e.g. to the A8 folder)


getValues.py - which creates a overall results file for one machine type
		Note: adjust the machineSize variable and the machineCost variable and the basePath