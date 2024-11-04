# check for fips mode is enabled
$fipsEnabled = (Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa\FipsAlgorithmPolicy" -Name "Enabled").Enabled

# check if bitlocker encryption is enabled on the c drive
if ($fipsEnabled -ne 0) {
    $driveLetter = "C" # change this to the drive letter you want to check

    $bitlockerStatus = (Get-BitlockerVolume -MountPoint $driveLetter).ProtectionStatus

    if ($bitlockerStatus -eq "On") {
        Write-Host "Bitlocker encryption is enabled on the drive $driveLetter"
        exit 0 # does not run the remediation script
    } else {
        Write-Host "Bitlocker encryption is not enabled on the drive $driveLetter"
        exit 1 # runs the remediation script
    }
} else {
    # enable fips mode and run remediation script
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa\FipsAlgorithmPolicy" -Name "Enabled" -Value 1

    Write-Host "FIPS mode has been enabled."
    exit 1 # run remediation script
}
