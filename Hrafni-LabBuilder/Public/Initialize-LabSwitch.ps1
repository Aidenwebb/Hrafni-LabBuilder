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
            Write-Verbose "Initialising Switch: $($Switch.Name)"
            Write-Verbose "Testing if LabSwitch already exists in Hyper-V: $($Switch.Name)"
            # Don't create a duplicate switch if one already has the same name
            if ((Get-VMSwitch | Where-Object -Property Name -EQ $Switch.Name).count -eq 0) {
                Write-Verbose "Switch does not exist: $($Switch.Name)"
                Write-Verbose "Creating Switch: $($Switch.Name)"
                if ($Switch.Type -eq "External")
                {
                    New-VMSwitch -Name $Switch.Name -NetAdapterName $Switch.BindAdapter.Name -AllowManagementOS $true
                }
                else 
                {
                    New-VMSwitch -Name $Switch.Name -SwitchType $Switch.Type
                }
            } else {
                Write-Verbose "Switch already exist and will not be created: $($Switch.Name)"
            }
            
        }
    }
    
    end {
        
    }
}