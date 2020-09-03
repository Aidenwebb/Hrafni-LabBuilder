class LabVM {

    [ValidateNotNullOrEmpty()][string]$Name
    [ValidateNotNullOrEmpty()][int]$Generation
    [string]$MemoryStartupBytes
    [LabVMAdapter[]]$Adapters

    # Constructor
    LabVM($Name, $Generation) {
        $this.Name = $Name
        $this.Generation = $Generation
        $this.MemoryStartupBytes = [Math]::Pow(1024, 3)
    }
    LabVM($Name, $Generation, $MemoryStartupBytes) {
        $this.Name = $Name
        $this.Generation = $Generation
        $this.MemoryStartupBytes = $MemoryStartupBytes
    }

    AddAdapter([LabVMAdapter]$Adapter) {
        $this.Adapters += $Adapter
    }

    CreateHyperVVM() {
        Write-Verbose "Initialising VM: $($this.Name)"
        Write-Verbose "Testing if VM already exists in Hyper-V: $($this.Name)"

        if ((Get-VM | Where-Object -Property Name -EQ $this.Name).count -eq 0) {
            Write-Verbose "VM does not exist: $($this.Name)"
            Write-Verbose "Creating VM: $($this.Name) with $($($this.MemoryStartupBytes)/1GB)GB Memory"
            New-VM -Name $this.Name `
                -Generation $this.Generation `
                -MemoryStartupBytes $this.MemoryStartupBytes

            # Remove the unused, automatically generated Network Adapter
            Remove-VMNetworkAdapter -VMName $this.Name -Name 'Network Adapter'
            foreach ($Adapter in $this.Adapters) {
                Add-VMNetworkAdapter -VMName $this.Name `
                    -Name $Adapter.Name `
                    -SwitchName $Adapter.Switch.Name `
                    -DeviceNaming On
            }
        }
        else {
            Write-Verbose "VM already exist and will not be created: $($this.Name)"
        }
    }
}
