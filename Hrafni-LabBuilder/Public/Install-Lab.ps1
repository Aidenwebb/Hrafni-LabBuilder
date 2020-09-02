# Just drafting a workflow for now

function Install-Lab {
    [CmdletBinding()]
    param (
        $ConfigPath
    )
    
    begin {
        # Load the Config into a referencable object
        $LabConfig = Get-LabConfig
        
        # Get Switch Config
        Get-LabSwitchConfig -LabConfig $LabConfig
    }
    
    process {

        # Set Hyper-V Switches
        #Initialize-LabSwitch

        # Create VMs
    }
    
    end {
        
    }
}