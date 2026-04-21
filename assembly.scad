// PIU bracketless pad — full assembly
// Two instances: center pad (278×278) and corner pad (334×278)

use <frame_mod.scad>
use <frame.scad>
use <rivet_nut.scad>
use <spacer.scad>
use <screw_m6_csk.scad>
use <panel_cnc.scad>

// ── Visibility flags ─────────────────────────────────────────────
show_frame        = true;
show_corner_piece = true;
show_rivet_nut    = true;
show_spacer       = true;
show_screw        = true;
show_panel        = true;

// ── Stack geometry ───────────────────────────────────────────────
sx       = 22.7;   // spacer/rivet nut center (matches frame_mod + panel_cnc)
sy       = 22.7;
piece_h  = 15;
gap      = 5;
panel_t  = 10;
wall_t   = 1.5;    // frame outer wall (must match frame.scad)

$fn = 64;

// Hardware for one corner, origin at its outer corner face
module single_corner() {
    if (show_corner_piece)
        color("BurlyWood")   corner_piece();
    if (show_rivet_nut)
        color("Silver")      translate([sx, sy, 0]) rotate([0, 0, -45]) rivet_nut();
    if (show_spacer)
        color("Gainsboro")   translate([sx, sy, piece_h]) spacer();
    if (show_screw)
        color("DimGray")     translate([sx, sy, piece_h + gap + 5]) screw_m6_csk(12);
}

// Full pad assembly for a given panel size
module pad_assembly(pw, ph) {
    // Frame — outer corner at (-wall_t,-wall_t), sits 1.5mm below corner pieces
    if (show_frame)
        color("SlateGray", 0.85)
            translate([-wall_t, -wall_t, -wall_t])
                frame(pw, ph);

    // 4 corner pieces + hardware
    single_corner();
    translate([pw,  0,  0]) mirror([1,0,0])     single_corner();
    translate([pw,  ph, 0]) rotate([0,0,180])   single_corner();
    translate([0,   ph, 0]) mirror([0,1,0])     single_corner();

    // Panel
    if (show_panel)
        color("LightCyan", 0.5)
            translate([0, 0, piece_h + gap])
                panel_with_corner_holes(pw, ph);
}

// ── Instances ────────────────────────────────────────────────────
// Center pad (278×278)
pad_assembly(278, 278);

// Corner pad (334×278) — offset so they don't overlap
translate([320, 0, 0])
    pad_assembly(334, 278);
