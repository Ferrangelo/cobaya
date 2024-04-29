# General python imports
import yaml
import numpy as np
import time 
import os, sys


with open('/gpfs/gpfs/gpfs_maestro/hpc/user/modified_gravity/angelo/BDG/cobaya/cobaya/mcmc_scripts/planck_2018.yaml') as f:
    info = yaml.safe_load(f)
# print(info)


from mpi4py import MPI

comm = MPI.COMM_WORLD
rank = comm.Get_rank()

print(f"rank {rank}")

from cobaya.run import run
from cobaya.log import LoggedError

success = False
try:
    upd_info, mcmc = run(info)
    success = True
except LoggedError as err:
    pass

# Did it work? (e.g. did not get stuck)
success = all(comm.allgather(success))

if not success and rank == 0:
    print("Sampling failed!")
else:
    print("Sampling done!")
