#!/bin/bash -l
#SBATCH -p slurmHPC_inf
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=4
#SBATCH -t 3-07:00:00

# BDG
#SBATCH -J min_bf_bdgphL_gIG_5_e-5_alpha8_P18_desi_dr1

# IG
##SBATCH -J min_bf_ig_V4_P18_desi_dr1

# DIG
##SBATCH -J min_bf_dig_V4_P18_desi_dr1

# LCDM
##SBATCH -J min_bf_lcdm_P18_desi_dr1

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
#module load /shared/software/modulefiles/gcc-12.3_sl7
source /gpfs/gpfs/gpfs_maestro/hpc/user/modified_gravity/angelo/planck_2018/code/plc_3.0/plc-3.1/bin/clik_profile.sh

cd /gpfs/gpfs/gpfs_maestro/hpc/user/modified_gravity/angelo/BDG/cobaya/cobaya

YAMLFOLDER=/gpfs/gpfs/gpfs_maestro/hpc/user/modified_gravity/angelo/BDG/cobaya/cobaya/mcmc_scripts/yaml/

# BDG
YAMLFILEMIN=${YAMLFOLDER}min_bdgphL_gIG_5e-5_alpha8_P18_bao_desi_dr1.yaml
YAMLFILEBF=${YAMLFOLDER}bf_bdgphL_gIG_5e-5_alpha8_P18_bao_desi_dr1.yaml

# IG
#YAMLFILEMIN=${YAMLFOLDER}min_ig_V4_P18_bao_desi_dr1.yaml
#YAMLFILEBF=${YAMLFOLDER}bf_ig_V4_P18_bao_desi_dr1.yaml

# DIG
#YAMLFILEMIN=${YAMLFOLDER}min_dig_V4_P18_bao_desi_dr1.yaml
#YAMLFILEBF=${YAMLFOLDER}bf_dig_V4_P18_bao_desi_dr1.yaml

# LCDM
#YAMLFILE=${YAMLFOLDER}min_lcdm_P18_bao_desi_dr1_covlcdm.yaml
#YAMLFILE=${YAMLFOLDER}bf_lcdm_P18_bao_desi_dr1_covlcdm.yaml

mpirun python mcmc_scripts/read_yaml_and_run_chain.py ${YAMLFILEMIN}
mpirun python mcmc_scripts/read_yaml_and_run_chain.py ${YAMLFILEBF}
