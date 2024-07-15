# How-To

# Before - Install nvm manually
# Win: Donwload und install EXE from https://github.com/coreybutler/nvm-windows/releases

# Then - Run this script in PowerShell as ADMIN one folder before .devcontainer
# .\setup_env.ps1 -dependencies $false -name "NAME"
#   dependencies -> Boolean: if true install Node.js and npm 
#   name -> the name for wsl

param (
  [bool]$dependencies = $false,
  [String]$name = "kraftwerk"
 )

# Install neccessary dependencies only if needed
# Install latest version Node.js and npm and devcontainer-cli
if ($dependencies)
{
    Write-Host "Install dependencies..."
    # Install Node LTS version
    nvm install lts
    nvm use lts
    # update npm
    npm install -g npm@latest
    # Check installations
    node --version
    npm --version
    npm install -g @devcontainers/cli
}

Write-Host "Create container..."
# Actual creation container and WSL
# bei der Erstellung mehrerer Container muss der Parameter '--id-label' angepasst werden
devcontainer up --id-label temp_container=1 --workspace-folder . 

Write-Host "Export container..."
docker export $(docker ps -a -q --filter "label=temp_container") -o rootfs.tar.gz

Write-Host "...and create Subsystem and restarting WSL..."
wsl --import $name . .\rootfs.tar.gz
wsl --shutdown -y
wsl -d $name 

Write-Host "Finish."
