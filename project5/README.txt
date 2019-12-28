The data file contains two variables:
    - sinogram: a Nviews x Nrays matrix containing the measured X-ray CT data,
        where Nviews is 540 and Nrays is 512
    - imgref: a Nx x Nx reference image, where Nx is 256 
If you are feeling ambitious, you can try to reconstruct a 512 x 512 image, but
more likely you will want (for computational reasons) to reconstruct a 
256 x 256 image. Some fine features will be lost, however, in the 256 x 256 
image. You may further find it useful to reduce the number of rays to 256 as
    sinogram256rays = sinogram(:,1:2:end);
The number of views can similarly be undersampled as
    sinogram270views = sinogram(1:2:end,:);
Do not wait till the last minute for this project. Even when undersampled, you
may find the image reconstruction times to be long, especially if you use your
laptops to reconstruct.

The forward model does not exactly match the true measurement conditions. This
is inevitable, at least to some degree. Keep this source of model error in mind
when designing your optimization problem and implementation. This source of 
error is in addition to the presence of noise.

The two main functions you will need to call are:
    - forward:  computes an estimated sinogram given an input image
    - backward: computes the adjoint of the forward operator
The other functions can likely be ignored.
