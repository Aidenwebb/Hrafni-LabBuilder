class LabSwitch
{
    [ValidateNotNullOrEmpty()][string]$Name
    [ValidateNotNullOrEmpty()][string]$Type
    [NetAdapter]$BindAdapter


    # Constructor

    LabSwitch($Name, $Type)
    {
        $this.Name = $Name
        $this.Type = $Type
    }

    LabSwitch($Name, $Type, $BindAdapter)
    {
        $this.Name = $Name
        $this.Type = $Type
        $this.BindAdapter = $BindAdapter
    }
    
    CreateHyperVSwitch() {
        Write-Verbose "Initialising Switch: $($this.Name)"
        Write-Verbose "Testing if LabSwitch already exists in Hyper-V: $($this.Name)"
        # Don't create a duplicate switch if one already has the same name
        if ((Get-VMSwitch | Where-Object -Property Name -EQ $this.Name).count -eq 0) {
            Write-Verbose "Switch does not exist: $($this.Name)"
            Write-Verbose "Creating Switch: $($this.Name)"
            if ($this.Type -eq "External")
            {
                New-VMSwitch -Name $this.Name -NetAdapterName $this.BindAdapter.Name -AllowManagementOS $true
            }
            else 
            {
                New-VMSwitch -Name $this.Name -SwitchType $this.Type
            }
        } else {
            Write-Verbose "Switch already exist and will not be created: $($this.Name)"
        }
    }
    
}