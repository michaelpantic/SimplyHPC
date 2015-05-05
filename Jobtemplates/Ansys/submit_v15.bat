@echo off
rem    Author:		Vladimir Baros / Michael Pantic
rem    Description: This script will run Ansys CFX calculation using distributed MSMPI


cmdkey /add:hsransys.file.core.windows.net /user:hsransys /pass:<pass>
net use X: \\hsransys.file.core.windows.net\main

rem Parameters to setup

rem CCP_NODES=[num_of_machines] [machine01] [num_of_mpi_processes_machine01] [machine02] [num_of_mpi_processes_machine02] ...
set CCP_NODES=tbd
set num_of_partitions=tbd

rem set Ansys parameters
set workdirpath=tbd
set def_file=bla.def

rem Static parameters

rem Setup the variables
set CFX_DATA_DIR=X:\apps\ANSYS Inc\v150\CFX\etc
set ANSYSLIC_DIR=X:\apps\ANSYS Inc\Shared Files\Licensing
set MPIEXEC_OPTIONS=-affinity
set CFX_DISABLE_REMOTE_CHECKS=1
set CFX5_HOSTS_CCL=NUL
set _CFX_PROC_PER_SOLVER=1
set _CFX_ENABLE_MSMPI_SM=1

rem Run the command
"X:\apps\ANSYS Inc\v150\CFX\bin\cfx5solve" -def "%def_file%" -chdir "%workdirpath%" -start-method MSMPI2 -part %num_of_partitions%

:end
@echo on