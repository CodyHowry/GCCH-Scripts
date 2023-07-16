Import-Module Microsoft.Online.SharePoint.PowerShell -DisableNameChecking
 
$AdminAccount = "chowry@jmares.com"
$AdminCenterURL = "https://jmares-admin.sharepoint.us/"
 
#Connect to SharePoint Online Admin Center
Connect-SPOService -Url $AdminCenterURL
 
#Get All OneDrive for Business Sites in the Tenant
$OneDriveSites = Get-SPOSite -Limit ALL -includepersonalsite $True -Filter "Url -like '-my.sharepoint.us/personal/'"
       
#Loop through each OneDrive Site
Foreach($Site in $OneDriveSites)
{
    Write-host "Scanning site:"$Site.Url -f Yellow

    try{
        $checkadmin = Get-SPOUser -Site $Site.Url | Where {$_.IsSiteAdmin -eq $true -and $_.LoginName -eq $AdminAccount }
        $setAdmin = $false;
 
        #Add Temp Site Admin
        if($checkadmin.Count -eq 0){
            #Write-host "Add Temp Admin:"$Site.URL -f Gray
            Set-SPOUser -Site $Site -LoginName $AdminAccount -IsSiteCollectionAdmin $True | Out-Null           
            $setAdmin = $true
        }
    }catch{
        #Write-Host "Error:" $_.Exception.Message
        if($_.Exception.Message -like "Access is denied*"){
            #Write-host "Add Temp Admin:"$Site.URL -f Gray
            Set-SPOUser -Site $Site -LoginName $AdminAccount -IsSiteCollectionAdmin $True | Out-Null           
            $setAdmin = $true
        }
    }
  
    #Get All Site Collection Administrators
    $SiteAdmins = Get-SPOUser -Site $Site.Url | Where {$_.IsSiteAdmin -eq $true -and $_.LoginName -ne $AdminAccount -and $_.LoginName -ne $Site.Owner}
 
    if($SiteAdmins.Count -gt 0){
        #Iterate through each admin
        Foreach($Admin in $SiteAdmins)
        {
            Write-host "Found other Admin:"$Admin.LoginName -f Blue
        }
    }
 
    #Remove Temp Site Administrator if added
    if($setAdmin -eq $true){       
        #Write-host "Remove Temp Admin:"$Site.URL -f Gray   
        Set-SPOUser -site $Site -LoginName $AdminAccount -IsSiteCollectionAdmin $False | Out-Null
    }
}


