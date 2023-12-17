  
$fn=100;
mar = 0.01;


// == Parameters for LCD
// https://cdn.shopify.com/s/files/1/0174/1800/files/PIM372-drawing.png?v=1651156568
screen_width      = 174.00;
screen_length     = 136.00;
screen_thickness  = 2.5;
screen_bwidth     = 165.20;
screen_blength    = 124.70; 
screen_cablew     = 50;
screen_cablel     = 2;

// == Parameters of plate
plate_bevel       = 2;
plate_thickness   = plate_bevel+screen_thickness;
plate_width       = 19.05*12;
plate_length      = screen_length+25;
plate_screen_pad  = 1;


plate_screwmar     = 5;
plate_screwr1      = 1.5;
plate_screwr2      = 4;
plate_screwh1      = 4;
plate_screwh       = plate_screwh1+1;
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
driver_offset     = [screen_width/2-(61.00+3.5)-driver_holewidth/2, 
screen_length/2-(31.00+3.5)-driver_holelength/2];

echo(driver_offset);

// == Parameters for Raspberry Pi
pi_holewidth  = 49.00;
pi_holelength = 58.00;
pi_offset  = [-screen_width/2 + 40.5 - pi_holewidth/2, 
    screen_length/2 - 27.0 - pi_holelength/2];

// == Parameters for backplate
back_width        = plate_width-2;
back_length       = plate_length-2;
back_thickness    = 2;
back_nlength      = 3;
back_nwidth       = 4;

back_screwthickn  = 1.5;
back_screwr       = 2.2/2;
back_screwpad     = 0.1;

support_h         = 5+back_thickness;
support_r1        = 4.5/2;
support_r2        = 6.5/2;
support_rscrew    = 2.6/2;
support_h1        = 2;

// == Parameters of outer case
case_pad          = 2*10;
case_width        = 250;
case_length       = 150;
case_height       = 20;
case_bevel_top    = 3;
case_bevel_corner = 5;
case_bevel_bottom = 3;
case_bevel_inner  = 2;




use<scad/beveled_cube.scad>


// ===========================================================================

// screen
translate([-screen_width/2, -screen_length/2, plate_bevel])
color("darkgray") {
  cube([screen_width, screen_length, screen_thickness]);
  // cable
  translate([-screen_cablew/2+screen_width/2, screen_length, 0])
    cube([screen_cablew, 1, screen_thickness*2]);
}


// ===========================================================================
// plate
difference() {
  ccube([plate_width, plate_length, plate_thickness]);
  translate([0, 0, -0.1])
    ccube([screen_bwidth, screen_blength, plate_thickness+0.2]);
  translate([0, 0, plate_bevel])
    ccube([screen_width+2*plate_screen_pad, 
      screen_length+2*plate_screen_pad, plate_thickness]);
  translate([-screen_cablew/2, screen_length/2+plate_screen_pad, 
    plate_bevel])
  cube([screen_cablew, screen_cablel, plate_thickness]); 
}

// screw holes on plate
for (i = [1:len(plate_screws)]) {
  difference() {
    translate([plate_screws[i-1][0], plate_screws[i-1][1], plate_thickness-mar])
      cylinder(r = plate_screwr2, h = plate_screwh);
    translate([plate_screws[i-1][0], plate_screws[i-1][1], plate_bevel])
      cylinder(r = plate_screwr1, h = plate_screwh+screen_thickness);
  }
  echo(i);
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
!color("red") 
translate([0, 0, plate_thickness]) {
  
  union() {
    ccube([back_width, back_length, back_thickness]);

    // lcd driver
    difference() {
      translate([driver_offset[0], driver_offset[1], 0]) {
        translate([ driver_holewidth/2,  driver_holelength/2, 0]) 
          cylinder(r = support_r2, h = support_h);
        translate([ driver_holewidth/2, -driver_holelength/2, 0])
          cylinder(r = support_r2, h = support_h);
        translate([-driver_holewidth/2,  driver_holelength/2, 0])
          cylinder(r = support_r2, h = support_h);
        translate([-driver_holewidth/2, -driver_holelength/2, 0])
          cylinder(r = support_r2, h = support_h);
      }
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
    }

    // raspberry pi
    difference() {
      translate([pi_offset[0], pi_offset[1], 0]) {
        translate([ pi_holewidth/2,  pi_holelength/2, 0])
          cylinder(r = support_r2, h = support_h);
        translate([ pi_holewidth/2, -pi_holelength/2, 0])
          cylinder(r = support_r2, h = support_h);
        translate([-pi_holewidth/2,  pi_holelength/2, 0])
          cylinder(r = support_r2, h = support_h);
        translate([-pi_holewidth/2, -pi_holelength/2, 0])
          cylinder(r = support_r2, h = support_h);
      }
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
    }

    // screw holes on plate
    for (i = [1:len(plate_screws)]) {
      difference() {
        translate([plate_screws[i-1][0], plate_screws[i-1][1], 0])
          cylinder(r = plate_screwr2+back_screwthickn, h = plate_screwh+back_screwthickn);
        translate([plate_screws[i-1][0], plate_screws[i-1][1], +mar])
          cylinder(r = back_screwr, h = plate_screwh+back_screwthickn);
        translate([plate_screws[i-1][0], plate_screws[i-1][1], -mar])
          cylinder(r = plate_screwr2+back_screwpad, h = plate_screwh-back_screwthickn);
      }
      echo(i);
    }
  }
}


module ccube(dim) {
  translate([-dim[0]*0.5, -dim[1]*0.5, 0]) cube(dim);
}