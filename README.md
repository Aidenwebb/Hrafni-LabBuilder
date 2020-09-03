# Hrafni-LabBuilder
Rapidly deploy Hyper-V environments from an XML config file.

# Deployment status
This module is currently in Alpha. Once a working proof of concept is complete, I will create a pipeline to publish to Powershell Gallery.

# Usage
  1. Add the module to your Windows Module path
  2. Create a config file in XML - see configs\labconfig.xml for an example.
  3. Create a folder for your environment
  4. Run Powershell as Admin and navigate to your environment folder
  4. Type Install-Lab -ConfigPath "\<PathToConfigFile>"


# Goal
  * Bring Infrastructure as Code elements to Hyper-V
  * Enable rapid, idempotent, repeatable deployment of sets of infrastructure from a pre-written config file

# Requirements
  * Windows 10 or Windows Server 2019 as the Lab Host
  * Hyper-V Installed
  * ISO's for Windows 10 and Windows Server 2019