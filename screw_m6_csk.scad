// M6 countersunk (flat head) screw — ISO 10642 / DIN 7991
// Length is measured from top of head to tip (standard for countersunk)

screw_length = 12;   // total length head-top to tip
dk = 12.0;           // head diameter
k  = 3.6;            // head height (conical, 90°)
d  = 6.0;            // shaft diameter

$fn = 64;

module screw_m6_csk(length = screw_length) {
    shaft_len = length - k;
    union() {
        // Countersunk head: cone from dk at top to d at bottom
        cylinder(h = k, d1 = d, d2 = dk);
        // Shaft going downward
        translate([0, 0, -shaft_len])
            cylinder(h = shaft_len, d = d);
    }
}

screw_m6_csk();
