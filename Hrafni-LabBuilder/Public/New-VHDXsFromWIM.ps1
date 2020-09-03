function New-VHDXsFromWIM {
    [CmdletBinding()]
    param (
        [string]$WIMPath,
        [string]$OutputDirectory,
        [string]$UnattendXMLPath
    )
    
    begin {

        # Name Sanitiser Pattern
        $pattern = '[^a-zA-Z0-9\-]'

        # Server naming pattern for Conver-WindowsImage

        # Test Paths
        If (-not(Test-Path $WIMPath))
        {
            throw "ISO not found"
        }
        $WIM = Get-Item $WIMPath

        If (-not(Test-Path $OutputDirectory))
        {
            throw "OutputDirectory not found"
        }
        
        $OutputDirectory = (Get-Item $OutputDirectory).FullName
    
        If ($PSBoundParameters.ContainsKey('UnattendXMLPath')){
            If (-not(Test-Path $UnattendXMLPath))
            {
                throw "Unattend.xml not found"
            }

            $UnattendXML = Get-Item -Path $UnattendXMLPath
        }
        

        $Images = Get-WindowsImage -ImagePath $WIM.FullName

    }
    
    process {
        foreach ($Image in $Images) {
            Write-Verbose "ImageName: $($image.ImageName)"

            switch ($Image.ImageName) {
                "Windows Server 2019 Standard" { $Edition = "ServerStandardCore" }
                "Windows Server 2019 Standard (Desktop Experience)" { $Edition = "ServerStandard" }
                "Windows Server 2019 Datacenter" { $Edition = "ServerDataCenterCore" }
                "Windows Server 2019 Datacenter (Desktop Experience)" { $Edition = "ServerDataCenter" }
                Default {$Edition = $Image.ImageName}
            }

            Write-Verbose "Edition: $Edition"
            # Replace spaces with hyphens
            $VHDName = $Image.ImageName -replace " ", "-"

            # Remove unwanted characters
            $VHDName = $VHDName -replace $pattern, ''

            # Add Extension
            $VHDName = "$VHDName.vhdx"
            Write-Verbose "VHDName: $($VHDName)"
            $VHDOutputPath = "$OutputDirectory$VHDName"
            Write-Verbose "VHDOuput: $($VHDOutputPath)"
            if (Test-Path $VHDOutputPath) {
                Write-Error "A file already exists at $VHDOutputPath. Please remove it to prevent conflicts"
                continue
            }
            If ($PSBoundParameters.ContainsKey('UnattendXMLPath'))
            {
                Convert-WindowsImage -WIM $WIM.FullName -DiskType Dynamic -Size 50GB -VHDFormat VHDX -VHDPath $VHDOutputPath -Edition $Edition -UnattendPath $UnattendXML.FullName
            }
            else
            {
                Convert-WindowsImage -WIM $WIM.FullName -DiskType Dynamic -Size 50GB -VHDFormat VHDX -VHDPath $VHDOutputPath -Edition $Edition
            }
        }
        
    }
    
    end {
        
    }
}