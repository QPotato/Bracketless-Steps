// DIN 933 M6×10 full-thread hex bolt

head_af = 10.0;   // across flats
head_h  =  4.0;   // head height
shaft_d =  6.0;   // shaft diameter
shaft_l = 10.0;   // shaft length (under-head to tip)

$fn = 64;

// Origin at bottom of head; shaft extends upward.
module screw_m6_din933(length = shaft_l) {
    union() {
        cylinder(h = head_h, d = head_af / cos(30), $fn = 6);
        translate([0, 0, head_h])
            cylinder(h = length, d = shaft_d);
    }
}

screw_m6_din933();
