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

# Upgrading to AD FS in Windows Server 2016 using a WID database


> [!NOTE]
> Only begin an upgrade with a definitive time frame planned for completion. It is not recommended to keep AD FS in a mixed mode state for an extended period of time, as leaving AD FS in a mixed mode state may cause issues with the farm.

## Upgrading a Windows Server 2012 R2 or 2016 AD FS farm to Windows Server 2019
The following document will describe how to upgrade your AD FS farm to AD FS in Windows Server 2019 when you are using a WID database.

### AD FS Farm Behavior Levels (FBL)
In AD FS for Windows Server 2016, the farm behavior level (FBL) was introduced. This is farm-wide setting that determines the features the AD FS farm can use.

The following table lists the FBL values by Windows Server version:

| Windows Server Version  | FBL | AD FS Configuration Database Name |
| ------------- | ------------- | ------------- |
| 2012 R2  | 1  | AdfsConfiguration |
| 2016  | 3  | AdfsConfigurationV3 |
| 2019  | 4  | AdfsConfigurationV4 |

> [!NOTE]
> Upgrading the FBL creates a new AD FS configuration database.  See the table above for the names of the configuration database for each Windows Server AD FS version and FBL value

### New vs Upgraded farms
By default, the FBL in a new AD FS farm matches the value for the Windows Server version of the first farm node installed.

An AD FS server of a later version can be joined to an AD FS 2012 R2 or 2016 farm, and the farm will operate at the same FBL as the existing node(s). When you have multiple Windows Server versions operating in the same farm at the FBL value of the lowest version, your farm is said to be "mixed". However, you will not be able to take advantage of the features of the later versions until the FBL is raised. With a mixed farm:

- Administrators can add new Windows Server 2019 federation servers to an existing Windows Server 2012 R2 or 2016 farm. As a result, the farm is in "mixed mode" and operates at the same farm behavior level as the original farm. To ensure consistent behavior across the farm, features of the newer Windows Server AD FS versions cannot be configured or used.

- Before the FBL can be raised, administrators must remove the AD FS nodes of previous Windows Server versions from the farm.  In the case of a WID farm, note that this requires one of the new Windows Server 2019 federation servers to be promoted to the role of primary node in the farm.

- Once all federation servers in the farm are at the same Windows Server version, the FBL can be raised.  As a result, any new AD FS Windows Server 2019 features can then be configured and used.

Be aware that while in mixed farm mode, the AD FS farm is not capable of any new features or functionality introduced in AD FS in Windows Server 2019. This means organizations that want to try out new features cannot do this until the FBL is raised. So if your organization is looking to test the new features prior to raising the FBL, you will need to deploy a separate farm to do this.

The remainder of the is document provides the steps for adding a Windows Server 2019 federation server to a Windows Server 2016 or 2012 R2 environment and then raising the FBL to Windows Server 2019. These steps were performed in a test environment outlined by the architectural diagram below.

> [!NOTE]
> Before you can move to AD FS in Windows Server 2019 FBL, you must remove all of the Windows Server 2016 or 2012 R2 nodes. You cannot just upgrade a Windows Server 2016 or 2012 R2 OS to Windows Server 2019 and have it become a 2019 node. You will need to remove it and replace it with a new 2019 node.

> [!NOTE]
> If AlwaysOnAvailability groups or merge replication are configured in AD FS, remove all replication of any ADFS databases prior to upgrade and point all nodes to the Primary SQL database. After performing this, perform the farm upgrade as documented. After upgrade, add AlwaysOnAvailability groups or merge replication to the new databases.

##### To upgrade your AD FS farm to Windows Server 2019 Farm Behavior Level

1. Using Server Manager, install the Active Directory Federation Services Role on the Windows Server 2019

2. Using the AD FS Configuration wizard, join the new Windows Server 2019 server to the existing AD FS farm.

![Screenshot that shows how to join the new Windows Server 2019 server to the existing AD FS farm.](media/Upgrading-to-AD-FS-in-Windows-Server-2016/ADFS_Mixed_1.png)

3. On the Windows Server 2019 federation server, open AD FS management. Note that management capabilities are not available because this federation server is not the primary server.

![Screenshot that shows the A D F S window.](media/Upgrading-to-AD-FS-in-Windows-Server-2016/ADFS_Mixed_3.png)

4. On the Windows Server 2019 server, open an elevated PowerShell command window and run the following cmdlet:

```PowerShell
Set-AdfsSyncProperties -Role PrimaryComputer
```

![Screenshot of a terminal window that shows how to use the Set-AdfsSyncProperties -Role PrimaryComputer cmdlet.](media/Upgrading-to-AD-FS-in-Windows-Server-2016/ADFS_Mixed_4.png)

5. On the  AD FS server that was previously configured as primary, open  an elevated PowerShell command window and run the following cmdlet:

```PowerShell
Set-AdfsSyncProperties -Role SecondaryComputer -PrimaryComputerName {FQDN}
```

![Screenshot of a terminal window that shows how to use the Set-AdfsSyncProperties -Role SecondaryComputer -PrimaryComputerName {FQDN} cmdlet.](media/Upgrading-to-AD-FS-in-Windows-Server-2016/ADFS_Mixed_5.png)

6. Now on the Windows Server 2016 federation server open AD FS Management. Note that now all of the admin capabilities appear because the primary role has been transferred to this server.

![Screenshot that shows the Windows Server 2016 federation server open AD FS Management window.](media/Upgrading-to-AD-FS-in-Windows-Server-2016/ADFS_Mixed_6.png)

7. If you are upgrading an AD FS 2012 R2 farm to 2016 or 2019, the farm upgrade requires the AD schema to be at least level 85.  To upgrade the schema, With the Windows Server 2016 installation media, open a command prompt and navigate to support\adprep directory. Run the following:  `adprep /forestprep`

![Screenshot that shows how to navigate to support\adprep directory.](media/Upgrading-to-AD-FS-in-Windows-Server-2016/ADFS_Mixed_7.png)

Once that completes run `adprep /domainprep`

> [!NOTE]
> Prior to running the next step, ensure Windows Server is current by running Windows Update from Settings. Continue this process until no further updates are needed.

![Screenshot that shows how to run adprep /domainprep.](media/Upgrading-to-AD-FS-in-Windows-Server-2016/ADFS_Mixed_8.png)

8. Now on the Windows Server 2016 Server open PowerShell and run the following cmdlet:


> [!NOTE]
> All 2012 R2 servers must be removed from the farm before running the next step.

```PowerShell
Invoke-AdfsFarmBehaviorLevelRaise
```

![Screenshot of a terminal window that shows how to run the Invoke-AdfsFarmBehaviorLevelRaise cmdlet.](media/Upgrading-to-AD-FS-in-Windows-Server-2016/ADFS_Mixed_9.png)

9. When prompted, type Y. This will begin raising the level. Once this completes you have successfully raised the FBL.

![Screenshot of a terminal window that shows when to type Y.](media/Upgrading-to-AD-FS-in-Windows-Server-2016/ADFS_Mixed_10.png)

10. Now, if you go to AD FS Management, you will see the new capabilities have been added for the later AD FS version

![Screenshot that shows the new capabilities that have been added.](media/Upgrading-to-AD-FS-in-Windows-Server-2016/ADFS_Mixed_12.png)

11. Likewise, you can use the PowerShell cmdlet:  `Get-AdfsFarmInformation` to show you the current FBL.

![upgrade](media/Upgrading-to-AD-FS-in-Windows-Server-2016/ADFS_Mixed_13.png)

12. To upgrade the WAP servers to the latest level, on each Web Application Proxy, re-configure the WAP by executing the following PowerShell cmdlet in an elevated window:

```PowerShell
$trustcred = Get-Credential -Message "Enter Domain Administrator credentials"
Install-WebApplicationProxy -CertificateThumbprint {SSLCert} -fsname fsname -FederationServiceTrustCredential $trustcred
```

Remove old servers from the cluster and keep only the WAP servers running the latest server version, which were reconfigured above, by running the following Powershell cmdlet.

```PowerShell
Set-WebApplicationProxyConfiguration -ConnectedServersName WAPServerName1, WAPServerName2
```

Check the WAP configuration by running the Get-WebApplicationProxyConfiguration cmdlet. The ConnectedServersName will reflect the server run from the prior command.

```PowerShell
Get-WebApplicationProxyConfiguration
```
> [!NOTE]
> Skip the next step if the ConfigurationVersion is Windows Server 2016. This is the correct value for Web Application Proxy on Windows Server 2016 / 2019.

To upgrade the ConfigurationVersion of the WAP servers, run the following Powershell command.

```PowerShell
Set-WebApplicationProxyConfiguration -UpgradeConfigurationVersion
```

This will complete the upgrade of the WAP servers.


> [!NOTE]
> A known PRT issue exists in AD FS 2019 if Windows Hello for Business with a Hybrid Certificate trust is performed. You may encounter this error in ADFS Admin event logs: Received invalid Oauth request. The client 'NAME' is forbidden to access the resource with scope 'ugs'.
> To remediate this error:
> 1. Launch AD FS management console. Brose to "Services > Scope Descriptions"
> 2. Right click "Scope Descriptions" and select "Add Scope Description"
> 3. Under name type "ugs" and Click Apply > OK
> 4. Launch Powershell as Administrator
> 5. Execute the command "Get-AdfsApplicationPermission". Look for the ScopeNames :{openid, aza} that has the ClientRoleIdentifier. Make a note of the ObjectIdentifier.
> 6. Execute the command "Set-AdfsApplicationPermission -TargetIdentifier <ObjectIdentifier from step 5> -AddScope 'ugs'
> 7. Restart the ADFS service.
> 8. On the client: Restart the client. User should be prompted to provision WHFB.
> 9. If the provisioning window does not pop up then need to collect NGC trace logs and further troubleshoot.
