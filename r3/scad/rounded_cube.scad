
module pie_piece(h, r, angle = 90, start_angle = 0) {
    rotate([0, 0, start_angle])
    rotate_extrude(angle = angle)
    square([r, h]);
}

module rounded_cube(dim, r) {
    dim_cube = dim - [2*r, 0, 0];
    translate([-0.5*dim_cube[0], -0.5*dim_cube[1], 0])
        cube(dim_cube);
    translate([0.5*dim[0]-0.5*r, 0, dim[2]*0.5])
        cube([r, dim[1]-2*r, dim[2]], center = true);
    translate([-0.5*dim[0]+0.5*r, 0, dim[2]*0.5])
        cube([r, dim[1]-2*r, dim[2]], center = true);
    translate([(0.5*dim[0]-r), (0.5*dim[1]-r), 0])
        pie_piece(dim[2], r);
    translate([-(0.5*dim[0]-r), (0.5*dim[1]-r), 0])
        pie_piece(dim[2], r, start_angle = 90);
    translate([-(0.5*dim[0]-r), -(0.5*dim[1]-r), 0])
        pie_piece(dim[2], r, start_angle = 90*2);
    translate([(0.5*dim[0]-r), -(0.5*dim[1]-r), 0])
        pie_piece(dim[2], r, start_angle = 90*3);
}
