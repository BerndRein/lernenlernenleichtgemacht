# Rein Campus Spot – Version 2

Ergebnis: `rein-campus-spot-30s-v2.mp4` im Repo-Hauptordner (1920×1080, 30 s, −14 LUFS für YouTube/Web).
Version 1 bleibt unverändert als `rein-campus-spot-30s.mp4` erhalten.

## Was sich geändert hat

1. **Foto in Szene 5:** Statt des Familienfotos mit Kleinkind zeigt die Szene jetzt einen Schüler (ca. 12 Jahre)
   am Schreibtisch – ein Ausschnitt aus dem Kursbild Klasse 5–7 der Website, ohne Schriftzug
   (`assets/schueler-schreibtisch.jpg`). Passt zur Zielgruppe.
2. **Weniger Text:** dritte Problemkarte, Zitatkarte, Schlusszeile in Szene 3 und Zielsatz in Szene 6 entfernt;
   je ein Chip weniger in „Das Was / Das Wie“. Verbleibende Schriften größer (Chips 34–38 px,
   Timeline-Labels 24/40 px, Kennzahlen-Labels 32 px), damit sie auf dem Handy lesbar sind.
3. **Bernds Stimme:** sechs Sätze aus der Sprechprobe (`assets/vo/bernd-sprechprobe.mp3`) als Sprecherspur.
   Die Musik wird unter der Stimme automatisch abgesenkt.
4. **Stärkerer Einstieg:** Der Spot beginnt sofort mit „Oh nein … muss das sein?“ – groß im Bild und gesprochen.

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
