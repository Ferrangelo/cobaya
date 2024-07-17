#!/bin/bash -l
#SBATCH -p slurmHPC_inf
#SBATCH --nodes=4
#SBATCH --ntasks-per-node=2
#SBATCH --cpus-per-task=28
#SBATCH -t 3-07:00:00
##SBATCH --exclude=hpc-200-06-26,hpc-200-06-27,hpc-200-06-28,hpc-200-06-29

# BDG
##SBATCH -J bdgphL_gIG_5_e-5_alpha8_P18_desi_dr1
##SBATCH -J bdgphL_gIG_5_e-5_alpha8_P18_desi_sdss_combo

# DIG
#SBATCH -J ig_P18_desi_H0
##SBATCH -J dig_P18_desi_H0

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

YAMLFOLDER=/gpfs/gpfs/gpfs_maestro/hpc/user/modified_gravity/angelo/BDG/cobaya/cobaya/mcmc_scripts/yaml/

# BDG
#YAMLFILE=${YAMLFOLDER}bdgphL_gIG_5e-5_alpha8_P18_bao_desi_dr1.yaml
#YAMLFILE=${YAMLFOLDER}bdgphL_gIG_5e-5_alpha8_P18_desi_dr1_sdss_combo.yaml

# IG and DIG
YAMLFILE=${YAMLFOLDER}ig_V4_P18_bao_desi_H0.yaml
#YAMLFILE=${YAMLFOLDER}dig_V4_P18_bao_desi_H0.yaml

mpirun python mcmc_scripts/resume_chain.py ${YAMLFILE}
