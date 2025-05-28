## Field Simulation for LArPix

This field simulation was developed for **LArPix**, a pixelated readout system for the **Liquid Argon Time Projection Chamber (LArTPC)**.

The field simulation is based on **Garfield++**, a toolkit for the simulation of particle detectors.  
Further details about Garfield++ can be found at: [Garfield++ Website](https://garfieldpp.web.cern.ch/garfieldpp/)

### **Finite Element Method (FEM)**

The finite-element field maps were calculated using **Elmer** and **Gmsh**.  
Learn more at: [Garfield++ Elmer Examples](https://garfieldpp.web.cern.ch/garfieldpp/examples/elmer/)

For detailed instructions on generating finite-element field maps using the mesher **Gmsh** ([website](http://geuz.org/gmsh)) and the field solver **Elmer** ([website](http://www.csc.fi/english/pages/elmer)), refer to this documentation:  
[Garfield++ Elmer Documentation](https://garfieldpp.web.cern.ch/garfieldpp/examples/elmer/garfield_elmer_doc.pdf)

These instructions also explain how to use the field maps for electron transport simulations in Garfield++.

### **Interactive Example**

An example implementation can be found in this interactive notebook:  
[Garfield FEM Notebook](https://colab.research.google.com/github/jerenner/garfieldfem/blob/master/garfield_FEM.ipynb)

---

## Steps to Build the Field Simulation

1. ### **Install Softwares**
     - **Gmsh**: [https://gmsh.info](https://gmsh.info)  
       Used for defining our detector geometry and creating a finite element mesh.
     - **Elmer**: [http://www.elmerfem.org](http://www.elmerfem.org)  
       Used for solving for the electrostatic fields.
         - Installing Elmer on macOS can be tricky
         - The following method works for me (macOS Sequoia 15.4.1)
        ```
            brew install openblas
            
            # brew install freecad (run this if the freecad was not installed successfully in the last step)
            
            mkdir elmer
            
            cd elmer
            
            git clone https://github.com/ElmerCSC/elmerfem.git
            
            mkdir build
            
            cd build
            
            cmake -DWITH_MPI:BOOLEAN=FALSE -DCMAKE_INSTALL_PREFIX=$(pwd)/../install -DHOMEBREW_PREFIX=/opt/homebrew ../elmerfem
            
            # cmake -DWITH_MPI:BOOLEAN=FALSE -DCMAKE_INSTALL_PREFIX=$(pwd)/../install -DMACPORTS_PREFIX=/opt/local ../elmerfem (if you use MacPorts)
            
            make
            
            make install
        ```

   - **ROOT**: [https://root.cern.ch](https://root.cern.ch)  
       A prerequisite for Garfield++ (with Python enabled). 

   - **Garfield++**: [https://garfieldpp.web.cern.ch/garfieldpp](https://garfieldpp.web.cern.ch/garfieldpp)  
       Used for detector simulation.


2. ### **Construct the Geometry**  
   - The LArPix geometry was created using CAD software; it was imported as a `.step` file into the `.geo` file format; the detector (2x2 detector in this example) was build in the `.geo` directly
   - **Convert `.geo` to `.msh` file**
        - Run `gmsh <geometry_file>.geo -3 -order 2`

3. ### **Calculate the Fields**
   - **Convert `.msh` to Elmer mesh files**
        - Run `ElmerGird 14 2 <mesh_file>.msh`
        - This will create a directly containing `mesh.boundary; mesh.elements; mesh.header; mesh.nodes`
   - **Calculate Electric Field and Weighting Field**
        - Run `ElmerSolver <solver_input_file>.sif` (both <electric_field>.sif and <weighting_field.sif>) in the parent directory to the Elmer mesh files (The folder location is specified in the `.sif`);
        - This will create the calculated field files `.result`; the `.result` will be generated in the same folder as the Elmer mesh files.

4. ### **View fields and calculate the induced current**
   - LArPix field response simulation code can be found in the [larpix_v2b/field_response_simulation.ipynb](https://github.com/jiangmei-yang/Pixel_Field_Simulation/blob/b1d678b0be8fa3fe02d9d6f7fc9a61ff3d297701/larpix_v2b/field_response_simulation.ipynb)
   
  

