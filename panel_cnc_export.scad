// PIU panel — 2D DXF export helper
//
// Manual use:
//   1. Set PANEL_W (278=center, 334=corner) and LAYER (0-3) below
//   2. File > Export > Export as DXF
//
// Layer summary (what to tell your CAM software):
//   0 = outline     — outer profile cut,  full depth (10 mm)
//   1 = drill       — through holes,      full depth (10 mm),  d=11 mm
//   2 = mid_pocket  — step pocket,        5 mm deep from top,  d=16 mm
//   3 = top_pocket  — top pocket/chamfer, 2 mm deep from top,  d=20 mm
//                     (router: V-bit or ball-nose; laser/waterjet: skip)

include <panel_cnc.scad>

PANEL_W = 278;   // center: 278   corner: 334
PANEL_H = 278;
LAYER   = 0;     // 0=outline  1=drill  2=mid_pocket  3=top_pocket

module layer_outline() {
    square([PANEL_W, PANEL_H]);
}

module layer_drill() {
    for (x = [hole_offset_x, PANEL_W - hole_offset_x])
        for (y = [hole_offset_y, PANEL_H - hole_offset_y])
            translate([x, y]) circle(d = drill_dia);
}

module layer_mid_pocket() {
    for (x = [hole_offset_x, PANEL_W - hole_offset_x])
        for (y = [hole_offset_y, PANEL_H - hole_offset_y])
            translate([x, y]) circle(d = mid_dia);
}

module layer_top_pocket() {
    for (x = [hole_offset_x, PANEL_W - hole_offset_x])
        for (y = [hole_offset_y, PANEL_H - hole_offset_y])
            translate([x, y]) circle(d = top_dia);
}

if      (LAYER == 0) layer_outline();
else if (LAYER == 1) layer_drill();
else if (LAYER == 2) layer_mid_pocket();
else if (LAYER == 3) layer_top_pocket();
