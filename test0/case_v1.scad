$fn=100;

grid = 19.05;

cross_height = 5+3.3-1.5+1;
cross_width = 1.5;
raster_height = 5-1.5;
nwidth = 3;
nlength = 4;
wall = 2;
rwall = 4;
hwall = 5+3.3+1.5+6;

use<rounded_cube.scad>
include<microproholder_v0.0.scad>

// how far does switch stick out at the back of the plate:
// https://switches-sensors.zf.com/wp-content/uploads/2012/07/Keymodule_MX_EN.pdf
// 5 mm thickness swith
// 3.3 mm length pins
// -1.5 thickness plate
// 5 + 3.3 - 1.5

color("red")
linear_extrude(1.5)
  translate([-0.095, -0.258])
  import("plate_base.dxf", convexity = 10);

// Crosses
translate([1*grid, 1*grid, 0]) 
  cross(cross_height, cross_width, nocross = true);
translate([1*grid, 2*grid, 0]) 
  cross(cross_height, cross_width);
translate([2*grid, 2*grid, 0]) 
  cross(cross_height, cross_width);
translate([1*grid, 3*grid, 0]) 
  cross(cross_height, cross_width);
translate([2*grid, 3*grid, 0]) 
  cross(cross_height, cross_width);
translate([2*grid, 1*grid, 0]) 
  cross(cross_height, cross_width);

// Raster; left to right
translate([0, -cross_width/2+1*grid, -raster_height])
  cube([3*grid, cross_width, raster_height]);
translate([0, -cross_width/2+2*grid, -raster_height])
  cube([3*grid, cross_width, raster_height]);
translate([0, -cross_width/2+3*grid, -raster_height])
  cube([3*grid, cross_width, raster_height]);
// Raster; bottom to top
translate([-cross_width/2+1*grid, grid, -raster_height])
  cube([cross_width, 3*grid, raster_height]);
translate([-cross_width/2+2*grid, 0, -raster_height])
  cube([cross_width, 4*grid, raster_height]);


wwall = nwidth*grid+2*wall;
lwall = nlength*grid+2*wall;



difference() {
  translate([0, 0, -hwall+1.5])
    translate([wwall/2-wall, lwall/2-wall, 0])
    rounded_cube([wwall, lwall, hwall], rwall);
  translate([0, 0, -hwall+1.5])
    translate([0.01, 0.01, -1])
    cube([nwidth*grid-0.02, nlength*grid-0.02, hwall+2]);
  // usb hole
  translate([grid, nlength*grid-1, -cross_height-3.5/2-bthick])
    rotate([-90, 0, 0])
    rounded_cube([busb+0.5, 3.5, wall+2], 1.75);  
  // slot for plate
  translate([grid-bwidth/2, nlength*grid-1, -cross_height-bthick-0])
    cube([bwidth, wall, bthick+0]);
}



//color("pink")
//translate([grid, nlength*grid-blength, -cross_height])
//mirror([0, 0, 1])
//  #microprocase();

//color("green")
//translate([grid-bwidth/2, nlength*grid-1, -cross_height-bthick-0])
//cube([bwidth, wall, bthick+0]);

translate([grid-cross_width/2, nlength*grid+1-5-blength-0.5, -cross_height-bheight])
  cube([cross_width, 5, bheight]);

translate([grid-cross_width/2, nlength*grid+1-cross_width-blength-0.5, -cross_height])
rotate([0, 0, 90])
wedge([cross_width, 4, 4]);

translate([grid+cross_width/2, nlength*grid+1-cross_width-blength-0.5, -cross_height])
mirror([1, 0, 0])
rotate([0, 0, 90])
wedge([cross_width, 4, 4]);

translate([grid-(cross_width+2*4)/2, nlength*grid+1-cross_width-blength-0.5, -cross_height-bheight])
cube([cross_width+2*4, cross_width, bheight]);

echo(blength);


module cross(height = 5, width = 1.5, nocross = false) {
  difference() {
    union() {
      translate([0, 0, -height])
        cylinder(r=2.8, h=height);    
      if (!nocross) {
        translate([-10, -width/2, -height])
          cube([14, width, height]);
        translate([-width/2, -8, -height])
          cube([width, 13, height]);
      }
    }
    translate([0, 0, -height-0.01])
      cylinder(r=3.2/2, h =2.1);
  }
}

