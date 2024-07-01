$fn =100;

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
  union() {
    // the case
    translate([0, 0, -screen_thickness]) 
      case_base1();
    sup_screwsupports();
    
    // screw holes for the usb port
    translate([charg_x, case_length/2-case_wallb-0.8+0.5, charg_h])
      rotate([case_phi, 0, 0])
      charg_holder();
  }
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
  // holes for the support screws
  sup_screwholes();
  // inset and hole for the usb port 
  translate([charg_x, case_length/2-case_wallb-0.8+0.5, charg_h])
    rotate([case_phi, 0, 0])
    charg_hole();
}



//translate([charg_x, case_length/2-case_wallb-0.8, charg_h])
//rotate([case_phi, 0, 0])
//color("red") {
//  charg_holder();
//
//  charg_hole();
//}



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

// supports for screen and lcd driver
!sup_support();







// ==========================================================================
// USB CHARGER
charg_x     = -60;
charg_h     = 10;
charg_width = 18;
charg_wtot  = 23;
charg_r1    = 3.1/2;
charg_d     = 4;
charg_dhole = 1;





module charg_hole() {
  translate([-charg_wtot/2, -2, 0])
    rotate([0, -90, -90])
    wedge([4.2+charg_dhole+2, charg_wtot, charg_dhole+2], charg_dhole+2);
  translate([0, 5, 1.5])
    beveled_cube([8, 10, 3.2], bevel_top = [1.1,1.1], bevel_side = 0, bevel_bottom=[1.8,1.8]);
}

module charg_holder() {
  translate([0, -5, 0])
  rotate([0, 0, 90])
  difference() {
    translate([0, (charg_width+6)/2, 0])
    rotate([90, 0, 0])
    linear_extrude(charg_width+6)
    polygon([
      [0, 0],
      [0, -4],
      [5, -10],
      [5, 0]
    ]); 
    translate([5/2, charg_width/2, -charg_d+0.01])
      cylinder(r = charg_r1, h = charg_d);
    translate([5/2, -charg_width/2, -charg_d+0.01])
      cylinder(r = charg_r1, h = charg_d);
  }
}


module wedge(dim, xwedge) {
  translate([0, dim[1], 0])
  rotate([90, 0, 0])
  linear_extrude(dim[1])
  polygon([
    [0, 0],
    [dim[0], 0], 
    [dim[0] - xwedge, dim[2]],
    [0, dim[2]]
  ]);
  
}




//===========================================================================
// BUTTON HOLE
button_r = 19.8/2;

module button_hole() {
  translate([-wl, 50, -10]) {
    cylinder(r = button_r, h = 20);
    translate([0, -2.1/2, 0])
      cube([button_r+1.3 , 2.1, 20]);
  }
}



//===========================================================================
// == SUPPORTS 2

sup_yleft  = [40, -46];
sup_yright = [40-12, -46];
sup_dim    = [6,5.5, 4-1.5];
sup_h      = 4;
sup_r1     = 3.1/2;
sup_r2     = 2.1/2;
sup_d      = 4;
sup_d2     = 2;

// == Parameters for LCD driver
// https://cdn.shopify.com/s/files/1/0174/1800/files/8inchdriver-drawing.png?v=1652097750
driver_width      = 65.00;
driver_length     = 56.00;
driver_holewidth  = 58.00;
driver_holelength = 49.00;
// moved the screen 10mm up otherwise the hdmi port of the pi is exacly above the 
// power connector of the driver
driver_offset     = [screen_width/2-64.5-driver_holewidth/2, 
                     screen_length/2-32.0-driver_holelength/2];


//difference() {
//translate([-screen_width/2-sup_dim[0]/2+screen_offset[0], sup_yleft[0], 0])
//  ccube(sup_dim);
//translate([-screen_width/2-sup_dim[0]/2+screen_offset[0], sup_yleft[1], 0])
//  ccube(sup_dim);  
//translate([screen_width/2+sup_dim[0]/2+screen_offset[0], sup_yright[0], 0])
//  ccube(sup_dim);  
//translate([screen_width/2+sup_dim[0]/2+screen_offset[0], sup_yright[1], 0])
//  ccube(sup_dim);   
//  
//translate([-screen_width/2-sup_dim[0]/2+screen_offset[0], sup_yleft[0], sup_dim[2]-sup_h+0.01])
//  cylinder(r = sup_r2, h = sup_h);
//}



module sup_support() {
  difference() {
    union() {
      translate([driver_offset[0], -3, 0])
        ccube([driver_width+10, driver_length+40, sup_d]);
      translate([screen_offset[0], sup_yleft[0], 0])
        sup_stem();
      translate([screen_offset[0], sup_yleft[1], 0])
        mirror([0, 1, 0])
        sup_stem();
      translate([screen_offset[0], sup_yright[0], 0])
        mirror([1, 0, 0])
        sup_stem();
      translate([screen_offset[0], sup_yright[1], 0])
        mirror([0, 1, 0])
        mirror([1, 0, 0])
        sup_stem();
    }
    // holes for the screws of the driver
    translate([driver_offset[0], driver_offset[1], 0]) {
      translate([ driver_holewidth/2,  driver_holelength/2, 0]) 
        cylinder(r = sup_r1, h = sup_h+1);
      translate([ driver_holewidth/2, -driver_holelength/2, 0])
        cylinder(r = sup_r1, h = sup_h+1);
      translate([-driver_holewidth/2,  driver_holelength/2, 0])
        cylinder(r = sup_r1, h = sup_h+1);
      translate([-driver_holewidth/2, -driver_holelength/2, 0])
        cylinder(r = sup_r1, h = sup_h+1);
    }
  }

}


module sup_screwsupports() {
  translate([-screen_width/2-sup_dim[0]/2+screen_offset[0], sup_yleft[0], 0])
    ccube(sup_dim);
  translate([-screen_width/2-sup_dim[0]/2+screen_offset[0], sup_yleft[1], 0])
    ccube(sup_dim);  
  translate([screen_width/2+sup_dim[0]/2+screen_offset[0], sup_yright[0], 0])
    ccube(sup_dim);  
  translate([screen_width/2+sup_dim[0]/2+screen_offset[0], sup_yright[1], 0])
    ccube(sup_dim);   
}

module sup_screwholes() {
  translate([-screen_width/2-sup_dim[0]/2+screen_offset[0], sup_yleft[0], sup_dim[2]-sup_h+0.01])
    cylinder(r = sup_r1, h = sup_h);
  translate([-screen_width/2-sup_dim[0]/2+screen_offset[0], sup_yleft[1], sup_dim[2]-sup_h+0.01])
    cylinder(r = sup_r1, h = sup_h);
  translate([ screen_width/2+sup_dim[0]/2+screen_offset[0], sup_yright[0], sup_dim[2]-sup_h+0.01])
    cylinder(r = sup_r1, h = sup_h);
  translate([ screen_width/2+sup_dim[0]/2+screen_offset[0], sup_yright[1], sup_dim[2]-sup_h+0.01])
    cylinder(r = sup_r1, h = sup_h);
}


module sup_stem() {
  difference() {
    union() {
      translate([-screen_width/4, 0, 0])
        ccube([screen_width/2, sup_dim[1], sup_d]);
      translate([-screen_width/2-sup_dim[0]+0.1, -sup_dim[1]/2, 0])
        cube([sup_dim[0]+sup_d, sup_dim[1]+sup_d2, sup_dim[2]+sup_d2]);
    }
    translate([-screen_width/2-sup_dim[0]/2, -0.1, 0])
      ccube(sup_dim);
    translate([-screen_width/2-sup_dim[0]/2, 0, sup_dim[2]-sup_h+0.01])
      cylinder(r = sup_r2, h = sup_h+10);
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

//translate([screen_offset[0], 40-12, 0]) support();
//translate([screen_offset[0], 40-12, 0]) support_screws();
//translate([screen_offset[0], -46, 0]) support();
//translate([screen_offset[0], -46, 0]) support_screws();



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
