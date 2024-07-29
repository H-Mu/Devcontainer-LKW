# devcontainer

**Der devcontainer ist für die Entwicklung von Python unter Ubuntu und VisualStudio Code optimiert und installiert direkt empfohlene Extensions für Code.**

Für die einfache und konsistente Entwicklung wird eine einheitliche Umgebung zu Verfügung gestellt. Die Pakete die zur Entwicklung notwendig sind, werden in den jeweiligen Listen gepflegt (siehe unten).

**Nun mit GPU Support IM Container mit Torch!** \n
**Nun mit GUI Support: Direkter Zugriff aus dem Container heraus auf das HostSystem Display**

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

-> für GPU Support im Container
  `"runArgs": [
    "--gpus","all"
  ],`
  
### Limitations
**Zwei Container Instanzen**
Falls der Container mit dieser devcontainer.json Kofiguration bereits existiert, kann kein zweiter Container erstellt werden. Die Ports vom VNC sind "belegt". Porblem kann umgangen werden, indem nur ein Container gleichzeitig existiert ODER falls mehrere Container gewünscht sind / gebraucht werden MÜSSEN in der devcontainer.json ALLE Ports abgeändert werden. Kann im Nachhinein in VS Code selber auch konfiguriert werden.

Diese Zeilen geben alle Ports an und müssen konsistent z.B. um eins erhöht werden. 
`  "appPort": [
		// 2222 Expose SSH port for tools that need it (e.g. JetBrains)
        // 6080, 5901 für desktop-lite 
		"127.0.0.1:2222:2222", "127.0.0.1:6080:6080", "127.0.0.1:5901:5901"
	],
  "portsAttributes": {
    "6080": {
      "label": "desktop"
    },
    "5901": {
      "label": "vnc"
    }
  },`
