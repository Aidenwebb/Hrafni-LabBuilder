function Initialize-LabVM {
    [CmdletBinding()]
    param (
        [LabVM[]]$VMs
    )
    
    begin {
        
    }
    
    process {
        Write-Verbose "Looping through LabVM configurations"
        foreach ($VM in $VMs)
        {
            $VM.CreateHyperVVM()
            
        }
    }
    
    end {
        
    }
}