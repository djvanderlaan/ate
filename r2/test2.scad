$fn = 100;

use<b1.scad>

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




case_length = 150-4;
case_width  = 250;
case_h1     = 16;
case_h2     = 22;
case_walls  = 3;
case_wallb  = 3;
case_wallf  = 5;
case_wallt  = 1.3;

case_phi    = 90-acos((case_h2 - case_h1)/case_length);



case_base0();

//ate_b1_negative();






// Wedge shaped case with hole for screen; no sides or
// bottom. 
module case_base1() {
  translate([0, 0, -case_wallt])
  difference() {
    color("steelblue")
      case_base0();
    translate([0, -screen_offset[1], -1])
      ccube([screen_bwidth, screen_blength, case_wallt+2]);
  }
  // Raised edges at the sides of the screen
  wl = (case_width - screen_width)/2 + screen_offset[0];
  ll = case_length - case_wallb;
  translate([-case_width/2, -case_length/2, 0])
    cube([wl, ll, screen_thickness]);
  wr = (case_width - screen_width)/2 - screen_offset[0];
  lr = case_length - case_wallb;
  translate([case_width/2-wr, -case_length/2, 0])
    cube([wr, lr, screen_thickness]);
}


// Wedge shaped case; no sides and no bottom
module case_base0() {
  //mirror([0, 0, 1])
  //translate([-case_width/2, -case_length/2, 0])
  //rotate([90, 0, 90])
  //linear_extrude(case_width)
  //rotate([0, 0, -case_phi])
  difference() {
    polygon([
      [0, -case_h1], 
      [case_length*cos(case_phi), -case_h1],
      [case_length*cos(case_phi), case_h2-case_h1],
      [0, 0] 
    ]);
    polygon([
      [case_wallf, 
        -case_wallt*cos(case_phi)+case_wallf*sin(case_phi)],
      [case_wallf, -case_h1-0.1],
      [case_length*cos(case_phi)-case_wallb, -case_h1-0.1],
      [case_length*cos(case_phi)-case_wallb, 
        case_h2-case_h1-case_wallt*cos(case_phi)-case_wallb*sin(case_phi)],
    ]);
  }
}


module lcd() {
  color("black")
    translate([-screen_cablew/2, screen_length/2, 0])
    cube([screen_cablew, screen_cablel, 5]);
  color("lightgray")
    ccube([screen_width, screen_length, screen_thickness]);
  color("black") 
    translate([-screen_offset[0], -screen_offset[1], -0.5])
    ccube([screen_bwidth, screen_blength, 0.6]);
}

