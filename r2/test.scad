$fn=100;
mar = 0.01;

use<scad/beveled_cube.scad>
use<scad/rounded_cube.scad>


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


#difference() {
translate([0, 0, -screen_thickness]) {
  //translate([screen_offset[0], 0, 0])
    //lcd();
  case_base1();
}


translate([pihattranslate[0]-wl, -10, 0.1-case_wallt-screen_thickness])
difference() {
  translate([0, 0, 10])
    mirror([1, 0, 0])
    mirror([0, 0, 1])
    pizeroholderhole();
}

}


// cutout for keyboard
translate([0, -case_length/2, 0])
rotate([case_phi, 0, 0])
translate([0, 4, ate_b1_height()-screen_thickness-case_wallt])
union() {
  ate_b1();
  translate([-5*19.05, -10, -7/2-1])
    rotate([-90, 0, 0])
    beveled_cube([13, 7, 20], [0, 0], 2, [0, 0]);
}


// cutout for keyboard
//    translate([0, -case_length/2+6, case_height])
//      ate_b1();
//    // cutout for usb for keyboard
//    translate([-5*19.05, -case_length/2-1, case_height-7/2-1])
//      rotate([-90, 0, 0])
//      beveled_cube([13, 7, 20], [0, 0], 2, [0, 0]);



back_supw    = screen_width+20;
back_supl    = 7;
back_supt    = 2;
back_suph    = 4;
back_supr1   = 3.1/2;
back_supr2   = 2.1/2;


translate([0, 40, 0]) support();
translate([0, 40, 0]) support_screws();
translate([0, -50, 0]) support();
translate([0, -50, 0]) support_screws();

wl = (case_width - screen_bwidth)/4+screen_bwidth/2;
translate([pihattranslate[0]-wl, -10, 0.1-case_wallt-screen_thickness])
difference() {
  translate([0, 0, 10])
    mirror([1, 0, 0])
    mirror([0, 0, 1])
    pizeroholder();
  translate([piwidth/2+2, 0, -0.1])
  ccube([10, pilength*2, 3]);
}



module support() {
  difference() {
    union() {
      ccube([back_supw-2*(back_supl-back_supt), back_supl, back_supt]);
      translate([-back_supw/2+back_supl/2, 0, back_suph])
        ccube([back_supl, back_supl, back_supt]);
      translate([+back_supw/2-back_supl/2, 0, back_suph])
        ccube([back_supl, back_supl, back_supt]);
      translate([0, back_supl/2-back_supt/2, 0])
        ccube([back_supw, back_supt, back_suph+back_supt]);
      translate([-back_supw/2-back_supt/2+back_supl, 0, 0])
        ccube([back_supt, back_supl, back_suph+back_supt]);
      translate([+back_supw/2+back_supt/2-back_supl, 0, 0])
        ccube([back_supt, back_supl, back_suph+back_supt]);
    }
    union() {
      translate([+back_supw/2-(back_supl-back_supt)/2, -back_supt/2, back_suph+back_supt-1])
        cylinder(r = back_supr2, h = back_supt+2); 
      translate([-back_supw/2+(back_supl-back_supt)/2, -back_supt/2, back_suph+back_supt-1])
        cylinder(r = back_supr2, h = back_supt+2); 
    }
  }
}

module support_screws() {
  translate([-back_supw/2+(back_supl-back_supt)/2, -back_supt/2, 0])
      difference() {
      ccube([back_supl-back_supt, back_supl-back_supt, back_suph]);
      cylinder(r = back_supr1, h = back_suph+0.1); 
    }
  translate([+back_supw/2-(back_supl-back_supt)/2, -back_supt/2, 0])
    difference() {
      ccube([back_supl-back_supt, back_supl-back_supt, back_suph]);
      cylinder(r = back_supr1, h = back_suph+0.1); 
    }
}



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
  mirror([0, 0, 1])
  translate([-case_width/2, -case_length/2, 0])
  rotate([90, 0, 90])
  linear_extrude(case_width)
  rotate([0, 0, -case_phi])
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


// ====================================================================
// PI ZERO 2 HOLDER
module pizeroholder() {
  difference() {
    union() {
      // cornders; to screw the pi to
      translate([picorners[0][0], picorners[0][1], pidim[2]])
        mirror([1, 0, 0]) cube1round([8,8,3+0.1], r = 3);
      translate([picorners[1][0], picorners[1][1], pidim[2]])
        mirror([0, 0, 0]) cube1round([8,8,3+0.1], r = 3);
      translate([picorners[2][0], picorners[2][1], pidim[2]])
        mirror([0, 1, 0]) cube1round([8,8,3+0.1], r = 3);
      translate([picorners[3][0], picorners[3][1], pidim[2]])
        mirror([1, 1, 0]) cube1round([8,8,3+0.1], r = 3);
      // widthwise supports at ends of pi zero
      translate([-(piwidth+8-3+8-3)/2, pilength/2-3, pidim[2]+3])
        cube([piwidth+8-3+8-3, 8, 10-3-pidim[2]]);
      translate([-(piwidth+8-3+8-3)/2, -pilength/2-8+3, pidim[2]+3])
        cube([piwidth+8-3+8-3, 8, 10-3-pidim[2]]);
      // lengthwise border around gpio headers
      translate([6, 0, pidim[2]+3])
        ccube([2, pilength, 10-3-pidim[2]]); 
      translate([(piwidth+8-3+8-3)/2-1, 0, pidim[2]+3])
        ccube([2, pilength, 10-3-pidim[2]]); 
    }
    // holes for the screws; r = 3.1 needed for threaded inserts M2
    for (i = [0:(len(picorners)-1)]) {  
      translate([picorners[i][0], picorners[i][1], pidim[2]-1])
        cylinder(r = 3.1/2, h = 10+4);
    }
  }
}

module pizeroholderhole() {
  translate(pihattranslate)
    ccube(pihatdim+[2,1,5]);
}



// ====================================================================
// PI ZERO 2
piwidth  = 23;
pilength = 29*2;
pidim    = [30, 65, 2];
picorners = [
    [-piwidth/2,  pilength/2],
    [ piwidth/2,  pilength/2],
    [ piwidth/2, -pilength/2],
    [-piwidth/2, -pilength/2]
  ];
pihatdim = [5, 51, 8];
pihattranslate = [piwidth/2-3.5+pihatdim[0]/2, 0, pidim[2]];

module pizero() {
  difference() {
    union() {
      color("green") ccube(pidim);
      color("black") translate(pihattranslate)
        ccube(pihatdim);
    } 
    for (i = [0:(len(picorners)-1)]) {  
      translate([picorners[i][0], picorners[i][1], -1])
        cylinder(r = 1.4, h = pidim[2]+2);
    }
  }
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