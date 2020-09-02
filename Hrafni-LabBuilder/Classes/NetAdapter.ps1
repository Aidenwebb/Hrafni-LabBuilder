class NetAdapter
{
    [string]$Name
    [ValidateNotNullOrEmpty()][string]$MACAddress

    # Constructor
    NetAdapter($Name, $MACAddress)
    {
        $this.Name = $Name
        $this.MACAddress = $MACAddress
    }
}