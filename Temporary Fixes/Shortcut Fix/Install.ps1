$StartMenuFolder = "$env:ProgramData\Microsoft\Windows\Start Menu\Programs"
$ShortCuts = Get-ChildItem -Filter "*.lnk"
$ShortCuts | % {
    If(test-path("$StartMenuFolder\$($_.name)")){
        "$($_.name) already exist in start menu"
    }
    else {
        "$($_.name) not found in start menu - checking if program pointed to by shortcut exist"
        $sh = New-Object -ComObject WScript.Shell
        if(Test-Path($sh.CreateShortcut($_.FullName).TargetPath)){
            "Program exist - copying $($_.Name) into start menu folder"
            Copy-Item -Path $_.FullName -Destination $StartMenuFolder -Force
        }
        else {
            "Did not find $($sh.CreateShortcut($_.FullName).TargetPath) - will not copy $($_.name)"
        }
    }
}