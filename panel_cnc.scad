// PIU bracketless acrylic panel helper (shared)
// Use panel_center_cnc.scad or panel_corner_cnc.scad to generate each panel.

$fn = 96;

// Shared panel settings
panel_thickness = 10;
top_chamfer     = 1;  // 1mm border chamfer on top face

// Corner hole location (from panel edges, center-to-edge)
// Moved inward so the countersink does not clip panel borders.
hole_offset_x = 22.7;
hole_offset_y = 22.7;

// Hole profile from top surface downward
top_dia   = 20;  // top pocket diameter
top_h     = 2;   // top pocket depth
mid_dia   = 16;  // middle pocket diameter
mid_h     = 3;   // middle pocket depth
drill_dia = 11;  // through drill diameter

module corner_hole_profile() {
    // Through drill
    translate([0, 0, -0.1])
        cylinder(h = panel_thickness + 0.2, d = drill_dia);

    // Middle pocket
    translate([0, 0, panel_thickness - (top_h + mid_h)])
        cylinder(h = mid_h + 0.1, d = mid_dia);

    // Top countersink (conical)
    translate([0, 0, panel_thickness - top_h])
        cylinder(h = top_h + 0.1, d1 = mid_dia, d2 = top_dia);
}

module chamfered_panel_body(w, h, t, ch) {
    if (ch <= 0) {
        cube([w, h, t]);
    } else {
        union() {
            cube([w, h, t - ch]);
            hull() {
                translate([0, 0, t - ch - 0.001])
                    cube([w, h, 0.001]);
                translate([ch, ch, t - 0.001])
                    cube([w - 2*ch, h - 2*ch, 0.001]);
            }
        }
    }
}

module panel_with_corner_holes(w, h) {
    difference() {
        chamfered_panel_body(w, h, panel_thickness, top_chamfer);

        for (x = [hole_offset_x, w - hole_offset_x])
            for (y = [hole_offset_y, h - hole_offset_y])
                translate([x, y, 0]) corner_hole_profile();
    }
}
