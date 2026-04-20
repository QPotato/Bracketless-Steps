// C-frame for PIU bracketless conversion
// Reference: C_Frame_AC_Accurate.stl (279.4×279.4×16.5mm)

// Defaults (used when opening this file standalone)
frame_w  = 278;    // panel width  → used as default for both axes
frame_h  = 278;    // panel height

// Fixed dimensions
wall_t   = 1.5;
fh       = 16.5;   // total frame height
arm_len  = 55.5;   // must match frame_mod.scad
arm_w    = 24.0;
piece_h  = 15.0;
arm_beam_h = 5.5;  // side arm height (from STL reference)

pad_from_outer    = 9.525;
side_hole_spacing = 35;
screw_hole_d      = 6.5;   // M6 clearance

$fn = 32;

module corner_holes() {
    ph  = wall_t + pad_from_outer;
    leg = wall_t + pad_from_outer + side_hole_spacing;
    for (pos = [[ph, ph], [leg, ph], [ph, leg]])
        translate([pos[0], pos[1], -0.1])
            cylinder(h = fh + 0.2, d = screw_hole_d);
}

module corner_pocket() {
    translate([0, 0, -0.1])
    union() {
        cube([arm_len + 0.1, arm_w   + 0.1, piece_h + 0.2]);
        cube([arm_w   + 0.1, arm_len + 0.1, piece_h + 0.2]);
    }
}

// pw / ph = panel width / height (inner face dimensions)
module frame(pw = frame_w, ph = frame_h) {
    ow = pw + 2 * wall_t;   // outer X
    oh = ph + 2 * wall_t;   // outer Y
    csz = arm_len + wall_t; // corner block size
    bw  = arm_w   + wall_t; // side arm width
    pz  = fh - piece_h;     // pocket start Z

    difference() {
        union() {
            // Corner blocks — full height
            cube([csz, csz, fh]);
            translate([ow-csz, 0,    0]) cube([csz, csz, fh]);
            translate([0,    oh-csz, 0]) cube([csz, csz, fh]);
            translate([ow-csz, oh-csz, 0]) cube([csz, csz, fh]);

            // Side arms — lower height, overlapping corner blocks by 0.1mm
            translate([csz-0.1, 0,      0]) cube([ow-2*csz+0.2, bw,  arm_beam_h]); // bottom
            translate([csz-0.1, oh-bw,  0]) cube([ow-2*csz+0.2, bw,  arm_beam_h]); // top
            translate([0,     csz-0.1,  0]) cube([bw, oh-2*csz+0.2,  arm_beam_h]); // left
            translate([ow-bw, csz-0.1,  0]) cube([bw, oh-2*csz+0.2,  arm_beam_h]); // right
        }

        // L-shaped corner pockets
        translate([wall_t,   wall_t,   pz]) corner_pocket();                           // BL
        translate([ow-wall_t, wall_t,  pz]) mirror([1,0,0]) corner_pocket();           // BR
        translate([ow-wall_t, oh-wall_t, pz]) rotate([0,0,180]) corner_pocket();       // TR
        translate([wall_t,   oh-wall_t, pz]) mirror([0,1,0]) corner_pocket();          // TL

        // Screw holes (3 per corner)
        corner_holes();                                            // BL
        translate([ow, 0,  0]) mirror([1,0,0]) corner_holes();   // BR
        translate([ow, oh, 0]) rotate([0,0,180]) corner_holes(); // TR
        translate([0,  oh, 0]) mirror([0,1,0]) corner_holes();   // TL
    }
}

frame();
