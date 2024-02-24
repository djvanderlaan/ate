

include<case-mod.scad>

// == Parameters for the screwholes for fixing the keyboard to the compute unit
case_screw_r      = 3.2/2; //M3
case_screw_pos    = [-0.94*plate_width/2, -0.66*plate_width/2, -0.33*plate_width/2,
  0*plate_width/2, 0.33*plate_width/2, 0.66*plate_width/2, 0.94*plate_width/2];
case_screw_nut    = (5.2+0.2+1)/2;





difference() {
  color("red") case();
 
  // holes to attach the keyboard
  for (i = case_screw_pos) {
    translate([i+plate_width/2, plate_length+20-0.01, -case_height/2+plate_thickness])
      rotate([90, 0, 0]) {
        cylinder(r = case_screw_r, h = 20);
        translate([0, 0, 20-3])
          cylinder(r = case_screw_nut, h = 3, $fn = 6);
        translate([-3, -7, 20])
          cube([6, 10, 4]);
     }
  } 
}
