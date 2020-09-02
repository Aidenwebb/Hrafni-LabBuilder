Remove-Module Hrafni-LabBuilder
Import-Module Hrafni-LabBuilder
$ConfigPath = ".\Hrafni-LabBuilder\configs\labconfig.xml"
$LabConfig = Get-LabConfig -ConfigPath $ConfigPath -Verbose
$Switches = Get-LabSwitch -LabConfig $LabConfig -Verbose
$InitializedSwitches = Initialize-LabSwitch -Switches $Switches -Verbose