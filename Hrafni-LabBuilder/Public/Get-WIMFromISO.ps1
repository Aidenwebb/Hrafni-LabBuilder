function Get-WIMFromISO {
    [CmdletBinding()]
    param (
        [string]$ISOPath,
        [string]$OutputDirectory
    )
    
    begin {
        # Test Paths
        If (-not(Test-Path $ISOPath))
        {
            throw "ISO not found"
        }

        $ISO = Get-Item $ISOPath
        If (-not(Test-Path $OutputDirectory))
        {
            throw "OutputDirectory not found"
        }
        $OutputDirectory = (Get-Item $OutputDirectory).FullName
        # Mount ISO
        $Volume = (Mount-DiskImage -ImagePath $ISO.FullName | Get-Volume)

        # Find Install.wim
        $WIMPath = '{0}:\sources\install.wim' -f $Volume.DriveLetter

        # Test WIM Path
        If (-not(Test-Path $WIMPath))
        {
            throw "Install.wim not found at location $WIMPath"
        }

        $WIM = Get-Item -Path $WIMPath
    }
    
    process {

        # Rename WIM to avoid clashes with others
        $OutputWIMName = "$($Volume.FileSystemLabel)-Install.wim"
        $Destination = "$OutputDirectory\$OutputWIMName"
        If (Test-Path $Destination)
        {
            throw "A file already exists at $Destination. Please remove it to prevent conflicts"
        }
        else
        {
            # Copy WIM to Output folder
            Copy-Item -Path $WIM.FullName -Destination $Destination
        }
        
        $OutputWim = Get-Item $Destination
    }
    
    end {
        # Unmount ISO
        Dismount-DiskImage -ImagePath $ISO.FullName
        Return $OutputWim
    }
}