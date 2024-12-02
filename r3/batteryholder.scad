




bat_h = 19;
bat_w = 37-0.5;
bat_l = 67;
bat_t = 4;
bat_b = 1;

batteryholder(10, 20);

module batteryholder(extend = 0, extendy = 0) {
   difference() {
   union() {
      batclam(10);
      translate([0, bat_l-10, 0])
         batclam(10);  
      translate([-bat_w/2, -extendy, 0])
         cube([bat_w+extend, bat_l+extendy, bat_b]);
      translate([+bat_w/2, -extendy, 0])
         cube([extend, bat_l+extendy, 4]);
      
   }
      translate([-bat_w, -extendy-1, -10])
         cube([bat_w+extend, bat_l+extendy+2, bat_h+20]);
   }

   translate([-15+bat_w/2, -3, 0])
      cube([extend+15, 3, 8]);
   translate([-15+bat_w/2, bat_l-0.01, 0])
      cube([extend+15, 3, 8]);
}

module batclam(l = 10) {
   difference() {
      translate([0, 0, -(bat_t-bat_b)])
         rounded(bat_w+2*bat_t, bat_h+2*bat_t, l);
      translate([0, -1, bat_b])
         rounded(bat_w, bat_h, l+2);
      translate([-(bat_w+15)/2, -2, bat_h+bat_b-5])
         cube([bat_w+15, l+4, 20]);
      translate([-(bat_w-bat_h+6)/2, -1, bat_h-bat_t-1])
         cube([bat_w-bat_h+6, l+2, 20]);
      translate([-(bat_w+4)/2, -2, -20])
         cube([bat_w+4, l+4, 20]);
   }
}



module rounded(w, h, l) {
   router = h/2;
   translate([0, 0, router])
   rotate([-90, 0,0 ]) {
      translate([-w/2+router, 0, 0])
         cylinder(r = router, h = l);
      translate([+w/2-router, 0, 0])
         cylinder(r = router, h = l);
      translate([-w/2+router, -router, 0])
         cube([w-2*router, 2*router, l]);
   }
}