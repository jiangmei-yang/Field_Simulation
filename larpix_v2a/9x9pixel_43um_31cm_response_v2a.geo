SetFactory("OpenCASCADE");
Merge "9x9pixel_4.434.step";
// Create the counters.
n_physv = 1; // physical volumes
n_physs = 1; // physical surfaces
n_pixel = 0; // pixels

Readout = 1;
// Pixel
p_w=3.5;
p_l=3.5;
//+
Physical Volume("Readout_Pixel", n_physv) = {Readout}; n_physv +=1;
s() = Abs(Boundary{Volume{Readout};});
Physical Surface(n_physs) = {s()}; n_physs += 1;
all_pixel_vol[n_pixel] = Readout; n_pixel += 1;

For i In {1:81}
	If (i != Readout)
		Physical Volume(n_physv) = {i}; n_physv += 1;
		s() = Abs(Boundary{Volume{i};});
		Physical Surface(n_physs) = {s()}; n_physs += 1;
		all_pixel_vol[n_pixel] = i; n_pixel += 1;
	EndIf
EndFor

// Drift Volume
box_h = 310;
box_l = 40;
box_w = 40;
vol_bound = newv; Box(vol_bound) = {-box_l/2,-box_w/2, 0,box_l,box_w,box_h};
vol_drift = newv; BooleanDifference(vol_drift) = {Volume{vol_bound};Delete;}{Volume{all_pixel_vol[]};};
drift_surface() = Abs(Boundary{Volume{vol_drift};});
Physical Surface(n_physs) = {drift_surface[2]}; n_physs += 1;// Top Plate
Physical Volume(n_physv) = {vol_drift}; n_physv += 1;

Mesh.MeshSizeExtendFromBoundary = 0;
Mesh.MeshSizeFromPoints = 0;
Mesh.MeshSizeFromCurvature = 0;

//+
Physical Volume("FR4", n_physv) = {82}; n_physv +=1;
//+
Field[1] = Box;
//+
Field[1].VIn = 0.5;
//+
Field[1].VOut = 5;
//+
Field[1].XMax = 40;
//+
Field[1].XMin = -40;
//+
Field[1].YMax = 40;
//+
Field[1].YMin = -40;
//+
Field[1].ZMax = 40;
//+
Background Field = 1;

Mesh.ScalingFactor=0.1;
