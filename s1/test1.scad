
use<scad/beveled_cube.scad>

$fn=100;


// Screen
// Orientation: flat cable to right
sdim = [128, 71, 1.55];
// Space to leave for flat cable
scable = sdim[1] - 2*9;
// margin around screen
smar = 1;
// Margin around display
// left-right (=flat cable)
smarx = [2, 6];
// top-bottom
smary = [2, 2];

// Box
bdim   = [sdim[0] + 40, sdim[1]+20, 25];
// thickness of bezel around screen
bbezel = 2;
// wall thickness
bwall = 3;


box = true;
screenback = true;
back = true;






// === BOX

if (box) {
difference() {
  translate([-bdim[0]/2, -bdim[1]/2, -bbezel])
    cube(bdim);
  // cutout for display
  translate([-display_dim[0]/2, -display_dim[1]/2, -bbezel-1])
    cube([display_dim[0], display_dim[1], bbezel+2]);
  // cutout for screen
  translate([-sdim[0]/2+(smarx[1]-smarx[0])/2-smar, -sdim[1]/2+(smary[1]-smary[0])/2-smar, 0])
    cube([sdim[0]+smar*2, sdim[1]+smar*2, sdim[2]+2]); 
  // cutout for inside box
  translate([-bdim[0]/2+bwall, -bdim[1]/2-bwall/2, sdim[2]])
  cube([bdim[0]-2*bwall, bdim[1]-0*2*bwall+2, bdim[2]]);
  // cutout for flatcable
  translate([(smarx[1]-smarx[0])/2+1, -scable/2, -1])
    cube([(sdim[0]+smar*2)/2, scable, sdim[2]+2]);
  // side slots 
  translate([-bdim[0]/2, +bolt_y_offset, 5]) side_slot(bdim[2]-10);
  translate([-bdim[0]/2, -bolt_y_offset, 5]) side_slot(bdim[2]-10);
  translate([+bdim[0]/2, +bolt_y_offset, 5]) mirror([1, 0, 0]) side_slot(bdim[2]-10);
  translate([+bdim[0]/2, -bolt_y_offset, 5]) mirror([1, 0, 0]) side_slot(bdim[2]-10);
}
}

// === SCREEN BACK
sbdim = [bdim[0]-2*bwall-2, bdim[1]-0*2*bwall-2+2, 2];


if (screenback) {
difference() {
  translate([-sbdim[0]/2, -sbdim[1]/2, sdim[2]])
    cube(sbdim);
  // hole for flat calbe
  translate([(smarx[1]-smarx[0])/2+sdim[0]/2-10, -scable/2, sdim[2]-1])
    cube([10+2, scable, 4]);
  translate([(smarx[1]-smarx[0])/2+sdim[0]/2-10, -scable, sdim[2]-1])
    cube([4, scable, 4]);
}

// screw holders for top
translate([0*(sbdim[0]/2-7.5), sbdim[1]/2-7.5, sdim[2]-0.001]) difference() {
  cube([7.5, 7.5, bdim[2]-sdim[2]-2-2]);
  translate([7.5/2, 7.5/2, 0])
    cylinder(h = bdim[2], r = bolt_inset_r);
}
translate([0*(sbdim[0]/2-7.5), -sbdim[1]/2, sdim[2]-0.001]) difference() {
  cube([7.5, 7.5, bdim[2]-sdim[2]-2-2]);
  translate([7.5/2, 7.5/2, 0])
    cylinder(h = bdim[2], r = bolt_inset_r);
}
translate([-sbdim[0]/2, sbdim[1]/2-7.5, sdim[2]-0.001]) difference() {
  cube([7.5, 7.5, bdim[2]-sdim[2]-2-2]);
  translate([7.5/2, 7.5/2, 0])
    cylinder(h = bdim[2], r = bolt_inset_r);
}
translate([-sbdim[0]/2, -sbdim[1]/2, sdim[2]-0.001]) difference() {
  cube([7.5, 7.5, bdim[2]-sdim[2]-2-2]);
  translate([7.5/2, 7.5/2, 0])
    cylinder(h = bdim[2], r = bolt_inset_r);
}

// screw holders to screw to box
translate([-sbdim[0]/2, 0, sbdim[2]+sdim[2]-0.01])
difference() {
  beveled_cube([13, 30, 10], [2, 6], 0, [0, 0]);
  translate([-10, -16, -1])
    cube([10, 32, 12]);
  translate([-1, bolt_y_offset, 5])
    rotate([0, 90, 0])
    cylinder(r = bolt_inset_r, h = 100);
  translate([-1, -bolt_y_offset, 5])
    rotate([0, 90, 0])
    cylinder(r = bolt_inset_r, h = 100); 
}
translate([sbdim[0]/2, 0, sbdim[2]+sdim[2]-0.01])
mirror([1, 0, 0])
difference() {
  beveled_cube([13, 30, 10], [2, 6], 0, [0, 0]);
  translate([-10, -16, -1])
    cube([10, 32, 12]);
  translate([-1, bolt_y_offset, 5])
    rotate([0, 90, 0])
    cylinder(r = bolt_inset_r, h = 100);
  translate([-1, -bolt_y_offset, 5])
    rotate([0, 90, 0])
    cylinder(r = bolt_inset_r, h = 100); 
}
}

// === BACK PLATE
backholes = [ [3, 62/2], [3, -62/2], [34.5, 0] ];

if (back) {
translate([0, 0, bdim[2]-bbezel-sbdim[2]]) {
difference() {
  translate([-sbdim[0]/2, -sbdim[1]/2, 0]) //bdim[2]-bbezel-sbdim[2]])
    cube(sbdim);
  translate([-sbdim[0]/2+7.5/2, -sbdim[1]/2+7.5/2, -0.01]) 
    cylinder(r = 3.2/2, h = 10);
  translate([-sbdim[0]/2+7.5/2, +sbdim[1]/2-7.5/2, -0.01]) 
    cylinder(r = 3.2/2, h = 10);
  translate([0+7.5/2, -sbdim[1]/2+7.5/2, -0.001]) 
    cylinder(r = 3.2/2, h = 10);
  translate([-0+7.5/2, +sbdim[1]/2-7.5/2, -0.001]) 
    cylinder(r = 3.2/2, h = 10);


translate([38+backholes[0][0], backholes[0][1], -0.01]) 
    cylinder(r = 3.2/2, h = 10);
translate([38+backholes[1][0], backholes[1][1], -0.01]) 
    cylinder(r = 3.2/2, h = 10);
translate([38+backholes[2][0], backholes[2][1], -0.01]) 
    cylinder(r = 3.2/2, h = 10);
}

}

}


//// === SCREEN
display_dim = [sdim[0]-smarx[0]-smarx[1], sdim[1]-smary[0]-smary[1], sdim[2]/2];
//translate([-sdim[0]/2+(smarx[1]-smarx[0])/2, -sdim[1]/2+(smary[1]-smary[0])/2, 0])
//  cube(sdim); 
//// the display itself
//color("red")
//  translate([-display_dim[0]/2, -display_dim[1]/2, -0.001])
//  cube(display_dim);







bolt_y_offset = 10;
bolt_inset_r = 2;

module side_slot(h) {
  dim = [155, 80, 100];
  translate([0, 0, h/2])
  rotate([0, 90, 0]) {
    translate([0, 0, -10+1.5])
      beveled_cube([h, 6, 10], [0, 0], 1, [0, 0]);
      beveled_cube([h-3, 3.2, 10], [0, 0], 1, [0, 0]);
  }
}

