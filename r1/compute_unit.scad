  
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

// == Parameters for LCD driver
// https://cdn.shopify.com/s/files/1/0174/1800/files/8inchdriver-drawing.png?v=1652097750
driver_width      = 65.00;
driver_length     = 56.00;
driver_holewidth  = 58.00;
driver_holelength = 49.00;
driver_offset     = [screen_width/2-(61.00+3.5)-driver_holewidth/2, 
screen_length/2-(31.00+3.5)-driver_holelength/2];

echo(driver_offset);


pi_holewidth  = 49.00;
pi_holelength = 58.00;
pi_offset  = [40.5, 27.0];

// == Parameters of plate
plate_bevel       = 2;
plate_thickness   = plate_bevel+screen_thickness;
plate_width       = 19.05*12;
plate_length      = screen_length+25;
plate_screen_pad  = 1;


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


// screen
translate([-screen_width/2, -screen_length/2, plate_bevel])
color("darkgray") {
  cube([screen_width, screen_length, screen_thickness]);
  // cable
  translate([-screen_cablew/2+screen_width/2, screen_length, 0])
    cube([screen_cablew, 1, screen_thickness*2]);
}

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

//beveled_cube([case_width, case_length, case_height], 
//    [case_bevel_top,case_bevel_top], case_bevel_corner, 
//    [case_bevel_bottom, case_bevel_bottom]);
// cut out central cube (where the plate is)
//translate([0, 0, -1])
//  beveled_cube([plate_width-2*mar, plate_length-2*mar, case_height+2],
//    [0.1, 0.1], case_bevel_inner, [0.1,0.1]);  

// lcd driver
translate([driver_offset[0], driver_offset[1], plate_thickness]) {
  translate([ driver_holewidth/2,  driver_holelength/2, 0]) cylinder(r = 5, h = 4);
  translate([ driver_holewidth/2, -driver_holelength/2, 0]) cylinder(r = 5, h = 4);
  translate([-driver_holewidth/2,  driver_holelength/2, 0]) cylinder(r = 5, h = 4);
  translate([-driver_holewidth/2, -driver_holelength/2, 0]) cylinder(r = 5, h = 4);
}


// raspberry pi
//translate([driver_offset[0], driver_offset[1], plate_thickness]) {
//  translate([ driver_holewidth/2,  driver_holelength/2, 0]) cylinder(r = 5, h = 4);
//  translate([ driver_holewidth/2, -driver_holelength/2, 0]) cylinder(r = 5, h = 4);
//  translate([-driver_holewidth/2,  driver_holelength/2, 0]) cylinder(r = 5, h = 4);
//  translate([-driver_holewidth/2, -driver_holelength/2, 0]) cylinder(r = 5, h = 4);
//}



module ccube(dim) {
  translate([-dim[0]*0.5, -dim[1]*0.5, 0]) cube(dim);
}