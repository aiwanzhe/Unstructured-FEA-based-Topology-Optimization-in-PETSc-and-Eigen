# Unstructured-FEA-based-Topology-Optimization-in-PETSc-and-Eigen （UF-Topt）
The code is a parallel 3D topology optimization framework on PETSc based on unstructured meshes.
The code default supports the diagonally numbered eight-node hexahedral element, and extends to four-node tetrahedral element is provided in folder "tet4".

The code had been tested on:
-Linux system: deepin 20.9

The code requires:
-PETSc (tested version: 3.16.4)
-LAPACK/BLAS
-MPICH
-Eigen (tested version: 3.4.0)

Four following steps for installation :

1. Modify the makefile such that PETSC_DIR and PETSC_ARCH points to the local PETSc installation on your system.

2. Move the mesh files to the path specified in "InputMeshData.cpp".

3. Compile the code with "make opt".

4. Run the code with "mpiexec -np 8 ./opt".

5. type paraview output_final to visualize with Paraview.

The default example is cantilever beam (392,000 elements) with minimun compliance objective.

The Code of MMA.h\cpp
The code of MMA.h\cpp is from TopOpt_in_PETSc code with the authorization from the author, Mr. Niels Aage. The original code can be found here: https://github.com/topopt/TopOpt_in_PETSc and the Copyright still reserved by the original author.
(N. Aage, E. Andreassen, B. S. Lazarov (2014), Topology optimization using PETSc: An easy-to-use, fully parallel, open source topology optimization framework, Structural and Multidisciplinary Optimization, DOI 10.1007/s00158-014-1157-0)

Acknowledgment:
The authors would like to thank Niels Aage for providing the C++ implementation of his 
Method of Moving Asymptotes in parallel which was used in this work.
