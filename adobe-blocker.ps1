# Make sure to add to $path all known Adobe directories, paths should be in qoutation marks, and delimited with commas.
$time = Get-Date -Format "ddMMyyyy";
$user = $Env:UserName;
$rule_prefix = "Adobe-$($user)$($time)";
$paths = "C:\Program Files\Common Files\Adobe", "C:\Program Files\Adobe", "C:\Program Files (x86)\Common Files\Adobe", "C:\Program Files (x86)\Adobe", "C:\Users\$($user)\AppData\LocalLow\Adobe", "C:\Users\$($user)\AppData\Roaming\Adobe", "C:\Users\$($user)\AppData\Local\Adobe"
 Get-ChildItem -Path $paths -Filter *.exe -Recurse |
    Select-Object Name,FullName |
    ForEach-Object `
    {New-NetFirewallRule -DisplayName "Block $($_.Name) Inbound" -Direction Inbound -Program "$($_.FullName)" -Action Block;
    New-NetFirewallRule -DisplayName "Block $($_.Name) Outbound" -Direction Outbound -Program "$($_.FullName)" -Action Block};
