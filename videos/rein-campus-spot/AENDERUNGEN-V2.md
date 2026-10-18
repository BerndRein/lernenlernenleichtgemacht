# Rein Campus Spot – Version 2

Ergebnis: `rein-campus-spot-30s-v2.mp4` im Repo-Hauptordner (1920×1080, 30 s, −14 LUFS für YouTube/Web).
Version 1 bleibt unverändert als `rein-campus-spot-30s.mp4` erhalten.

## Was sich geändert hat

1. **Foto in Szene 5:** Statt des Familienfotos mit Kleinkind zeigt die Szene jetzt einen Schüler (ca. 12 Jahre)
   am Schreibtisch – ein Ausschnitt aus dem Kursbild Klasse 5–7 der Website, ohne Schriftzug
   (`assets/schueler-schreibtisch.jpg`). Passt zur Zielgruppe.
2. **Weniger Text:** dritte Problemkarte, Zitatkarte, Zielsatz in Szene 6 entfernt. Verbleibende Schriften größer (Chips 34–38 px,
   Timeline-Labels 24/40 px, Kennzahlen-Labels 32 px), damit sie auf dem Handy lesbar sind.
3. **Bernds Stimme:** fünf Sätze aus der Sprechprobe (`assets/vo/bernd-sprechprobe.mp3`) als Sprecherspur.
   Die Musik wird unter der Stimme automatisch abgesenkt.
4. **„Das Was / Das Wie“ entfernt:** Die Szene ist komplett raus. Die Programm-Szene läuft dafür
   länger (8,2–17,6 s), die Ablaufleiste baut sich passend zur Stimme langsamer auf. Länge bleibt 30 s.
5. **Stärkerer Einstieg:** Der Spot beginnt sofort mit „Oh nein … muss das sein?“ – groß im Bild und gesprochen.

## Sprecherspur

| Zeit im Spot | Satz |
|---|---|
| 0,2 s | „Oh nein, muss das sein?“ |
| 3,0 s | „Das ist völlig normal.“ |
| 8,2 s | „In unserem Programm wollen wir gemeinsam herausfinden, wie Lernen leichter werden kann und vielleicht sogar richtig Spaß macht.“ |
| 18,5 s | „Die Kinder übernehmen auf dieser Reise das Steuer.“ |
| 25,6 s | „Heute beginnt eine ganz besondere Reise.“ |

Schnittpunkte und Startzeiten stehen in `tools/build-voiceover.sh`. Nach einer Änderung dort:

```bash
bash tools/build-voiceover.sh   # baut assets/vo/voiceover.wav und die abgesenkte assets/bgm.wav
npm run render
```

## Hochformat-Ausschnitt für Post 2

`post2-hochformat-18s.mp4` im Repo-Hauptordner: 1080×1920 (9:16) für Reels, Stories und den Facebook-Feed, 18 s.
Quelle: `post2-hochformat.html`, Tonspur über `bash tools/build-voiceover.sh tools/vo-post2.txt`.
Rendern: `npx hyperframes@0.8.170 render -c post2-hochformat.html`.

Ablauf: Uhr springt auf 18:00 („Es ist 18 Uhr.“) → zwei Problemkarten → „Nicht weil Ihr Kind zu wenig kann …“
→ Schüler am Schreibtisch → Angebot mit 299 € bis 30.11.2026 (ab 1. Dezember regulär 599 €) und Website.
Inhalte bleiben im Bereich y 280–1500, damit die Bedienelemente von Instagram und Facebook nichts verdecken.

## Hochformat-Version des 30-s-Spots (Instagram)

`rein-campus-spot-30s-hochformat.mp4` im Repo-Hauptordner: 1080×1920 (9:16) für Reels, Stories und den Feed, 30 s.
Quelle: `spot-hochformat.html` – gleiche Szenen, Tonspur und Soundeffekte wie der 16:9-Spot, Layout neu fürs Hochformat
(senkrechte Ablaufleiste, Inhalte im Bereich y 280–1500, damit die App-Bedienelemente nichts verdecken).
Rendern: `npx hyperframes@0.8.170 render -c spot-hochformat.html`.

## 4:5-Version für Instagram-Feedbeiträge

`rein-campus-spot-30s-4x5.mp4`: 1080×1350 (4:5), 30 s. Instagram-Feedbeiträge akzeptieren nur 4:5 bis 16:9,
9:16 nur als Reel. Die Datei ist ein Zuschnitt der Hochformat-Version (`crop=1080:1350:0:215`), der den Inhaltsbereich
y 280–1500 vollständig enthält:

```bash
ffmpeg -i rein-campus-spot-30s-hochformat.mp4 -vf "crop=1080:1350:0:215" -c:v libx264 -crf 16 -preset slow \
  -pix_fmt yuv420p -c:a copy -movflags +faststart rein-campus-spot-30s-4x5.mp4
```

`post2-4x5-18s.mp4`: 4:5-Version des Post-2-Clips (1080×1350, 18 s) für Instagram-Feedbeiträge, gleicher Zuschnitt
(`crop=1080:1350:0:215`) aus `post2-hochformat-18s.mp4`.
