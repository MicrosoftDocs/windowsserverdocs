---
title: Transition from a Disjoint Namespace to a Contiguous Namespace
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 9bb3aada-c59a-4b43-aba2-d73121065b60
author: Femila
---
# Transition from a Disjoint Namespace to a Contiguous Namespace
If your network uses a disjoint namespace and you decide to change to a contiguous namespace, there are several tasks to complete:  
  
-   [Configure domain member computers to use a primary DNS suffix that is the same as the Active Directory domain name](#BKMK_1)  
  
-   [Remove unnecessary DNS suffixes from the client search lists](#BKMK_2)  
  
-   [Remove no\-longer\-needed DNS suffixes from AD DS](#BKMK_3)  
  
-   [Remove no\-longer\-needed permissions for Windows 2000 computers](#BKMK_4)  
  
The actual number of tasks that are required for the change depends on how much configuration was accomplished to make the disjoint namespace work. For example, if custom Domain Name System \(DNS\) suffix search lists were never created, there is obviously no need to remove them.  
  
> [!NOTE]  
> If any of your servers have Service Principal Names \(SPNs\) that were manually configured, you may have to modify them. For information about manually configuring SPNs, see Setspn Overview \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=104232](http://go.microsoft.com/fwlink/?LinkID=104232)\).  
  
## <a name="BKMK_1"></a>Configure domain member computers to use a primary DNS suffix that is the same as the Active Directory domain name  
You can configure the DNS client's primary DNS suffix by using Group Policy, by manually changing the settings in the **System Properties** dialog box on each computer, or through a registry modification. These options are described in the following sections.  
  
### Configure primary DNS suffixes by using a GPO  
On Windows Server 2003 and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] servers, use a Group Policy object \(GPO\) to configure the primary DNS suffix for each member computer. Set the DNS Client policy for **Primary DNS Suffix** to the desired primary DNS suffix to match the DNS suffix of the Active Directory domain name. On Windows Server 2003–based computers, the GPO path for the **Primary DNS Suffix** policy setting is Computer Configuration\\Administrative Templates\\Network\\DNS Client. On [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]–based computers, the GPO path for the **Primary DNS Suffix** policy setting is Computer Configuration\\Policies\\Administrative Templates\\Network\\DNS Client. For more information, see Edit a Group Policy Object \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=108852](http://go.microsoft.com/fwlink/?LinkID=108852)\).  
  
### Configure primary DNS suffixes by using System Properties  
To change from a disjoint namespace that is created on a local computer running Windows 2000, Windows XP, or Windows Vista, complete the following procedure.  
  
Membership in **Administrators**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
##### To configure the primary DNS suffix by using System Properties  
  
1.  Open the **System Properties** dialog box:  
  
    -   To open the **System Properties** dialog box in Windows 2000 or Windows XP, click **Start**, click **Run**, type **sysdm.cpl**, and then press ENTER.  
  
    -   To open the **System Properties** dialog box in Windows Vista, click **Start**, in **Start Search** type **sysdm.cpl**, and then press ENTER.  
  
2.  On the **Computer Name** tab, click **Change**, and then click **More**.  
  
3.  Verify that the value in **Primary DNS suffix of this computer** is the same as the Active Directory domain name.  
  
4.  Verify that the **Change primary DNS suffix when domain membership changes** check box is selected, and then click **OK** twice.  
  
5.  Click **OK** to confirm that the computer must be restarted, and then click **Close**.  
  
6.  When you are prompted to restart your computer, click **Restart Now**.  
  
    If you choose to restart your computer later, any changes that you make will take effect at that time.  
  
### Configure primary DNS suffixes by registry modification  
If you use a script \(or directly modify the registry\) to configure the Primary DNS suffix, there are two values to modify: **Domain** and **SyncDomainWithMembership**. Both of these values are in the **Parameters** key under **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Tcpip**. To create a contiguous namespace, enable **SyncDomainWithMembership** by setting its value to **1**, and then enter the primary DNS suffix that is identical to the Active Directory domain for the **Domain** value. If the **SyncDomainWithMembership** value does not exist, you can create it as a **REGDWORD**. For more information about registry scripts, see article 264584 in the Microsoft Knowledge base \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=102370](http://go.microsoft.com/fwlink/?LinkId=102370)\). If you configure these values in the registry, be sure to restart the computers to have the settings take effect.  
  
## <a name="BKMK_2"></a>Remove unnecessary DNS suffixes from the client search lists  
When you change from a disjoint namespace to a contiguous namespace, there are likely to be several entries in the DNS suffix search list that clients no longer need. There may also be some different values that should be added to the DNS suffix search list. You can modify the DNS suffix search list by using Group Policy, by using Network Connections, or through registry modification. These options are described in the following sections.  
  
### Changing the DNS suffix search list by using a GPO  
On Windows Server 2003 and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] servers, remove any GPOs or settings that were used to create custom DNS suffix search lists that applied to the disjoint namespace. Remove the **DNS Suffix Search List** or configure it with the correct DNS suffixes for the contiguous namespace. On Windows Server 2003–based computers, the GPO path for the **DNS Suffix Search List** policy setting is Computer Configuration\\Administrative Templates\\Network\\DNS Client. On [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]–based computers, the GPO path for the **DNS Suffix Search List** policy setting is Computer Configuration\\Policies\\Administrative Templates\\Network\\DNS Client. For more information, see Edit a Group Policy Object \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=108852](http://go.microsoft.com/fwlink/?LinkID=108852)\).  
  
### Changing the DNS suffix search list by using Network Connections  
To change the DNS suffix search list by using the graphical user interface \(GUI\) on Windows 2000, Windows XP, or Windows Vista, complete the following procedure.  
  
Membership in **Administrators**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
##### To change the DNS suffix search list by using Network Connections  
  
1.  Open Network Connections.  
  
    -   To open the **Network Connections** dialog box in Windows 2000 or Windows XP, click **Start**, click **Run**, type **ncpa.cpl**, and then press ENTER.  
  
    -   To open the **Network Connections** dialog box in Windows Vista, click **Start**, type **ncpa.cpl** in **Start Search**, and then press ENTER.  
  
2.  Right\-click the icon that represents the computer's local network connection \(**Local Area Connection**, by default\), and then click **Properties**.  
  
3.  In **This connection uses the following items**, select **Internet Protocol \(TCP\/IP\)**, and then click **Properties**.  
  
4.  Click **Advanced**.  
  
5.  On the **DNS** tab, click **Append these DNS suffixes \(in order\)**, and then click **Add**. Type the first DNS suffix that you want the client to use when it searches for single\-label names \(names that do not have DNS suffixes\), and then click **Add**. Repeat this step for each successive DNS suffix that you want clients to use when they try to resolve a name.  
  
    > [!NOTE]  
    > As an alternative, you can select **Append primary and connection specific DNS suffixes** and, as an option, also select **Append parent suffixes of the primary DNS suffix**, assuming that there is no longer a need for a custom list that includes other domains.  
  
6.  Click **OK** twice to confirm your changes.  
  
7.  Close the **Local Area Connection Properties** and the **Network Connections** dialog boxes.  
  
### Changing the DNS suffix search list by registry modification  
If you want to use a script \(or directly modify the registry\) to configure the DNS suffix search list, you can modify the **SearchList** value that is located in the **Parameters** key under **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Tcpip**. For more information about registry scripts, see article 264584 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=102370](http://go.microsoft.com/fwlink/?LinkId=102370)\).  
  
## <a name="BKMK_3"></a>Remove no\-longer\-needed DNS suffixes from AD DS  
To remove permissions that may have been added to grant client computers permission to modify their primary DNS suffixes in Active Directory Domain Services \(AD DS\), use Active Directory Service Interfaces Editor \(ADSI Edit\) to complete the following procedure.  
  
> [!NOTE]  
> ADSI Edit provides a view of every object and attribute in an Active Directory forest. You can use ADSI Edit to query, view, and edit Active Directory objects and attributes.  
  
Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To remove no\-longer\-needed DNS suffixes from AD DS  
  
1.  On any domain controller in the Active Directory domain, click **Start**, click **Run**, type **adsiedit.msc**, and then press ENTER.  
  
2.  Expand **Domain Naming Context \(NC\)** to expose the directory partition that relates to the Active Directory domain for which you want to allow a disjoint namespace.  
  
3.  Right\-click the Active Directory domain partition, and then click **Properties**. For example, DC\=fabrikam,DC\=com is the domain partition for Fabrikam.com.  
  
4.  In **Attributes**, locate and click the **msDS\-AllowedDNSSuffixes** attribute, and then click **Edit**.  
  
5.  If there are any DNS suffixes entered in **Values**, select each one separately, and then click **Remove**.  
  
6.  When you have removed all the unnecessary DNS suffixes, click **OK** on the two open dialog boxes to confirm your changes.  
  
7.  Close ADSI Edit.  
  
## <a name="BKMK_4"></a>Remove no\-longer\-needed permissions for Windows 2000 computers  
If AD DS was modified to allow member computers or domain controllers running Windows 2000 to update the **dNSHostName** and **servicePrincipalName** attributes of their Active Directory computer accounts, you can revert those changes by completing the following procedure.  
  
Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To remove no\-longer\-needed permissions for Windows 2000 computers  
  
1.  To open Active Directory Users and Computers snap\-in, click **Start**, click **Run**, type **dsa.msc**, and then press ENTER.  
  
2.  Click **View**, and then ensure that the **Advanced Features** check box is selected. If it is not selected, click **Advanced Features**. If the domain to which you want to allow a disjoint namespace does not appear in the console, do the following:  
  
    1.  In the console tree, right\-click **Active Directory Users and Computers**, and then click **Connect to Domain**.  
  
    2.  In the **Domain** box, type the name of the Active Directory domain to which you want to allow the disjoint namespace \(or use the **Browse** button to locate it\), and then click **OK**.  
  
3.  In the console tree, right\-click the object that represents the domain to which you want to allow a disjoint namespace, and then click **Properties**.  
  
4.  Right\-click the domain, and then click **Properties**.  
  
5.  On the **Security** tab, click **Advanced**.  
  
6.  On the **Permissions** tab, click **Add**.  
  
7.  In **Enter the object name to select**, type **self**, and then click **OK**.  
  
8.  Configure the **Apply onto** box for **Computer objects**.  
  
9. At the bottom of the **Permissions** box, ensure that the **Allow** check boxes that correspond to the **Validated write to DNS host name** and **Validated write to service principal name** permissions are cleared, and then click **OK** on the three open dialog boxes to confirm your changes.  
  
10. Close Active Directory Users and Computers.  
  
