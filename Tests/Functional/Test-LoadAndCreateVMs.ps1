Remove-Module Hrafni-LabBuilder
Import-Module Hrafni-LabBuilder
$ConfigPath = ".\Hrafni-LabBuilder\configs\labconfig.xml"
$LabConfig = Get-LabConfig -ConfigPath $ConfigPath -Verbose
$VMs = Get-LabVMConfig -LabConfig $LabConfig -Verbose
#$InitializedVMs = Initialize-LabSwitch -Switches $Switches -Verbose