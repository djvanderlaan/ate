  
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
plate_length      = screen_length+25;
plate_screen_pad  = 1;


plate_screwmar     = 5;
plate_screwr1      = 3.2/2;
plate_screwr2      = plate_screwr1+1.7;
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
case_length       = 150;
case_height       = 20;
case_bevel_top    = 3;
case_bevel_corner = 5;
case_bevel_bottom = 3;
case_bevel_inner  = 2;



screen = false;
frontplate = true;
backplate = false;


use<scad/beveled_cube.scad>


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
//beveled_cube([case_width, case_length, case_height], 
//    [case_bevel_top,case_bevel_top], case_bevel_corner, 
//    [case_bevel_bottom, case_bevel_bottom]);
// cut out central cube (where the plate is)
//translate([0, 0, -1])
//  beveled_cube([plate_width-2*mar, plate_length-2*mar, case_height+2],
//    [0.1, 0.1], case_bevel_inner, [0.1,0.1]);  


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