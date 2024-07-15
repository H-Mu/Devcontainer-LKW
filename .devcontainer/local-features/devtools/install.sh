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


# create and set wsl.conf 
cat << 'EOF' > /etc/wsl.conf
[boot]
#systemd=true
[user]
default=vscode
# Set a command to run when a new WSL instance launches. This example starts the Docker container service.
		command = service docker start
# Automatically mount Windows drive when the distribution is launched
[automount]
# Set to true will automount fixed drives (C:/ or D:/) with DrvFs under the root directory set above. Set to false means drives won't be mounted automatically, but need to be mounted manually or with fstab.
enabled = true
# Sets the directory where fixed drives will be automatically mounted. This example changes the mount location, so your C-drive would be /c, rather than the default /mnt/c.
root = /mnt/
# Sets the `/etc/fstab` file to be processed when a WSL distribution is launched.
mountFsTab = true
# Network host settings that enable the DNS server used by WSL 2. This example changes the hostname, sets generateHosts to false, preventing WSL from the default behavior of auto-generating /etc/hosts, and sets generateResolvConf to false, preventing WSL from auto-generating /etc/resolv.conf, so that you can create your own (ie. nameserver 1.1.1.1).
[network]
# hostname to be used for WSL distribution. Windows hostname is default
# hostname = devcontainer-wsl
# generateHosts = true
# generateResolvConf = true
# Set whether WSL supports interop process like launching Windows apps and adding path variables. Setting these to false will block the launch of Windows processes and block adding $PATH environment variables.
[interop]
# Setting this key will determine whether WSL will support launching Windows processes.
enabled = true
# Setting this key will determine whether WSL will add Windows path elements to the $PATH environment variable.

EOF

# Install and update packages
pip install --upgrade pip 
apt-get update
for package in $packages; do
  apt-get install -y $package
done

apt-get update
apt-get upgrade -y

### Set Settings
mkdir /home/workspaces 
chmod -R 777 /home/workspaces

# Lösche und setze Passwort für die SSH Verbidnung
passwd -d vscode
echo "vscode:qwertz." | sudo chpasswd
