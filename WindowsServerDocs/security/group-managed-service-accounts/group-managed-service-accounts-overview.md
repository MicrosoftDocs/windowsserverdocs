---
title: Group Managed Service Accounts Overview
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: cef0693c-f861-48a7-a1c0-8d1bc06143ce
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Group Managed Service Accounts Overview

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic for the IT professional introduces the group Managed Service Account by describing practical applications, changes in Microsoft's implementation, and hardware and software requirements.


## <a name="BKMK_OVER"></a>Feature description
A standalone Managed Service Account (sMSA) is a managed domain account that provides automatic password management, simplified service principal name (SPN) management and the ability to delegate the management to other administrators. This type of managed service account (MSA) was introduced in Windows Server 2008 R2 and Windows 7.

The group Managed Service Account (gMSA) provides the same functionality within the domain but also extends that functionality over multiple servers. When connecting to a service hosted on a server farm, such as Network Load Balanced solution, the authentication protocols supporting mutual authentication require that all instances of the services use the same principal. When a gMSA is used as service principals, the Windows operating system manages the password for the account instead of relying on the administrator to manage the password.

The Microsoft Key Distribution Service \(kdssvc.dll\) provides the mechanism to securely obtain the latest key or a specific key with a key identifier for an Active Directory account. The Key Distribution Service shares a secret which is used to create keys for the account. These keys are periodically changed. For a gMSA the domain controller computes the password on the key provided by the Key Distribution Services, in addition to other attributes of the gMSA.  Member hosts can obtain the current and preceding password values by contacting a domain controller.

## <a name="BKMK_APP"></a>Practical applications
gMSAs provide a single identity solution for services running on a server farm, or on systems behind Network Load Balancer. By providing a gMSA solution, services can be configured for the new gMSA principal and the password management is handled by Windows.

Using a gMSA, services or service administrators do not need to manage password synchronization between service instances. The gMSA supports hosts that are kept offline for an extended time period, and management of member hosts for all instances of a service. This means you can deploy a server farm that supports a single identity to which existing client computers can authenticate without knowing the instance of the service to which they are connecting.

Failover clusters do not support gMSAs. However, services that run on top of the Cluster service can use a gMSA or a sMSA if they are a Windows service, an App pool, a scheduled task, or natively support gMSA or sMSA.

## <a name="BKMK_SOFT"></a>Software requirements

A 64\-bit architecture is required to run the Windows PowerShell commands which are used to administer gMSAs.

A managed service account is dependent upon Kerberos supported encryption types.When a client computer authenticates to a server using Kerberos the DC creates a Kerberos service ticket protected with encryption both the DC and server supports. The DC uses the account's msDS\-SupportedEncryptionTypes attribute to determine what encryption the server supports and, if there is no attribute, it assumes the client computer does not support stronger encryption types. If the host is configured to not support RC4, then authentication will always fail. For this reason, AES should always be explicitly configured for MSAs.

> [!NOTE]
> Beginning with Windows Server 2008 R2, DES is disabled by default. For more information about supported encryption types, see [Changes in Kerberos Authentication](https://technet.microsoft.com/library/dd560670(WS.10).aspx).

gMSAs are not applicable to Windows operating systems prior to Windows Server 2012.

## Server Manager information
There are no configuration steps necessary to implement MSA and gMSA using Server Manager or the Install\-WindowsFeature cmdlet.

## <a name="BKMK_LINKS"></a>See also
The following table provides links to additional resources related to Managed Service Accounts and group Managed Service Accounts.

|Content type|References|
|--------|-------|
|**Product evaluation**|[What's New for Managed Service Accounts](what-s-new-for-managed-service-accounts.md)<br /><br />[Managed Service Accounts Documentation for Windows 7 and Windows Server 2008 R2](https://technet.microsoft.com/library/ff641731(v=ws.10).aspx)<br /><br />[Service Accounts Step\-by\-Step Guide](https://technet.microsoft.com/library/dd548356(v=ws.10).aspx)|
|**Planning**|Not yet available|
|**Deployment**|Not yet available|
|**Operations**|[Managed Service Accounts in Active Directory](https://technet.microsoft.com/library/dd378925(v=ws.10).aspx)|
|**Troubleshooting**|Not yet available|
|**Evaluation**|[Getting Started with Group Managed Service Accounts](getting-started-with-group-managed-service-accounts.md)|
|**Tools and settings**|[Managed Service Accounts in Active Directory Domain Services](https://technet.microsoft.com/library/dd378925(v=WS.10).aspx)|
|**Community resources**|[Managed Service Accounts: Understanding, Implementing, Best Practices, and Troubleshooting](https://blogs.technet.com/b/askds/archive/2009/09/10/managed-service-accounts-understanding-implementing-best-practices-and-troubleshooting.aspx)|
|**Related technologies**|[Active Directory Domain Services Overview](active-directory-domain-services-overview.md)|


