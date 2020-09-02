function Get-LabConfig 
{
    [CmdletBinding()]
    param (
        $ConfigPath
    )
    
    begin {
        Write-Verbose "Testing Path is valid $ConfigPath"
        If (-not(Test-Path $ConfigPath))
        {
            throw "ConfigPath not found"
        }
    }
    
    process {
        Write-Verbose "Loading $ConfigPath"
        [xml]$LabConfig = Get-Content $ConfigPath
    }
    
    end {
        return $LabConfig    
    }
    
}