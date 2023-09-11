$fn=100;

grid = 19.05;

cross_height = 5;
cross_width = 1.5;

// how far does switch stick out at the back of the plate:
// https://switches-sensors.zf.com/wp-content/uploads/2012/07/Keymodule_MX_EN.pdf
// 5 mm thickness swith
// 3.3 mm length pins
// -1.5 thickness plate
// 5 + 3.3 - 1.5

//color("red")
//linear_extrude(1.5)
//translate([-0.095, -0.258])
//import("plate_base.dxf", convexity = 10);


//translate([0, 0, -1])
//cube([3*grid, 4*grid, 1]);

module cross(height = 5, width = 1.5, nocross = false) {
  translate([0, 0, -height])
    cylinder(r=2, h=height);
  if (!nocross) {
    translate([-10, -width/2, -height])
      cube([14, width, height]);
    translate([-width/2, -8, -height])
      cube([width, 13, height]);
  }
}

//translate([1*grid, 1*grid, 0]) 
//  cross(cross_height, cross_width, nocross = true);
//translate([1*grid, 2*grid, 0]) 
//  cross(cross_height, cross_width);
//translate([2*grid, 2*grid, 0]) 
//  cross(cross_height, cross_width);
//translate([1*grid, 3*grid, 0]) 
//  cross(cross_height, cross_width);
//translate([2*grid, 3*grid, 0]) 
//  cross(cross_height, cross_width);
//translate([2*grid, 1*grid, 0]) 
//  cross(cross_height, cross_width);
//
//translate([0, -cross_width/2+1*grid, -1.5])
//  cube([3*grid, cross_width, 1.5]);
//translate([0, -cross_width/2+2*grid, -1.5])
//  cube([3*grid, cross_width, 1.5]);
//translate([0, -cross_width/2+3*grid, -1.5])
//  cube([3*grid, cross_width, 1.5]);
//
//translate([-cross_width/2+1*grid, grid, -1.5])
//  cube([cross_width, 3*grid, 1.5]);
//translate([-cross_width/2+2*grid, 0, -1.5])
//  cube([cross_width, 4*grid, 1.5]);


blength  = 33.6;
bwidth   = 17.9;
bthick   = 0.9;
bheight  = 4.5;
busb     = 9;
bmiddlew = 11.5;

cthick = 1;
cwall = 2;
cfront = 2.4;

translate([0, 0, cthick+0.1])
color("darkred") {
translate([-bwidth/2, 0, 0])
  cube([bwidth, blength, bthick]);
translate([-busb/2, blength-10, 0])
  cube([busb, 10, bheight]);
translate([-bmiddlew/2, 2.5, 0])
  cube([bmiddlew, blength-5, bthick+0.2]);
}

translate([-bmiddlew/2, -cwall, 0])
  cube([bmiddlew, blength+cwall*2, cthick]);
translate([-bwidth/2, blength-cfront, 0])
  cube([bwidth, cfront+cwall, cthick]);

translate([-bmiddlew/2, -cwall, 0])
  cube([bmiddlew, cwall, bheight+cthick]);

translate([-bwidth/2, blength, 0])
  cube([(bwidth-busb)/2, cwall, bheight+cthick]);
translate([busb/2, blength, 0])
  cube([(bwidth-busb)/2, cwall, bheight+cthick]);

translate([-bwidth/2, blength-1, cthick+bthick+0.5])
  cube([(bwidth-busb)/2, 1, bheight-bthick-0.5]);
translate([busb/2, blength-1, cthick+bthick+0.5])
  cube([(bwidth-busb)/2, 1, bheight-bthick-0.5]);
