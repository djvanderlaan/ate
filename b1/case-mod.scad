
$fn=100;
mar = 0.01;

// == Parameters of plate
plate_grid        = 19.05;
plate_thickness   = 1.45;
plate_nwidth      = 12;
plate_nlength     = 5;
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
case_height       = 15.74;
case_bevel_top    = 3;
case_bevel_corner = 5;
case_bevel_bottom = 3;
case_bevel_inner  = 2;
case_usb_inset    = 20;

// == Parameters for raster
raster_height     = 5-1.5;
raster_width      = 1.5;
raster_skip       = 6;

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
bottom_mar        = 0.3;
bottom_raster     = 2;

// == Parameters for controler and USB port
controller_row     = plate_nwidth-1;
controller_depth   = 2.5;
controller_base    = 0.9;
controller_wall    = 2;
controller_width   = micropro_width()+1;
controller_height  = controller_base+0.5;
controller_support = 0.8;
controller_length  = 31.6;

use<scad/beveled_cube.scad>
use<scad/micropro_example.scad>
use<scad/rounded_cube.scad>

case = true;
bottom = false;

// how far does switch stick out at the back of the plate:
// https://switches-sensors.zf.com/wp-content/uploads/2012/07/Keymodule_MX_EN.pdf
// 5 mm thickness swith
// 3.3 mm length pins
// -1.5 thickness plate
// 5 + 3.3 - 1.5


module case() {


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
  // cut-out for bottom
  translate([0, 0, -mar])
    beveled_cube([plate_width+2*bottom_edge, plate_length+2*bottom_edge, bottom_inset+mar],
      [0, 0], case_bevel_inner, [0,0]);
  // cutout for USB-port 
  translate(-[(plate_width)/2, plate_length/2, -case_height+plate_thickness])
  translate([controller_row*plate_grid, plate_length+controller_depth+controller_wall, 
      -usb_hole_height()-guide_height-controller_base])
    translate([0, 0, 3.5/2])
    usb_hole(20, 10, 20);
  // cutout for usb port on controller
  translate(-[(plate_width)/2, plate_length/2, -case_height+plate_thickness])
  translate([controller_row*plate_grid-usb_width()/2, plate_length+controller_depth-case_pad, 
      -case_height-guide_height])
    cube([usb_width(), case_pad, case_height]);
  // cutout for the board of the controller
  // we leave a few part with width controller_support; otherwise the printer is 
  // unable to print the top of the hole as this is then not supported
  conthw = (controller_width-usb_width())/2;
  translate(-[(plate_width)/2, plate_length/2, -case_height+plate_thickness])
  translate([controller_row*plate_grid-controller_width/2, plate_length-2*mar, -guide_height])
    mirror([0, 0, 1])
    cube([conthw-controller_support, controller_depth+mar, controller_height]);
  translate(-[(plate_width)/2, plate_length/2, -case_height+plate_thickness])
  translate([controller_row*plate_grid-conthw+controller_width/2+controller_support, 
        plate_length-2*mar, -guide_height])
    mirror([0, 0, 1])
    cube([conthw-controller_support, controller_depth+mar, controller_height]);
  // holes for the screws to fix the bottom plate
  translate([(plate_width/2+bottom_edge/2-1), (plate_length/2+bottom_edge/2-1), bottom_inset-mar])
    cylinder(r = 3.2/2, h = 8);
  translate([(plate_width/2+bottom_edge/2-1), -(plate_length/2+bottom_edge/2-1), bottom_inset-mar])
    cylinder(r = 3.2/2, h = 8);
  translate([-(plate_width/2+bottom_edge/2-1), (plate_length/2+bottom_edge/2-1), bottom_inset-mar])
    cylinder(r = 3.2/2, h = 8);
  translate([-(plate_width/2+bottom_edge/2-1), -(plate_length/2+bottom_edge/2-1), bottom_inset-mar])
    cylinder(r = 3.2/2, h = 8);
}


// Inset for USB-port
// at the bottom below the usb port the rim in the case for the bottom plate
difference() {
  translate([controller_row*plate_grid, plate_length+bottom_edge+mar, -case_height+plate_thickness])
  mirror([0, 1, 0])
  union(){
    //cube([case_usb_inset, bottom_edge-controler_depth+mar, bottom_inset+mar]);
    translate([-mar, 0, 0])
      bevels([case_usb_inset/2+mar, bottom_edge-controller_depth+mar, bottom_inset+mar], 
        0, bottom_edge- controller_depth+mar);
    mirror([1, 0, 0]) 
      bevels([case_usb_inset/2, bottom_edge-controller_depth+mar, bottom_inset+mar], 
        0, bottom_edge-controller_depth+mar);
  }
  // cutout for USB
  translate([controller_row*plate_grid, plate_length+controller_depth+controller_wall, 
      -usb_hole_height()-guide_height-controller_base])
    translate([0, 0, 3.5/2])
      usb_hole(20, 10, 20);
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

// === STOPPER FOR CONTROLER
translate([controller_row*plate_grid, plate_length-guide_width-controller_length, 
    -raster_height+mar])
  mirror([0, 0, 1])
  tapered_cube(guide_width, 7, guide_height-raster_height+controller_depth, guide_width);
translate([controller_row*plate_grid-guide_width/2, plate_length-5-controller_length, 
    -guide_height])
  mirror([0, 0, 0])
  cube([guide_width, 5, guide_width]);



} //end case

//// === BOTTOM
//if (bottom) {
//  
//  translate([(plate_width)/2, plate_length/2, -case_height+plate_thickness])
//  color("pink")
//  difference() {
//    // bottom
//    #translate([0, 0, 0])
//      beveled_cube([plate_width+2*bottom_edge-2*bottom_mar, plate_length+2*bottom_edge-2*bottom_mar, bottom_thickness],
//        [0, 0], case_bevel_inner, [0,0]);
//    // Inset for USB-port
//    translate([controller_row*plate_grid-plate_width/2, plate_length/2+bottom_edge+mar-bottom_mar, -mar])
//      mirror([0, 1, 0])
//      union(){
//        //cube([case_usb_inset, bottom_edge-controler_depth+mar, bottom_inset+mar]);
//        translate([-mar, 0, 0])
//          bevels([(case_usb_inset+bottom_mar)/2+mar, bottom_edge-controller_depth+mar, bottom_inset+2*mar], 
//            0, bottom_edge- controller_depth+mar);
//        mirror([1, 0, 0]) 
//          bevels([(case_usb_inset+bottom_mar)/2, bottom_edge-controller_depth+mar, bottom_inset+2*mar], 
//            0, bottom_edge-controller_depth+mar);
//      }
//    // holes for the screws to fix the bottom plate
//    translate([+(plate_width/2+bottom_edge/2-1), +(plate_length/2+bottom_edge/2-1), +0.4]) 
//      mirror([0, 0, 1]) screw_hole(r1 = 2/2, r2 = 4/2);
//    translate([-(plate_width/2+bottom_edge/2-1), +(plate_length/2+bottom_edge/2-1), +0.4]) 
//      mirror([0, 0, 1]) screw_hole(r1 = 2/2, r2 = 4/2);
//    translate([+(plate_width/2+bottom_edge/2-1), -(plate_length/2+bottom_edge/2-1), +0.4]) 
//      mirror([0, 0, 1]) screw_hole(r1 = 2/2, r2 = 4/2);
//    translate([-(plate_width/2+bottom_edge/2-1), -(plate_length/2+bottom_edge/2-1), +0.4]) 
//      mirror([0, 0, 1]) screw_hole(r1 = 2/2, r2 = 4/2);  
//  }
//
//  // Raster in x/width direction
//  for (i = [1:(plate_nlength-2)]) {
//    translate([+bottom_mar, i*plate_grid-raster_width/2, -case_height+plate_thickness+bottom_raster-mar])
//      cube([plate_width-2*bottom_mar, raster_width, bottom_raster+mar]);
//  }
//  // last row until controller
//  translate([+bottom_mar, (plate_nlength-1)*plate_grid-raster_width/2, 
//      -case_height+plate_thickness+bottom_raster-mar])
//    cube([plate_width-2*bottom_mar-(plate_nwidth-controller_row+1)*plate_grid, 
//      raster_width, bottom_raster+mar]);
//  
//  // Raster in y/length direction
//  for (i = [1:(plate_nwidth-1)]) {
//    if (i != controller_row) {
//      translate([i*plate_grid-raster_width/2, +bottom_mar, -case_height+plate_thickness+bottom_raster-mar])
//        cube([raster_width, plate_length-2*bottom_mar, bottom_raster+mar]);
//    } else {
//      translate([i*plate_grid-raster_width/2, +bottom_mar, -case_height+plate_thickness+bottom_raster-mar])
//        cube([raster_width, plate_length-2*bottom_mar-2*plate_grid, bottom_raster+mar]);
//    }
//  }
//} // end bottom








module usb_hole(length1, length2, height1 = 8/2, height2 = 8/2, width = 13, bevel = 2) {
  translate([0, 0, (height2-height1)/2])
  rotate([-90, 0, 0])
  beveled_cube([width, height1+height2, length2], [0, 0], bevel, [0, 0]);
  rotate([90, 0, 0]) 
  rounded_cube([9.5, 3.5, length1], 1.75); 
}
function usb_width() = 9.5;
function usb_hole_height() = 3.5;
function usb_hole_width()  = 13;


module screw_hole(r1, r2, l1=20, l2=20, mar = 0.01) {
  dh = abs(r2-r1);
  translate([0, 0, -l1-dh+mar])
    cylinder(r = r1, h = l1);
  translate([0, 0, -dh])
    cylinder(r1 = r1, r2 = r2, h = dh);
  translate([0, 0, -mar])
    cylinder(r = r2, h = l2);
}


module tapered_cube(base, top, height, depth) {
  h1 = (top-base)/2;
  union() {
    linear_extrude(h1, scale = [top/base,1]) square([base/2,depth]);
    mirror([1, 0, 0]) linear_extrude(h1, scale = [top/base,1]) square([base/2,depth]);
    translate([-top/2, 0, h1])
    cube([top, depth, height-h1]);
  }
}


//// usb hole
//  translate([grid, nlength*grid-1, -cross_height-3.5/2-bthick])
//    rotate([-90, 0, 0])
//    rounded_cube([busb+0.5, 3.5, wall+2], 1.75);  
//  // slot for plate
//  translate([grid-bwidth/2, nlength*grid-1, -cross_height-bthick-0])
//    cube([bwidth, wall, bthick+0]);
//




//translate([controller_row*plate_grid, plate_length-micropro_length()+2.5, -guide_height])
//mirror([0, 0, 1])
//micropro_example();

//translate([0, 0, -case_height-0.1])
//color("green")
//cylinder(r = 3.2/2, h = 4.5);





