// M6×20 round sleeve (coupling sleeve)
// OD: 10mm, length: 20mm, M6 through thread

od  = 10.0;
len = 20.0;

$fn = 64;

// Origin at bottom face; extends upward.
module coupling_nut() {
    difference() {
        cylinder(h = len, d = od);
        translate([0, 0, -0.1])
            cylinder(h = len + 0.2, d = 5.0);
    }
}

coupling_nut();
