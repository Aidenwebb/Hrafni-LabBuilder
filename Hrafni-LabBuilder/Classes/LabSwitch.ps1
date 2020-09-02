class LabSwitch
{
    [ValidateNotNullOrEmpty()][string]$Name
    [ValidateNotNullOrEmpty()][string]$Type
    [NetAdapter]$BindAdapter


    # Constructor

    LabSwitch($Name, $Type)
    {
        $this.Name = $Name
        $this.Type = $Type
    }

    LabSwitch($Name, $Type, $BindAdapter)
    {
        $this.Name = $Name
        $this.Type = $Type
        $this.BindAdapter = $BindAdapter
    }
    
    
}