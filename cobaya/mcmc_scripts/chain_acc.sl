#!/bin/bash -l
#SBATCH -p slurm_hpc_acc
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=12
#SBATCH -t 28-00:00:0

##SBATCH --exclude=hpc-201-11-17-a,hpc-201-11-17-b,hpc-201-11-18-a,hpc-201-11-18-b,hpc-201-11-19-b,hpc-201-11-20-a,hpc-201-11-20-b,hpc-201-11-21-a,hpc-201-11-21-b,hpc-201-11-22-a,hpc-201-11-22-b

# BDG
##SBATCH -J bdgphL_gIG_5_e-5_alpha8_P18_desi_sdss_combo
#SBATCH -J bdgphL_gIG_5_e-5_alpha8_P18_desi_H0

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
which python
which gcc
#module load /shared/software/modulefiles/gcc-12.3_sl7
source /gpfs/gpfs/gpfs_maestro/hpc/user/modified_gravity/angelo/planck_2018/code/plc_3.0/plc-3.1/bin/clik_profile.sh

cd /gpfs/gpfs/gpfs_maestro/hpc/user/modified_gravity/angelo/BDG/cobaya/cobaya

YAMLFOLDER=/gpfs/gpfs/gpfs_maestro/hpc/user/modified_gravity/angelo/BDG/cobaya/cobaya/mcmc_scripts/yaml/

# BDG
YAMLFILE=${YAMLFOLDER}bdgphL_gIG_5e-5_alpha8_P18_desi_H0.yaml
#YAMLFILE=${YAMLFOLDER}bdgphL_gIG_5e-5_alpha8_P18_bao_desi_dr1_sdss_combo.yaml
#YAMLFILE=${YAMLFOLDER}bdgphL_gIG_5e-5_alpha8_P18_bao_desi_dr1_rv.yaml

mpirun python mcmc_scripts/read_yaml_and_run_chain.py ${YAMLFILE}
