function Get-LabSwitch {
    [CmdletBinding()]
    param (
        $Name
    )
    
    begin {
        
    }
    
    process {
        $VMSwitch = Get-VMSwitch -Name $Name
        [LabSwitch]$LabSwitch = [LabSwitch]::New($VMSwitch.Name, $VMSwitch.SwitchType)
    }
    
    end {
        return $LabSwitch
    }
}