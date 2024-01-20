# Load the SharePoint PowerShell snap-in
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue

# Get all IIS sites on the server
$iisSites = Get-WebSite

# Loop through each IIS site
foreach ($iisSite in $iisSites) {
    Write-Host "IIS Site: $($iisSite.name)"
    
    # Get the SharePoint web application associated with the IIS site
    $webApp = Get-SPWebApplication | Where-Object { $_.IisSettings.Item("IIS Web Site").Value -eq $iisSite.Name }

    # Check if the IIS site is associated with a SharePoint web application
    if ($webApp -ne $null) {
        # Get the virtual directories for the IIS site
        $virtualDirectories = $webApp.IisSettings[$iisSite.Name].Path
        Write-Host "Virtual Directories:"
        
        foreach ($virtualDirectory in $virtualDirectories) {
            Write-Host "  - $virtualDirectory"
        }
    }
    else {
        Write-Host "Not associated with a SharePoint web application."
    }

    Write-Host "`n"
}

# Remove the SharePoint PowerShell snap-in
Remove-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue
