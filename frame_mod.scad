// Corner bracket replacement piece
// Adjust these constants to fit your frame

arm_length       = 55.5;  // length of each arm of the L
arm_width        = 24.0;  // width of each arm
height           = 15.0;  // protruding corner height (not full frame thickness)

// Hole positions measured from the piece's outer corner face
// (= frame inner wall face, since piece sits inside 1.5mm frame walls)
// C_Frame_AC_Accurate: holes at 24.0mm from frame outer edge → 24.0-1.5 = 22.5mm from inner face ≈ 22.7mm panel hole
spacer_from_outer = 22.7;  // panel screw / spacer center — matches panel hole offset
pad_from_outer    = 9.525; // pad-to-frame screw center (outer of the two, from C_Frame: 9.5mm from inner wall face)

// Rivet nut specs (M6, hex body, flange at bottom)
rivet_flange_od  = 13.5;  // flange outer diameter
rivet_flange_h   = 1.5;   // flange thickness (estimate — measure and tune)
rivet_body_od    = 8.8;   // hex body OD (across corners)
rivet_total_h    = 15.0;  // total height (flange + body)
rivet_clearance  = 0.4;   // extra clearance on body for press fit

// Pad-to-frame screw half-hole
pad_screw_dia   = 9;      // diameter
half_hole_depth = height / 2;

// Side frame-mount holes (one per arm, stepped for M5 screw + head pocket)
side_hole_spacing = 35;   // center-to-center from pad hole
side_thread_dia   = 6;    // bottom/through part (screw thread clearance)
side_head_dia     = 9;    // top counterbore for screw head
side_head_depth   = 11;    // counterbore depth from top (tunable)

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
                cylinder(h = height, d = rivet_flange_od + 8);
        }

        // Rivet nut flange recess (bottom face)
        translate([spacer_cx, spacer_cy, -0.1])
            cylinder(h = rivet_flange_h + 0.1, d = rivet_flange_od);

        // Rivet nut body hole — hex, full remaining height, rotated 45°
        translate([spacer_cx, spacer_cy, rivet_flange_h - 0.1])
            rotate([0, 0, -45])
            cylinder(h = rivet_total_h - rivet_flange_h + 0.2,
                     d = rivet_body_od + rivet_clearance, $fn = 6);

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
