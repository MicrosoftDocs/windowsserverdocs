---
title: Create a Disjoint Namespace
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: afe94bc3-41fb-4817-84b5-5517c38a0d39
author: Femila
---
# Create a Disjoint Namespace
If you decide to create a disjoint namespace on your network, first read about the advantages and disadvantages of doing this in [Disjoint Namespace \[LH\]](assetId:///9b519506-a37f-4810-b0c5-4bb151f553c0). To create a disjoint namespace, perform the following tasks:  
  
1.  [Create appropriate DNS forward lookup zones](#BKMK_1)  
  
2.  [Configure different primary DNS suffixes](#BKMK_2)  
  
3.  [Enable computers to register disjoint names](#BKMK_3)  
  
4.  [Update the DNS suffix search list](#BKMK_4)  
  
Although you do not have to complete these tasks before you deploy Active Directory Domain Services \(AD DS\), you must complete them for the disjoint namespace to function properly or to receive support from Microsoft for problems with the disjoint namespace.  
  
> [!NOTE]  
> If there are manually configured Service Principal Names \(SPNs\) on any of your servers, they may require modification. For information about manually configuring SPNs, see Setspn Overview \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=104232](http://go.microsoft.com/fwlink/?LinkID=104232)\).  
  
The following sections describe the tasks that you must complete to create a working disjoint namespace.  
  
## <a name="BKMK_1"></a>Create appropriate DNS forward lookup zones  
On a Domain Name System \(DNS\) server for the domain, you must add the appropriate forward lookup zone for each primary DNS suffix. For information about adding a forward lookup zone to Windows 2000 Server, see article 308201 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=163312](http://go.microsoft.com/fwlink/?LinkId=163312)\). For information about adding a forward lookup zone using a Windows Server 2003–based computer, see article 323445 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=163313](http://go.microsoft.com/fwlink/?LinkId=163313)\). For information about adding a forward lookup zone using a [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)]–based computer, see Add a Forward Lookup Zone \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=108851](http://go.microsoft.com/fwlink/?LinkId=108851)\).  
  
## <a name="BKMK_2"></a>Configure different primary DNS suffixes  
You can configure the **Primary DNS Suffix** policy setting on the DNS client by using Group Policy, by manually changing the settings in the **System Properties** dialog box on each computer, or by modifying the registry on each computer. The following sections describe these options.  
  
### Configure primary DNS suffixes by using a GPO  
On Windows Server 2003–based and [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)]–based servers, you can use a Group Policy object \(GPO\) to configure the primary DNS suffix for each member computer. You set the **Primary DNS Suffix** policy setting to the primary DNS suffix that you want to use on the member computers that will apply this policy setting. On Windows Server 2003–based computers, the GPO path for the **Primary DNS Suffix** policy setting is Computer Configuration\\Administrative Templates\\Network\\DNS Client. On [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)]–based computers, the GPO path for the **Primary DNS Suffix** policy setting is Computer Configuration\\Policies\\Administrative Templates\\Network\\DNS Client. For more information, see Edit a Group Policy Object \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=108852](http://go.microsoft.com/fwlink/?LinkId=108852)\).  
  
### Change the primary DNS suffix by using System Properties  
Membership in **Administrators**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](includes/review_details_md.md)]  
  
To manually set the primary DNS suffix on a local computer running Windows 2000, Windows XP, or Windows Vista, complete the following procedure.  
  
##### Change the primary DNS suffix by using System Properties  
  
1.  Open the **System Properties** dialog box.  
  
    -   To open the **System Properties** dialog box in Windows 2000 or Windows XP, click **Start**, click **Run**, type **sysdm.cpl**, and then press ENTER.  
  
    -   To open the **System Properties** dialog box in Windows Vista, click **Start**, in **Start Search** type **sysdm.cpl**, and then press ENTER.  
  
2.  On the **Computer Name** tab, click **Change**, and then click **More**.  
  
3.  In **Primary DNS suffix of this computer**, set the primary DNS suffix to the domain name that you want.  
  
4.  Verify that the **Change primary DNS suffix when domain membership changes** check box is cleared, and then click **OK** twice.  
  
5.  Click **OK** to confirm that the computer must be restarted, and then click **Close**.  
  
6.  When you are prompted to restart your computer, click **Restart Now**.  
  
7.  If you choose to restart the computer later, any changes that you made will take effect at that time.  
  
### Change the primary DNS suffix by using the registry  
If you plan to use a script \(or to modify the registry manually\) when you configure the primary DNS suffix, you must modify the **Domain** and **SyncDomainWithMembership** values. Both of these values are in the **Parameters** key under **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Tcpip**. To allow a disjoint namespace to be created, disable the **SyncDomainWithMembership** value by setting its value to **0**, and then enter the name of the primary DNS suffix that you want to use for the **Domain** value. If the **SyncDomainWithMembership** value does not exist, you can create it as a REGDWORD data type. For more information about registry scripts, see article 264584 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=102370](http://go.microsoft.com/fwlink/?LinkId=102370)\). If you configure these values using a registry script or Registry Editor, you must restart the computer for the settings to take effect.  
  
## <a name="BKMK_3"></a>Enable computers to register disjoint names  
By default, AD DS does not allow you to register another domain name as the DNS suffix for a domain. If you want to use a disjoint namespace, you must modify the security settings on the **msDS\-AllowedDNSSuffixes** attribute. Otherwise, the default security settings prevent member computers from registering a different namespace.  
  
### Allow additional primary DNS suffixes  
To add additional primary DNS suffixes to the list of allowed suffixes in AD DS, perform the following steps.  
  
> [!NOTE]  
> Active Directory Service Interfaces Editor \(ADSI Edit\) provides a view of every object and attribute in an Active Directory forest. You can use ADSI Edit to query, view, and edit Active Directory objects and attributes.  
  
Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](includes/review_details_md.md)]  
  
##### To add the additional primary DNS suffixes to the list of allowed suffixes in AD DS  
  
1.  On any domain controller in the Active Directory domain, click **Start**, click **Run**, type **adsiedit.msc**, and then press ENTER.  
  
2.  Expand the domain naming context \(NC\) to expose the directory partition that relates to the Active Directory domain for which you want to allow a disjoint namespace.  
  
3.  Right\-click the Active Directory domain partition, and then click **Properties**.  
  
    For example, DC\=fabrikam,DC\=com is the domain partition for Fabrikam.com.  
  
4.  In **Attributes**, click the **msDS\-AllowedDNSSuffixes** attribute, and then click **Edit**.  
  
5.  In **Value to add**, type the name of a primary DNS suffix that you want to allow.  
  
    For example, type na.corp.fabrikam.com if you have computers that will use that primary DNS suffix, and then click **Add**. To configure multiple DNS suffixes, repeat this step for each DNS suffix.  
  
6.  When you have entered all the additional DNS suffixes that you want to allow, click **OK** twice to confirm your changes.  
  
7.  Close ADSI Edit.  
  
If the domain has no Windows 2000–based computers, skip the following section and go directly to [Update the DNS suffix search list](#BKMK_4).  
  
### Allow Windows 2000–based computers to update attributes  
If the domain has member computers or domain controllers running Windows 2000, you must allow these computers to update the **dNSHostName** and **servicePrincipalName** attributes of their Active Directory computer accounts.  
  
> [!NOTE]  
> These steps do not have to be performed if you have no Windows 2000 computers on your network.  
  
Membership in **Domain Admins**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](includes/review_details_md.md)]  
  
##### To allow Windows 2000–based computers to update attributes  
  
1.  Open Active Directory Users and Computers.  
  
    To open Active Directory Users and Computers, click **Start**, click **Run**, type **dsa.msc**, and then press ENTER.  
  
2.  Click **View**, and then select the **Advanced Features** check box, if it is not already selected.  
  
3.  If the domain to which you want to allow a disjoint namespace is not in the console tree, perform the following steps:  
  
    1.  In the console tree, right\-click Active Directory Users and Computers, and then click **Connect to Domain**.  
  
    2.  In **Domain**, type the name of the Active Directory domain to which you want to allow the disjoint namespace, and then click **OK**. \(You can also use the **Browse** button to locate the name of the domain.\)  
  
4.  In the console tree, right\-click the domain to which you want to allow a disjoint namespace, and then click **Properties**.  
  
5.  On the **Security** tab, click **Advanced**.  
  
6.  On the **Permissions** tab, click **Add**.  
  
7.  In **Enter the object name to select**, type **self**, and then click **OK**.  
  
8.  In the **Apply onto** box, select **Computer objects**.  
  
9. At the bottom of the **Permissions** box, select the **Allow** check boxes that correspond to the **Validated write to DNS host name** and **Validated write to service principal name** permissions.  
  
10. Click **OK** three times to confirm your changes and close the dialog boxes.  
  
11. Close Active Directory Users and Computers.  
  
## <a name="BKMK_4"></a>Update the DNS suffix search list  
When you make the transition to a disjoint namespace, consider creating customized DNS suffix search lists to ensure that clients can locate services and other computers when they perform single\-label name queries. Single\-label name queries occur when a computer or user queries a name but does not provide a DNS suffix. The DNS suffixes that are you add to the DNS suffix search list are used by the DNS client to create fully qualified domain names \(FQDNs\) when they resolve single\-label names. For example, if your computer sends a query for the name computer2, your computer can use the DNS suffix search list to make a name resolution query for computer2.contoso.com, computer2.na.corp.contoso.com, computer2.corp.contoso.com, or whatever is in the DNS suffix search list.  
  
You can configure the DNS suffix search list by using Group Policy or by modifying each computer on the network through the user interface \(UI\) or registry.  
  
### Change the DNS suffix search list by using a GPO  
On Windows Server 2003–based and [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)]–based servers, you can use a GPO to configure the DNS suffix search list for each member computer. You set the DNS Client policy for **DNS Suffix Search List** to the DNS suffix search list that you want to use on the member computers that will apply this policy setting. On Windows Server 2003–based computers, the GPO path for the **DNS Suffix Search List** policy setting is Computer Configuration\\Administrative Templates\\Network\\DNS Client. On [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)]–based computers, the GPO path for the **DNS Suffix Search List** policy setting is Computer Configuration\\Policies\\Administrative Templates\\Network\\DNS Client. For more information, see Edit a Group Policy Object \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=108852](http://go.microsoft.com/fwlink/?LinkID=108852)\).  
  
> [!NOTE]  
> By default, the **DNS Suffix Search List** policy setting is not available on a server running Windows 2000 Server. However, you can add it by using the Windows XP administrative templates. For more information, see article 307900 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=102373](http://go.microsoft.com/fwlink/?LinkId=102373)\).  
  
### Change the DNS suffix search list by using network connections  
To change the **DNS Suffix Search List** policy setting by using the UI in Windows 2000, Windows XP, or Windows Vista, complete the following procedure.  
  
Membership in **Administrators**, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](includes/review_details_md.md)]  
  
##### To change the DNS suffix search list by using network connections  
  
1.  Open the **System Properties** dialog box.  
  
    -   To open the **System Properties** dialog box in Windows 2000 or Windows XP, click **Start**, click **Run**, type **sysdm.cpl**, and then press ENTER.  
  
    -   To open the **System Properties** dialog box in Windows Vista, click **Start**, in **Start Search** type **sysdm.cpl**, and then press ENTER.  
  
2.  Right\-click the icon that represents the computer's local network connection, and then click **Properties**.  
  
    **Local Area Connection** is the default connection.  
  
3.  In **This connection uses the following items**, click **Internet Protocol \(TCP\/IP\)**, and then click **Properties**.  
  
4.  Click **Advanced**.  
  
5.  On the **DNS** tab, click **Append these DNS suffixes \(in order\)**.  
  
6.  Click **Add**, and then type the first DNS suffix that you want the clients to use when they search for single\-label names \(names that do not have DNS suffixes\).  
  
7.  Repeat the previous step for each DNS suffix that you want clients to try when they resolve a name.  
  
    > [!NOTE]  
    > Be sure to include the Active Directory domain name and all other domain names in your organization that clients might have to resolve, in the appropriate order.  
  
8.  Click **OK** twice to confirm your changes.  
  
9. Close the **Local Area Connection Properties** and the **Network Connections** dialog boxes.  
  
### Change the DNS suffix search list in the registry  
If you plan to use a script \(or modify the registry manually\) when you configure the DNS suffix search list, you can modify the **SearchList** value in the **Parameters** key under **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\Tcpip**. For more information about registry scripts, see article 264584 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=102370](http://go.microsoft.com/fwlink/?LinkId=102370)\).  
  

