$fn=100;

grid = 19.05;
nwidth = 3;
nlength = 4;

botpad = [1, 1];
botthickness2 = 1;
botheight = 6;
botthickness1 = 3;

difference() {
  
  union() {
    translate([botpad[0]/2, botpad[1]/2, 0])
      cube([nwidth*grid-botpad[0], nlength*grid-botpad[1], botthickness1]);
    
    // pins
    translate([1*grid, 1*grid, 0])
      cylinder(r = 2.5, h = botheight);
    translate([1*grid, 2*grid, 0])
      cylinder(r = 2.5, h = botheight);
    translate([1*grid, 3*grid, 0])
      cylinder(r = 2.5, h = botheight);
    translate([2*grid, 3*grid, 0])
      cylinder(r = 2.5, h = botheight);
  }
  
  // usbhole
  translate([nwidth*grid-9-23, -1, botthickness2])
    cube([25, 30.33+1+10, botthickness1]);
  // reset hole
  translate([nwidth*grid-23, 30.33, -1])
    cylinder(r = 3.5/2, h = botthickness1+2);
  
  
  translate([1*grid, 1*grid, botheight-2.99])
    cylinder(r = 1, h = 3);
  translate([1*grid, 2*grid, botheight-2.99])
    cylinder(r = 1, h = 3);
  translate([1*grid, 3*grid, botheight-2.99])
    cylinder(r = 1, h = 3);
  translate([2*grid, 3*grid, botheight-2.99])
    cylinder(r = 1, h = 3);
}




//$fn=100;
//
//grid = 19.05;
//nwidth = 3;
//nlength = 4;
//
//
//botthickness = 1;
//botheight = 8;
//botwall = 1;
//
//difference() {
//  cube([nwidth*grid, nlength*grid, botheight]);
//  translate([botwall, botwall, botthickness])
//    cube([nwidth*grid-2*botwall, nlength*grid-2*botwall, botheight]);
//  
//  // usbhole
//  translate([nwidth*grid-9-23, -1, botthickness])
//    cube([23, botwall+2, botheight]);
//  // reset hole
//  
//  translate([nwidth*grid-23, 30.33, -1])
//  cylinder(r = 3.5/2, h = botthickness+2);
//}
