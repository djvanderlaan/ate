


dim = [50, 30, 5];
bt  = [4, 4];
bs  = [13, 10];

polyhedron(
  points = [
    [0, 0, 0], // 0
    [dim[0], 0, 0], // 1
    [dim[0]-bt[0], 0, dim[2]], // 2
    [0, 0, dim[2]],  // 3
    [dim[0], dim[1]-bs[1], 0], //4 
    [dim[0]-bt[0], dim[1]-bs[1], dim[2]], //5
    [0, dim[1], 0],  // 6
    [dim[0]-bs[0], dim[1], 0], //7 
    [dim[0]-bs[0], dim[1]-bt[1], dim[2]], //8
    [0, dim[1]-bt[1], dim[2]]
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