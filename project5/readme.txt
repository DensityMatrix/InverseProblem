main_q1cgm.m is the program for X-ray CT image reconstruction using the conjugate gradient method.

Ref. JR Shewchuk, An introduction to the conjugate gradient method without the agonizing pain (1994).

The data file bme593_project_data.mat contains two variables:
sinogram: a Nviews x Nrays matrix containing the measured X-ray CT data, where Nviews is 540 and Nrays is 512
imgref: a Nx x Nx reference image, where Nx is 256 

The project contains the functions:
forward:  calculates an estimated sinogram given the radiodensity map.
CalC_integral: calculates the pixel value in the estimated sinogram for ray i at view j given the radiodensity map.
backward: calculates a radiodensity map based on the estimated sinogram.
CalC_bp: calculates a radiodensity map based on each ray in the estimated sinogram.
