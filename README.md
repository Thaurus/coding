# Branth-Chemie – Website-Relaunch

Ein moderner, schlanker Neuaufbau der Website von **Branth-Chemie A.V. Branth KG** (Glinde bei Hamburg), dem Hersteller von Brantho-Korrux.

## Aufbau

```
index.html        Startseite (One-Pager): Hero, 3in1, Sortiment, Komfortdose,
                  Anwendungen, Unternehmen, Händlersuche, Kontakt
impressum.html    Impressum
datenschutz.html  Datenschutzerklärung (Vorlage – vor Livegang prüfen!)
css/styles.css    Gesamtes Styling (Custom Properties, responsive, ohne Framework)
js/main.js        Mobile Navigation, Produktfilter, Scroll-Animationen, Formulare
assets/           Logo und Produktillustration (SVG)
```

## Eigenschaften

- Reines HTML/CSS/JS – kein Build-Schritt, keine Abhängigkeiten, keine externen Requests
- Responsive (Mobile-First-Navigation), barrierearm (Skip-Link, ARIA, Fokusstile, `prefers-reduced-motion`)
- Datensparsam: keine Cookies, kein Tracking, keine Webfonts von Drittanbietern
- Kontakt- und Händlerformular öffnen das E-Mail-Programm des Besuchers (statisch hostbar)

## Lokal ansehen

```bash
python3 -m http.server 8000
# http://localhost:8000
```

## Vor dem Livegang

- Echte Produktfotos, das Originallogo und die vollständige Produktliste (inkl. Datenblätter) einpflegen
- Datenschutzerklärung durch die rechtsverbindliche Fassung ersetzen
- Optional: Formulare an einen Server-Endpunkt anbinden und echte Händlerdatenbank integrieren
