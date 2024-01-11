#Add SharePoint PowerShell Snapin which adds SharePoint specific cmdlets
Add-PSSnapin Microsoft.SharePoint.PowerShell -EA SilentlyContinue
 
# Script settings
$webUrl = "https://spwfe.contoso.local"
$listName = "List #2"
$numberItemsToCreate = 100
$itemNamePrefix = "Item - "
 
# Open web and library
$web = Get-SPWeb $webUrl
$list = $web.Lists[$listName]
 
# Create desired number of items in subfolder
for($i=1; $i -le $numberItemsToCreate; $i++)
{
$newItemSuffix = $i.ToString("00000")
$newItem = $list.AddItem()
$newItem["Title"] = "$itemNamePrefix$newItemSuffix"
$newItem.Update()
write-host "Item created: $itemNamePrefix$newItemSuffix"
}
 
#Dispose web
$web.Dispose()
