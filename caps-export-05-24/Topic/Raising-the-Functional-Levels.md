---
title: Raising the Functional Levels
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 95a37a13-0263-41fd-92ea-56d3d39a3b14
author: Femila
---
# Raising the Functional Levels
This topic contains the following subjects:  
  
-   [Raising the forest functional level](../Topic/Raising-the-Functional-Levels.md#BKMK_FFL)  
  
-   [Raising the domain functional level](../Topic/Raising-the-Functional-Levels.md#BKMK_DFL)  
  
-   [Troubleshooting errors when you raise the functional level](../Topic/Raising-the-Functional-Levels.md#BKMK_Tshoot)  
  
When you deploy the first [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] domain controller in your forest root domain, Active Directory Domain Services \(AD DS\) sets the functional levels by default, unless you set them to higher levels when you run Dcpromo. They remain at the following levels until you raise them manually:  
  
-   Windows 2000 forest functional level  
  
-   Windows 2000 native domain functional level  
  
Functional levels are set at these default levels to give you the option of adding Windows 2000–based domain controllers or Windows Server 2003–based domain controllers to your new [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] forest. However, if you plan to run [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] operating systems on all domain controllers in your new [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] environment, you can take advantage of all [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] forest\-level and domain\-level features by setting the forest functional level—and then the domain functional level to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. Similarly, if you plan to run [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] operating systems on all domain controllers in your new [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] environment, you can take advantage of all [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] forest\-level and domain\-level features by setting the forest functional level—and then the domain functional level to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)].  
  
> [!IMPORTANT]  
> We recommend that you raise forest and domain functional levels when you run the Active Directory Domain Services Installation Wizard \(Dcpromo.exe\). The following procedures describe how to raise the forest and domain functional levels.  
  
For more information about advanced features that are enabled at various available functional levels, see [Enabling Advanced Features for AD DS](../Topic/Enabling-Advanced-Features-for-AD-DS.md).  
  
## <a name="BKMK_FFL"></a>Raising the forest functional level  
Membership in **Domain Admins** or **Enterprise Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To raise the forest functional level  
  
1.  To open the Active Directory Domains and Trusts snap\-in, click **Start**, click **Administrative Tools**, and then click **Active Directory Domains and Trusts**.  
  
2.  In the console tree, right\-click **Active Directory Domains and Trusts**, and then click **Raise Forest Functional Level**.  
  
3.  In **Select an available forest functional level**, do one of the following:  
  
    -   To raise the forest functional level to Windows Server 2003, click **Windows Server 2003**, and then click **Raise**.  
  
    -   To raise the forest functional level to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], click **Windows Server 2008**, and then click **Raise**.  
  
    -   To raise the forest functional level to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], click **Windows Server 2008 R2**, and then click **Raise**.  
  
    > [!CAUTION]  
    > Do not raise the forest functional level to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] if you have or will have any domain controllers running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or earlier.  
  
    > [!IMPORTANT]  
    > After you set the forest functional level to a certain value, you cannot roll back or lower the forest functional level, with one exception: when you raise the forest functional level to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and if Active Directory Recycle Bin is not enabled, you have the option of rolling the forest functional level back to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. You can lower the forest functional level only from [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. If the forest functional level is set to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], it cannot be rolled back, for example, to Windows Server 2003.  
    >   
    > For more information about the Active Directory Recycle Bin, see Active Directory Recycle Bin Step\-by\-Step Guide \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=133971](http://go.microsoft.com/fwlink/?LinkId=133971)\).  
  
## <a name="BKMK_DFL"></a>Raising the domain functional level  
Membership in Domain Admins or Enterprise Admins, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To raise the domain functional level  
  
1.  To open the Active Directory Domains and Trusts snap\-in, click **Start**, click **Administrative Tools**, and then click **Active Directory Domains and Trusts**.  
  
2.  In the console tree, right\-click the domain for which you want to raise functional level, and then click **Raise Domain Functional Level**.  
  
3.  In **Select an available domain functional level**, do one of the following:  
  
    -   To raise the domain functional level to Windows Server 2003, click Windows Server 2003, and then click **Raise**.  
  
    -   To raise the domain functional level to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], click [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], and then click **Raise**.  
  
    -   To raise the domain functional level to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], click [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], and then click **Raise**.  
  
    > [!CAUTION]  
    > Do not raise the domain functional level to a later version \(such as Windows Server 2008 or Windows Server 2008 R2\) if you have or will have any domain controllers running earlier versions of Windows Server.  
  
    > [!IMPORTANT]  
    > After you set the domain functional level to a certain value, you cannot roll back or lower the domain functional level, with one exception: when you raise the domain functional level to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and if the forest functional level is [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or lower, you have the option of rolling the domain functional level back to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. You can lower the domain functional level only from [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] to [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. If the domain functional level is set to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], it cannot be rolled back, for example, to Windows Server 2003.  
  
## <a name="BKMK_Tshoot"></a>Troubleshooting errors when you raise the functional level  
If the domain or forest includes an unoccupied read\-only domain controller \(RODC\) account that has an **msDS\-Behavior\-Version** attribute value that is less than the value that the domain or forest is being raised to, the operation to raise the functional level will fail.  
  
If you are using Active Directory Domains and Trusts to raise the forest functional level, the error message is the following:  
  
“The functional level could not be raised. This may be due to replication latency. Please wait about 30 minutes and try again.”  
  
If you are using Active Directory Domains and Trusts or Active Directory Users and Computers to raise the domain functional level, the error message is the following:  
  
“The functional level could not be raised. The error is: The server is unwilling to process the request.”  
  
If you are using the [!INCLUDE[firstref_ad_powershell](../Token/firstref_ad_powershell_md.md)] to raise the functional level, the error message is the following:  
  
“The functional level of the domain \(or forest\) cannot be raised to the requested value, because there exist one or more domain controllers in the domain \(or forest\) that are at a lower incompatible functional level.”  
  
For more information about using the [!INCLUDE[nextref_ad_powershell](../Token/nextref_ad_powershell_md.md)] to raise the functional level, see [Forest and Domain Management](http://go.microsoft.com/fwlink/?LinkId=157592) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=157592\).  
  
To verify the **msDS\-Behavior\-Version** of a domain controller account, use Active Directory Sites and Services to check the **Attribute Editor** tab in the properties of the NTDS Settings object for the domain controller. To resolve the error, you can delete the unoccupied RODC account.  
  
