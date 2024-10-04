#!/bin/bash -l
#SBATCH -p slurm_hpc_acc
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=12
#SBATCH -t 28-00:00:0

# BDG
##SBATCH -J bdgphL_gIG_5_e-5_alpha8_P18_desi_dr1
##SBATCH -J bdgphL_P18_desi_dr1
##SBATCH -J bdgphL_gIG_5_e-5_alpha8_P18_desi_sdss_combo

# IG and DIG
##SBATCH -J ig_P18_desi_sdss_combo
##SBATCH -J dig_P18_desi_sdss_combo
##SBATCH -J ig_P18_desi_H0
##SBATCH -J dig_P18_desi_H0

# EMG
#SBATCH -J emg_P18_desi
##SBATCH -J emg_P18_desi_sdss_combo
##SBATCH -J emg_P18_desi_H0

# EMG CC
##SBATCH -J emg_cc_P18_desi
##SBATCH -J emg_cc_P18_desi_wideV0
##SBATCH -J emg_cc_P18_desi_sdss_combo
##SBATCH -J emg_cc_P18_desi_H0

# LCDM
##SBATCH -J lcdm_P18_desi_dr1
##SBATCH -J lcdm_P18_desi_dr1_classig
##SBATCH -J lcdm_P18_desi_sdss_combo
##SBATCH -J lcdm_P18_desi_H0

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
#YAMLFILE=${YAMLFOLDER}bdgphL_P18_desi_dr1.yaml
#YAMLFILE=${YAMLFOLDER}bdgphL_gIG_5e-5_alpha8_P18_desi_dr1_sdss_combo.yaml

# EMG
YAMLFILE=${YAMLFOLDER}emg_P18_desi_dr1_cov1.yaml
#YAMLFILE=${YAMLFOLDER}emg_P18_desi_sdss_combo.yaml
#YAMLFILE=${YAMLFOLDER}emg_P18_desi_H0.yaml

# EMG CC
#YAMLFILE=${YAMLFOLDER}emg_cc_P18_desi_dr1.yaml
#YAMLFILE=${YAMLFOLDER}emg_cc_P18_desi_wideV0.yaml
#YAMLFILE=${YAMLFOLDER}emg_cc_P18_desi_sdss_comb.yaml
#YAMLFILE=${YAMLFOLDER}emg_cc_P18_desi_H0.yaml

# IG and DIG
#YAMLFILE=${YAMLFOLDER}ig_V4_P18_bao_desi_dr1_sdss_combo.yaml
#YAMLFILE=${YAMLFOLDER}dig_V4_P18_bao_desi_dr1_sdss_combo.yaml
#YAMLFILE=${YAMLFOLDER}ig_V4_P18_bao_desi_H0.yaml
#YAMLFILE=${YAMLFOLDER}dig_V4_P18_bao_desi_H0.yaml

# LCDM
#YAMLFILE=${YAMLFOLDER}lcdm_P18_desi_dr1.yaml
#YAMLFILE=${YAMLFOLDER}lcdm_P18_desi_dr1_classig.yaml
#YAMLFILE=${YAMLFOLDER}lcdm_P18_desi_dr1_sdss_combo.yaml
#YAMLFILE=${YAMLFOLDER}lcdm_P18_desi_H0.yaml

mpirun python mcmc_scripts/resume_chain.py ${YAMLFILE}
