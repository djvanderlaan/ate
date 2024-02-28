$fn = 100;

frontthickn = 1.5;

 


translate([0, pidim[1]/2+1, 0])
mirror([1, 0, 0]) mirror([0, 0, 1]) translate([0, 0, -10]) {
  pizero();
  pizeroholder();
}



translate([-5, -powdim[1]/2-1, frontthickn])
rotate([0, 0, -180]){
translate([0, 0, 4])
  power();
  powholder();

}



module powholder() {
  difference() {
    union() {
      ccube([4, powdim[1]+2, 4]);
      translate([0, powdim[1]/2-3, 0])
        ccube([powdim[0]+4, 8, 4]);
    }
    for (i = [0:(len(powcorners)-1)]) {  
      translate([powcorners[i][0], powcorners[i][1], -1])
        cylinder(r = 3.1/2, h = 6);
    }
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


// ====================================================================
// Battery controller
powwidth = 18;
powdim   = [23, 37, 2];
powcorners = [
    [-powwidth/2, powdim[1]/2-3],
    [ powwidth/2, powdim[1]/2-3]
  ];
  

module power() {
  difference() {
    union() {
      color("steelblue") ccube(powdim);
      // JST connector
      color("black") 
        translate([powdim[0]/2-6/2, powdim[1]/2-11.5, powdim[2]]) 
        ccube([6,8,6]);
      // usb connector
      color("lightgray")
      translate([0, powdim[1]/2-6/2, powdim[2]])
      ccube([8,6,3]);
    }
    for (i = [0:(len(powcorners)-1)]) {  
      translate([powcorners[i][0], powcorners[i][1], -1])
        cylinder(r = 1.4, h = powdim[2]+2);
    }
  }
}

// ====================================================================
// Basic objects

// cube centered in x and y around 0
module ccube(dim) {
  translate([-dim[0]/2, -dim[1]/2, 0]) cube(dim);
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
