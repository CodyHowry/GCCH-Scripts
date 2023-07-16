#Parameters
$AdminCenterURL = "https://jmares-Admin.SharePoint.us"

#update this OneDriveSiteURL with the users. You should be able to just replace their name in the url.
$OneDriveSiteURL = "https://jmares-my.sharepoint.us/personal/salaudeen_jmares_com"
$UserAccount = "Chowry@jmares.com"
 
#Connect to SharePoint Online
Connect-SPOService -url $AdminCenterURL -Credential (Get-Credential)
 
#Get the OneDrive for Business Site
$Site = Get-SPOSite $OneDriveSiteURL
 
#Remove site collection admin
Set-SPOUser -Site $Site -LoginName $UserAccount -IsSiteCollectionAdmin $False


#Read more: https://www.sharepointdiary.com/2019/08/remove-site-collection-administrator-from-onedrive-for-business.html#ixzz85l1JOvFn