use<wedge_case.scad>
use<screen.scad>
use<scad/beveled_cube.scad>
use<scad/rounded_cube.scad>
use<batteryholder.scad>


$fn=100;

difference() {
   union() {
      wedgecasedefault();
      // wall for inset for switch and usb connector
      // make sure the same parameters are used as for the
      // caseholewallinset
      translate([50, 0, 0])
         caseholewall(width = 60, hshift = 4);
      // holde usb port
      charg_holder();
   }

   // hole for screen
   translate([0, -0.5, 1.3])
      screenhole(3);
   // inset for switch and usb connector
   // use same parameters as for caseholewall above
   translate([50, 0, 0])
      caseholeinset(width = 60, hshift = 4);
   // hole for swich
   holeforswitch();
   // hole usb port
   charg_hole();
   // screwholes for support of screen
   supportholes();
   // hole for pi zero in top
   translate([100-0.5, 0, 10+3.3-2])
      mirror([0, 0, 1])
      pizeroholderhole();

}


difference() {
   translate([100-0.5, 0, 10+3.3-2])
      mirror([0, 0, 1])
      pizeroholder();
   translate([52, -50, 0])
      cube([49, 100, 3.5]);
}



//!union() {
//   translate([0, 0, 3]) support();
//   translate([-91+10, 40+12.8-4.5+2, 3])
//      rotate([0, 0, -90])
//      batteryholder(15-4.5+2,10);
//}


!wedgecasebottomdefault();

// ==================================================================
// === INSET IN BACK
// ==================================================================


module caseholewall(depth = 5, height = 15, width = 40, bevel = 4, hshift = 4) {
   phi = wedgecasephi();
   dim = wedgecasedim();
   intersection() {
      rotate([phi, 0, 0])
      translate([0, dim[1]/2, hshift])
         rotate([90, 0, 0])
         translate([0, height, 0])
         beveled_cube([width+14, height*2+14+5, depth+2], [8,8], 4, [0,0]);
      wedgecaseouterdefault();
   }
}

module caseholeinset(depth = 5, height = 15, width = 40, bevel = 4, hshift = 4) {
   phi = wedgecasephi();
   dim = wedgecasedim();
   rotate([phi, 0, 0])
      translate([0, dim[1]/2, hshift])
      difference() {
         translate([0, 10, 0])
            rotate([90, 0, 0])
            translate([0, height, 0])
            beveled_cube([width, height*2, depth+10], [0,0], bevel, [0,0]);
         translate([-100/2, -50, 30/2+5])
               cube([100, 100, 100]);
      }
}


module holeforswitch(xshift = 35, hshift = 11) {
   phi = wedgecasephi();
   dim = wedgecasedim();
   rotate([phi, 0, 0])
      translate([xshift, dim[1]/2, hshift])
      cube([13.6, 20, 9], center = true);
}



// ==================================================================
// === USB CHARGER
// ==================================================================

charg_width = 18;
charg_wtot  = 23;
charg_r1    = 3.1/2;
charg_d     = 4;
charg_dhole = 1;

module charg_hole(xshift = 65, hshift = 9) {
   phi = wedgecasephi();
   dim = wedgecasedim();
   rotate([phi, 0, 0])
      translate([xshift, dim[1]/2-6-1, hshift]) {
        translate([-charg_wtot/2, -2, 0])
          rotate([0, -90, -90])
          charge_wedge([4.2+charg_dhole+2, charg_wtot, charg_dhole+2], charg_dhole+2);
        translate([0, 5, 1.5])
          beveled_cube([8, 10, 3.2], bevel_top = [1.1,1.1], 
            bevel_side = 0, bevel_bottom=[1.8,1.8]);
      }
}

module charg_holder(xshift = 65, hshift = 9) {
   phi = wedgecasephi();
   dim = wedgecasedim();
   rotate([phi, 0, 0])
   translate([xshift, dim[1]/2-6-1, hshift]) 
   translate([0, -5, 0])
   rotate([0, 0, 90])
   difference() {
      translate([0, (charg_width+6)/2, 0])
         rotate([90, 0, 0])
         linear_extrude(charg_width+6)
         polygon([
            [0, 0],
            [0, -4+2],
            [5, -10+3+0.5],
            [5, 0]
         ]); 
      translate([5/2, charg_width/2, -charg_d+0.01])
         cylinder(r = charg_r1, h = charg_d);
      translate([5/2, -charg_width/2, -charg_d+0.01])
         cylinder(r = charg_r1, h = charg_d);
   }
}


module charge_wedge(dim, xwedge) {
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

// ==================================================================
// === BACK SUPPORT SCREEN
// ==================================================================

sup_width = 210;
sup_depth = 90;

driver_width      = 65.00;
driver_depth      = 56.00;
driver_holewidth  = 58.00;
driver_holedepth  = 49.00;


module supportholes() {
   translate([sup_width/2, sup_depth/2, -0.1])
      sub_screw_hole();
   translate([sup_width/2, -sup_depth/2, -0.1])
      sub_screw_hole();
   translate([-sup_width/2, sup_depth/2, -0.1])
      sub_screw_hole();
   translate([-sup_width/2, -sup_depth/2, -0.1])
      sub_screw_hole();
}

module support_base() {
   translate([0, 0, 0]) {
      difference() {
         // holder for lcd driver
         ccube([driver_width, sup_depth, 4]);
         translate([0, 10, 0]) {
            translate([driver_holewidth/2, driver_holedepth/2, -0.1])
               cylinder(h = 10, r = 3.1/2);
            translate([driver_holewidth/2, -driver_holedepth/2, -0.1])
               cylinder(h = 10, r = 3.1/2);
            translate([-driver_holewidth/2, driver_holedepth/2, -0.1])
               cylinder(h = 10, r = 3.1/2);
            translate([-driver_holewidth/2, -driver_holedepth/2, -0.1])
               cylinder(h = 10, r = 3.1/2);
            translate([0, 0, -0.1])
               rounded_cube([driver_width-10, driver_depth-10, 5], r = 5);
         }
      }

      // horizontal bars
      difference() {
         union() {
            translate([0, sup_depth/2, 0])
               rounded_cube([sup_width+10, 5, 4], r = 2.4);
            translate([0, -sup_depth/2, 0])
               rounded_cube([sup_width+10, 5, 4], r = 2.4);
         }
         translate([sup_width/2, sup_depth/2, -0.1])
            cylinder(h = 10, r = 3.1/2);
         translate([sup_width/2, -sup_depth/2, -0.1])
            cylinder(h = 10, r = 3.1/2);
         translate([-sup_width/2, sup_depth/2, -0.1])
            cylinder(h = 10, r = 3.1/2);
         translate([-sup_width/2, -sup_depth/2, -0.1])
            cylinder(h = 10, r = 3.1/2);
      }
   }
   
}





module support() {
   mirror([0, 1, 0])
   mirror([1, 0, 0])
   difference() {
      union() {
         support_base();
         translate([driver_width/2+32-1, -sup_depth/2+15, 0])
            ccube([64, 30, 4]);
      }
      translate([driver_width/2+64-50-6, -sup_depth/2-15+20, -1])
         rounded_cube([100, 40, 6], r=2.5);
   }
}
   
module sub_screw_hole() {
   cylinder(h = 15, r = 2.1/2);
   cylinder(h = 2, r1 = 2.5, r2 = 0.5);
}

// ==================================================================
// === PI ZERO 2 HOLDER
// ==================================================================



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
                     














