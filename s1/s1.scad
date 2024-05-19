
use<scad/beveled_cube.scad>

$fn=100;

dim = [155, 80, 100];
bevel_top  = [0, 0];
bevel_side  = 15;
bevel_bottom  = [0, 0];
wall = 3;
 

//difference() {
//  beveled_cube(dim, bevel_top, bevel_side, bevel_bottom);
//  translate([0, 0, -1])
//    beveled_cube(dim-[2*wall, 2*wall,-2], 
//      [0, 0], bevel_side-wall/sqrt(2), [0, 0]);
//}

inner_dim = [dim[0]- 2*wall-1, dim[1] - 2*wall-1];
inner_bevel = bevel_side-wall/sqrt(2);

lens_r = 25;
lens_thickn = 3;
inter_eye = 65;

difference() {
beveled_cube([inner_dim[0], inner_dim[1], lens_thickn+2], [0,0], inner_bevel, [0,0]);
translate([-inter_eye/2, 0, 2])
  cylinder(r = lens_r, h = lens_thickn+1);
translate([-inter_eye/2, 0, -1])
  cylinder(r = lens_r-2, h = 4);
translate([+inter_eye/2, 0, 2])
  cylinder(r = lens_r, h = lens_thickn+1);
translate([+inter_eye/2, 0, -1])
  cylinder(r = lens_r-2, h = 4);
}

bolt_y_offset = 10;
bolt_inset_r = 1.5;

!color("red") { 
difference() {
  beveled_cube([10, 30, 10], [2, 6], 0, [0, 0]);
  translate([-10, -16, -1])
    cube([10, 32, 12]);
  
}
translate([-1, bolt_y_offset, 5])
  rotate([0, 90, 0])
  cylinder(r = bolt_inset_r, h = 100);
translate([-1, -bolt_y_offset, 5])
  rotate([0, 90, 0])
  cylinder(r = bolt_inset_r, h = 100);
}