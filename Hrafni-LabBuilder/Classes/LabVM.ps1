class LabVM {

    [ValidateNotNullOrEmpty()][string]$Name
    [ValidateNotNullOrEmpty()][int]$Generation
    [string]$MemoryStartupBytes
    [LabVMAdapter[]]$Adapters

    # Constructor
    LabVM($Name, $Generation)
    {
        $this.Name = $Name
        $this.Generation = $Generation
        $this.MemoryStartupBytes = [Math]::Pow(1024,2)
    }
    LabVM($Name, $Generation, $MemoryStartupBytes)
    {
        $this.Name = $Name
        $this.Generation = $Generation
        $this.MemoryStartupBytes = $MemoryStartupBytes
    }

    AddAdapter([LabVMAdapter]$Adapter)
    {
        $this.Adapters += $Adapter
    }

    CreateHyperVVM()
    {
        New-VM -Name $this.Name `
        -Generation $this.Generation `
        -MemoryStartupBytes $this.MemoryStartupBytes

        foreach ($Adapter in $this.Adapters) {
            Add-VMNetworkAdapter -VMName $this.Name `
            -Name $this.Adapter.Name `
            -SwitchName $this.Adapter.Switch.Name `
            -DeviceNaming On
            -Passthru
        }
    }
}
