---
title: Configure Client Automatic Hosted Cache Discovery by Service Connection Point
description: This guide provides instructions on deploying BranchCache in hosted cache mode on computers running Windows Server 2016 and Windows 10
manager: brianlic
ms.prod: windows-server
ms.technology: networking-bc
ms.topic: article
ms.assetid: ea1c34fd-5a33-4228-9437-9bb3d44230eb
ms.author: lizross
author: eross-msft
---

#  Configure Client Automatic Hosted Cache Discovery by Service Connection Point

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

With this procedure you can use Group Policy to enable and configure BranchCache hosted cache mode on domain\-joined computers that are running the following BranchCache\-capable Windows operating systems.

- Windows 10 Enterprise
- Windows 10 Education
- Windows 8.1 Enterprise
- Windows 8 Enterprise

> [!NOTE]  
> To configure domain-joined computers that are running Windows Server 2008 R2 or Windows 7, see the Windows Server 2008 R2 [BranchCache Deployment Guide](https://technet.microsoft.com/library/ee649232.aspx).

Membership in **Domain Admins**, or equivalent is the minimum required to perform this procedure.

### To use Group Policy to configure clients for hosted cache mode

1. On a computer upon which the Active Directory Domain Services server role is installed, open Server Manager, select the Local Server, click **Tools**, and then click **Group Policy Management**. The Group Policy Management console opens.

2. In the Group Policy Management console, expand the following path: **Forest:** *corp.contoso.com*, **Domains**, *corp.contoso.com*, **Group Policy Objects**, where *corp.contoso.com* is the name of the domain where the BranchCache client computer accounts that you want to configure are located.

3. Right\-click **Group Policy Objects**, and then click **New**. The **New GPO** dialog box opens. In **Name**, type a name for the new Group Policy object \(GPO\). For example, if you want to name the object BranchCache Client Computers, type **BranchCache Client Computers**. Click **OK**.

4. In the Group Policy Management console, ensure that **Group Policy Objects** is selected, and in the details pane right\-click the GPO that you just created. For example, if you named your GPO BranchCache Client Computers, right\-click **BranchCache Client Computers**. Click **Edit**. The Group Policy Management Editor console opens.

5. In the Group Policy Management Editor console, expand the following path: **Computer Configuration**, **Policies**, **Administrative Templates: Policy definitions \(ADMX files\) retrieved from the local computer**, **Network**, **BranchCache**.

6. Click **BranchCache**, and then in the details pane, double\-click **Turn on BranchCache**. The **Turn on BranchCache** dialog box opens.
  
7.  In the **Turn on BranchCache** dialog box, click **Enabled**, and then click **OK**.

8. In the Group Policy Management Editor console, ensure that **BranchCache** is still selected, and then in the details pane double\-click **Enable Automatic Hosted Cache Discovery by Service Connection Point**. The policy setting dialog box opens.

9. In the **Enable Automatic Hosted Cache Discovery by Service Connection Point** dialog box, click **Enabled**, and then click **OK**.

10. To enable client computers to download and cache content from BranchCache file server\-based content servers: In the Group Policy Management Editor console, ensure that **BranchCache** is still selected, and then in the details pane double\-click **BranchCache for network files**. The **Configure BranchCache for network files** dialog box opens. 
11. In the **Configure BranchCache for network files** dialog box, click **Enabled**. In **Options**, type a numeric value, in milliseconds, for the maximum round trip network latency time, and then click **OK**.
  
    > [!NOTE]
    > By default, client computers cache content from file servers if the round trip network latency is longer than 80 milliseconds.
  
12. To configure the amount of hard disk space allocated on each client computer for the BranchCache cache: In the Group Policy Management Editor console, ensure that **BranchCache** is still selected, and then in the details pane double\-click **Set percentage of disk space used for client computer cache**. The **Set percentage of disk space used for client computer cache** dialog box opens. Click **Enabled**, and then in **Options** type a numeric value that represents the percentage of hard disk space used on each client computer for the BranchCache cache. Click **OK**.

13. To specify the default age, in days, for which segments are valid in the BranchCache data cache on client computers: In the Group Policy Management Editor console, ensure that **BranchCache** is still selected, and then in the details pane double\-click **Set age for segments in the data cache**. The **Set age for segments in the data cache** dialog box opens. Click **Enabled**, and then in the details pane type the number of days that you prefer. Click **OK**.

14. Configure additional BranchCache policy settings for client computers as appropriate for your deployment.

15. Refresh Group Policy on branch office client computers by running the command **gpupdate /force**, or by rebooting the client computers.

Your BranchCache Hosted Cache mode deployment is now complete.

For additional information on the technologies in this guide, see [Additional Resources](11-Bc-Hcm-additional-resources.md).