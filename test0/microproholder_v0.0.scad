$fn=100;

// Dimensions of the board
blength  = 33.6+0.3;
bwidth   = 17.9;
bthick   = 0.9;
bheight  = 4.5;
// Height of the USB port; measured from the bottom of 
// plate
busb     = 9;
// Width of the board minus the width of the connector
// pins
bmiddlew = 11.5;
bmiddlew2 = 5;

// Parameters for the case
// Bottom thickness
cthick = 1;
// Wall thickness
cwall = 1.5;
// Length of the wider part of the bottom at the
// front (usb) of the case
cfront = 2.4;
// Extra space for the slot at the front of the
// case
cpad = 1;


example_board = true;
if (example_board) {
  translate([0, 0, cthick+0.1])
  color("darkred") {
  translate([-bwidth/2, 0, 0])
    cube([bwidth, blength, bthick]);
  translate([-busb/2, blength-10, 0])
    cube([busb, 10, bheight]);
  translate([-bmiddlew/2, 2.5, 0])
    cube([bmiddlew, blength-5, bthick+0.2]);
  }
}


//microprocase();



module wedge(dim) {
  translate([dim[0], 0, 0])
  rotate([0, -90, 0])
  linear_extrude(dim[0])
  polygon([
    [0, 0],
    [dim[2], 0],
    [0, dim[1]]
  ]);
}

module microprocase() {
  // Bottom
  //translate([-bmiddlew/2, -cwall, 0])
  //  cube([bmiddlew, blength+cwall*2, cthick]);
  translate([-bmiddlew2/2, -cwall, 0])
    cube([bmiddlew2, blength+cwall*2, cthick]);
  
  translate([-bwidth/2, blength-cfront, 0])
    cube([bwidth, cfront+cwall, cthick]);

  // Back
  translate([-bmiddlew/2, -cwall, 0])
    cube([bmiddlew, cwall, bheight+cthick]);

  // Front
  translate([-bwidth/2, blength, 0])
    cube([(bwidth-busb)/2, cwall, bheight+cthick]);
  translate([busb/2, blength, 0])
    cube([(bwidth-busb)/2, cwall, bheight+cthick]);
  // left extension
  translate([-bwidth/2, blength-1, cthick+bthick+cpad])
    cube([(bwidth-busb)/2, 1, bheight-bthick-cpad]);
  translate([-bwidth/2, blength, cthick+bthick+cpad])
    mirror([0, 1, 1]) wedge([(bwidth-busb)/2, 1, 1]);
  // right extension
  translate([busb/2, blength-1, cthick+bthick+cpad])
    cube([(bwidth-busb)/2, 1, bheight-bthick-cpad]);
  translate([busb/2, blength, cthick+bthick+cpad])
    mirror([0, 1, 1]) wedge([(bwidth-busb)/2, 1, 1]);
  

}