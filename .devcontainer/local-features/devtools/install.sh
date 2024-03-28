set -e
if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

# Eine Liste von Paketen, die nachfolgend installiert werden
# !!! HIER ERWEITERN !!! ... vim nano curl wget
packages="portaudio19-dev
          libsndfile1
          "

# Install and update packages
pip install --upgrade pip 
apt-get update
for package in $packages; do
  apt-get install -y $package
done

apt-get update
apt-get upgrade -y

### Set Settings
#mkdir /workspaces
#chmod -R 777 /workspaces # - vergibt Berechtigung
#chown -R vscode:vscode /workspaces # USER:GRUPPE - definiert Besitzer  

# Lösche und setze Passwort für die SSH Verbidnung
passwd -d vscode
echo "vscode:qwertz." | sudo chpasswd
