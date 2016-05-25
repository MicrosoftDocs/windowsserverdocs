---
title: Reverse an Accidentally Created Disjoint Namespace
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 16168412-cd4d-4478-bdff-5f062ba0f5e7
author: Femila
---
# Reverse an Accidentally Created Disjoint Namespace
An administrator can configure a computer to be in a disjoint namespace accidentally in the either of the following ways:  
  
-   The local administrator can clear the **Change primary DNS suffix** policy setting when domain membership changes.  
  
-   On servers running Windows Server 2003 or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], a domain or enterprise administrator can add a Domain Name System \(DNS\) domain name to the **Primary DNS Suffix** policy setting on the DNS client. This policy setting overrides the **Change primary DNS suffix when domain membership changes** policy setting on DNS clients.  
  
The following sections describe how to reverse a disjoint namespace that an administrator accidentally created.  
  
## Reverse a locally configured disjoint namespace  
To reverse a disjoint namespace that an administrator created on a local computer running Windows 2000, Windows XP, or Windows Vista, perform the following procedure.  
  
Membership in **Administrators**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### Reverse a locally configured disjoint namespace  
  
1.  Open the **System Properties** dialog box.  
  
    -   To open the **System Properties** dialog box in Windows 2000 or Windows XP, click **Start**, click **Run**, type **sysdm.cpl**, and then press ENTER.  
  
    -   To open System Properties using Windows Vista, click **Start**. In **Start Search** type **sysdm.cpl**, and then press ENTER.  
  
2.  On the **Computer Name** tab, click **Change**, and then click **More**.  
  
3.  Verify that the value in **Primary DNS suffix of this computer** is the same as the Active Directory domain name.  
  
4.  Verify that the **Change primary DNS suffix when domain membership changes** check box is selected, and then click **OK** twice.  
  
5.  Click **OK** to confirm that the computer must be restarted, and then click **Close**.  
  
6.  When you are prompted to restart your computer, click **Restart Now**.  
  
    If you choose to restart your computer later, any changes that you made will take effect at that time.  
  
## Reverse a disjoint namespace that was created using Group Policy  
Domain controllers can use Group Policy to deploy a primary DNS suffix to computers that are members of the domain. On Windows Server 2003–based computers, the Group Policy object \(GPO\) path for the **Primary DNS Suffix** policy setting is Computer Configuration\\Administrative Templates\\Network\\DNS Client. On [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]–based computers, the GPO path for the **Primary DNS Suffix** policy setting is Computer Configuration\\Policies\\Administrative Templates\\Network\\DNS Client.  
  
To reverse a disjoint namespace that an administrator created using Group Policy, remove or revise the GPO that implements the **Primary DNS Suffix** policy setting. To determine which policy settings are implemented, you can use the Group Policy Results tool \(Gpresult.exe\) from the DNS client. For more information about Gpresult, see article 321709 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=102289](http://go.microsoft.com/fwlink/?LinkId=102289)\). You can use the Group Policy Management Console \(GPMC\) to determine which GPO implements the policy. For more information, see Group Policy Management Console \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=105933](http://go.microsoft.com/fwlink/?LinkID=105933)\).  
  
> [!NOTE]  
> The **Primary DNS Suffix** policy setting does not apply to Windows 2000–based domain controllers. If you are running only Windows 2000–based domain controllers, you must modify the namespace of those computers manually. For more information, see Primary DNS Suffix \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=102283](http://go.microsoft.com/fwlink/?LinkId=102283)\).  
  
