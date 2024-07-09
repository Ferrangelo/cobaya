#!/bin/bash -l
#SBATCH -p slurm_hpc_acc
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=12
#SBATCH -t 28-00:00:0

# BDG
##SBATCH -J bf_bdgphL_gIG_5_e-5_alpha8_P18_desi_rv
##SBATCH -J bf_bdgphL_gIG_5_e-5_alpha8_P18_desi_sdss_combo
##SBATCH -J bf_bdgphL_gIG_5_e-5_alpha8_P18_desi_H0

# IG and DIG
##SBATCH -J bf_ig_P18_desi_sdss_combo
##SBATCH -J bf_ig_P18_desi_H0
#SBATCH -J bf_dig_P18_desi_sdss_combo

# LCDM
##SBATCH -J bf_lcdm_P18_desi_sdss_combo
##SBATCH -J bf_lcdm_P18_desi_H0
##SBATCH -J bf_lcdm_P18_desi

#SBATCH --export=ALL
##SBATCH --mem=64000
#SBATCH --mail-type=NONE
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
#YAMLFILE=${YAMLFOLDER}bf_bdgphL_gIG_5e-5_alpha8_P18_desi_dr1_rv.yaml
#YAMLFILE=${YAMLFOLDER}bf_bdgphL_gIG_5e-5_alpha8_P18_desi_H0.yaml

# IG and DIG
YAMLFILE=${YAMLFOLDER}bf_dig_V4_P18_bao_desi_dr1_sdss_combo.yaml

# LCDM
#YAMLFILE=${YAMLFOLDER}bf_lcdm_P18_desi_dr1.yaml
#YAMLFILE=${YAMLFOLDER}bf_lcdm_P18_desi_dr1_sdss_combo.yaml

mpirun python mcmc_scripts/read_yaml_and_run_chain.py ${YAMLFILE}
