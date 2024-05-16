#!/bin/bash -l
#SBATCH -p slurm_hpc_acc
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=12
#SBATCH -t 28-00:00:0

#SBATCH -J lcdm_P18_desi_dr1_drag_covlcdm

#SBATCH --export=ALL
##SBATCH --mem=64000
#SBATCH --mail-type=ALL
#SBATCH --mail-user=anferrar@bo.infn.it
#SBATCH --output=/gpfs/gpfs/gpfs_maestro/hpc/user/modified_gravity/angelo/BDG/cobaya/cobaya/err_out/%x_%j.out
#SBATCH --error=/gpfs/gpfs/gpfs_maestro/hpc/user/modified_gravity/angelo/BDG/cobaya/cobaya/err_out/%x_%j.err

echo "SLURM_JOBID="$SLURM_JOBID
echo "SLURM_JOB_NODELIST"=$SLURM_JOB_NODELIST
echo "SLURM_NNODES"=$SLURM_NNODES

module purge
conda activate bdg
module load compilers/gcc-12.3_sl7
source /gpfs/gpfs/gpfs_maestro/hpc/user/modified_gravity/angelo/planck_2018/code/plc_3.0/plc-3.1/bin/clik_profile.sh


cd /gpfs/gpfs/gpfs_maestro/hpc/user/modified_gravity/angelo/BDG/cobaya/cobaya

YAMLFILE=/gpfs/gpfs/gpfs_maestro/hpc/user/modified_gravity/angelo/BDG/cobaya/cobaya/mcmc_scripts/yaml/lcdm_P18_bao_desi_dr1_drag_covlcdm.yaml
mpirun python mcmc_scripts/read_yaml_and_run_chain.py ${YAMLFILE}
