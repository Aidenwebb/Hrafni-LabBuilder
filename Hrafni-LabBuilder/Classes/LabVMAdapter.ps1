class LabVMAdapter
{
    [ValidateNotNullOrEmpty()][string]$Name
    [ValidateNotNullOrEmpty()][LabSwitch]$Switch

    # Constructor
    LabVMAdapter($Name, $Switch)
    {
        $this.Name = $Name
        $this.Switch = $Switch
    }
}