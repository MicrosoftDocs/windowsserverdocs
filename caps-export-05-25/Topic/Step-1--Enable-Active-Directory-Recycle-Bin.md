---
title: Step 1: Enable Active Directory Recycle Bin
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 179bd37c-5a8a-480e-81dc-ff648a4429a0
author: Femila
---
# Step 1: Enable Active Directory Recycle Bin
This step provides instructions for the following tasks:  
  
-   [Raising the forest functional level](#BKMK_1)  
  
-   [Enabling Active Directory Recycle Bin](#BKMK_2)  
  
## <a name="BKMK_1"></a>Raising the forest functional level  
You can enable Active Directory Recycle Bin only if the forest functional level of your environment is set to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]. You can raise the forest functional level by using the following methods:  
  
-   [Set\-ADForestMode Active Directory module cmdlet](#BKMK_3)  
  
    > [!NOTE]  
    > The [!INCLUDE[firstref_ad_powershell](../Token/firstref_ad_powershell_md.md)] in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] is a Windows PowerShell™ module \(named Active Directory\) that consolidates a group of cmdlets. You can use these cmdlets to manage your Active Directory domains, Active Directory Lightweight Directory Services \(AD LDS\) configuration sets, and Active Directory Database Mounting Tool instances in a single, self\-contained package. For more information, see What's New in AD DS: Active Directory Module for Windows PowerShell \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=140056](http://go.microsoft.com/fwlink/?LinkID=140056)\).  
  
-   [Ldp.exe](#BKMK_4)  
  
Membership in **Enterprise Admins**, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### <a name="BKMK_3"></a>  
##### To raise the forest functional level to Windows Server 2008 R2 using the Set\-ADForestMode cmdlet  
  
1.  Click **Start**, click **Administrative Tools**, right\-click [!INCLUDE[shortcut_ad_powershell](../Token/shortcut_ad_powershell_md.md)], and then click **Run as administrator**.  
  
2.  At the `Active Directory module for Windows PowerShell` command prompt, type the following command, and then press ENTER:  
  
    `Set-ADForestMode [-Identity] <ADForest> [-ForestMode] <ADForestMode>`  
  
    To set the forest functional level to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], type `Windows2008R2Forest` for `<ADForestMode>`.  
  
    For example, to set the forest functional level of contoso.com to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], type the following command, and then press ENTER:  
  
    `Set-ADForestMode –Identity contoso.com -ForestMode Windows2008R2Forest`  
  
For more information about the **Set\-ADForestMode** cmdlet, at the `Active Directory module for Windows PowerShell` command prompt, type `Get-Help Set-ADForestMode`, and then press ENTER.  
  
> [!NOTE]  
> You can use the **Set\-ADObject** cmdlet to raise the functional level of an AD LDS configuration set. For example, to raise the functional level of an AD LDS configuration set on a local AD LDS server, where the distinguished name of the AD LDS configuration directory partition is CN\=Configuration,CN\={32E430E4\-42D3\-4663\-BCA7\-5F5DFDC898}, use the following cmdlet:  
>   
> `Set-ADObject -Identity 'CN=Partitions,CN=Configuration,CN={32E430E4-42D3-4663-BCA7-5F5DFDC898}’ -Replace @{'msds-Behavior-Version'=4} -Server localhost:50000`  
  
### <a name="BKMK_4"></a>  
##### To raise the forest functional level to Windows Server 2008 R2 using Ldp.exe  
  
1.  To open Ldp.exe, click **Start**, click **Run**, and then type **ldp.exe**.  
  
2.  To connect and bind to the server that hosts the forest root domain of your AD DS environment, under **Connection**, click **Connect**, and then click **Bind**.  
  
3.  Click **View**, and then click **Tree**. In **BaseDN**, select the configuration directory partition, and then click **OK**.  
  
4.  In the console tree, double\-click the distinguished name \(also known as DN\) of the configuration directory partition, and then navigate to the CN\=Partitions container.  
  
5.  Right\-click the CN\=Partitions container’s distinguished name, and then click **Modify**.  
  
6.  In the **Modify** dialog box, in **Edit Entry Attribute**, type **msDS\-Behavior\-Version**.  
  
7.  In the **Modify** dialog box, in **Values**, type **4** \(the value of the [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] forest functional level\).  
  
8.  In the **Modify** dialog box, under **Operation** click **Replace**, click **Enter**, and then click **Run**.  
  
## <a name="BKMK_2"></a>Enabling Active Directory Recycle Bin  
After the forest functional level of your environment is set to [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], you can enable Active Directory Recycle Bin by using the following methods:  
  
-   [Enable\-ADOptionalFeature Active Directory module cmdlet](#BKMK_5) \(This is the recommended method.\)  
  
-   [Ldp.exe](#BKMK_6)  
  
> [!NOTE]  
> In this release of [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], the process of enabling Active Directory Recycle Bin is irreversible. After you enable Active Directory Recycle Bin in your environment, it cannot be disabled.  
  
Membership in **Enterprise Admins**, or equivalent, is the minimum required to complete these procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### <a name="BKMK_5"></a>  
##### To enable Active Directory Recycle Bin using the Enable\-ADOptionalFeature cmdlet  
  
1.  Click **Start**, click **Administrative Tools**, right\-click [!INCLUDE[shortcut_ad_powershell](../Token/shortcut_ad_powershell_md.md)], and then click **Run as administrator**.  
  
    > [!WARNING]  
    > If you do not use the [!INCLUDE[shortcut_ad_powershell](../Token/shortcut_ad_powershell_md.md)] to run the following commands, you will see errors. If you would prefer to run the following commands from Windows PowerShell directly, then first import the Active Directory cmdlet by running the following command `import-module activedirectory`  
  
2.  At the `Active Directory module for Windows PowerShell` command prompt, type the following command, and then press ENTER:  
  
    `Enable-ADOptionalFeature -Identity <ADOptionalFeature> -Scope <ADOptionalFeatureScope> -Target <ADEntity>`  
  
    > [!NOTE]  
    > The distinguished name \(also known as DN\) of Active Directory Recycle Bin is CN\=Recycle Bin Feature,CN\=Optional Features,CN\=Directory Service,CN\=Windows NT,CN\=Services,CN\=Configuration,DC\=<mydomain>,DC\=<com>, where <mydomain> and <com> represent the appropriate forest root domain name of your Active Directory Domain Services \(AD DS\) environment.  
  
    For example, to enable Active Directory Recycle Bin for contoso.com, type the following command, and then press ENTER:  
  
    `Enable-ADOptionalFeature –Identity ‘CN=Recycle Bin Feature,CN=Optional Features,CN=Directory Service,CN=Windows NT,CN=Services,CN=Configuration,DC=contoso,DC=com’ –Scope  ForestOrConfigurationSet –Target ‘contoso.com’`  
  
> [!NOTE]  
> You can also use the **Enable\-ADOptionalFeature** cmdlet to enable Active Directory Recycle Bin in an AD LDS environment. For example, to enable Active Directory Recycle Bin on a local AD LDS server, where the distinguished name of the AD LDS configuration directory partition is CN\=Configuration,CN\={372A5A3F\-6ABE\-4AFD\-82DE\-4A84D2A10E81}, use the following cmdlet:  
>   
> `Enable-ADOptionalFeature 'recycle bin feature' -Scope ForestOrConfigurationSet -Server localhost:50000 -Target 'CN=Configuration,CN={372A5A3F-6ABE-4AFD-82DE-4A84D2A10E81}'`  
  
For more information about the **Enable\-ADOptionalFeature** cmdlet, at the `Active Directory module for Windows PowerShell` command prompt, type `Get-Help Enable-ADOptionalFeature`, and then press ENTER.  
  
### <a name="BKMK_6"></a>  
##### To enable Active Directory Recycle Bin using Ldp.exe  
  
1.  To open Ldp.exe, click **Start**, click **Run**, and then type **ldp.exe**.  
  
2.  To connect and bind to the server that hosts the forest root domain of your AD DS environment, under **Connection**, click **Connect**, and then click **Bind**.  
  
3.  Click **View**, click **Tree**, in **BaseDN**, select the configuration directory partition, and then click **OK**.  
  
4.  In the console tree, double\-click the distinguished name of the configuration directory partition, and then navigate to the CN\=Partitions container.  
  
5.  Right\-click the CN\=Partitions container’s distinguished name, and then click **Modify**.  
  
6.  In the **Modify** dialog box, make sure that the **DN** box is empty.  
  
7.  In the **Modify** dialog box, in **Edit Entry Attribute**, type **enableOptionalFeature**.  
  
8.  In the **Modify** dialog box, in **Values**, type **CN\=Partitions,CN\=Configuration,DC\=mydomain,DC\=com:766ddcd8\-acd0\-445e\-f3b9\-a7f9b6744f2a**. Replace **mydomain** and **com** with the appropriate forest root domain name of your AD DS environment.  
  
    > [!NOTE]  
    > 766ddcd8\-acd0\-445e\-f3b9\-a7f9b6744f2a is the Active Directory Recycle Bin globally unique identifier \(GUID\).  
    >   
    > To verify the Active Directory Recycle Bin GUID, navigate to the **CN\=Recycle Bin Feature,CN\=Optional Features,CN\=Directory Service,CN\=Windows NT,CN\=Services,CN\=Configuration, DC\=mydomain,DC\=com** container \(replace **mydomain** and **com** with the appropriate forest root domain name of your AD DS environment\), and in the details pane, locate the value of the **msDS\-OptionalFeatureGUID** attribute.  
  
9. In the **Modify** dialog box, under **Operation** click **Add**, click **Enter**, and then click **Run**.  
  
10. To verify that Active Directory Recycle Bin is enabled, navigate to the **CN\=Partitions** container. In the details pane, locate the **msDS\-EnabledFeature** attribute, and confirm that its value is set to **CN\=Recycle Bin Feature,CN\=Optional Features,CN\=Directory Service,CN\=Windows NT,CN\=Services,CN\=Configuration, DC\=mydomain,DC\=com**, where **mydomain** and **com** represent the appropriate forest root domain name of your AD DS environment.  
  
