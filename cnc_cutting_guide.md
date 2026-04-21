# CNC Cutting Guide

This guide covers the requirements and recommended workflow for cutting the polycarbonate panels on any 3-axis CNC router.

For a specific worked example on one particular machine see `cnc_cutting_guide_fraese2.md`.

## Machine Requirements

- 3-axis CNC router with at least 335 mm × 280 mm × 15 mm working envelope (X × Y × Z)
- Spindle capable of running carbide end mills suitable for plastic at recommended chip loads
- Tool holding that accepts standard end mill shanks (6 mm or 1/4" shank is typical)
- Ability to set a work offset at a known corner of the stock

The panels are 10 mm thick polycarbonate. Your Z clearance only needs to exceed that by a comfortable margin for the tool and collet.

## Panel Dimensions

| Panel  | Width  | Height | Thickness |
|--------|--------|--------|-----------|
| Center | 278 mm | 278 mm | 10 mm     |
| Corner | 334 mm | 278 mm | 10 mm     |

Hole centers are 22.7 mm inward from each edge in both X and Y.

## Hole Profile

Each corner hole is a three-step feature machined from the top surface:

| Layer      | Diameter | Depth from top |
|------------|----------|----------------|
| top_pocket | 20 mm    | 2 mm           |
| mid_pocket | 16 mm    | 5 mm total     |
| drill      | 11 mm    | through (10 mm)|

The pockets are concentric. The through hole goes all the way through the panel.

## DXF File Set

The `dxf_export/` folder contains one DXF per panel per machining operation:

| File                     | Operation                          | Depth        |
|--------------------------|------------------------------------|--------------|
| `*_outline.dxf`          | Outer profile contour cut          | Full (10 mm) |
| `*_drill.dxf`            | Through holes, d = 11 mm           | Full (10 mm) |
| `*_mid_pocket.dxf`       | Stepped pocket, d = 16 mm          | 5 mm         |
| `*_top_pocket.dxf`       | Top pocket, d = 20 mm              | 2 mm         |

`center_*` files are for the 278 × 278 mm panel; `corner_*` for the 334 × 278 mm panel.

## Material and Stock

- Material: polycarbonate (PC)
- Center stock: 300 × 300 × 10 mm is sufficient
- Corner stock: 300 × 350 × 10 mm is sufficient (orient the 334 mm cut dimension along the 350 mm stock dimension)
- Keep the protective film on the sheet during cutting if possible; it helps prevent scratches and chip adhesion

## Fixturing

The panels are too large for a standard machine vise. Use the spoilboard:

- Double-sided tape is the simplest option and needs no edge clearance
- Screws through sacrificial corner areas also work well
- Toe clamps along the long sides are an alternative if tape is not available
- Leave enough margin around the part for whichever method you choose

## Recommended Cut Order

1. Pocket operations first (`top_pocket`, then `mid_pocket`)
2. Through holes next (`drill`)
3. Outer contour last (`outline`) — cutting this last keeps the part stable while internal features are machined

## CAM Setup

- Set units to millimeters
- Set stock thickness to 10 mm
- Place the program origin at a known corner of the stock and use the same corner for your machine work offset
- Use a climb or conventional contour for the outline; the tool can enter via a helical plunge or ramp rather than a straight plunge
- Add tabs or rely on your fixturing to keep the part from shifting when the outline releases it

## Feeds, Speeds, and Tool Selection

These depend on your specific machine, spindle, and tooling. General guidance for polycarbonate:

- Use a sharp carbide end mill; dull tooling melts polycarbonate instead of cutting it
- Single-flute or two-flute end mills are common choices for plastics
- Radial engagement (stepover): start below 40% of tool diameter
- If the material starts to melt, smear, or weld to the cutter, reduce feed rate or increase spindle speed
- Air blast or mist coolant helps clear chips and prevent heat buildup; not always required for light cuts

Use your tool manufacturer's data for starting values, then adjust based on the results of a test cut.

## CAM Checklist

1. Correct units (mm)
2. Stock thickness set to 10 mm
3. Correct DXF loaded for the panel size being cut
4. Pocket depths assigned: top_pocket = 2 mm, mid_pocket = 5 mm, drill = 10 mm (through)
5. Outline depth = 10 mm (through)
6. Program origin matches machine setup corner
7. Tabs or fixturing confirmed for outline cut
8. Toolpath simulated before posting G-code

## Practical Cautions

- Cut one test piece before committing to a full panel if feeds and speeds have not been validated for your machine and stock
- Do not let the tool dwell in place with the spindle running; this melts polycarbonate
- If the part lifts or shifts during the outline cut, stop and re-fixture before continuing
