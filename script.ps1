$Items = (Get-ChildItem "" -Recurse -Depth 1 -Directory | Where { $_.PSIsContainer } | select fullname | %{$_.fullname.trim()})
$Path = "ACLs.csv"

$Table = @()
$Record = [ordered]@{
"Directory" = ""
"Owner" = ""
"FileSystemRights" = ""
"AccessControlType" = ""
"IdentityReference" = ""
"IsInherited" = ""
"InheritanceFlags" = ""
"PropogationFlags" = ""

}

Foreach ($Item in $Items)
{

$ACL = (Get-Acl -Path $Item)

$Record."Directory" = $ACL.path | %{$_.trimstart("Microsoft.PowerShell.Core\FileSystem::")}
$Record."Owner" = $ACL.Owner
echo $ACL.access
Foreach ($SItem in $ACL.access)
{
$Record."FileSystemRights" = $SItem.FileSystemRights
$Record."AccessControlType" = $SItem.AccessControlType
$Record."IdentityReference" = $SItem.IdentityReference
$Record."IsInherited" = $SItem.IsInherited
$Record."InheritanceFlags" = $SItem.InheritanceFlags
$Record."PropogationFlags" = $SItem.PropagationFlags


$objRecord = New-Object PSObject -property $Record
$Table += $objrecord
}
}
$Table | Export-Csv -Path $Path -NoTypeInformation
