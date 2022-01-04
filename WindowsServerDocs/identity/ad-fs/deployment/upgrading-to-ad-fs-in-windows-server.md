---
description: "Learn more about: Upgrading to AD FS in Windows Server 2016 and 2019 using a WID database"
ms.assetid: 7671e0c9-faf0-40de-808a-62f54645f891
title: Upgrading to AD FS in Windows Server 2016 and 2019
author: billmath
manager: femila
ms.date: 04/09/2018
ms.topic: article
ms.author: billmath
---

# Upgrading Active Directory Federation Services in Windows Server running Windows Internal Database(WID)

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2

The following document describes how to upgrade Active Directory Federation Services' (AD FS) and Web Application Proxy's (WAP) Farm Behavior Level. When you have multiple Windows Server versions operating in the same farm at the FBL value of the lowest version, your farm is said to be "mixed". Be aware that while in mixed farm mode, the AD FS farm is not capable of any new features or functionality introduced in a newer version of AD FS. This means organizations that want to try out new features cannot do this until the FBL is raised. If your organization is looking to test the new features in an development environment before introducing to production, you will need to deploy a separate farm to do this. 

See: [The AD FS deployment guide](https://docs.microsoft.com/en-us/windows-server/identity/ad-fs/deployment/ad-fs-deployment-guide)

> [!NOTE]
> Only begin an upgrade with a definitive time frame planned for completion. It is not recommended to keep AD FS in a mixed mode state for an extended period of time, as leaving AD FS in a mixed mode state may cause issues with the farm.


## AD FS Farm Behavior Levels (FBL)
In AD FS for Windows Server 2016, the farm behavior level (FBL) was introduced. This is farm-wide setting that determines the features the AD FS farm can use.

The following table lists the FBL values by Windows Server version:	
| Windows Server Version  | FBL | AD FS Configuration Database Name |
| ------------- | ------------- | ------------- |
| 2012 R2  | 1  | AdfsConfiguration |
| 2016  | 3  | AdfsConfigurationV3 |
| 2019  | 4  | AdfsConfigurationV4 |
| 2022  | 4  | AdfsConfigurationV4 |

To check the current Farm Behavior Level run the following cmdlet in PowerShell: 
- Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

```PowerShell
Get-ADFSFarminformation
```


### New vs Upgraded farms
By default, the FBL in a new AD FS farm matches the value for the Windows Server version of the first farm node installed.

Begining in Windows Server 2012R2, an AD FS server of a later version can be joined to an AD FS farm, and the farm will operate at the same FBL as the existing node(s). For example, this means that an administrator can add a Windows Server 2016 or higher with the AD FS role installed to a AD FS 2012 R2 Farm. All Servers in the farm will operate 2012R2 Farm Behavior level with a Configuration Database Name of AdfsConfiguration.  However, you will not be able to take advantage of the features of the later versions until the FBL is raised. With a mixed farm:

- Administrators can add additional servers of the same or later version of Windows Server to an existing AD FS farm. As a result, the farm is in "mixed mode" and operates at the same farm behavior level as the original farm. To ensure consistent behavior across the farm, features of the newer Windows Server AD FS versions cannot be configured or used. 

- Before the FBL can be raised, administrators must remove the AD FS nodes of previous Windows Server versions from the farm.  In the case of a WID farm, note that this requires one of the newer version Windows Server federation servers to be promoted to the role of primary node in the farm.  

- Once all federation servers in the farm are at the same Windows Server version, the FBL can be raised.  Any new Windows Server AD FS  features can then be configured and used after the FBL has been raised

## Upgrading Active Directory Federation Services Farm Behavior Level

### Upgrading from AD FS 2012R2 farm to AD FS 2016 and above
If you are upgrading an AD FS 2012 R2 farm, the later version of AD FS requires the AD schema to be at least level 85.  To upgrade the schema, With the Windows Server 2016 installation media, open a command prompt and navigate to support\adprep directory. Run the following cmdlet:  `adprep /forestprep`

![Screenshot that shows how to navigate to support\adprep directory.](media/Upgrading-to-AD-FS-in-Windows-Server-2016/ADFS_Mixed_7.png)

Once that completes run `adprep /domainprep`

> [!NOTE]
> Prior to running the next steps, ensure Windows Server is current by running Windows Update from Settings. Continue this process until no further updates are needed.
![Screenshot that shows how to run adprep /domainprep.](media/Upgrading-to-AD-FS-in-Windows-Server-2016/ADFS_Mixed_8.png)

### ADD new nodes to the current farm

> [!IMPORTANT]
> Before updating to a higher FBL, you must remove all previous AD FS server nodes. 
> For example You cannot just upgrade a Windows Server 2016 or 2012 R2 OS to Windows Server 2019 and have it become a 2019 node. You will need to remove it and replace it with a new 2019 node.

> [!NOTE]
> If AlwaysOnAvailability groups or merge replication are configured in AD FS, remove all replication of any AD FS databases prior to upgrade and point all nodes to the Primary SQL database. After performing this, perform the farm upgrade as documented. After upgrade, add AlwaysOnAvailability groups or merge replication to the new databases.

1. Install the Active Directory Federation Services Role on the Windows Server. 

```PowerShell
Install-WindowsFeature adfs-federation –IncludeManagementTools
```


2. Join the new Windows Server to the existing AD FS farm.

```PowerShell
#fscredential is the credential of the AD FS Service Account
$fscredential = Get-Credential
Add-AdfsFarmNode -PrimaryComputerName "FQDN of Primary Server" -PrimaryComputerPort 80 -ServiceAccountCredential $fscredential -CertificateThumbprint "{CertificateThumbprint}"
```

3. On the new federation server, open AD FS management console. Note that management capabilities are not available because this federation server is not the primary server.

![Screenshot that shows the A D F S window.](media/Upgrading-to-AD-FS-in-Windows-Server-2016/ADFS_Mixed_3.png)

### Switch the Primary Computer role to the new AD FS Primary Computer 

A new primary computer node must be disignated to one of the latest level AD FS Servers before upgrading the FBL. The following steps will transfer the role of primary computer to the latest AD FS server version and mark the downlevel server as secondary. 


4. On the Windows Server you've decided to grant the role of PrimaryComputer, open an elevated PowerShell command window and run the following cmdlet:

```PowerShell
Set-AdfsSyncProperties -Role PrimaryComputer
```

![Screenshot of a terminal window that shows how to use the Set-AdfsSyncProperties -Role PrimaryComputer cmdlet.](media/Upgrading-to-AD-FS-in-Windows-Server-2016/ADFS_Mixed_4.png)

5. On old AD FS PrimaryComputer, open an elevated PowerShell command window and run the following cmdlet:

```PowerShell
#PrimaryComputer is the FQDN of the new AD FS server in step 4, which you granted the primary computer role. 
Set-AdfsSyncProperties -Role SecondaryComputer -PrimaryComputerName {FQDN}
```

![Screenshot of a terminal window that shows how to use the Set-AdfsSyncProperties -Role SecondaryComputer -PrimaryComputerName {FQDN} cmdlet.](media/Upgrading-to-AD-FS-in-Windows-Server-2016/ADFS_Mixed_5.png)

6. Now on the new AD FS PrimaryComputer open the AD FS Management Console. Note that now all of the admin capabilities appear because the primary role has been transferred to this server.

![Screenshot that shows the Windows Server 2016 federation server open AD FS Management window.](media/Upgrading-to-AD-FS-in-Windows-Server-2016/ADFS_Mixed_6.png)

### Add the new Web Application Proxy Servers 

Web Application Proxy servers are required to be at or above the Windows Server version configured on the AD FS Farm. This means when performing a farm behavior level upgrade you must upgrade the WAP servers to the same Windows Server version as well. 


7. Using Server Manager, install the Web Application Proxy Role on a new Windows Server using the following: 

```PowerShell
Install-WindowsFeature Web-Application-Proxy -IncludeManagementTools
```

8. Configure Web Application Proxy(s) using the following: 

```PowerShell
$trustcred = Get-Credential -Message "Enter Domain Administrator credentials"
Install-WebApplicationProxy -CertificateThumbprint {SSLCert} -fsname fsname -FederationServiceTrustCredential $trustcred
```

### Remove old AD FS and WAP Server nodes

9. Remove all old AD FS Farm nodes using the following: 

```PowerShell
Uninstall-WindowsFeature adfs-federation –IncludeManagementTools
```
> View any stale node configuration data using the 'Get-ADFSFarmInformation'. If the old servers are still showing up in the nodes,  remove any stale node data using the   following: 
````PowerShell
Set-AdfsFarmInformation -RemoveNode "adfs02.contoso.com"
````

10. Remove all the downlevel WAP nodes using the following 
````PowerShell
Uninstall-WindowsFeature Web-Application-Proxy -IncludeManagementTools
````

Remove old servers from the cluster and keep only the WAP servers running the latest server version, which were reconfigured above, by running the following Powershell cmdlet and use only the fqdn of the the WAP servers that remain.

```PowerShell
Set-WebApplicationProxyConfiguration -ConnectedServersName WAPServerName1, WAPServerName2
```

>Check the WAP configuration by running the Get-WebApplicationProxyConfiguration cmdlet. The ConnectedServersName will reflect the servers run from the prior command.
````PowerShell
Get-WebApplicationProxyConfiguration
````



### Upgrading the Farm Behavior Level for AD FS and WAP 

> [!IMPORTANT]
> All downlevel Windows Servers must be removed from the farm before running the next steps.

> [!NOTE]
> Attemping to raise the FBL creates a new AD FS configuration database. This will take place even if the cmdlet is ran prematurely without removing all downlevel servers from the AD FS Farm. If this happen this will prevent an AD FS farm behavior level from raising. See the troubleshooting section below for mitigation steps. 
11. Ensure that the farm behavior level can successfully be raised with the [Test Farm Behavior Level](/powershell/module/adfs/test-adfsfarmbehaviorlevelraise?view=windowsserver2019-ps&preserve-view=true) command.

```PowerShell
Test-AdfsFarmBehaviorLevelRaise
```

12. Now on the new Primary Computer, open PowerShell and run the following cmdlet:

```PowerShell
Invoke-AdfsFarmBehaviorLevelRaise
```
![Screenshot of a terminal window that shows how to run the Invoke-AdfsFarmBehaviorLevelRaise cmdlet.](media/Upgrading-to-AD-FS-in-Windows-Server-2016/ADFS_Mixed_9.png)


13. When prompted, type Y. This will begin raising the level. Once this completes you have successfully raised the FBL.

![Screenshot of a terminal window that shows when to type Y.](media/Upgrading-to-AD-FS-in-Windows-Server-2016/ADFS_Mixed_10.png)

14. After completion, you will see the new capabilities have been added for the later AD FS version. See the AD FS documentation for [What's New in Active Directory Federation Services](https://docs.microsoft.com/en-us/windows-server/identity/ad-fs/overview/whats-new-active-directory-federation-services-windows-server#:~:text=What%27s%20new%20in%20Active%20Directory%20Federation%20Services%20for,for%20Code%20Exchange%20%28PKCE%29%20support%20for%20oAuth.%20).

![Screenshot that shows the new capabilities that have been added.](media/Upgrading-to-AD-FS-in-Windows-Server-2016/ADFS_Mixed_12.png)



15. Likewise, you can use the PowerShell cmdlet:  `Get-AdfsFarmInformation` to show you the current FBL.

![upgrade](media/Upgrading-to-AD-FS-in-Windows-Server-2016/ADFS_Mixed_13.png)



16. To upgrade the ConfigurationVersion of the WAP servers, run the following Powershell command.

```PowerShell
Set-WebApplicationProxyConfiguration -UpgradeConfigurationVersion
```

This will complete the upgrade of the WAP servers.


## Known Issues

> [!NOTE]
> A known PRT issue exists in AD FS 2019 if Windows Hello for Business with a Hybrid Certificate trust is performed. You may encounter this error in AD FS Admin event logs: Received invalid Oauth request. The client 'NAME' is forbidden to access the resource with scope 'ugs'.
> To remediate this error:
> 1. Launch AD FS management console. Brose to "Services > Scope Descriptions"
> 2. Right click "Scope Descriptions" and select "Add Scope Description"
> 3. Under name type "ugs" and Click Apply > OK
> 4. Launch Powershell as Administrator
> 5. Execute the command "Get-AdfsApplicationPermission". Look for the ScopeNames :{openid, aza} that has the ClientRoleIdentifier. Make a note of the ObjectIdentifier.
> 6. Execute the command "Set-AdfsApplicationPermission -TargetIdentifier <ObjectIdentifier from step 5> -AddScope 'ugs'
> 7. Restart the AD FS service.
> 8. On the client: Restart the client. User should be prompted to provision WHFB.
> 9. If the provisioning window does not pop up then need to collect NGC trace logs and further troubleshoot.


# Troubleshooting

## Removing existing Databases

### Issue: 
Test-AdfsFarmBehaviorLevelRaise fails with the following error: Database upgrade cannot be performed on adfs1.contoso.com. Error: A database for the target behavior level already exists.

### Cause: 
The Invoke-FarmbehaivorLevelRaise cmdlet was previously ran on the server. This cause the creation of a database instance in the Windows Internal Base. 

### Solution 1: 
To resolve this issue attempt the following:
1. Re-add the previous downlevel version of an AD FS Sever to the farm. 
2. Use the following cmdlet to clean up the database. 
```Powershell
#Specify your previous farm behavior level 1,3,4.
Restore-AdfsFarmBehaviorLevel -FarmBehavior 
```

### Solution 2: 
If a downlevel server is unavailable you must unmount the new DB from the Windows Internal Base using SQL Management studio. 

1. Download [SQL Management Studio](https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-ver15)
2. Open SSMS as administrator

> To acquire the SQL connection string for the AD FS WID
> 1.  Open Windows PowerShell
> 2. Enter the following: `$adfs = gwmi -Namespace root/ADFS -Class SecurityTokenService` and hit Enter
> 3. Enter the following:  `$adfs.ConfigurationDatabaseConnectionString` and hit enter.
> 4. You should see the connect string information.

3. Use the Connection string and login to the database with the ADFS Service account credentials. 
> Under Database you will see one of the following database: 
> - AdfsConfiguration | Farm Bahavior Level 1
> - AdfsConfigurationV3 | Farm Bahavior Level 3
> - AdfsConfigurationV4 | Farm Bahavior Level 4

4. Unmount the database for the FBL you wish to upgrade to. 
5. Restart the AD FS service
```PowerShell
Restart-Service AdfsSrv
```
6. Try raise the FBL once more. If this step fails contact Microsoft Support. 

