function Initialize-LabSwitch {
    [CmdletBinding()]
    param (
        [LabSwitch[]]$Switches
    )
    
    begin {
        
    }
    
    process {
        Write-Verbose "Looping through LabSwitch configurations"
        foreach ($Switch in $Switches)
        {
            $Switch.CreateHyperVSwitch()
            
        }
    }
    
    end {
        
    }
}