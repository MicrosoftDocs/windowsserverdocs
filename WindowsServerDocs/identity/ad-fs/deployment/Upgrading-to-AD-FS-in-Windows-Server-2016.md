---
ms.assetid: 7671e0c9-faf0-40de-808a-62f54645f891
title: Upgrading to AD FS in Windows Server 2016
description:
author: billmath
manager: femila
ms.date: 03/10/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
ms.author:  billmath
---

# Upgrading to AD FS in Windows Server 2016 using a WID database

>Applies To: Windows Server 2016


## Moving from a Windows Server 2012 R2 AD FS farm to a Windows Server 2016 AD FS farm  
The following document will describe how to upgrade your AD FS Windows Server 2012 R2 farm to AD FS in Windows Server 2016 when you are using a WID database.  

### Upgrading AD FS to Windows Server 2016 FBL  
New in AD FS for Windows Server 2016 is the farm behavior level feature (FBL).   This features is farm wide and determines the features that the AD FS farm can use.   By default, the FBL in a Windows Server 2012 R2 AD FS farm is at the Windows Server 2012 R2 FBL.  

A Windows Server 2016 AD FS server can be added to a Windows Server 2012 R2 farm and it will operate at the same FBL as a Windows Server 2012 R2.  When you have a Windows Server 2016 AD FS server operating in this fashion, your farm is said to be "mixed".  However, you will not be able to take advantage of the new Windows Server 2016 features until the FBL is raised to Windows Server 2016.  With a mixed farm:  

-   Administrators can add new, Windows Server 2016 federation servers to an existing Windows Server 2012 R2 farm.  As a result, the farm is in "mixed mode" and operates the Windows Server 2012 R2  farm behavior level.  To ensure consistent behavior across the farm, new Windows Server 2016 features cannot be configured or used in this mode.  

-   Once all Windows Server 2012 R2 federation servers have been removed from the mixed mode farm, and in the case of a WID farm, one of the new Windows Server 2016 federation servers has been promoted to the role of primary node, the administrator can then raise the FBL from Windows Server 2012 R2 to Windows Server 2016.  As a result, any new AD FS Windows Server 2016 features can then be configured and used.  

-   As a result of the mixed farm feature, AD FS Windows Server 2012 R2 organizations looking to upgrade to Windows Server 2016 will not have to deploy an entirely new farm, export and import configuration data.  Instead, they can add Windows Server 2016 nodes to an existing farm while it is online and only incur the relatively brief downtime involved in the FBL raise.  

Be aware that while in mixed farm mode, the AD FS farm is not capable of any new features or functionality introduced in AD FS in Windows Server 2016.  This means organizations that want to try out new features cannot do this until the FBL is raised.  So if your organization is looking to test the new features prior to rasing the FBL, you will need to deploy a separate farm to do this.  

The remainder of the is document provides the steps for adding a Windows Server 2016 federation server to a Windows Server 2012 R2 environment and then raising the FBL to Windows Server 2016.  These steps were performed in a test environment outlined by the architectural diagram below.  

> [!NOTE]  
> Before you can move to AD FS in Windows Server 2016 FBL, you must remove all of the Windows 2012 R2 nodes.  You cannot just upgrade a Windows Server 2012 R2 OS to Windows Server 2016 and have it become a 2016 node.  You will need to remove it and replace it with a new 2016 node.  

##### To upgrade your AD FS farm to Windows Server 2016 Farm Behavior Level  

1.  Using Server Manager install the Active Directory Federation Services Role on the Windows Server 2016  

2.  Using the AD FS Configuration wizard, join the new Windows Server 2016 server to the existing AD FS farm.  

    ![upgrade](media/Upgrading-to-AD-FS-in-Windows-Server-2016/ADFS_Mixed_1.png)  

3.  On the Windows Server 2016 federation server, open AD FS management.    Note that nothing is showing up as this federation server is not the primary server.  

    ![upgrade](media/Upgrading-to-AD-FS-in-Windows-Server-2016/ADFS_Mixed_3.png)  

4.  Once the join is complete, on the Windows Server 2016 server, open PowerShell and run the following cmdlt:  Set-AdfsSyncProperties -Role PrimaryComputer  

    ![upgrade](media/Upgrading-to-AD-FS-in-Windows-Server-2016/ADFS_Mixed_4.png)  

5.  On the original AD FS Windows Server 2012 R2 server, open PowerShell and run the following cmdlt:  Set-AdfsSyncProperties -Role SecondaryComputer -PrimaryComputerName {FQDN}  

    ![upgrade](media/Upgrading-to-AD-FS-in-Windows-Server-2016/ADFS_Mixed_5.png)  

6.  On your Web Application Proxy open PowerShell and run the followoing cmdlt:  Install-WebApplicationProxy -CertificateThumbprint {SSLCert} -fsname fsname -TrustCred $trustcred  

7.  Now on the Windows Server 2016 federation server open AD FS Management.  Note that now all of the nodes appear because the primary role has been transferred to this server.  

    ![upgrade](media/Upgrading-to-AD-FS-in-Windows-Server-2016/ADFS_Mixed_6.png)  

8.  With the Windows Server 2016 installation media, open a command prompt and navigate to support\adprep directory.  Run the following:  adprep /forestprep.  

    ![upgrade](media/Upgrading-to-AD-FS-in-Windows-Server-2016/ADFS_Mixed_7.png)  

9. Once that completes run adprep/domainprep  

    ![upgrade](media/Upgrading-to-AD-FS-in-Windows-Server-2016/ADFS_Mixed_8.png)  

10. Now on the Windows Server 2016 Server open PowerShell and run the following cmdlt: Invoke-AdfsFarmBehaviorLevelRaise  

    ![upgrade](media/Upgrading-to-AD-FS-in-Windows-Server-2016/ADFS_Mixed_9.png)  

11. When prompted, type Y.  This will begin raising the level.  Once this completes you have successfully raised the FBL.  

    ![upgrade](media/Upgrading-to-AD-FS-in-Windows-Server-2016/ADFS_Mixed_10.png)  

12. Now, if you go to AD FS Management, you will see the new nodes that have been added for AD FS in Windows Server 2016  

    ![upgrade](media/Upgrading-to-AD-FS-in-Windows-Server-2016/ADFS_Mixed_12.png)  

13. Likewise, you can use the PowerShell cmdlt:  Get-AdfsFarmInformation to show you the current FBL.  

    ![upgrade](media/Upgrading-to-AD-FS-in-Windows-Server-2016/ADFS_Mixed_13.png)  
