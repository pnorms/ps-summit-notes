<#
3:15 pm → 45 min
Rocking Docker with PowerShell
James Brundage
#>

# Dockerfile, only has 18 commands total
  # FROM: Image source
  # COPY: Copies file in
  #  ENV: Sets Env Vars inside the container
  #  RUN: Entry point in the container
  #  ADD: Can add a private repo

# Powershell base image
  # FROM: mcr.microsoft.com/powershell

# RUN
  # RUN pwsh -c "Install-Module SomeModule -Force -AllowClobber -Scope CurrentUser"

# Docker has noun oriented CLI
    # docker build, builds and image
    # docker run, runs and image
    # docker container, manages containers

# Run interactive
   docker run --interactive --tty mcr.microsoft.com/powershell

# Build image
   docker build --tag my-docker-image # must be lowercase

# Check out ugit, helps with Git management in powershell

# Rocker PS module
# Install-Module Rocker
