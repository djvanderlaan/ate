
$fn=100;
use<scad/beveled_cube.scad>


length = 30;
thickness = 3;
height = 5.5;
hook = 6;
width = 18+2*5;

difference() {

  cube([width, length+thickness, thickness]);

  translate([5, 6+3.1/2, -1])
    cylinder(r = 3.1/2, h = thickness+2);

  translate([5+18, 6+3.1/2, -1])
    cylinder(r = 3.1/2, h = thickness+2);
}

translate([0, length, 0])
  cube([width, thickness, height+thickness]);
  
translate([0, length, height])
  cube([width, hook+2*thickness, thickness]);

translate([0, length+hook+thickness, height-3])
  cube([width, thickness, thickness+3]);
  
  


bolt_inset_r = 2;

!color("red") {

  difference() {
    
    union() {
      beveled_cube([width, 10, 6], [0.5, 0.5], 2, [0.5,0.5]);
      translate([5-width/2, 0, 0])
        beveled_cube([3, 10, 6+2], [0.5, 0.5], 0, [0, 0]);
      translate([5+18-width/2, 0, 0])
        beveled_cube([3, 10, 6+2], [0.5, 0.5], 0, [0, 0]);
    }
  
  translate([5-width/2, 0, -1])
    cylinder(r = bolt_inset_r, h = 10);
    
  translate([5-width/2, 0, 6])
    cylinder(r = 5/2, h = 10);
  
  translate([5+18-width/2, 0, -1])
    cylinder(r = bolt_inset_r, h = 10);
    
  translate([5+18-width/2, 0, 6])
    cylinder(r = 5/2, h = 10);
  }
  

}

