$fn=100;
mar = 0.01;

use<scad/beveled_cube.scad>
use<scad/rounded_cube.scad>

module ate_b1_negative() {
  mirror([1, 0, 0]) mirror([0, 1, 0]) mirror([0, 0, 1]) {
    ate_b1();
    // USB port
    translate([-5*19.05, -10, -7/2-1])
      rotate([-90, 0, 0])
      beveled_cube([13, 7, 20], [0, 0], 2, [0, 0]);
    //bolt holes
    for (i = ate_b1_screwpos()) {
      translate([i, 15, -ate_b1_height()/2])
        rotate([90, 0, 0])
      cylinder(r = 3.2/2, h = 20);
    }
  }
}


function ate_b1_screwpos() = [-0.94*12*19.05/2, 
  -0.66*12*19.05/2, -0.33*12*19.05/2,
   0*12*19.05/2,     0.33*12*19.05/2, 
   0.66*12*19.05/2,  0.94*12*19.05/2];

module ate_b1() {  
  // Setting copied from ate_b1 scad file
  // == Parameters of plate
  keyb_plate_grid        = 19.05;
  keyb_plate_nwidth      = 12;
  keyb_plate_nlength     = 5;
  keyb_plate_width       = keyb_plate_grid*keyb_plate_nwidth;
  keyb_plate_length      = keyb_plate_grid*keyb_plate_nlength;
  // == Parameters of outer case
  keyb_case_pad          = 2*10;
  keyb_case_width        = keyb_plate_width + keyb_case_pad;
  keyb_case_length       = keyb_plate_length + keyb_case_pad;
  keyb_case_height       = 15.74;
  keyb_case_bevel_top    = 3;
  keyb_case_bevel_corner = 5;
  keyb_case_bevel_bottom = 3;
  // outside of case
  translate([0,-keyb_case_length/2, -keyb_case_height]) 
    beveled_cube([keyb_case_width, keyb_case_length, keyb_case_height], 
        [keyb_case_bevel_top,keyb_case_bevel_top], keyb_case_bevel_corner, 
        [keyb_case_bevel_bottom, keyb_case_bevel_bottom]);
}

function ate_b1_height() = 15.74;
