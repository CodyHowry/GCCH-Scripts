$StartMenuFolder = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs"
$Count = (Get-ChildItem $StartMenuFolder | ? Name -match "Word|Outlook|Powerpoint|Edge").count
If($count -ge 4){"Installed"}