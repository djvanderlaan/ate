
$fn=100;
mar = 0.01;

// == Parameters of plate
plate_grid        = 19.05;
plate_thickness   = 1.45;
plate_nwidth      = 3;
plate_nlength     = 4;
plate_width       = plate_grid*plate_nwidth;
plate_length      = plate_grid*plate_nlength;

// == Parameters for switches
// https://switches-sensors.zf.com/wp-content/uploads/2012/07/Keymodule_MX_EN.pdf
switch_depth      = 5;
switch_pinlength  = 3.3;
switch_stick_out  = switch_depth+switch_pinlength - plate_thickness;

// == Parameters of outer case
case_pad          = 2*10;
case_width        = plate_width + case_pad;
case_length       = plate_length + case_pad;
case_height       = 15;
case_bevel_top    = 3;
case_bevel_corner = 5;
case_bevel_bottom = 3;
case_bevel_inner  = 2;

// == Parameters for raster
raster_height     = 5-1.5;
raster_width      = 1.5;
raster_skip       = 1;

// == Parameters for guides
guide_width       = raster_width;
guide_height      = switch_stick_out + 1;
guide_left        = plate_grid*0.6;
guide_right       = plate_grid*0.1;
guide_top         = plate_grid*0.5;
guide_bottom      = plate_grid*0.15;

// == Parameters for bottom
bottom_thickness  = 2;
bottom_inset      = bottom_thickness;
bottom_edge       = 5;






use<scad/beveled_cube.scad>


// how far does switch stick out at the back of the plate:
// https://switches-sensors.zf.com/wp-content/uploads/2012/07/Keymodule_MX_EN.pdf
// 5 mm thickness swith
// 3.3 mm length pins
// -1.5 thickness plate
// 5 + 3.3 - 1.5


// === TOP PLATE
color("red")
linear_extrude(plate_thickness)
  translate([-0.0947, -0.2578])
  import("sources/plate_base.dxf", convexity = 10);
  
// === CASE
translate([(plate_width)/2, plate_length/2, -case_height+plate_thickness])
difference() {
  // outside of case
  beveled_cube([case_width, case_length, case_height], 
      [case_bevel_top,case_bevel_top], case_bevel_corner, 
      [case_bevel_bottom, case_bevel_bottom]);
  // cut out central cube (where the plate is)
  translate([0, 0, -1])
    beveled_cube([plate_width-2*mar, plate_length-2*mar, case_height+2],
      [0.1, 0.1], case_bevel_inner, [0.1,0.1]);  
  // TODO cutout for bottom
  translate([0, 0, -mar])
    beveled_cube([plate_width+2*bottom_edge, plate_length+2*bottom_edge, bottom_inset+mar],
      [0, 0], case_bevel_inner, [0,0]);
  // TODO cutout for USB-port and controler
}

// === RASTER
// Raster in x/width direction
for (i = [1:(plate_nlength-1)]) {
  translate([-mar, i*plate_grid-raster_width/2, -raster_height])
    cube([plate_width+2*mar, raster_width, raster_height+mar]);
}
// Raster in y/length direction
for (i = [1:(plate_nwidth-1)]) {
  if (i == raster_skip) {
    translate([i*plate_grid-raster_width/2, -mar+plate_grid, -raster_height])
      cube([raster_width, plate_length+2*mar-plate_grid, raster_height+mar]);
  } else {
    translate([i*plate_grid-raster_width/2, -mar, -raster_height])
      cube([raster_width, plate_length+2*mar, raster_height+mar]);
  }
}

// === GUIDES
// Guides in x/width direction
for (j = [1:(plate_nlength-1)]) for (i = [1:(plate_nwidth)]) {
  // Left part of guide
  translate([i*plate_grid-guide_left+mar, j*plate_grid-guide_width/2, -guide_height])
    cube([guide_left+mar, guide_width, guide_height+mar]);
  // Right part 
  translate([i*plate_grid-plate_grid-mar, j*plate_grid-guide_width/2, -guide_height])
    cube([guide_right+mar, guide_width, guide_height+mar]);
}
// Guides in y/length direction
for (j = [1:(plate_nlength)]) for (i = [1:(plate_nwidth-1)]) {
  if (j != 1 || i != raster_skip) {
    // Top part of guide
    translate([i*plate_grid-guide_width/2, j*plate_grid-guide_top+mar, -guide_height])
      cube([guide_width, guide_top+mar, guide_height+mar]);
    // Bottom part of guide
    translate([i*plate_grid-guide_width/2, (j-1)*plate_grid-mar, -guide_height])
      cube([guide_width, guide_bottom+mar, guide_height+mar]);
  }
}





