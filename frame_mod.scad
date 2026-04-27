// Corner bracket replacement piece
// Adjust these constants to fit your frame

arm_length       = 55.5;  // length of each arm of the L
arm_width        = 24.0;  // width of each arm
height           = 15.0;  // protruding corner height (not full frame thickness)

// Hole positions measured from the piece's outer corner face
// (= frame inner wall face, since piece sits inside 1.5mm frame walls)
// C_Frame_AC_Accurate: holes at 24.0mm from frame outer edge → 24.0-1.5 = 22.5mm from inner face ≈ 22.7mm panel hole
spacer_from_outer = 22.7;  // panel screw / spacer center — matches panel hole offset
pad_from_outer    = 10; // pad-to-frame screw center (outer of the two, from C_Frame: 9.5mm from inner wall face)

// DIN 933 M6 hex bolt head (captured in pocket at bottom face)
bolt_head_af  = 10.5;  // across flats
bolt_head_h   =  4.0;  // head height
bolt_clearance =  0.4;  // hex pocket clearance

// M6×20 round sleeve (10mm OD)
sleeve_od        = 10.5          ;
sleeve_clearance =  0.3;

// Pad-to-frame screw half-hole
pad_screw_dia   = 10;      // diameter
half_hole_depth = height / 2;

// Side frame-mount holes (one per arm, stepped for M5 screw + head pocket)
side_hole_spacing = 35;   // center-to-center from pad hole
side_thread_dia   = 6;    // bottom/through part (screw thread clearance)
side_head_dia     = 10;    // top counterbore for screw head
side_head_depth   = 10;    // counterbore depth from top (tunable)

// Derived
spacer_cx = spacer_from_outer;
spacer_cy = spacer_from_outer;
pad_cx    = pad_from_outer;
pad_cy    = pad_from_outer;
side_x_cx = pad_cx + side_hole_spacing;
side_x_cy = pad_cy;
side_y_cx = pad_cx;
side_y_cy = pad_cy + side_hole_spacing;

$fn = 64;

module corner_piece() {
    difference() {
        // L-shape body + reinforcement boss around rivet nut
        union() {
            cube([arm_length, arm_width, height]);
            cube([arm_width, arm_length, height]);
            translate([spacer_cx, spacer_cy, 0])
                cylinder(h = height, d = sleeve_od + 8);
        }

        // Hex bolt head pocket (bottom face) — captures DIN 933 M6 head
        translate([spacer_cx, spacer_cy, -0.1])
            cylinder(h = bolt_head_h + 0.1,
                     d = bolt_head_af / cos(30) + bolt_clearance, $fn = 6);

        // Round sleeve through-hole — M6×20, 10mm OD
        translate([spacer_cx, spacer_cy, bolt_head_h - 0.1])
            cylinder(h = height - bolt_head_h + 0.2,
                     d = sleeve_od + sleeve_clearance);

        // Pad-to-frame half-hole (blind from bottom)
        translate([pad_cx, pad_cy, -0.1])
            cylinder(h = half_hole_depth + 0.1, r = pad_screw_dia/2);

        // Side hole on X arm: 6mm through + 9mm top counterbore
        translate([side_x_cx, side_x_cy, -0.1])
            cylinder(h = height + 0.2, r = side_thread_dia/2);
        translate([side_x_cx, side_x_cy, height - side_head_depth])
            cylinder(h = side_head_depth + 0.1, r = side_head_dia/2);

        // Side hole on Y arm: 6mm through + 9mm top counterbore
        translate([side_y_cx, side_y_cy, -0.1])
            cylinder(h = height + 0.2, r = side_thread_dia/2);
        translate([side_y_cx, side_y_cy, height - side_head_depth])
            cylinder(h = side_head_depth + 0.1, r = side_head_dia/2);
    }
}

corner_piece();
