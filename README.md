![Hrafni Labs Logo](misc/Hrafni-labs-logo.png)

# Hrafni-LabBuilder
Rapidly deploy Hyper-V environments from an XML config file.

# Hrafni?
Hrafni is the Icelandic word for Raven. Raven's are well known as [very intelligent animals](https://www.nationalgeographic.com/news/2017/07/ravens-problem-solving-smart-birds/) capable of experiementing, learning, using tools and solving puzzles. This makes them an excellent mascott for my various experimental projects such as this one

I registered hrafni.com in 2020 to act as the root domain for my various experiments and mini projects.

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