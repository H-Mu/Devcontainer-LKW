# devcontainer

**Der devcontainer ist für die Entwicklung von Python unter Ubuntu und VisualStudio Code optimiert und installiert direkt empfohlene Extensions für Code.**

Für die einfache und konsistente Entwicklung wird eine einheitliche Umgebung zu Verfügung gestellt. Die Pakete die zur Entwicklung notwendig sind, werden in den jeweiligen Listen gepflegt (siehe unten).

## Abhängikeiten
Notwendige Abhängigkeiten des Systems sind Node.js, npm und devcontainer-cli.

## nur devcontainer 

Folgendermassen erstelle / baue ich einen devcontainer 
- Konsolenfenster in dem Ordner öffnen, in dem sich der Ordner .devcontainer befindet: Mit dem Befehl `devcontainer up --workspace-folder .`
- Konsolenfenster beliebig `devcontainer up --workspace-folder <pfad_zum_.devcontainer>`

## Zusätzliche Infos - Pakete

Es werden Systempackages (per apt-get) installiert, diese sind in einem devcontainer-feature umgesetzt. Zum Hinzufügen / Entfernen die Liste in dem Skript `.devcontainer/local-features/features/install.sh` anpassen.
Softwarepakete über pip werden im Erstellungsprozess am Ende der Kreation des Containers installiert. Für Anpassungen die Liste `.devcontainer/requirements.txt` bearbeiten.
Änderungen werden erst beim Neubauen wirksam.

### Rebuilden
Die übersichtlichste Verwaltung von (mehreren) devcontainer kann über VS Code selber durchgeführt werden. Ist ziemlich intuitiv.

### Hilfreiche Code Sachen

#### devcontainer.json
-> features:
//"ghcr.io/devcontainers-contrib/features/ffmpeg-apt-get:1": {}
