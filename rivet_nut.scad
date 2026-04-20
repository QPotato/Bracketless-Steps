// Rivet nut — M6, hex body, flanged

flange_od  = 13;
flange_h   = 1.5;
body_od    = 8.8;   // hex across corners
body_h     = 13.5;  // = total_h - flange_h
thread_d   = 5.0;   // M6 minor diameter (simplified, no real thread)

$fn = 64;

module rivet_nut() {
    difference() {
        union() {
            cylinder(h = flange_h, d = flange_od);
            translate([0, 0, flange_h])
                cylinder(h = body_h, d = body_od, $fn = 6);
        }
        translate([0, 0, -0.1])
            cylinder(h = flange_h + body_h + 0.2, d = thread_d);
    }
}

rivet_nut();
