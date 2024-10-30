
use<b1.scad>

// == Parameters for LCD
screen_width      = 201.50;
screen_length     = 132.00;
screen_thickness  = 2; 
screen_bevel      = [6, 3, 3, 3]; // top, right, bottom, left

// Derived paramers
// screen is not completely center in the panel at the top of the panel there is
// at bit more space; therefore the hole for the screen needs to move offset up
// first is left; second top
screen_offset     = [(screen_bevel[3]-screen_bevel[1])/2, 
    (screen_bevel[0]-screen_bevel[2])/2];
// Dimensions of bevel
screen_bwidth     = screen_width-screen_bevel[1]-screen_bevel[3];
screen_blength    = screen_length-screen_bevel[0]-screen_bevel[2]; 


// == Parameters for case
case_width   = 250;
case_h1      = 16;
case_h2      = 26;
//case_walls   = 3;
case_wallb   = 3;   // wall thickness back
case_wallf   = 6.5; // wall thickness front
case_wallt   = 1.3; // wall thickness top
case_screend = 0; // extra offset of scren from bottom

// Derived parameters
// Length of case
case_length = screen_length + case_wallb + case_wallf+case_screend+1;
// Angle of top
case_phi    = 90-acos((case_h2 - case_h1)/case_length);



//case_base1();
//translate([screen_offset[0], case_screend, 0]) lcd();



//color("red")
//translate([0, (case_wallf-case_wallb)/2, 0])
//cylinder(h = 2, r = 65, $fn=100);


// Wedge shaped case with hole for screen; no sides or
// bottom. 
module case_base1() {
  //screen_shift = (case_wallf-case_wallb)/2;//-screen_offset[1]/2;
  screen_shift = +screen_blength/2-case_length/2+
    case_wallf+screen_bevel[2];
    
  translate([0, 0, -case_wallt])
  difference() {
    color("steelblue")
      case_base0();
    translate([0, screen_shift, -1])
      ccube([screen_bwidth, screen_blength, case_wallt+2]);
  }
  // Raised edges at the sides of the screen
  wl = (case_width - screen_width)/2 + screen_offset[0];
  ll = case_length - case_wallb-case_wallf+1;
  translate([-case_width/2, -case_length/2+case_wallf-1, 0])
    cube([wl, ll, screen_thickness]);
  wr = (case_width - screen_width)/2 - screen_offset[0];
  lr = case_length - case_wallb-case_wallf+1;
  translate([case_width/2-wr, -case_length/2+case_wallf-1, 0])
    cube([wr, lr, screen_thickness]);
}


// case_base00 with the keyboard cut out
module case_base0() {
  mirror([0, 0, 1])
  translate([0, -case_length/2, 0])
  rotate([-case_phi, 0, 0])
  difference() {
    case_base00();
//    translate([0, 4, -case_h1])
//      rotate([0, 0, 180])
//      ate_b1_negative();
  }
}

// Wedge shaped case; no sides and no bottom
module case_base00() {
  //mirror([0, 0, 1])
  //translate([-case_width/2, -case_length/2, 0])
  translate([-case_width/2, 0, 0])
  rotate([90, 0, 90])
  linear_extrude(case_width)
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
  color("pink")
    ccube([screen_width, screen_length, screen_thickness]);
  color("black") 
    translate([-screen_offset[0], -screen_offset[1], -0.5])
    ccube([screen_bwidth, screen_blength, 0.6]);
}

// =============================================================
module ccube(dim) {
  translate([-dim[0]/2, -dim[1]/2, 0])
    cube(dim);
}


// cube with 1 corner rounded; cube is centered on centre cylinder of
// corner
module cube1round(dim ,r) {
  cylinder(r = r, h = dim[2]);
  translate([-r, 0, 0])
    cube([dim[0], dim[1]-r, dim[2]]);
  translate([0, -r, 0])
    cube([dim[0]-r, dim[1], dim[2]]);
}