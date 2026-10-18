#!/usr/bin/env bash
# Baut eine Sprecherspur aus Bernds Sprechprobe und die darunter abgesenkte Musik.
# Aufruf aus dem Projektordner:
#   bash tools/build-voiceover.sh                    # 30-s-Spot (tools/vo-spot.txt)
#   bash tools/build-voiceover.sh tools/vo-post2.txt # Hochformat-Ausschnitt für Post 2
# Die Clip-Datei legt Ausgabedateien, Länge und Schnittpunkte fest (siehe tools/vo-spot.txt).
set -euo pipefail
cd "$(dirname "$0")/.."
LIST=${1:-tools/vo-spot.txt}
SRC=assets/vo/bernd-sprechprobe.mp3
TMP=$(mktemp -d)

OUT=$(sed -n 's/^out=//p' "$LIST")
BGM_OUT=$(sed -n 's/^bgm=//p' "$LIST")
DUR=$(sed -n 's/^duration=//p' "$LIST")
FADE=$(sed -n 's/^fadeout=//p' "$LIST")

inputs=(); filters=""; mix=""; i=0
while read -r name from to at; do
  len=$(echo "$to - $from" | bc)
  ffmpeg -v error -y -ss "$from" -to "$to" -i "$SRC" -ac 1 -ar 48000 \
    -af "afade=t=in:d=0.04,afade=t=out:st=$(echo "$len - 0.08" | bc):d=0.08" "$TMP/$name.wav"
  inputs+=(-i "$TMP/$name.wav")
  ms=$(echo "$at * 1000 / 1" | bc)
  filters+="[$i:a]adelay=${ms}:all=1[d$i];"; mix+="[d$i]"; i=$((i+1))
done < <(grep -vE '^\s*(#|$|out=|bgm=|duration=|fadeout=)' "$LIST" | sed 's/#.*//')

# Stimme: Rumpeln weg, etwas Präsenz, sanft komprimiert, auf Sendepegel
ffmpeg -v error -y "${inputs[@]}" -filter_complex \
  "${filters}${mix}amix=inputs=$i:normalize=0,apad=whole_dur=$DUR,atrim=0:$DUR,\
highpass=f=80,equalizer=f=3000:t=q:w=1.2:g=2.5,\
acompressor=threshold=-24dB:ratio=3:attack=8:release=120:makeup=4,\
loudnorm=I=-16:TP=-1.5:LRA=7" -ar 48000 -ac 2 "$OUT"

# Musik auf Länge bringen, optional ausblenden und unter der Stimme absenken (Ducking)
fade=""
[ -n "$FADE" ] && fade=",afade=t=out:st=$(echo "$DUR - $FADE" | bc):d=$FADE"
ffmpeg -v error -y -i assets/bgm-original.wav -i "$OUT" -filter_complex \
  "[0:a]atrim=0:$DUR$fade[m];[m][1:a]sidechaincompress=threshold=0.06:ratio=3:attack=60:release=600" \
  -ar 48000 "$BGM_OUT"

rm -rf "$TMP"
echo "fertig: $OUT + $BGM_OUT"
