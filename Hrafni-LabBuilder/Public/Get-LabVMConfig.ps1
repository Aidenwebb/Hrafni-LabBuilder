function Get-LabVMConfig {
    [CmdletBinding()]
    param (
        $LabConfig
    )
    
    begin {
        Write-Verbose "Loading VM Config"
        [LabVM[]]$VMs = @()
        $VMConfigs = $LabConfig.hrafniconfig.vms.vm

    }
    
    process {
        Write-Verbose "Looping through each of $($VMConfigs.count) VM Configs"
        foreach ($VMConfig in $VMConfigs)
        {
            Write-Verbose "Current VMConfig:- Name: $($VMConfig.Name)"

            $LabVM = [LabVM]::New($VMConfig.Name,$VMConfig.Generation)
            foreach ($adapter in $VMConfig.adapters.adapter) {
                $AdapterLinkToSwitch = (Get-LabSwitch -Name $adapter.linktoswitch)
                $VMAdapter = [LabVMAdapter]::New($adapter.Name, $AdapterLinkToSwitch)
                $LabVM.AddAdapter($VMAdapter)
            }
            Write-Verbose "Adding $($VMConfig.Name) to VMs$VMs array"
            $VMs += @($LabVM)
        }
    }
    
    end {
        return $VMs
    }
}