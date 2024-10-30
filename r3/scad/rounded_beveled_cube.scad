use<rounded_cube.scad>

module bevel_base(width, height, offset = 0) {
  if (offset > 0) {
    polygon([ [0, 0], [offset + width, 0], [offset, height], [0, height] ]);
  } else {
    polygon([ [0, 0], [width, 0], [0, height] ]);
  }
}

module top_quart(width, height, radius, bevel) {
  translate([width*0.5-radius, height*0.5-radius])
    rotate_extrude(angle = 90)
    bevel_base(bevel[0], bevel[1], offset = radius - bevel[0]);
  translate([width*0.5-radius, height*0.5-radius])
    rotate([90, 0, 0])
    linear_extrude(height*0.5-radius)
    bevel_base(bevel[0], bevel[1], offset = radius - bevel[0]);
  translate([0, height*0.5-radius])
    rotate([90, 0, 90])
    linear_extrude(width*0.5-radius)
    bevel_base(bevel[0], bevel[1], offset = radius - bevel[0]);
  cube([width*0.5-radius, height*0.5-radius, bevel[1]]);
}

module top(width, height, radius, bevel) {
  top_quart(width, height, radius, bevel);
  mirror([1,0,0]) top_quart(width, height, radius, bevel);
  mirror([0,1,0]) top_quart(width, height, radius, bevel);
  mirror([0,1,0]) mirror([1,0,0]) top_quart(width, height, radius, bevel);
}

module rounded_beveled_cube(dim, radius, bevel_top, bevel_bottom) {
  translate([0, 0, dim[2]-bevel_top[1]])
    top(dim[0], dim[1], radius, bevel_top);
  translate([0, 0, bevel_bottom[1]])
    rounded_cube([dim[0], dim[1], dim[2]-bevel_top[1]-bevel_bottom[1]], radius);
  translate([0, 0, bevel_bottom[1]])
    mirror([0, 0, 1])
    top(dim[0], dim[1], radius, bevel_bottom);
}