
// ==================================================================
// === PARAMETERS
// ==================================================================

// == Parameters for LCD
screen_width      = 202.00;
screen_height     = 134.00;
screen_thickness  = 2; 
screen_bevel      = [8, 3, 3, 3]; // top, right, bottom, left

// Derived paramers
// screen is not completely center in the panel at the top of the panel there is
// at bit more space; therefore the hole for the screen needs to move offset up
// first is left; second top
screen_offset     = [(screen_bevel[3]-screen_bevel[1])/2, 
    (screen_bevel[0]-screen_bevel[2])/2];
// Dimensions of bevel
screen_bwidth     = screen_width-screen_bevel[1]-screen_bevel[3];
screen_bheight    = screen_height-screen_bevel[0]-screen_bevel[2]; 



screen();

// ==================================================================
// === MODULE SCREENHOLE
// ==================================================================
// Hole that needs to be in model for LCD screen to fit

module screenhole(height1 = 20, height2 = 20) {
   translate([screen_offset[0], screen_offset[1], 0])
      ccube([screen_width, screen_height, height1]);
   translate([0, 0, -height2+0.1])
      ccube([screen_bwidth, screen_bheight, height2]);
}


// ==================================================================
// === MODULE SCREEN
// ==================================================================
// Dummy of LCD screen

module screen() {
   color("pink")
      translate([screen_offset[0], screen_offset[1], 0])
      ccube([screen_width, screen_height, screen_thickness]);
   color("black") 
      translate([0, 0, -screen_thickness+0.1])
      ccube([screen_bwidth, screen_bheight, screen_thickness]);
}


// ==================================================================
// === MODULE CCUBE
// ==================================================================
// x-y centred cube

module ccube(dim) {
   translate([-dim[0]/2, -dim[1]/2, 0])
      cube(dim);
}



