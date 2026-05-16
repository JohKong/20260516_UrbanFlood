#!/bin/bash
#SBATCH --job-name=openfoam_Hk42      
#SBATCH --partition=cpuXeon6458     
#SBATCH --ntasks-per-node=64     
#SBATCH -n 64                  
#SBATCH --error=%j.err

ulimit -s unlimited
ulimit -l unlimited
module purge
module load mpi/openmpi/gnu/5.0.3  compiler/cmake/3.20.1  cuda/12.3.0
source activate openFoam
source /public/software/openFOAM/OpenFOAM-12/OpenFOAM-dev/etc/bashrc
topoSet
createPatch -overwrite
decomposePar
mpirun -np 64 foamRun -parallel
reconstructPar 
rm -rf processor*
foamPostProcess -func interfaceHeight -field g
foamPostProcess -func 'components(U)'