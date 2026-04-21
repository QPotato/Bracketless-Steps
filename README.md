# PIU Bracketless Conversion

Pieces to mod a classic (corner-bracket style) Pump It Up arcade dance pad into bracketless. The main interesting pieces are:
- `frame_mod.scad`: replaces the corner rubber piece. Covers the main frame screw to protect it from dust and has a piccket for a rivet and spacer, for your bracketless panel.
- `panel_center_cnc.scad` and  `panel_corner_cnc.scad`: panel models, meant to be exported into CNC cutting instrucitons. Some pre-exported files included, not yet tested. Discussed below.
- `frame.scad`: in case you want to print a full frame instead of keeping the metal ones.
- `assembly.scad`: to visualize the expected result.

Other 3D models like screws, spacers, rivet nuts and there for reference and for the assembly, ensuring it all fits together, but not meant to be printed.

THIS IS STILL IN BETA, LET ME PRINT AND TEST MYSELF BEFORE YOU WASTE MATERIAL.

## Screenshots

### Assembly

![Assembly](screenshots/assembly.gif)

### Corner piece

![Corner piece perspective](screenshots/corner_piece.png)

![Corner piece top view](screenshots/corner_piece_top.png)

![Corner piece bottom](screenshots/corner_piece_bottom.png)

## Hardware (per corner)

| Part | Spec | Notes |
|---|---|---|
| Rivet nut | M6, hex body, 13mm flange OD, 15mm total height | Press-fit into corner piece from bottom |
| Spacer / standoff | M6 male-female, 8mm OD body, 10mm body height, 8mm stud | Screws into rivet nut, protrudes above piece |
| Panel screw | M6 countersunk, 12mm length | Sits recessed in panel countersink |
| Frame screws | M5, quantity 3 per corner | Pad-to-frame + 2× leg screws |

**Panels:** 10mm polycarbonate sheet, CNC cut.


### CNC panel files

| File | Description |
|---|---|
| `panel_cnc.scad` | Shared panel geometry (hole profile, chamfer). |
| `panel_center_cnc.scad` | Center panel: 278×278mm. |
| `panel_corner_cnc.scad` | Corner panel: 334×278mm. |
| `panel_cnc_export.scad` | DXF export helper. Set `LAYER`, `PANEL_W`, and `PANEL_H`, export as DXF. |
| `dxf_export/` | Pre-exported DXF files for both panel sizes, one file per machining operation. |
| `cnc_cutting_guide.md` | Generic CNC cutting guide: requirements, DXF layer reference, CAM setup, and polycarbonate tips. |
| `cnc_cutting_guide_fraese2.md` | Machine-specific instructions for CNC-Fraese-2 at das-labor. |

---

## Assembly order

1. Press rivet nut into corner piece from the bottom (hex body up).
2. Drop corner piece into frame corner pocket, flat side down.
3. Screw M6 standoff into rivet nut from above until snug.
4. Fasten corner piece to frame using 3 screws per corner (pad-to-frame hole + 2 leg holes).
5. Lower panel over all 4 spacers.
6. Drive M6 countersunk screw into each spacer until head is below panel surface.


---

## Credits

Thanks to Nirvash for the idea for the corner piece.
Thanks to Vaughan14 in the Ryhthm Game Cabs discord server for the original schematics of the panels.
Thanks dj505 in thingiverse for the initial STL files for bracketless frames. I took a lot of measurements from there.
