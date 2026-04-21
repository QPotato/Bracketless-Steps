#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

SCHEME="--colorscheme=Cornfield"
OUT="screenshots"

snap() {
    local label=""
    for arg in "$@"; do [[ "$arg" == *.png ]] && label="$arg" && break; done
    echo "  $label"
    openscad $SCHEME "$@"
}

echo "Rendering screenshots..."

# Assembly — both pads, full fit
snap --imgsize=1400,900 --camera=313,139,0,55,0,25,1200 \
    -D "show_screw=false" \
    -D "show_panel=false" \
    -D "show_spacer=false" \
    -D "show_corner_piece=false" \
    -D "show_rivet_nut=false" \
    -o "$OUT/assembly_1.png" assembly.scad

# Assembly — both pads, full fit
snap --imgsize=1400,900 --camera=313,139,0,55,0,25,1200 \
    -D "show_screw=false" \
    -D "show_panel=false" \
    -D "show_spacer=false" \
    -D "show_corner_piece=false" \
    -o "$OUT/assembly_2.png" assembly.scad

# Assembly — both pads, full fit
snap --imgsize=1400,900 --camera=313,139,0,55,0,25,1200 \
    -D "show_screw=false" \
    -D "show_panel=false" \
    -D "show_spacer=false" \
    -o "$OUT/assembly_3.png" assembly.scad

# Assembly — both pads, full fit
snap --imgsize=1400,900 --camera=313,139,0,55,0,25,1200 \
    -D "show_screw=false" \
    -D "show_panel=false" \
    -o "$OUT/assembly_4.png" assembly.scad

# Assembly — both pads, full fit
snap --imgsize=1400,900 --camera=313,139,0,55,0,25,1200 \
    -D "show_screw=false" \
    -o "$OUT/assembly_5.png" assembly.scad

# Assembly — both pads, full fit
snap --imgsize=1400,900 --camera=313,139,0,55,0,25,1200 \
    -o "$OUT/assembly_6.png" assembly.scad

# Corner piece — perspective, top, bottom
snap --imgsize=1200,900 --camera=27,27,7,55,0,25,220 \
    -o "$OUT/corner_piece.png" frame_mod.scad

snap --imgsize=1200,1200 --camera=27,27,0,0,0,0,155 --projection=ortho \
    -o "$OUT/corner_piece_top.png" frame_mod.scad

snap --imgsize=1200,900 --camera=27,27,7,120,0,315,220 \
    -o "$OUT/corner_piece_bottom.png" frame_mod.scad

# Combine assembly frames into animated GIF and remove individual PNGs
echo "  $OUT/assembly.gif"
ffmpeg -y -loglevel error \
    -framerate 1 \
    -i "$OUT/assembly_%d.png" \
    -vf "split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" \
    -loop 0 \
    "$OUT/assembly.gif"
rm "$OUT"/assembly_{1..6}.png

echo "Done. Screenshots written to $OUT/"
