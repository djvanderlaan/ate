
$fn=100;

grid = 19.05;

cross_height = 5+3.3-1.5+1;
cross_width = 1.5;
raster_height = 5-1.5;
nwidth = 12;
nlength = 5;
wall = 2;
rwall = 4;
hwall = 5+3.3+1.5+6;
width = grid*nwidth;
length = grid*nlength;

use<scad/beveled_cube.scad>


// how far does switch stick out at the back of the plate:
// https://switches-sensors.zf.com/wp-content/uploads/2012/07/Keymodule_MX_EN.pdf
// 5 mm thickness swith
// 3.3 mm length pins
// -1.5 thickness plate
// 5 + 3.3 - 1.5

color("red")
linear_extrude(1.45)
  translate([-0.0947, -0.2578])
  import("plate_base.dxf", convexity = 10);
  
 
translate([(width)/2, length/2, -20+1.45])
difference() {
  beveled_cube([width+20, length+20,20], [5,5], 5, [5,5]);
  translate([-width/2, -length/2, -1])
    cube([width, length, 20+2]);  
  translate([0, 0, 1.5])
    beveled_cube([width+20-8, length+20-8,20-3], [5,5], 1, [5,5]);  
}



echo(width+20, length+20);

