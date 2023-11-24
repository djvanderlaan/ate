
// Beveled cube
//
// dim: dimensions of the cube
// bevel_top: 2d array width the dimensions of the bevel used
//   at the top of the cube. The first element specifies the 
//   amount the bevel goed towards the z-axis. The second
//   element the height of the bevel.
// bevel_size: single value with the dimension of the side 
//   bevel
// bevel_bottom: 2d array for the bottom bevel. See 
//   bevel_top. 
//
// The cube is centered at the origin for the x and y axis and 
// the bottom of the cube is positioned at z=0. 
// 
// Example:
// dim = [200, 100, 20];
// bevel_top  = [10, 3];
// bevel_side  = 8;
// bevel_bottom  = [4, 4];
// beveled_cube(dim, bevel_top, bevel_side, bevel_bottom);
//
module beveled_cube(dim, bevel_top, bevel_side, bevel_bottom) {
  d = [dim[0]*0.5, dim[1]*0.5, dim[2]];
  beveled_cube_q(d, bevel_top, bevel_side, bevel_bottom);
  mirror([1, 0, 0])
    beveled_cube_q(d, bevel_top, bevel_side, bevel_bottom);
  mirror([0, 1, 0])
    beveled_cube_q(d, bevel_top, bevel_side, bevel_bottom);
  mirror([1, 0, 0]) mirror([0, 1, 0])
    beveled_cube_q(d, bevel_top, bevel_side, bevel_bottom);
}

// Utility function for beveled_cube
module beveled_cube_q(dim, bt, bs, bb) {
  // top
  translate([0, 0, dim[2]-bt[1]])
    bevels([dim[0], dim[1], bt[1]], bt[0], bs);
  // middle
  translate([0, 0, bb[1]])
    bevels([dim[0], dim[1], dim[2]-bt[1]-bb[1]], 0, bs);
  //bottom
  translate([0, 0, bb[1]])
    mirror([0, 0, 1])
    bevels([dim[0], dim[1], bb[1]], bb[0], bs);
}

// Utility function for beveled_cube
module bevels(dim, bt, bs) {
  polyhedron(
    points = [
      [0, 0, 0], // 0
      [dim[0], 0, 0], // 1
      [dim[0]-bt, 0, dim[2]], // 2
      [0, 0, dim[2]],  // 3
      [dim[0], dim[1]-bs, 0], //4 
      [dim[0]-bt, min(dim[1]-bt, dim[1]-bs), dim[2]], //5
      [0, dim[1], 0],  // 6
      [dim[0]-bs, dim[1], 0], //7 
      [min(dim[0]-bt, dim[0]-bs), dim[1]-bt, dim[2]], //8
      [0, dim[1]-bt, dim[2]] //9
    ],
    faces = [
      [3, 9, 8, 5, 2], //top
      [0, 3, 2, 1], //front
      [0, 6, 9, 3], //left 
      [6, 7, 8, 9], // back
      [7, 4, 5, 8], // back-side-bevel
      [1, 2, 5, 4], // right side
      [0, 1, 4, 7, 6] // bottom
    ]
  );
}
