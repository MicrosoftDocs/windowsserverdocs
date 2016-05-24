---
title: Determine Service Pack Levels
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 34f7bc5d-c67e-453b-a645-5d3606309272
author: Femila
---
# Determine Service Pack Levels
Before preparing your infrastructure for upgrade, all Windows 2000–based domain controllers in the forest must be running Windows 2000 Service Pack 4 \(SP4\). Use the **repadmin\/showattr** command to perform an inventory of the operating system and service pack revision level on all domain controllers in a particular domain.  
  
Membership in the local **Administrator** account, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To determine the operating system and service pack revision level on all domain controllers  
  
-   For each domain in the forest, type the following command at the command line of a computer that has the support tools for [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] installed, and then press ENTER:  
  
    **repadmin \/showattr <domain\_controller\_in\_target\_domain> ncobj:domain: \/filter:"\(&\(objectcategory\=computer\)\(primaryGroupID\=516\)\)”\/subtree \/atts:operatingSystem,operatingSystemVersion,operatingSystemServicePack**  
  
    The following text is sample output from this command:  
  
    ```  
    DN: CN=NA-DC-01,OU=Domain Controllers,DC=company,DC=com  
        1> operatingSystem: Windows Server 2008 Standard  
        1> operatingSystemVersion: 6.0 (6001)  
        1> operatingSystemServicePack: Service Pack 1, v.624  
    ```  
  
    > [!NOTE]  
    > The **repadmin \/showattr** command does not show any hotfixes that might be installed on a domain controller.  
  
|Parameter|Description|  
|-------------|---------------|  
|repadmin \/showattr|Displays the attributes on an object.|  
|domain\_controller\_in\_target\_domain|Specifies the fully qualified domain name \(FQDN\) of the domain controller.|  
|\/filter:"\(&\(objectcategory\=computer\)\(primaryGroupID\=516\)\)” \/subtree \/atts:operatingSystem,operatingSystemVersion,operatingSystemServicePack|Filters the output to display the object's operating system, operating system version, and operating system service pack.|  
  
Upgrade domain controllers to the appropriate service pack as necessary.  
  
