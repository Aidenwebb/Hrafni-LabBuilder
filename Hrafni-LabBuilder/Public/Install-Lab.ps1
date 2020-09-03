# Just drafting a workflow for now

function Install-Lab {
    [CmdletBinding()]
    param (
        $ConfigPath
    )
    
    begin {
        # Load the Config into a referencable object
        $LabConfig = Get-LabConfig -ConfigPath $ConfigPath 
    }
    
    process {

        # Get Switch Config
        $Switches = Get-LabSwitchConfig -LabConfig $LabConfig
        # Initialize LabSwitch
        $InitializedSwitches = Initialize-LabSwitch -Switches $Switches

        
        # Get VM Config
        $VMs = Get-LabVMConfig -LabConfig $LabConfig
        # Initialise LabVMs
        $InitializedVMs = Initialize-LabVM -VMs $VMs
    }
    
    end {
        
    }
}