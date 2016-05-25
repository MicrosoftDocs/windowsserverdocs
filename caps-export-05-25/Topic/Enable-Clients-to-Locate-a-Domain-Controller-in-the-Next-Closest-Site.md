---
title: Enable Clients to Locate a Domain Controller in the Next Closest Site
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: ff3fd2ce-5e2f-47b3-adf0-2e1a1be1ba16
author: Femila
---
# Enable Clients to Locate a Domain Controller in the Next Closest Site
You can modify the Default Domain Policy to enable Windows Vista and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] clients in the domain to locate domain controllers in the next closest site if no domain controller in their own site or the closest site is available.  
  
Membership **Enterprise Admins** in the forest or **Domain Admins** in the domain, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To enable clients to locate a domain controller in the next closest site  
  
1.  Click **Start**, click **Administrative Tools**, and then click **Group Policy Management**.  
  
2.  [!INCLUDE[uac_appears](../Token/uac_appears_md.md)]  
  
3.  Double\-click **Forest:***forest\_name*, double\-click **Domains**, and then double\-click *domain\_name*.  
  
4.  Right\-click **Default Domain Policy**, and then click **Edit**.  
  
5.  In **Group Policy Management Editor**, in the console tree, go to Computer Configuration\/Policies\/Administrative Templates\/System\/Netlogon\/DC Locator DNS Records.  
  
6.  In the details pane, double\-click **Try Next Closest Site**, click **Enabled**, and then click **OK**.  
  
As an option, you can create the following registry entry to affect the Domain Locator \(DC Locator\) behavior for an individual computer that runs Windows Vista or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. However, using a domain\-wide Group Policy object \(GPO\) is recommended instead because the behavior will be more consistent.  
  
> [!CAUTION]  
> Incorrectly editing the registry may severely damage your system. Before making changes to the registry, you should back up any valued data on the computer.  
  
**HKLM\\Software\\Policies\\Microsoft\\Netlogon\\Parameters\\Try Next Closest Site**  
  
If the registry entry **DWORD** value is **1**, DC Locator will try to find the domain controller in the next closest site if it cannot find a domain controller in the client's site. If the value is **0**, DC Locator will find any domain controller if it cannot find a domain controller in the client's site.  
  
To verify the setting, type the following command:  
  
```  
NLTEST /DSGETDC: domain_name /WRITABLE /TRY_NEXT_CLOSEST_SITE  
```  
  
Or on the caller, the NETLOGON.LOG or ETW tracing in dsgetdcname indicates the domain controller in the next closest site.  
  
With the policy enabled, site\-specific DNS queries appear first for the site defined in “dynamicsitename”, then a fallback to the next closest site, and finally a siteless query.  
  
More information:  
  
HYPERLINK "http:\/\/msdn.microsoft.com\/library\/ms675983\(VS.85\).aspx" http:\/\/msdn.microsoft.com\/library\/ms675983\(VS.85\).aspx  
  
HYPERLINK "http:\/\/msdn.microsoft.com\/library\/ms675933\(v\=VS.85\).aspx" http:\/\/msdn.microsoft.com\/library\/ms675933\(v\=VS.85\).aspx  
  
## Change History  
  
|Date|Revision|  
|--------|------------|  
|Sept 12, 2011|Corrected Registry path and added verification information.|  
  
