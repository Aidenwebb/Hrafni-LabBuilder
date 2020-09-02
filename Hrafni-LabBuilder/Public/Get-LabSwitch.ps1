function Get-LabSwitch {
    [CmdletBinding()]
    param (
        $LabConfig
    )
    
    begin {
        Write-Verbose "Loading Switch Config"
        [LabSwitch[]]$Switches = @()
        $SwitchConfigs = $LabConfig.hrafniconfig.switches.switch

    }
    
    process {
        Write-Verbose "Looping through each Switch Config"
        foreach ($SwitchConfig in $SwitchConfigs)
        {
            Write-Verbose "Current SwitchConfig:- Name: $($SwitchConfig.Name) | Type: $($SwitchConfig.Type)"
            if ($SwitchConfig.type -eq "External")
            {
                $AdapterMAC = $Switchconfig.bindadapter.macaddress
                Write-Verbose "Getting Physical Adapter for MAC: $AdapterMAC"
                $PhysicalAdapter = Get-NetAdapter -Physical | Where-Object {$_.MacAddress -eq $AdapterMAC}
                Write-Verbose "Creating Adapter Object for Physical Adapter: $($PhysicalAdapter.Name)"
                $BindAdapter = [NetAdapter]::New($PhysicalAdapter.Name, $AdapterMAC)
                Write-Verbose "Creating LabSwitch Object for $($SwitchConfig.Name)"
                $LabSwitch = [LabSwitch]::New($SwitchConfig.name, $SwitchConfig.type, $BindAdapter)

            }
            else
            {
                Write-Verbose "Creating LabSwitch Object for $($SwitchConfig.Name)"
                $LabSwitch = [LabSwitch]::New($SwitchConfig.name, $SwitchConfig.type)    
            }
            Write-Verbose "Adding $($SwitchConfig.Name) to Switches array"
            $Switches += @($LabSwitch)
        }
    }
    
    end {
        return $Switches
    }
}