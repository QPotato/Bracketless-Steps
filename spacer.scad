// M6 male-female standoff (spacer)
// Body: 8mm OD, 10mm tall, M6 female thread inside
// Stud: M6 male thread, 6mm OD, 8mm long, below body

body_od      = 8.0;
body_h       = 10.0;
stud_d       = 6.0;
stud_h       = 8.0;
thread_d     = 5.0;
thread_depth = 8.0;

$fn = 64;

module spacer() {
    difference() {
        union() {
            cylinder(h = body_h, d = body_od);
            translate([0, 0, -stud_h])
                cylinder(h = stud_h, d = stud_d);
        }
        translate([0, 0, body_h - thread_depth])
            cylinder(h = thread_depth + 0.1, d = thread_d);
    }
}

spacer();
