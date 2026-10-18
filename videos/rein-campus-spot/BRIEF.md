---
workflow: product-launch-video
flow: automation
storyboard: no
message: "Nicht mehr lernen. Besser lernen."
destination: youtube / web
aspect: "16:9"
language: de
audience: Eltern von Kindern der Klassen 5–7
length: 30s
angle: Vom täglichen Kampf am Schreibtisch zu selbstständigem Lernen mit Freude
music: warm, hoffnungsvoll, Klavier + leichte Akustik-Gitarre (lokal mit MusicGen erzeugt)
voice: none
---

# Rein Campus – 30-Sekunden-Spot

## Intent

Werbespot für das Lerntraining „Lernen lernen leicht gemacht“ (Klasse 5–7) von Rein Campus.
„Endlich wieder mit Freude lernen. Lernstrategien, Struktur und echtes Selbstvertrauen für Schüler,
die sich mehr zutrauen sollen – statt täglichem Kampf am Schreibtisch.“

Der Spot soll sich wie ein offizieller Spot der Marke anfühlen: warm, persönlich, klar, praxisnah.
Keine Nachhilfe-2.0-Optik, kein Druck, keine leeren Versprechen.

## Ende (verbatim)

Rein Campus · „Nicht mehr lernen. Besser lernen.“ · „Jetzt zum Einführungspreis“ · www.lernenlernenleichtgemacht.de

## Run-Rahmen

- Autonom (niemand sitzt daneben): keine Rückfragen, alle Entscheidungen selbst.
- Ausgabe: MP4, H.264, 1920×1080 in `final/`.
- Ton: Nur, was wirklich verfügbar ist. Higgsfield/ElevenLabs/HeyGen nicht eingerichtet, `~/claude-sounds` leer
  → keine Sprecherstimme (lokales Kokoro kann kein Deutsch), Musik lokal mit MusicGen (kostenlos),
  Soundeffekte aus der mitgelieferten HyperFrames-Bibliothek. Verbrauchte Credits: 0.

## Notes

- HyperFrames-Capture scheiterte am Proxy-Zertifikat (ERR_CERT_AUTHORITY_INVALID). Die Seite wurde
  stattdessen manuell erfasst (HTML, CSS-Tokens, Schriften, Bilder, Screenshots) → `capture/`.
- Inhalte stammen wörtlich oder sinngemäß von lernenlernenleichtgemacht.de und rein-campus.de.
