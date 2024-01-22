  
$fn=100;
mar = 0.01;


// == Parameters for LCD
// https://cdn.shopify.com/s/files/1/0174/1800/files/PIM372-drawing.png?v=1651156568
screen_width      = 174.00;
screen_length     = 136.00;
screen_thickness  = 2.5-0.1; //screen is 2.5 but this left to much movement -> -0.1
screen_bwidth     = 165.20;
screen_blength    = 124.70; 
screen_cablew     = 50;
screen_cablel     = 2;
// screen is not completely center in the panel at the top of the panel there is
// at bit more space; therefore the hole for the screen needs to move offset up
// first is left; second top
screen_offset     = [2.5,3];

// == Parameters of plate
plate_bevel       = 2;
plate_thickness   = plate_bevel+screen_thickness;
plate_width       = 19.05*12;
plate_length      = screen_length+20;
plate_screen_pad  = 1;

plate_screwmar     = 3.8;
plate_screwr1      = 3.2/2;
plate_screwr2      = plate_screwr1+1.3;
// Depth of the screwhole; 4 = minimum for threaded insert
plate_screwh       = 4+1;
// The amount de screw hole sticks out from the front plate
plate_screwh1      = plate_screwh - screen_thickness;
plate_screws       = [
  [-screen_width/4,                 screen_length/2+plate_screwmar],
  [ screen_width/4,                 screen_length/2+plate_screwmar],
  [ screen_width/2+plate_screwmar,  screen_length/2+plate_screwmar],
  [ screen_width/2+plate_screwmar,  screen_length/2+plate_screwmar],
  [ screen_width/2+plate_screwmar, 0],
  [ screen_width/2+plate_screwmar, -screen_length/2-plate_screwmar],
  [ screen_width/4,                -screen_length/2-plate_screwmar],
  [ 0,                             -screen_length/2-plate_screwmar],
  [-screen_width/4,                -screen_length/2-plate_screwmar],
  [-screen_width/2-plate_screwmar, -screen_length/2-plate_screwmar],
  [-screen_width/2-plate_screwmar, 0],
  [-screen_width/2-plate_screwmar, +screen_length/2+plate_screwmar],
];


// == Parameters for LCD driver
// https://cdn.shopify.com/s/files/1/0174/1800/files/8inchdriver-drawing.png?v=1652097750
driver_width      = 65.00;
driver_length     = 56.00;
driver_holewidth  = 58.00;
driver_holelength = 49.00;
// moved the screen 10mm up otherwise the hdmi port of the pi is exacly above the 
// power connector of the driver
driver_offset     = [screen_width/2-(61.00+3.5)-driver_holewidth/2, 
screen_length/2-(31.00+3.5)-driver_holelength/2+10];

echo(driver_offset);

// == Parameters for Raspberry Pi
pi_holewidth  = 49.00;
pi_holelength = 58.00;
// 20240101 moved the pi 38 mm down and 7 mm left this leaves more space
// for the usb ports and hdmi port of the pi; at the bottom enough space 
// for the usb port of the keayboard.
pi_offset  = [-screen_width/2 + 40.5-3 - pi_holewidth/2 -7, 
    screen_length/2 - 27.0 - pi_holelength/2 - 38];

// == Parameters for backplate
back_width        = plate_width-2;
back_length       = plate_length-2;
back_thickness    = 2;
back_nlength      = 3;
back_nwidth       = 4;

back_screwthickn  = 1.5;
back_screwr       = 2.3/2;
back_screwpad     = 0.1;

support_h         = 4+back_thickness;
// 20240101: the driver can be a bit lower; has flat back and this leaver more
// room from cables coming from the pi
support_h_driver  = support_h-2;
support_r1        = 4.5/2;
support_r2        = 7/2;
support_rscrew    = 2.7/2;
support_h1        = 3;


// == Parameters for the on/off button
// we will assume in the model that the height of the switch is lower than
// that of the front plate; e.q. that we don't need space in the backplate
// height excluding button
switch_height     = 3.5+0.5;
// button is square width = depth
switch_width      = 6.2+0.5;
switch_totheight  = 4.25;
switch_wirer      = 2/2;
switch_wirespace  = 2.54*2;
switch_rbutton    = 4.3/2;
// distance from top of bevel down
switch_top        = 10;

// == Parameters of outer case
case_pad          = 2*10;
case_width        = 250;
case_length       = plate_length+case_pad;
case_height       = 36;
case_bevel_top    = 3;
case_bevel_corner = 5;
case_bevel_bottom = 3;
case_bevel_inner  = 2;
case_screw_r      = 3.2/2; //M3
case_screw_pos    = [-0.94*plate_width/2, -0.66*plate_width/2, -0.33*plate_width/2,
  0*plate_width/2, 0.33*plate_width/2, 0.66*plate_width/2, 0.94*plate_width/2];

// == Parameters for charging USB port
//distance between screw holes
usb_hwidth        = 16;
usb_pos           = 70;
usb_width         = 26;
usb_front         = 2.7;
usb_length        = 8;


// == Parameters for bottom
bottom_thickness  = 2;
bottom_inset      = bottom_thickness;
bottom_edge       = 5;
bottom_mar        = 0.3;
bottom_raster     = 2;




screen = false;
frontplate = true;
backplate = false;


use<scad/beveled_cube.scad>
use<scad/rounded_cube.scad>


// ===========================================================================
// screen

if (screen) {
  translate([-screen_width/2, -screen_length/2, plate_bevel])
  color("darkgray") {
    cube([screen_width, screen_length, screen_thickness]);
    // cable
    translate([-screen_cablew/2+screen_width/2, screen_length, 0])
      cube([screen_cablew, 1, screen_thickness*2]);
  }
}

// ===========================================================================
// frontplate

if (frontplate) {
  // plate
  difference() {
    translate([-screen_offset[0], -1*screen_offset[1], 0])
      ccube([plate_width, plate_length, plate_thickness]);
    // hole for the screen in the front
    translate([-screen_offset[0], -screen_offset[1], -0.1])
      ccube([screen_bwidth, screen_blength, plate_thickness+0.2]);
    // hole for the panel itself
    translate([0, 0, plate_bevel])
      ccube([screen_width+2*plate_screen_pad, 
        screen_length+2*plate_screen_pad, plate_thickness]);
    // hole for the cable at the top of the panel
    translate([-screen_cablew/2, screen_length/2+plate_screen_pad, 
        plate_bevel])
      cube([screen_cablew, screen_cablel, plate_thickness]); 
    
     // screw holes on plate
    for (i = [1:len(plate_screws)]) {
      translate([plate_screws[i-1][0], plate_screws[i-1][1], plate_bevel])
        cylinder(r = plate_screwr1, h = plate_screwh+mar);
    }
    // hole for on/off switch
    translate([-screen_bwidth/2-(plate_width-screen_bwidth)/4, 
      screen_blength/2-switch_width-switch_top, 
      plate_thickness-switch_height]) {
        translate([-switch_width/2, -switch_width/2, +mar])
          cube([switch_width, switch_width, switch_height]);
        translate([0, 0, -plate_thickness+switch_height-1])
          cylinder(r = switch_rbutton, h = plate_thickness+2);
    }
  } 
  // screw holes on plate
  for (i = [1:len(plate_screws)]) {
    difference() {
      translate([plate_screws[i-1][0], plate_screws[i-1][1], plate_bevel])
        cylinder(r = plate_screwr2, h = plate_screwh);
      translate([plate_screws[i-1][0], plate_screws[i-1][1], plate_bevel])
        cylinder(r = plate_screwr1, h = plate_screwh+mar);
    }
  }
}



// ===========================================================================
// outer case


color("green")
translate([-screen_offset[0], -screen_offset[1], 0]) {
  difference(){
    beveled_cube([case_width, case_length, case_height], 
        [case_bevel_top,case_bevel_top], case_bevel_corner, 
        [case_bevel_bottom, case_bevel_bottom]);
    // cut out central cube (where the plate is)
    translate([0, 0, -1])
      beveled_cube([plate_width-2*mar, plate_length-2*mar, case_height+2],
        [0.1, 0.1], case_bevel_inner, [0.1,0.1]);  
    // cutout for keyboard
    translate([0, -case_length/2+6, case_height])
      ate_b1();
    // cutout for usb for keyboard
    translate([-5*19.05, -case_length/2-1, case_height-7/2-1])
      rotate([-90, 0, 0])
      beveled_cube([13, 7, 20], [0, 0], 2, [0, 0]);
    // cut-out for bottom
    translate([0, 0, case_height-bottom_inset+mar])
    difference() {
      beveled_cube([plate_width+2*bottom_edge, plate_length+2*bottom_edge, bottom_inset+mar],
        [0, 0], case_bevel_inner, [0,0]);
      translate([-5*19.06, -plate_length/2-bottom_edge, 0]) {
        translate([-mar, -mar, -2*mar])
          bevels([7+bottom_edge+mar, bottom_edge+mar, bottom_inset+6*mar], 0, bottom_edge);
        mirror([1,0,0])
          translate([-mar, -mar, -2*mar])
          bevels([7+bottom_edge+mar, bottom_edge+mar, bottom_inset+6*mar], 0, bottom_edge);
      }
    }
    // holes for the screws to fix the bottom plate
    translate([(plate_width/2+bottom_edge/2-1), (plate_length/2+bottom_edge/2-1), case_height-bottom_inset-8+mar])
      cylinder(r = 3.2/2, h = 8);
    translate([(plate_width/2+bottom_edge/2-1), -(plate_length/2+bottom_edge/2-1), case_height-bottom_inset-8+mar])
      cylinder(r = 3.2/2, h = 8);
    translate([-(plate_width/2+bottom_edge/2-1), (plate_length/2+bottom_edge/2-1), case_height-bottom_inset-8+mar])
      cylinder(r = 3.2/2, h = 8);
    translate([-(plate_width/2+bottom_edge/2-1), -(plate_length/2+bottom_edge/2-1), case_height-bottom_inset-8+mar])
      cylinder(r = 3.2/2, h = 8);
    // holes to attach the keyboard
    for (i = case_screw_pos) {
      translate([i, -plate_length/2+1, case_height-ate_b1_height()/2])
        rotate([90, 0, 0])
      cylinder(r = case_screw_r, h = 20);
    }
    // hole for usb port
    translate([usb_pos, plate_length/2+bottom_edge+2, case_height/2])
      usb_hole(20, 20, height1=5, height2 = 5, width=15);
    translate([usb_pos-usb_width/2, plate_length/2-mar, plate_thickness])
      cube([usb_width, bottom_edge+mar, case_height]);
    
  }
}


// For attaching the USB power supply connector
translate([-screen_offset[0], -screen_offset[1], 0])
difference() {
  translate([usb_pos-usb_width/2, plate_length/2-usb_length+bottom_edge, plate_thickness-mar])
    cube([usb_width, usb_length+mar, case_height/2 - usb_hole_height()/2 - plate_thickness-1.6]);
  translate([usb_pos-usb_hwidth/2, plate_length/2+bottom_edge-usb_front, 
      case_height/2 - usb_hole_height()/2 -1.6 - 8 + mar])
    cylinder(r = 3.2/2, h = 8);
  translate([usb_pos+usb_hwidth/2, plate_length/2+bottom_edge-usb_front, 
      case_height/2 - usb_hole_height()/2 -1.6 - 8 + mar])
  cylinder(r = 3.2/2, h = 8);
}


//// Inset for USB-port
//// at the bottom below the usb port the rim in the case for the bottom plate
//difference() {
//  translate([5*19.05, plate_length+bottom_edge+mar, -case_height+plate_thickness])
//  mirror([0, 1, 0])
//  union(){
//    //cube([case_usb_inset, bottom_edge-controler_depth+mar, bottom_inset+mar]);
//    translate([-mar, 0, 0])
//      bevels([case_usb_inset/2+mar, bottom_edge-controller_depth+mar, bottom_inset+mar], 
//        0, bottom_edge- controller_depth+mar);
//    mirror([1, 0, 0]) 
//      bevels([case_usb_inset/2, bottom_edge-controller_depth+mar, bottom_inset+mar], 
//        0, bottom_edge-controller_depth+mar);
//  }
//  // cutout for USB
//  translate([controller_row*plate_grid, plate_length+controller_depth+controller_wall, 
//      -usb_hole_height()-guide_height-controller_base])
//    translate([0, 0, 3.5/2])
//      usb_hole(20, 10, 20);
//}
//
//






// ===========================================================================
// backplate

if (backplate) {

  color("red") 
  translate([0, 0, plate_thickness]) difference() {
    union() {
      translate([-screen_offset[0], -screen_offset[1], 0])
        ccube([back_width, back_length, back_thickness]);

      // lcd driver
      translate([driver_offset[0], driver_offset[1], 0]) {
        translate([ driver_holewidth/2,  driver_holelength/2, 0]) 
          cylinder(r = support_r2, h = support_h_driver);
        translate([ driver_holewidth/2, -driver_holelength/2, 0])
          cylinder(r = support_r2, h = support_h_driver);
        translate([-driver_holewidth/2,  driver_holelength/2, 0])
          cylinder(r = support_r2, h = support_h_driver);
        translate([-driver_holewidth/2, -driver_holelength/2, 0])
          cylinder(r = support_r2, h = support_h_driver);
        // wide rim for lcd driver
        translate([ driver_holewidth/2,  driver_holelength/2, 0]) 
          cylinder(r = support_r2+2, h = support_h_driver-0);
        translate([ driver_holewidth/2, -driver_holelength/2, 0])
          cylinder(r = support_r2+2, h = support_h_driver-0);
        translate([-driver_holewidth/2,  driver_holelength/2, 0])
          cylinder(r = support_r2+2, h = support_h_driver-0);
        translate([-driver_holewidth/2, -driver_holelength/2, 0])
          cylinder(r = support_r2+2, h = support_h_driver-0);
      }
      // raspberry pi
      translate([pi_offset[0], pi_offset[1], 0]) {
        translate([ pi_holewidth/2,  pi_holelength/2, 0])
          cylinder(r = support_r2, h = support_h);
        translate([ pi_holewidth/2, -pi_holelength/2, 0])
          cylinder(r = support_r2, h = support_h);
        translate([-pi_holewidth/2,  pi_holelength/2, 0])
          cylinder(r = support_r2, h = support_h);
        translate([-pi_holewidth/2, -pi_holelength/2, 0])
          cylinder(r = support_r2, h = support_h);
        // wide rim for pi
        translate([ pi_holewidth/2,  pi_holelength/2, 0])
          cylinder(r = support_r2+2, h = support_h-2);
        translate([ pi_holewidth/2, -pi_holelength/2, 0])
          cylinder(r = support_r2+2, h = support_h-2);
        translate([-pi_holewidth/2,  pi_holelength/2, 0])
          cylinder(r = support_r2+2, h = support_h-2);
        translate([-pi_holewidth/2, -pi_holelength/2, 0])
          cylinder(r = support_r2+2, h = support_h-2);
      }
      // screw holes on plate
      for (i = [1:len(plate_screws)]) {
        translate([plate_screws[i-1][0], plate_screws[i-1][1], 0])
          cylinder(r = plate_screwr2+back_screwthickn, h = plate_screwh1+back_screwthickn);
      }
    }
    
    // The stuff below will be removed
    union() {
      // lcd driver
      translate([driver_offset[0], driver_offset[1], 0]) {
        // hole for screwhead
        translate([ driver_holewidth/2,  driver_holelength/2, -mar]) 
          cylinder(r = support_r1, h = support_h1);
        translate([ driver_holewidth/2, -driver_holelength/2, -mar])
          cylinder(r = support_r1, h = support_h1);
        translate([-driver_holewidth/2,  driver_holelength/2, -mar])
          cylinder(r = support_r1, h = support_h1);
        translate([-driver_holewidth/2, -driver_holelength/2, -mar])
          cylinder(r = support_r1, h = support_h1);
        // hole for screw
        translate([ driver_holewidth/2,  driver_holelength/2, -mar]) 
          cylinder(r = support_rscrew, h = support_h+2*mar);
        translate([ driver_holewidth/2, -driver_holelength/2, -mar])
          cylinder(r = support_rscrew, h = support_h+2*mar);
        translate([-driver_holewidth/2,  driver_holelength/2, -mar])
          cylinder(r = support_rscrew, h = support_h+2*mar);
        translate([-driver_holewidth/2, -driver_holelength/2, -mar])
          cylinder(r = support_rscrew, h = support_h+2*mar);
      }
      // raspberry pi
      translate([pi_offset[0], pi_offset[1], 0]) {
        // hole for screwhead
        translate([ pi_holewidth/2,  pi_holelength/2, -mar]) 
          cylinder(r = support_r1, h = support_h1);
        translate([ pi_holewidth/2, -pi_holelength/2, -mar])
          cylinder(r = support_r1, h = support_h1);
        translate([-pi_holewidth/2,  pi_holelength/2, -mar])
          cylinder(r = support_r1, h = support_h1);
        translate([-pi_holewidth/2, -pi_holelength/2, -mar])
          cylinder(r = support_r1, h = support_h1);
        // hole for screw
        translate([ pi_holewidth/2,  pi_holelength/2, -mar]) 
          cylinder(r = support_rscrew, h = support_h+2*mar);
        translate([ pi_holewidth/2, -pi_holelength/2, -mar])
          cylinder(r = support_rscrew, h = support_h+2*mar);
        translate([-pi_holewidth/2,  pi_holelength/2, -mar])
          cylinder(r = support_rscrew, h = support_h+2*mar);
        translate([-pi_holewidth/2, -pi_holelength/2, -mar])
          cylinder(r = support_rscrew, h = support_h+2*mar);
      }
      // screw holes on plate
      for (i = [1:len(plate_screws)]) {
        translate([plate_screws[i-1][0], plate_screws[i-1][1], +mar])
          cylinder(r = back_screwr, h = plate_screwh1+back_screwthickn);
        translate([plate_screws[i-1][0], plate_screws[i-1][1], -mar])
          cylinder(r = plate_screwr2+back_screwpad, h = plate_screwh1);

      }
      // hole for cable from lcd screen
      translate([-screen_cablew/2-1, screen_length/2-1.5, -mar])
        cube([screen_cablew+2, 5, screen_thickness*2]);
      // holes for the legs of the on/off switch
      translate([-screen_bwidth/2-(plate_width-screen_bwidth)/4, 
            screen_blength/2-switch_width-switch_top, 0]) {
        translate([-switch_wirespace/2, -switch_wirespace/2, -mar])
          cylinder(r = switch_wirer, h = back_thickness+2*mar);
        translate([-switch_wirespace/2, +switch_wirespace/2, -mar])
          cylinder(r = switch_wirer, h = back_thickness+2*mar);
        translate([+switch_wirespace/2, -switch_wirespace/2, -mar])
          cylinder(r = switch_wirer, h = back_thickness+2*mar);
        translate([+switch_wirespace/2, +switch_wirespace/2, -mar])
          cylinder(r = switch_wirer, h = back_thickness+2*mar);
      }
    } 
  }

}






// ==============================================================================
// UTILS

module ccube(dim) {
  translate([-dim[0]*0.5, -dim[1]*0.5, 0]) cube(dim);
}

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


// length1 = length small hole usb
// length2 = length large hole
// height1 = height of large hole below small hole
// height2 = height of large hole above small hole
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
