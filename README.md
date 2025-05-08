### Field Simulation for LArPix

This field simulation was developed for **LArPix**, a pixelated readout system for the **Liquid Argon Time Projection Chamber (LArTPC)**.

### Field Simulation Methodology

The field simulation is based on **Garfield++**, a toolkit for the simulation of particle detectors.  
Further details about Garfield++ can be found at: [Garfield++ Website](https://garfieldpp.web.cern.ch/garfieldpp/)

#### **Finite Element Method (FEM)**

The finite-element field maps were calculated using **Elmer** and **Gmsh**.  
Learn more at: [Garfield++ Elmer Examples](https://garfieldpp.web.cern.ch/garfieldpp/examples/elmer/)

For detailed instructions on generating finite-element field maps using the mesher **Gmsh** ([website](http://geuz.org/gmsh)) and the field solver **Elmer** ([website](http://www.csc.fi/english/pages/elmer)), refer to this documentation:  
[Garfield++ Elmer Documentation](https://garfieldpp.web.cern.ch/garfieldpp/examples/elmer/garfield_elmer_doc.pdf)

These instructions also explain how to use the field maps for electron transport simulations in Garfield++.

#### **Interactive Example**

An example implementation can be found in this interactive notebook:  
[Garfield FEM Notebook](https://colab.research.google.com/github/jerenner/garfieldfem/blob/master/garfield_FEM.ipynb)

---

### Steps to Build the Field Simulation

1. **Install Gmsh**  


2. **Construct Geometry**  
   - The LArPix geometry was created using CAD software.  
   - It is imported as a `.step` file into the `.geo` file format
