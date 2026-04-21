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
    -o "$OUT/assembly_top.png" assembly.scad

snap --imgsize=1400,900 --camera=313,139,0,55,0,25,1200 \
    -D "show_panel=false" \
    -o "$OUT/assembly_no_panel.png" assembly.scad

# Corner piece — perspective, top, bottom
snap --imgsize=1200,900 --camera=27,27,7,55,0,25,220 \
    -o "$OUT/corner_piece.png" frame_mod.scad

snap --imgsize=1200,1200 --camera=27,27,0,0,0,0,155 --projection=ortho \
    -o "$OUT/corner_piece_top.png" frame_mod.scad

snap --imgsize=1200,900 --camera=27,27,7,120,0,315,220 \
    -o "$OUT/corner_piece_bottom.png" frame_mod.scad

echo "Done. Screenshots written to $OUT/"
