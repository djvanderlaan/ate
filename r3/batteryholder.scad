




bat_h = 19;
bat_w = 37;
bat_l = 67;
bat_t = 2;

batteryholder();

module batteryholder(extend = 0) {
   batclam(10);
   translate([0, bat_l-10, 0])
      batclam(10);
      
   translate([-bat_w/2, 0, 0])
      cube([bat_w+extend, bat_l, bat_t]);
}

module batclam(l = 10) {
   difference() {
      rounded(bat_w+2*bat_t, bat_h+2*bat_t, l);
      translate([0, -1, bat_t])
         rounded(bat_w, bat_h, l+2);
      translate([-(bat_w-bat_h+6)/2, -1, bat_h-bat_t-1])
         cube([bat_w-bat_h+6, l+2, 10]);
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