use<b1.scad>
use<scad/beveled_cube.scad>
      
// ==================================================================
// === PARAMETERS
// ==================================================================

// == Parameters for case
case_width   = 249;
case_depth   = 150-2;
case_h1      = 16;
case_h2      = 26;

case_wallb   = 3;   // wall thickness back
case_wallf   = 6.5; // wall thickness front
case_wallt   = 2+1.3; // wall thickness top
case_walls   = 5;

case_bevels  = 3;
case_bevelt  = 5;
case_bevelb  = 10;

// Dimensions of topsurface of case
topdim = [case_width-case_bevels*2, case_depth-case_bevelt];

// Dimensions of inner topsurface of case
// The first two elements are the dimensions in x and y direction
// The third and fourth elements are the offset of the surface in
// the x and y-direction. The offset is from the centre of the 
// front surface. 
indim = [
  case_width-2*case_bevels-2*case_walls, 
   case_depth-case_bevels-case_wallb-case_wallf, 
   0, 
   (case_wallf-case_wallb)/2
];

// ==================================================================
// === MODEL
// ==================================================================

wedgecasedefault();

wedgecasebottomdefault();

//color("red")
//wedgecaseouterdefault();
//wedgecase(case_width, case_depth, case_h1, case_h2, 
//   case_wallb, case_wallf, case_wallt, case_walls, 
//   case_bevels, case_bevelt, case_bevelb, false);


//// Front surface
//color("red") 
//   translate([-topdim[0]/2, -topdim[1]/2, -0.1]) 
//   cube([topdim[0], topdim[1], 0.2]);

//// Inner surface
//color("green")
//   translate([-indim[0]/2+indim[2], -indim[1]/2+indim[3], -1])
//   cube([indim[0], indim[1], case_wallt+2]);


function wedgecasephi() = 
   90-acos((case_h2 - case_h1)/(case_depth-case_bevelt));

function wedgecasedim() =
   [case_width, case_depth, case_h1, case_h2];

// ==================================================================
// === MODULE WEDGECASEDEFAULT
// ==================================================================
// Function creating wedgecase using the parameters in this script
// to be called from other scripts.

module wedgecasedefault() {
   wedgecase(case_width, case_depth, case_h1, case_h2, 
      case_wallb, case_wallf, case_wallt, case_walls, 
      case_bevels, case_bevelt, case_bevelb);
}

// ==================================================================
// === MODULE WEDGECASEBOTTOMDEFAULT
// ==================================================================
// Function creating bottom plate of wedgecase using the parameters 
// in this script to be called from other scripts.

module wedgecasebottomdefault() {
   wedgecasebottom(case_width, case_depth, case_h1, case_h2, 
      case_wallb, case_wallf, case_wallt, case_walls, 
      case_bevels, case_bevelt, case_bevelb);
}


// ==================================================================
// === MODULE WEDGECASEOUTERDEFAULT
// ==================================================================
// Function creating wedgecase using the parameters in this script
// to be called from other scripts.

module wedgecaseouterdefault() { 
   phi    = 90-acos((case_h2 - case_h1)/(case_depth-case_bevelt));
   mirror([0, 0, 1])
      translate([0, -case_depth/2+1*case_bevelt/2, 0])
      rotate([-phi, 0, 0])
      translate([0, 0, -case_h1])
      wedgeshape(case_width, case_depth, case_h1, case_h2, 
         case_bevels, case_bevelt, case_bevelb, mirror = true);
}


// ==================================================================
// === MODULE WEDGECASE
// ==================================================================
// The generic case shape, centred and with inset for keyboard

module wedgecase(width, depth, h1, h2, 
   wallb, wallf, wallt, walls, 
   bevels, bevelt, bevelb,
   keyboardinset = true
) {
   phi    = 90-acos((h2 - h1)/(depth-bevelt));
   difference() {
      wedgecasebase(width, depth, h1, h2, 
         wallb, wallf, wallt, walls, 
         bevels, bevelt, bevelb);
      if (keyboardinset) {      
         translate([0, -depth/2+1*bevelt/2, h1+0.1])
            rotate([phi, 0, 0])
            translate([0, 3, 0])
            mirror([1, 0, 0])
            mirror([0, 1, 0])
            mirror([0, 0, 1])
            ate_b1_negative(); 
      }
   }
}


// ==================================================================
// === MODULE WEDGECASEBASE
// ==================================================================
// The generic case shape, not centred and without inset for 
// keyboard

module wedgecasebase(width, depth, h1, h2, 
   wallb, wallf, wallt, walls, 
   bevels, bevelt, bevelb
) {
   phi    = 90-acos((h2 - h1)/(depth-bevelt));
   dimbottom = [width-2*walls-2*bevels+7, 
               depth - wallb - wallf- bevelb+2, 2+0.1];
   mirror([0, 0, 1])
      translate([0, -depth/2+1*bevelt/2, 0])
      rotate([-phi, 0, 0])
      translate([0, 0, -h1])
      difference(){
         wedgeshape(width, depth, h1, h2, 
            bevels, bevelt, bevelb, mirror = true);  

         translate([0, wallf, 1.5-0.01])
            wedgeshape(width-2*walls-8, depth - wallb - wallf, 
               h1 + wallf*tan(phi)-wallt*cos(phi)-1.5, 
               h2 - wallb*tan(phi)-wallt*cos(phi)-1.5, 
               bevels, bevelt, bevelb, true);
         
         translate([0, dimbottom[1]/2 + case_wallf, -0.1])
            beveled_cube(dimbottom, [0, 0], 4, [0, 0]);
         // screw holes
         translate([dimbottom[0]/2-3, dimbottom[1]/2-5, 0])
            translate([0, dimbottom[1]/2 + case_wallf, -0.1])
            translate([0, 0, -0.1]) cylinder(h = 5, r = 3.1/2, $fn=100);
         translate([-(dimbottom[0]/2-3), dimbottom[1]/2-5, 0])
            translate([0, dimbottom[1]/2 + case_wallf, -0.1])
            translate([0, 0, -0.1]) cylinder(h = 5, r = 3.1/2, $fn=100);
         translate([-(dimbottom[0]/2-3), -(dimbottom[1]/2-5), 0])
            translate([0, dimbottom[1]/2 + case_wallf, -0.1])
            translate([0, 0, -0.1]) cylinder(h = 5, r = 3.1/2, $fn=100);
         translate([(dimbottom[0]/2-3), -(dimbottom[1]/2-5), 0])
            translate([0, dimbottom[1]/2 + case_wallf, -0.1])
            translate([0, 0, -0.1]) cylinder(h = 5, r = 3.1/2, $fn=100);
      } 
}


// ==================================================================
// === MODULE WEDGECASEBOTTTOM
// ==================================================================
module wedgecasebottom(width, depth, h1, h2, 
   wallb, wallf, wallt, walls, 
   bevels, bevelt, bevelb
) {
   pad    = 0.5;
   phi    = 90-acos((h2 - h1)/(depth-bevelt));
   dimbottom = [width-2*walls-2*bevels+7-pad, 
               depth - wallb - wallf- bevelb+2-pad, 2];
   mirror([0, 0, 1])
      translate([0, -depth/2+1*bevelt/2, 0])
      rotate([-phi, 0, 0])
      translate([0, 0, -h1])
      difference(){
         translate([0, dimbottom[1]/2 + case_wallf+0.5, -0.1])
            beveled_cube(dimbottom, [0, 0], 4, [0, 0]);
         // screw holes
         translate([dimbottom[0]/2-3+pad/2, dimbottom[1]/2-5+pad/2, 0])
            translate([0, dimbottom[1]/2 + case_wallf, -0.1])
            translate([0, 0, -0.1]) sub_screw_hole();
         translate([-(dimbottom[0]/2-3+pad/2), dimbottom[1]/2-5+pad/2, 0])
            translate([0, dimbottom[1]/2 + case_wallf, -0.1])
            translate([0, 0, -0.1]) sub_screw_hole();
         translate([-(dimbottom[0]/2-3+pad/2), -(dimbottom[1]/2-5+pad/2), 0])
            translate([0, dimbottom[1]/2 + case_wallf, -0.1])
            translate([0, 0, -0.1]) sub_screw_hole();
         translate([(dimbottom[0]/2-3+pad/2), -(dimbottom[1]/2-5+pad/2), 0])
            translate([0, dimbottom[1]/2 + case_wallf, -0.1])
            translate([0, 0, -0.1]) sub_screw_hole();
      } 
}

module sub_screw_hole() {
   cylinder(h = 15, r = 2.1/2, $fn=100);
   cylinder(h = 2, r1 = 2.5, r2 = 0.5, $fn=100);
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