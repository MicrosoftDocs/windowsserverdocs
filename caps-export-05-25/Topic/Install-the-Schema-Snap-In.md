---
title: Install the Schema Snap-In
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 92bb42f2-3941-40b2-88cd-e7313b1b512b
author: Femila
---
# Install the Schema Snap-In
  Before you can install the Active Directory Schema snap\-in, must either install the Active Directory Domain Services \(AD DS\) server role or the Windows Server 2008 Remote Server Administration Tools \(RSAT\) for Windows Vista Service Pack 1 \(SP1\). For download and installation information about RSAT, see article 941314 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=116179](http://go.microsoft.com/fwlink/?LinkID=116179)\).  
  
 You can use this procedure to first register the dynamic\-link library \(DLL\) that is required for the Active Directory Schema snap\-in. You can then add the snap\-in to Microsoft Management Console \(MMC\).  
  
 Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To install the Active Directory Schema snap\-in  
  
1.  Open a Command Prompt as an administrator: Click **Start**, click **All Programs**, click **Accessories**, right\-click **Command Prompt**, and then click **Run as administrator**. If the **User Account Control** dialog box appears, provide Domain Admins credentials, and then click **Continue**.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
     `regsvr32 schmmgmt.dll`  
  
3.  A message indicates that the command succeeded. Click **OK**.  
  
4.  Click **Start**, click **Control Panel**, click **Appearance**, and then click **Show hidden files and folders**.  
  
5.  On the **View** tab, click **Show hidden files, folders, and drives**, and then click **OK**.  
  
6.  Click **Start**, click **Run**, type **mmc**, and then click **OK**.  
  
7.  On the **File** menu, click **Add\/Remove Snap\-in**.  
  
8.  Under **Available snap\-ins**, click **Active Directory Schema**, click **Add**, and then click **OK**.  
  
9. To save this snap\-in, on the **File** menu, click **Save**.  
  
10. In the **Save As** dialog box, do one of the following:  
  
    -   To place the snap\-in in the **Administrative Tools** folder, in **File name**, type a name for the snap\-in, such as Active Directory Schema. In **Save in**, navigate to the following folder:  
  
         **%systemroot%\/ProgramData\/Microsoft\/Windows\/Start Menu\/Programs\/Administrative Tools**  
  
         Click **Save**.  
  
    -   To save the snap\-in in a location other than the Administrative Tools folder, in **Save in**, navigate to a location for the snap\-in. In **File name**, type a name for the snap\-in, and then click **Save**.  
  
> [!CAUTION]  
>  Modifying the schema is an advanced operation that is best performed by experienced programmers and system administrators. For detailed information about modifying the schema, see Active Directory Schema \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=80809](http://go.microsoft.com/fwlink/?LinkId=80809)\).  
  
 **Additional considerations**  
  
-   To perform the Schmmgmt.dll registration portion of this procedure, you must be a member of the Domain Admins group in the domain or the Enterprise Admins group in the forest, or you must have been delegated the appropriate authority. Adding the Active Directory Schema snap\-in to MMC requires only membership in the Domain Users group. However, making changes to the schema requires membership in the Schema Admins group.  
  
-   The [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] Administration Tools Pack cannot be installed on computers running Windows XP Professional or Windows Server 2003.  
  
  