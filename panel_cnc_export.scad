include <panel_cnc.scad>

// DXF export helper for the CNC panel layers.
// Select the machining layer with LAYER and the panel size with PANEL_W/PANEL_H.

LAYER = "outline";
PANEL_W = 278;
PANEL_H = 278;

module panel_outline_2d(w, h) {
    square([w, h]);
}

module hole_ring(diameter) {
    circle(d = diameter);
}

module panel_layer_2d(layer, w, h) {
    if (layer == "outline") {
        panel_outline_2d(w, h);
    } else if (layer == "drill") {
        for (x = [hole_offset_x, w - hole_offset_x])
            for (y = [hole_offset_y, h - hole_offset_y])
                translate([x, y]) hole_ring(drill_dia);
    } else if (layer == "mid_pocket") {
        for (x = [hole_offset_x, w - hole_offset_x])
            for (y = [hole_offset_y, h - hole_offset_y])
                translate([x, y]) hole_ring(mid_dia);
    } else if (layer == "top_pocket") {
        for (x = [hole_offset_x, w - hole_offset_x])
            for (y = [hole_offset_y, h - hole_offset_y])
                translate([x, y]) hole_ring(top_dia);
    } else {
        echo(str("Unknown LAYER: ", layer));
    }
}

panel_layer_2d(LAYER, PANEL_W, PANEL_H);
