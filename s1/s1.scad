
use<scad/beveled_cube.scad>

$fn=100;

view_case = false;
view_lens_holder = true;

dim = [155, 80, 100];
bevel_top  = [0, 0];
bevel_side  = 15;
bevel_bottom  = [0, 0];
wall = 3;

if (view_case) {

  difference() {
    beveled_cube(dim, bevel_top, bevel_side, bevel_bottom);
    translate([0, 0, -1])
      beveled_cube(dim-[2*wall, 2*wall,-2], 
        [0, 0], bevel_side-wall/sqrt(2), [0, 0]);
    
    head();
    nose_hole_for_case();
    translate([-dim[0]/2, +bolt_y_offset, 10]) side_slot();
    translate([-dim[0]/2, -bolt_y_offset, 10]) side_slot();
    translate([+dim[0]/2, +bolt_y_offset, 10]) mirror([1, 0, 0]) side_slot();
    translate([+dim[0]/2, -bolt_y_offset, 10]) mirror([1, 0, 0]) side_slot();
    top_slots();
    bottom_slots();
  }

}

inner_dim = [dim[0]- 2*wall-1, dim[1] - 2*wall-1];
inner_bevel = bevel_side-wall/sqrt(2);


head_r = 75;
head_offset = 25;


module nose_hole_for_case() {
  translate([0, -dim[1]/2, head_r-head_offset+nose_base])
  rotate([90, 0, 0])
  nose_hole_for_viewer();
}

module head() {
  translate([0, dim[1], -head_offset])
  rotate([90, 0, 0])
  cylinder(r = head_r, h = dim[1]*2);
}

module side_slot() {
  translate([0, 0, (dim[2]-20)/2])
  rotate([0, 90, 0]) {
  translate([0, 0, -10+1.5])
    beveled_cube([dim[2]-20, 6, 10], [0, 0], 1, [0, 0]);
  beveled_cube([dim[2]-20-3, 3.2, 10], [0, 0], 1, [0, 0]);
  }
}


top_slot_d = 18;


module bottom_slots() {
  mirror([0, 1, 0]) {
  //translate([ 0*top_slot_d, dim[1]/2, dim[2]-10]) top_slot(20);
  //translate([ 1*top_slot_d, dim[1]/2, dim[2]-10]) top_slot(25);
  translate([ 2*top_slot_d, dim[1]/2, dim[2]-10]) top_slot(30);
  translate([ 3*top_slot_d, dim[1]/2, dim[2]-10]) top_slot(40);
  //translate([-1*top_slot_d, dim[1]/2, dim[2]-10]) top_slot(25);
  translate([-2*top_slot_d, dim[1]/2, dim[2]-10]) top_slot(30);
  translate([-3*top_slot_d, dim[1]/2, dim[2]-10]) top_slot(40);
  }
}

module top_slots() {
  translate([ 0*top_slot_d, dim[1]/2, dim[2]-10]) top_slot(20);
  translate([ 1*top_slot_d, dim[1]/2, dim[2]-10]) top_slot(25);
  translate([ 2*top_slot_d, dim[1]/2, dim[2]-10]) top_slot(30);
  translate([ 3*top_slot_d, dim[1]/2, dim[2]-10]) top_slot(40);
  translate([-1*top_slot_d, dim[1]/2, dim[2]-10]) top_slot(25);
  translate([-2*top_slot_d, dim[1]/2, dim[2]-10]) top_slot(30);
  translate([-3*top_slot_d, dim[1]/2, dim[2]-10]) top_slot(40);
}

module top_slot(h = 20) {
  rotate([0, 0, -90])
  translate([0, 0, -h/2])
  rotate([0, 90, 0]) {
  translate([0, 0, -10+1.5])
    beveled_cube([h, 6, 10], [0, 0], 1, [0, 0]);
  beveled_cube([h-3, 3.2, 10], [0, 0], 1, [0, 0]);
  }
}



// ===========================================================================
// === LENS HOLDER


lens_r = 25.2;
lens_thickn = 3;
inter_eye = 68;

nose_top = 14;
nose_base = 36;
nose_h    = 40;

bolt_y_offset = 10;
bolt_inset_r = 2;

if (view_lens_holder) {

  difference() {
    beveled_cube([inner_dim[0], inner_dim[1], lens_thickn+2], [0,0], inner_bevel, [0,0]);
    translate([-inter_eye/2, 0, 2])
      cylinder(r = lens_r, h = lens_thickn+1);
    translate([-inter_eye/2, 0, -1])
      cylinder(r = lens_r-2.5, h = 4);
    translate([+inter_eye/2, 0, 2])
      cylinder(r = lens_r, h = lens_thickn+1);
    translate([+inter_eye/2, 0, -1])
      cylinder(r = lens_r-2.5, h = 4);
    nose_hole_for_viewer(); 
    
    //extra bit removed by nose as edge of lens is too narrow to print
    translate([-25, -inner_dim[1]/2+nose_h-15, 2])
      cube([50, 15, 10]); 

  }



  translate([-inner_dim[0]/2, 0, lens_thickn+2])
  difference() {
    beveled_cube([13, 30, 10], [2, 6], 0, [0, 0]);
    translate([-10, -16, -1])
      cube([10, 32, 12]);
    translate([-1, bolt_y_offset, 5])
      rotate([0, 90, 0])
      cylinder(r = bolt_inset_r, h = 100);
    translate([-1, -bolt_y_offset, 5])
      rotate([0, 90, 0])
      cylinder(r = bolt_inset_r, h = 100); 
  }
  translate([inner_dim[0]/2, 0, lens_thickn+2])
  mirror([1, 0, 0])
  difference() {
    beveled_cube([13, 30, 10], [2, 6], 0, [0, 0]);
    translate([-10, -16, -1])
      cube([10, 32, 12]);
    translate([-1, bolt_y_offset, 5])
      rotate([0, 90, 0])
      cylinder(r = bolt_inset_r, h = 100);
    translate([-1, -bolt_y_offset, 5])
      rotate([0, 90, 0])
      cylinder(r = bolt_inset_r, h = 100); 
  }

}

// Nose
module nose_hole_for_viewer() {
  translate([0, -inner_dim[1]/2, 0])
  rotate([-90, 0, 0])
  translate([0, 0, -nose_h]) 
    beveled_cube([nose_base, 50, nose_h*2], [(nose_base-nose_top)/2, nose_h], 0, [0, 0]);
}




