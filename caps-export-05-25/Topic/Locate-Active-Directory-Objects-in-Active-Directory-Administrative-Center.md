---
title: Locate Active Directory Objects in Active Directory Administrative Center
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: b0f7db2b-8d52-4313-aa92-ffcfd69ab0df
author: Femila
---
# Locate Active Directory Objects in Active Directory Administrative Center
  If you want to locate Active Directory objects quickly in Active Directory Administrative Center, you can use the query\-building search and filtering mechanism. When the Active Directory objects that you target are returned as the results of a search or a filter query, you can then perform the necessary administrative tasks.  
  
 You can also save the queries that you build and use them again at a later time. Each saved query consists of the query criteria that you select, as well as the customized sorting and column information that you specify.  
  
## Searching for Active Directory objects  
 To search for Active Directory objects in Active Directory Administrative Center, you can use the Global Search feature to specify a scope for your search query.  
  
 There is no minimum group membership required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### Windows Server 2012: To search for Active Directory objects using Global Search  
  
1.  To open Active Directory Administrative Center, in **Server Manager**, click **Tools**, and then click **Active Directory Administrative Center**.  
  
    > [!NOTE]  
    >  Another way to open Active Directory Administrative Center is to click **Start**, and then type **dsac.exe**.  
  
2.  In the Active Directory Administrative Center navigation pane \(the left pane\), click **Global Search**.  
  
     Or  
  
     Use the **Global Search** tile on the  **Administrative Center Overview** page.  
  
3.  You can build a Global Search query by using keywords and the available search criteria or by using the Lightweight Directory Access Protocol \(LDAP\) query mode:  
  
    -   To build a query by using keywords and search criteria, click **Normal**. To add search criteria to your query, first click to expand the search criteria.  
  
         Click the chevron to expand the search criteria as shown in the following illustration:  
  
         ![](../Image/ADDS_ADACExpandSearchCriteria.gif)  
  
         Then click **Add Criteria** as shown in the following illustration.  
  
         ![](../Image/admux_gs.gif)  
  
    -   To search for Active Directory Data by using the LDAP query mode, click **Convert to LDAP** and enter the LDAP query, as shown in the following illustration.  
  
         ![](../Image/admux_gs_ldap.gif)  
  
4.  To adjust the scope of your search query, click **Scope**.  
  
     The default Global Search scope is set to the local domain, that is, the domain that you are currently logged on to. You can set Global Search scope to **Global Catalog Search** for any forest that you are managing in the selected instance of Active Directory Administrative Center. You can also set Global Search scope to one or more nodes that are currently added to your navigation pane.  
  
     If you set the scope of your query to Global Catalog Search for a particular forest that you are managing in Active Directory Administrative Center, the query returns a subset of the Active Directory objects that are stored across all the partitions of the selected forest, including domain partitions, configuration partitions, schema partitions, and all other user\-defined partitions.  
  
     If you set the scope of your query to one or more nodes that are currently added to your navigation pane, the query returns a subset of the Active Directory objects that are stored in the containers that the selected navigation nodes represent, including all the child containers of the selected parent containers.  
  
5.  To run your query, click **Search**.  
  
#### Windows Server 2008 R2: To search for Active Directory objects using Global Search  
  
1.  To open Active Directory Administrative Center, click **Start**, click **Administrative Tools**, and then click **Active Directory Administrative Center**.  
  
    > [!NOTE]  
    >  Another way to open Active Directory Administrative Center is to click **Start**, click **Run**, and then type **dsac.exe**.  
  
2.  In the Active Directory Administrative Center navigation pane \(the left pane\), click **Global Search**.  
  
     Or  
  
     Use the **Global Search** tile on the  **Administrative Center Overview** page.  
  
3.  You can build a Global Search query by using keywords and the available search criteria or by using the Lightweight Directory Access Protocol \(LDAP\) query mode:  
  
    -   To build a query by using keywords and search criteria, click **Normal**. To add search criteria to your query, first click to expand the search criteria.  
  
         Then click **Add Criteria** as shown in the following illustration.  
  
         ![](../Image/admux_gs.gif)  
  
    -   To search for Active Directory Data by using the LDAP query mode, click **Convert to LDAP** and enter the LDAP query, as shown in the following illustration.  
  
         ![](../Image/admux_gs_ldap.gif)  
  
4.  To adjust the scope of your search query, click **Scope**.  
  
     The default Global Search scope is set to the local domain, that is, the domain that you are currently logged on to. You can set Global Search scope to **Global Catalog Search** for any forest that you are managing in the selected instance of Active Directory Administrative Center. You can also set Global Search scope to one or more nodes that are currently added to your navigation pane.  
  
     If you set the scope of your query to Global Catalog Search for a particular forest that you are managing in Active Directory Administrative Center, the query returns a subset of the Active Directory objects that are stored across all the partitions of the selected forest, including domain partitions, configuration partitions, schema partitions, and all other user\-defined partitions.  
  
     If you set the scope of your query to one or more nodes that are currently added to your navigation pane, the query returns a subset of the Active Directory objects that are stored in the containers that the selected navigation nodes represent, including all the child containers of the selected parent containers.  
  
5.  To run your query, click **Search**.  
  
> [!NOTE]  
>  By default, Active Directory Administrative Center is installed on your [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] computer with the [!INCLUDE[firstref_ad_powershell](../Token/firstref_ad_powershell_md.md)] and the Active Directory Web Services \(ADWS\) service. The [!INCLUDE[nextref_ad_powershell](../Token/nextref_ad_powershell_md.md)] must be installed on your [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] computer for Active Directory Administrative Center function correctly. The ADWS service must be installed on at least one domain controller in the Active Directory domain so that you can use Active Directory Administrative Center to manage the domain.  
>   
>  The [!INCLUDE[nextref_ad_powershell](../Token/nextref_ad_powershell_md.md)] imposes a two\-minute operations time\-out \(when it attempts to connect to the ADWS service\), which is different from the operations time\-out that is monitored and controlled by the ADWS service that is running on a [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] server. When you are running a Global Search query in Active Directory Administrative Center, if you are experiencing a slow network connection or if the results of your Global Search query are not returned within the two minutes of the [!INCLUDE[nextref_ad_powershell](../Token/nextref_ad_powershell_md.md)] time\-out, you might see the following error message: “The operation was aborted because the client side timeout limit was exceeded.”  
  
## Filtering through the Active Directory data of a selected organizational unit  
 If an organizational unit \(OU\) in your Active Directory logical structure contains a particularly large data set, you can narrow it down by building a query and filtering through the Active Directory data of that specific OU.  
  
 There is no minimum group membership required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
#### To filter through the Active Directory data of a selected OU  
  
1.  To open Active Directory Administrative Center, click **Start**, click **Administrative Tools**, and then click **Active Directory Administrative Center**.  
  
    > [!NOTE]  
    >  Another way to open Active Directory Administrative Center is to click **Start**, click **Run**, and then type **dsac.exe**.  
  
2.  Navigate to the OU by using either the Active Directory Administrative Center navigation pane or the management list.  
  
    > [!IMPORTANT]  
    >  The scope of filtering through the Active Directory data of a specific OU is always set to that particular OU. It cannot be adjusted. This scope does not include any child OUs of the selected parent OU. To include the child OUs of the selected parent OU in the filter scope, in the **Tasks** pane \(the right pane\), click **Search under this node**.  
  
3.  In the **Filter** box near the top of the Active Directory Administrative Center window, type keywords for your query, or to add criteria, click **Add criteria** as shown in the following illustration. As soon as you type keywords or add criteria, the search results will appear.  
  
     ![](../Image/admux_filtering.gif)  
  
> [!IMPORTANT]  
>  If you build a query to filter through the Active Directory data of a specific OU, your query is applied only to the objects that are displayed in the Active Directory Administrative Center management list for this OU. In other words, this query returns a subset of the objects that appear in the Active Directory Administrative Center management list for this OU, not a subset of all the objects that this OU contains. To specify the maximum number of objects that are displayed per container \(or OU\), in the Active Directory Administrative Center management list, on the **View** menu, click **Management List Options**.  
  
> [!NOTE]  
>  If you add **Users with enabled accounts who have not logged on for more than a given number of days** criteria to your query \(either in **Global Search** or when filtering through the Active Directory data of a selected organizational unit\), and then run this query against a domain with the domain functional level set to Windows Server 2000, your query might return inaccurate results. This occurs because the update of the logon time stamp feature is not enabled in domains with the domain functional level set to Windows 2000. When the update of the logon time stamp feature is enabled, the **lastLogonTimestamp** attribute is updated with the last logon time of the user or computer, and the attribute is replicated within the domain. This feature is enabled in domains with the domain functional level set to Windows Server 2003 or higher. For more information about functional level features, see [Understanding Active Directory Domain Services \(AD DS\) Functional Levels](http://technet.microsoft.com/library/understanding-active-directory-functional-levels(v=ws.10)).  
  
  