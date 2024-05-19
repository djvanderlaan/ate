$fn = 100;

use<b1.scad>
use<scad/beveled_cube.scad>
use<scad/rounded_cube.scad>

include<case_base.scad>



//case_base1();
//translate([screen_offset[0], case_screend, 0])
//lcd();

//translate([0, 0, -screen_thickness]) {
//  translate([screen_offset[0], case_screend, 0])
//    lcd();
//}


difference() {
  // the case
  translate([0, 0, -screen_thickness]) 
    case_base1();
  // hole for the hat for the pi
  translate([pihattranslate[0]-wl, -9, 0.1-case_wallt-screen_thickness])
  difference() {
    translate([0, 0, 10])
      mirror([1, 0, 0])
      mirror([0, 0, 1])
      pizeroholderhole();
  }
  // hole for the button
  button_hole();
}


// == PIZERO HOLDER
wl = (case_width - screen_bwidth)/4+screen_bwidth/2;
translate([pihattranslate[0]-wl, -9, 0.1-case_wallt-screen_thickness])
difference() {
  translate([0, 0, 10])
    mirror([1, 0, 0])
    mirror([0, 0, 1])
    pizeroholder();
  translate([piwidth/2+2, 0, -0.1])
    ccube([10, pilength*2, 3.8]);
}



//===========================================================================
// BUTTON HOLE
button_r = 19.5/2;

module button_hole() {
  translate([-wl, 45, -10]) {
    cylinder(r = button_r, h = 20);
    translate([0, -2.1/2, 0])
      cube([button_r+1.5, 2.1, 20]);
  }
}


//===========================================================================
// == SUPPORTS


back_supw    = screen_width+12;
back_supl    = 7;
back_supt    = 2;
back_suph    = 4;
back_supr1   = 3.1/2;
back_supr2   = 2.1/2;

//translate([0, 40, 0]) support();
translate([screen_offset[0], 40, 0]) support_screws();
//translate([0, -50, 0]) support();
translate([screen_offset[0], -46, 0]) support_screws();



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
      translate([5, 0, pidim[2]+3])
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
pihattranslate = [piwidth/2-3.5-0.5+1+pihatdim[0]/2, 0, pidim[2]];

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
