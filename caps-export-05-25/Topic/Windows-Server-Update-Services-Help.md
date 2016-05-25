---
title: Windows Server Update Services Help
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2660fb74-7619-4b8f-b6a2-c674c4ef90d5
author: coreyp
---
# Windows Server Update Services Help
This topic provides an overview about WSUS, and links to additional information pertaining to WSUS and related technologies.  
  
The Windows Server Update Service \(WSUS\) enables information technology administrators to deploy the latest Microsoft product updates. By using WSUS, administrators can fully manage the distribution of updates that are released through Microsoft Update to their network computers.  
  
Update management is the process of controlling the deployment and maintenance of interim software releases into production environments. It helps you maintain operational efficiency, overcome security vulnerabilities, and maintain the stability of your production environment. If your organization cannot determine and maintain a known level of trust within its operating systems and application software, it might have a number of security vulnerabilities that, if exploited, could lead to a loss of revenue and intellectual property. Minimizing this threat requires you to have properly configured systems, use the latest software, and install the recommended software updates.  
  
The core scenarios where WSUS adds value to your business are centralized update management, and update management automation.  
  
A WSUS server can be the update source for other WSUS servers within the organization. The WSUS server that acts as an update source is called an upstream server. In a WSUS implementation, at least one WSUS server in the network must connect to Microsoft Update to get available update information. The administrator can determine, based on network security and configuration, how many other servers connect directly to Microsoft Update.  
  
Prior to [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)], WSUS was not, by default, part of the server operating system; installation required that you first download the WSUS software from the Microsoft Download Center. Starting in [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)], WSUS is integrated with the server operating system as a server role.  
  
## More information about how to deploy and manage WSUS  
For information about how to deploy and manage WSUS, see the following topics:  
  
-   For detailed information about creating computer groups in WSUS, see section **3.3. Configure computer groups**, in: [Step 3: Configure WSUS](http://technet.microsoft.com/library/hh852346.aspx).  
  
-   For information about how to assign computers and groups using Group Policy, see section **3.4. Configure client updates**, in: [Step 3: Configure WSUS](http://technet.microsoft.com/library/hh852346.aspx).  
  
-   For information about using Secure Sockets Layer \(SSL\) protocol to help protect Windows Server Update Services \(WSUS\), see section **3.5. Secure WSUS with the Secure Sockets Layer Protocol**, in: [Step 3: Configure WSUS](http://technet.microsoft.com/library/hh852346.aspx).  
  
-   For information about **configuring auto\-approval rules**, see section **4.2. Configure auto\-approval rules**, in: [Step 4: Approve and Deploy WSUS Updates](http://technet.microsoft.com/library/hh852348.aspx)  
  
For information about migrating WSUS 3.0 SP2 to [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)] and [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)], see:  
  
-   [Migrate Windows Server Update Services to Windows Server 2012](http://technet.microsoft.com/library/hh852339.aspx)  
  
    -   [Step 1: Plan for WSUS Migration](http://technet.microsoft.com/library/hh852352.aspx)  
  
    -   [Step 2: Prepare to Migrate WSUS](http://technet.microsoft.com/library/hh852347.aspx)  
  
    -   [Step 3: Migrate WSUS](http://technet.microsoft.com/library/hh852349.aspx)  
  
    -   [Step 4: Verify the WSUS Migration](http://technet.microsoft.com/library/hh852343.aspx)  
  
For information about deploying WSUS in [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)] and [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)], see:  
  
-   [Deploy Windows Server Update Services in Your Organization](http://technet.microsoft.com/library/hh852340.aspx)  
  
    -   [Step 1: Prepare for Your WSUS Deployment](http://technet.microsoft.com/library/hh852344.aspx)  
  
    -   [Step 2: Install the WSUS Server Role](http://technet.microsoft.com/library/hh852338.aspx)  
  
    -   [Step 3: Configure WSUS](http://technet.microsoft.com/library/hh852346.aspx)  
  
    -   [Step 4: Approve and Deploy WSUS Updates](http://technet.microsoft.com/library/hh852348.aspx)  
  
Additional resources:  
  
-   The [Windows Server Update Services](http://technet.microsoft.com/windowsserver/bb332157.aspx) TechCenter home page, on TechNet.  
  
-   For overview information about Server Roles, Features, and server technologies, see: [Server Roles and Technologies](http://technet.microsoft.com/library/hh831669.aspx)  
  
