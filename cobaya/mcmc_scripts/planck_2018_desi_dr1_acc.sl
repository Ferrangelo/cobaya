#!/bin/bash -l
#SBATCH -p slurm_hpc_acc
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=8
#SBATCH --cpus-per-task=12
#SBATCH -t 28-00:00:0

##SBATCH -J bdgphL_gIG_5_e-5_alpha8_P18_desi_dr1
##SBATCH -J bdgphL_gIG_5_e-5_alpha8_P18_desi_dr1_rv

### BDG gamma open
##SBATCH -J bdgphL_P18_bao_desi_dr1

##SBATCH -J ig_V4_P18_desi_dr1
##SBATCH -J ig_V0_P18_desi_dr1

##SBATCH -J dig_V4_P18_desi_dr1
##SBATCH -J dig_V0_P18_desi_dr1

### EMG
##SBATCH -J emg_P18_desi_dr1
##SBATCH -J emg_P18_desi_dr1_covlcdm
#SBATCH -J emg_cc_P18_desi_dr1

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

### BDG
#YAMLFILE=/gpfs/gpfs/gpfs_maestro/hpc/user/modified_gravity/angelo/BDG/cobaya/cobaya/mcmc_scripts/yaml/bdgphL_gIG_5e-5_alpha8_P18_bao_desi_dr1.yaml
#YAMLFILE=${YAMLFOLDER}bdgphL_gIG_5e-5_alpha8_P18_bao_desi_dr1_rv.yaml

### BDG con gamma aperto
#YAMLFILE=${YAMLFOLDER}bdgphL_P18_bao_desi_dr1.yaml

### IG
#YAMLFILE=/gpfs/gpfs/gpfs_maestro/hpc/user/modified_gravity/angelo/BDG/cobaya/cobaya/mcmc_scripts/yaml/ig_V4_P18_bao_desi_dr1.yaml
#YAMLFILE=/gpfs/gpfs/gpfs_maestro/hpc/user/modified_gravity/angelo/BDG/cobaya/cobaya/mcmc_scripts/yaml/ig_V0_P18_bao_desi_dr1.yaml

### DeltaIG
#YAMLFILE=/gpfs/gpfs/gpfs_maestro/hpc/user/modified_gravity/angelo/BDG/cobaya/cobaya/mcmc_scripts/yaml/dig_V4_P18_bao_desi_dr1.yaml
#YAMLFILE=/gpfs/gpfs/gpfs_maestro/hpc/user/modified_gravity/angelo/BDG/cobaya/cobaya/mcmc_scripts/yaml/dig_V0_P18_bao_desi_dr1.yaml

### EMG
#YAMLFILE=${YAMLFOLDER}emg_V4_P18_bao_desi_dr1.yaml
#YAMLFILE=${YAMLFOLDER}emg_V4_P18_bao_desi_dr1_cov1.yaml
YAMLFILE=${YAMLFOLDER}emg_cc_V4_P18_bao_desi_dr1.yaml

mpirun python mcmc_scripts/read_yaml_and_run_chain.py ${YAMLFILE}
