
// Dimensions of the board
blength  = 33.6+0.3;
bwidth   = 17.9;
bthick   = 0.9;
bheight  = 4.5;
// Height of the USB port; measured from the bottom of 
// plate
busb     = 9.5;
// Width of the board minus the width of the connector
// pins
bmiddlew = 11.5;
bmiddlew2 = 5;


function micropro_length() = blength;
function micropro_width() = bwidth;


module micropro_example() {
  color("darkred") {
  translate([-bwidth/2, 0, 0])
    cube([bwidth, blength, bthick]);
  translate([-busb/2, blength-10, 0])
    cube([busb, 10, bheight]);
  translate([-bmiddlew/2, 2.5, 0])
    cube([bmiddlew, blength-5, bthick+0.2]);
  }
}

micropro_example();
