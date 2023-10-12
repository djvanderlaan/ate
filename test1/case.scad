
$fn=100;
mar = 0.01;

// == Parameters of plate
plate_grid      = 19.05;
plate_thickness = 1.45;
plate_nwidth    = 3;
plate_nlength   = 4;
plate_width     = plate_grid*plate_nwidth;
plate_length    = plate_grid*plate_nlength;

// == Parameters of outer case
case_pad          = 2*10;
case_width        = plate_width + case_pad;
case_length       = plate_length + case_pad;
case_height       = 15;
case_bevel_top    = 3;
case_bevel_corner = 5;
case_bevel_bottom = 3;
case_wall         = 4;

cross_height = 5+3.3-1.5+1;
cross_width = 1.5;
raster_height = 5-1.5;

wall = 2;
rwall = 4;
hwall = 5+3.3+1.5+6;



use<scad/beveled_cube.scad>


// how far does switch stick out at the back of the plate:
// https://switches-sensors.zf.com/wp-content/uploads/2012/07/Keymodule_MX_EN.pdf
// 5 mm thickness swith
// 3.3 mm length pins
// -1.5 thickness plate
// 5 + 3.3 - 1.5

color("red")
linear_extrude(plate_thickness)
  translate([-0.0947, -0.2578])
  import("sources/plate_base.dxf", convexity = 10);
  
 
translate([(plate_width)/2, plate_length/2, -case_height+plate_thickness])
difference() {
  // outside of case
  beveled_cube([case_width, case_length, case_height], 
      [case_bevel_top,case_bevel_top], case_bevel_corner, 
      [case_bevel_bottom, case_bevel_bottom]);
  // cut out central cube (where the plate is)
  translate([-plate_width/2+mar, -plate_length/2+mar, -1])
    cube([plate_width-2*mar, plate_length-2*mar, 20+2]);  
  if (case_wall > 0) {
    translate([0, 0, case_wall])
      beveled_cube([case_width-case_wall*2, case_length-case_wall*2, 
        case_height-plate_thickness-case_wall], [5,5], 1, [5,5]);  
  }
}



