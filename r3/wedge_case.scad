      
// ==================================================================
// === PARAMETERS
// ==================================================================

// == Parameters for case
case_width   = 249;
case_depth   = 150;
case_h1      = 16;
case_h2      = 26;

case_wallb   = 3;   // wall thickness back
case_wallf   = 6.5; // wall thickness front
case_wallt   = 1.3; // wall thickness top
case_walls   = 5;

case_bevels  = 5;
case_bevelt  = 5;
case_bevelb  = 10;

// ==================================================================
// === MODEL
// ==================================================================

wedgecase(case_width, case_depth, case_h1, case_h2, 
   case_wallb, case_wallf, case_wallt, case_walls, 
   case_bevels, case_bevelt, case_bevelb);



// ==================================================================
// === MODULE WEDGECASE
// ==================================================================

module wedgecase(width, depth, h1, h2, 
   wallb, wallf, wallt, walls, 
   bevels, bevelt, bevelb
) {
   phi    = 90-acos((h2 - h1)/depth);
   difference(){
      wedgeshape(width, depth, h1, h2, 
         bevels, bevelt, bevelb, mirror = true);
      translate([-0.001, wallf, -0.01])
         wedgeshape(width-2*walls, depth - wallb - wallf, 
            h1 + wallf*tan(phi)-wallt*cos(phi)+0.01, 
            h2 - wallb*tan(phi)-wallt*cos(phi)+0.01, 
            bevels, bevelt, bevelb, true);
   }
}

// ==================================================================
// === MODULE WEDGESHAPE
// ==================================================================

module wedgeshape(width, depth, h1, h2, bevels, bevelt, bevelb, 
   mirror = true
) {
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
      [0, width/2+0.01, 0], // 11
      [depth-bevelb, width/2+0.01, 0], // 12
      [depth, width/2+0.01, bevelb], // 13
      [0, width/2+0.01, h1], // 14
      [depth, width/2+0.01, h2-bevelt], // 15
      [depth-bevelt, width/2+0.01, h2] // 16
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
      [10,11,12,14,15,13],
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