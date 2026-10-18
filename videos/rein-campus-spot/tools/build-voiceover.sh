#!/usr/bin/env bash
# Baut die Sprecherspur (assets/vo/voiceover.wav) aus Bernds Sprechprobe
# und die darunter abgesenkte Musik (assets/bgm.wav aus assets/bgm-original.wav).
# Aufruf aus dem Projektordner: bash tools/build-voiceover.sh
set -euo pipefail
cd "$(dirname "$0")/.."
SRC=assets/vo/bernd-sprechprobe.mp3
OUT=assets/vo/voiceover.wav
TMP=$(mktemp -d)

# name  von   bis    -> Startzeit im Spot
CLIPS=(
  "hook   21.55 23.35  0.20"   # „Oh nein, muss das sein?“
  "normal 32.05 34.25  2.95"   # „Das ist völlig normal.“
  "prog   39.55 48.95  8.20"   # „In unserem Programm … und vielleicht sogar richtig Spaß macht.“
  "steuer 67.95 71.08 18.45"   # „Die Kinder übernehmen auf dieser Reise das Steuer.“
  "reise   9.35 11.98 25.60"   # „Heute beginnt eine ganz besondere Reise.“
)

inputs=(); filters=""; mix=""; i=0
for c in "${CLIPS[@]}"; do
  read -r name from to at <<<"$c"
  len=$(echo "$to - $from" | bc)
  ffmpeg -v error -y -ss "$from" -to "$to" -i "$SRC" -ac 1 -ar 48000 \
    -af "afade=t=in:d=0.04,afade=t=out:st=$(echo "$len - 0.08" | bc):d=0.08" "$TMP/$name.wav"
  inputs+=(-i "$TMP/$name.wav")
  ms=$(echo "$at * 1000 / 1" | bc)
  filters+="[$i:a]adelay=${ms}:all=1[d$i];"; mix+="[d$i]"; i=$((i+1))
done

# Stimme: Rumpeln weg, etwas Präsenz, sanft komprimiert, auf Sendepegel
ffmpeg -v error -y "${inputs[@]}" -filter_complex \
  "${filters}${mix}amix=inputs=$i:normalize=0,apad=whole_dur=30,atrim=0:30,\
highpass=f=80,equalizer=f=3000:t=q:w=1.2:g=2.5,\
acompressor=threshold=-24dB:ratio=3:attack=8:release=120:makeup=4,\
loudnorm=I=-16:TP=-1.5:LRA=7" -ar 48000 -ac 2 "$OUT"

# Musik unter der Stimme automatisch absenken (Ducking)
ffmpeg -v error -y -i assets/bgm-original.wav -i "$OUT" -filter_complex \
  "[0:a]atrim=0:30[m];[m][1:a]sidechaincompress=threshold=0.06:ratio=3:attack=60:release=600" \
  -ar 48000 assets/bgm.wav

rm -rf "$TMP"
echo "fertig: $OUT + assets/bgm.wav"
