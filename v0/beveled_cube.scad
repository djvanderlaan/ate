
dim           = [50, 70, 20];
bevel_top     = [5,1];
bevel_bottom  = [10, 10];
bevel_sides   = [10, 8];




//translate([0, dim[1]*0.5-bevel_top[0]])
//rotate([90, 0, 90])
//linear_extrude(dim[0]*0.5-bevel_sides[1])
//  triangle(bevel_top);
//
//translate([dim[0]*0.5-bevel_sides[1], dim[1]*0.5-bevel_sides[0]])
//corner(bevel_sides, bevel_top);
//
//
//translate([dim[0]*0.5-bevel_top[0], 0])
//mirror([0,1,0])
//rotate([90, 0, 0])
//linear_extrude(dim[1]*0.5-bevel_sides[0])
//  triangle(bevel_top);

top([dim[0], dim[1], bevel_sides, bevel_top]);

module top(dim, bevel1, bevel2) {
  dx = dim[0]
  polyhedron(
    points = [
      [0, 0, 0],    
      [bevel1[1], 0, 0],
      [bevel1[1]-bevel2[0], 0, bevel2[1]],
      [0, 0, bevel2[1]],
      [0, bevel1[0], 0],
      [0, bevel1[0]-bevel2[0], bevel2[1]],
    ], 
    faces = [
      [0,3,2,1],
      [1,2,5,4],
      [0,4,5,3],
      [0,1,4],
      [2,3,5]
    ]
  );
}

module corner(bevel1, bevel2) {
  polyhedron(
    points = [
      [0, 0, 0],    
      [bevel1[1], 0, 0],
      [bevel1[1]-bevel2[0], 0, bevel2[1]],
      [0, 0, bevel2[1]],
      [0, bevel1[0], 0],
      [0, bevel1[0]-bevel2[0], bevel2[1]],
    ], 
    faces = [
      [0,3,2,1],
      [1,2,5,4],
      [0,4,5,3],
      [0,1,4],
      [2,3,5]
    ]
  );
}


module tetrahedron(dim) {
  polyhedron(
    points = [
      [0, 0, 0],
      [dim[0], 0, 0],
      [0, 0, dim[2]],
      [0, dim[1], 0]
    ], 
    faces = [
      [0, 2, 1],
      [1, 2, 3],
      [0, 3, 2],
      [0, 3, 1]
    ]
  );
}


module triangle(dim) {
  polygon([
    [0, 0],
    [0, dim[1]],
    [dim[0], 0]
  ]);
}