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
        Write-Verbose "Looping through each VM Config"
        foreach ($VMConfig in $VMConfigs)
        {
            Write-Verbose "Current VMConfig:- Name: $($VMConfig.Name)"


            #$AdapterMAC = $Switchconfig.bindadapter.macaddress
            #Write-Verbose "Getting Physical Adapter for MAC: $AdapterMAC"
            #$PhysicalAdapter = Get-NetAdapter -Physical | Where-Object {$_.MacAddress -eq $AdapterMAC}
            #Write-Verbose "Creating Adapter Object for Physical Adapter: $($PhysicalAdapter.Name)"
            #$BindAdapter = [NetAdapter]::New($PhysicalAdapter.Name, $AdapterMAC)
            #Write-Verbose "Creating LabSwitch Object for $($VMConfig.Name)"
            #$LabSwitch = [LabSwitch]::New($VMConfig.name, $VMConfig.type, $BindAdapter)
            $LabVM = [LabVM]::New($VMConfig.Name,$VMConfig.Generation)
            foreach ($adapter in $VMConfig.adapters.adapter) {
                $AdapterLinkToSwitch = (Get-LabSwitch -Name $adapter.linktoswitch)
                $VMAdapter = [LabVMAdapter]::New($adapter.Name, $AdapterLinkToSwitch)
                $LabVM.AddAdapter($VMAdapter)
            }
            #$LabVM.AddAdapter()
            Write-Verbose "Adding $($VMConfig.Name) to VMs$VMs array"
            $VMs += @($LabVM)
        }
    }
    
    end {
        return $VMs
    }
}