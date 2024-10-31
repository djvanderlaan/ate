
// ==================================================================
// === PARAMETERS
// ==================================================================

// == Parameters for case
case_width   = 249;
case_depth   = 150;
case_h1      = 16;
case_h2      = 26;

wallb   = 3;   // wall thickness back
wallf   = 6.5; // wall thickness front
wallt   = 1.3; // wall thickness top
walls   = 5;

case_bevels  = 5;
case_bevelt  = 5;
case_bevelb  = 10;

// ==================================================================
// === MODEL
// ==================================================================



difference(){
wedgeshape(case_width, case_depth, case_h1, case_h2, 
   case_bevels, case_bevelt, case_bevelb, mirror = true);


case_phi    = 90-acos((case_h2 - case_h1)/case_depth);


color("red")
translate([-0.001, wallf, -0.001])
wedgeshape(case_width-2*walls, case_depth - wallb - wallf, 
   case_h1 + wallf*tan(case_phi)-wallt*cos(case_phi), 
   case_h2 - wallb*tan(case_phi)-wallt*cos(case_phi), 
   case_bevels, case_bevelt, case_bevelb, true);
}

// ==================================================================
// === MODULE WEDGESHAPE
// ==================================================================

module wedgeshape(width, depth, h1, h2, bevels, bevelt, bevelb, mirror = true) {
   points = [
      [0, bevels, 0],  // 1
      [depth - bevelb, bevels, 0], // 2
      [0, 0, bevels],  // 3
      [depth-bevels, 0, bevelb], //4
      [depth, bevels, bevelb], //5 
      [0, 0, h1-bevels], //6 
      [depth-bevels, 0, h2-bevelt], //7 
      [depth, bevels, h2-bevelt], //8
      [0, bevels, h1],  //9
      [depth-bevelt, bevels, h2], //10
      [0, width/2+0.001, 0], // 11
      [depth-bevelb, width/2, 0], // 12
      [depth, width/2+0.001, bevelb], // 13
      [0, width/2+0.001, h1], // 14
      [depth, width/2+0.001, h2-bevelt], // 15
      [depth-bevelt, width/2+0.001, h2] // 16
   ];
   faces = [
      [2,3,1,0],
      [5,6,3,2],
      [8,9,6,5],
      [3,4,1], 
      [6,7,4,3], 
      [9,7,6], 
      [4,12,11,1], 
      [7,14,12,4], 
      [9,15,14,7], 
      [0,1,11,10], 
      [8,13,15,9], 
      [10,11,12,14,15,13], //[13,15,14,12,11,10], 
      [10,13,8,5,2,0], 
   ];
   rotate([0, 0, 90]) {
      if (mirror) {
         mirror([0, 1, 0])
            translate([0, -width/2, 0])
            polyhedron(points = points, faces = faces);
      }
      translate([0, -width/2, 0])
         polyhedron(points = points, faces = faces);
   }
}