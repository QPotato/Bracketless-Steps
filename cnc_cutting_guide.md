# CNC Cutting Guide

This guide is for cutting the polycarbonate panels on CNC-Fraese-2.
It is based on the machine page and the lab workflow guide.

## Machine Facts

- Controller: LinuxCNC
- Travel: X 1150 mm, Y 750 mm, Z 220 mm
- Spindle: G-Penny 2.2 kW, water cooled
- Max spindle speed: 24,000 rpm
- Tool holder: ER20
- Max shank diameter: 14 mm
- Standard coolant: minimal lubrication, M7
- Approved materials include plastics such as POM, acrylic, and polycarbonate

## Panel Stock

- Center panel: 278 x 278 x 10 mm
- Corner panel: 334 x 278 x 10 mm
- Your stock sizes are sufficient:
- Center sheet: 300 x 300 x 10 mm
- Corner sheet: 300 x 350 x 10 mm

## File Set

- `panel_cnc_export.scad` is the DXF export helper.
- `dxf_export/*_outline.dxf` is the outer cut path.
- `dxf_export/*_drill.dxf` is the through-hole pattern.
- `dxf_export/*_mid_pocket.dxf` is the middle pocket layer.
- `dxf_export/*_top_pocket.dxf` is the top pocket layer.

## Confirm Before CAM

Fill these in with the expert operator before generating toolpaths:

- Tool diameter: ____ mm
- Flute count: ____
- Stickout from collet: ____ mm
- Spindle speed: ____ rpm
- Feed rate for contour cuts: ____ mm/min
- Feed rate for plunges: ____ mm/min
- Tabs or hold-down strategy: ____
- Coolant strategy: M7 / none / other: ____

If you do not know the tool diameter, stop here and ask. The stepover, plunge rate, and minimum inside radius all depend on it.

## Recommended Cut Order

1. Import the DXFs into CAM.
2. Generate the pocket operations first.
3. Cut the through-drill layer next.
4. Cut the outline last so the part stays stable while the internal features are machined.

## CAM Checklist

1. Set units to millimeters.
2. Set the stock thickness to 10 mm.
3. Load the correct DXF for the panel size you are making.
4. Place the program origin at the same corner used in the machine setup.
5. Use the tool diameter from the expert confirmation, not a guess.
6. Keep pocket stepover conservative for polycarbonate; start below 40 percent of tool diameter.
7. Use the pocket operations before the outer contour.
8. Add tabs or another hold-down method for the final outline cut so the part does not move when it releases.
9. Verify that hole diameters and pocket depths match the README table.
10. Simulate the job before posting G-code.

## Setup Before Cutting

1. Do not start without an experienced operator present. The lab wiki says the machine may only be used by instructed people.
2. These panels must be fixtured on the spoilboard — the machine vise has a 110 mm max clamping length and cannot hold a 278 mm or 334 mm panel. Use double-sided tape, screws into a sacrificial area, or toe clamps along the long sides.
3. Clear the bed, check the spoilboard, and confirm the fixture plan before loading material.
4. Keep the protective film on the polycarbonate sheet until the cut is done, unless the experts ask otherwise.
5. Use a carbide end mill suitable for plastic. The wiki says the lab has carbide tools from about 2 to 10 mm.
6. Make sure the tool length is set correctly before any motion.

## CAM Notes

- Use millimeters, not inches.
- Use the G54 work offset.
- In FreeCAD CAM, disable automatic tool-length compensation with `--no-tlo` if you post-process there.
- For plastics, the lab guidance suggests keeping radial engagement below 0.4 x tool diameter.
- Use the manufacturer data sheet for the final feed and speed values, then reduce if needed. The wiki notes that 50% to 75% of manufacturer values is usually realistic on this machine.
- If the tool diameter changes, revisit the contour radius limits and the feed per tooth before cutting.
- The lab uses M7 mist coolant. Confirm with an expert whether to use it for your exact polycarbonate sheet and tool.

## Operator Workflow

1. Power on the machine, cooling pump, and PC.
2. Start LinuxCNC and home all axes.
3. Mount the sheet on the spoilboard so the full toolpath has clearance.
4. Install the tool in the ER20 collet, keeping as much shank in the collet as practical.
5. Set the tool length offset.
6. Set G54 on the workpiece corner that matches your CAM origin.
7. Load the program and inspect the preview carefully.
8. Run a dry check with feed and rapid turned down.
9. Start the program, then raise rapid and feed gradually while watching the first moves.

## Orientation Recommendation

- Center panel: place the 278 mm side along the X or Y axis, whichever leaves the best clamping room.
- Corner panel: orient the 334 mm side along the 350 mm stock dimension. This leaves about 8 mm per side in that direction, which is sufficient for tape or screw fixturing; no edge clamps are needed on those sides.
- Keep margin on the longer sides for any toe clamps or screw heads.

## Practical Cautions

- Do not use the stationary spindle to touch off the sheet.
- Do not let the tool rub in place; use moving contact or a proper touch-off method.
- If the sheet starts to melt or weld to the cutter, stop and reduce the load or ask for help.
- Cut one test piece first if the team has not already validated the toolpath and feeds for this stock.

## Suggested CAM Exports

For the provided panels, export the following DXFs from `panel_cnc_export.scad`:

- `center_outline.dxf`
- `center_drill.dxf`
- `center_mid_pocket.dxf`
- `center_top_pocket.dxf`
- `corner_outline.dxf`
- `corner_drill.dxf`
- `corner_mid_pocket.dxf`
- `corner_top_pocket.dxf`

If your CAM can only handle a simpler workflow, you can use the outline and drill layers first and add the pockets after the machine setup is confirmed.