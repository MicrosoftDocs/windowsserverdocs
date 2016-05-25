---
title: Active Directory Administrative Center Overview
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 122037c2-e7d5-4e65-aa59-7a82f01735e6
author: Femila
---
# Active Directory Administrative Center Overview
  Active Directory Administrative Center includes the features that are described in the following sections. The following illustration shows the graphical user interface \(GUI\) features that are described in the following sections.  
  
 ![](../Image/admux.gif)  
  
## Administrative Center Overview page  
 This overview page appears by default when you first open Active Directory Administrative Center. The **Administrative Center Overview** page consists of several tiles, each of which features an administrative task that you perform frequently, such as resetting a user password or searching through Active Directory data. You can customize the **Administrative Center Overview** page anytime by displaying or hiding various tiles.  
  
 The following illustration shows the **Administrative Center Overview** page.  
  
 ![](../Image/admux_overview.gif)  
  
## Management of Active Directory objects across multiple domains  
 When you open Active Directory Administrative Center, the domain that you are currently logged on to on this server \(the local domain\) appears in the Active Directory Administrative Center navigation pane \(the left pane\). Depending on the rights of your current set of logon credentials, you can view or manage the Active Directory objects in this local domain.  
  
 You can also use the same instance of Active Directory Administrative Center and the same set of logon credentials to view or manage Active Directory objects from any other domain. The domains that you view can belong to the same forest as the local domain. They can also *not* belong to the same forest as the local domain, as long as they have an established trust with the local domain. Both one\-way trusts and two\-way trusts are supported. In addition, you can open Active Directory Administrative Center by using a set of logon credentials that is different from your current set of logon credentials. For more information, see [Manage Different Domains in Active Directory Administrative Center](../Topic/Manage-Different-Domains-in-Active-Directory-Administrative-Center.md).  
  
## Navigation pane  
 You can browse through the Active Directory Administrative Center navigation pane by using the tree view, which is similar to the Active Directory Users and Computers console tree, or by using the new list view. To see the tree view, move your cursor over the left tab at the top of the navigation pane until the words **Tree View** appear, and then click that tab. To see the list view, move your cursor over the right tab at the top of the navigation pane until the words **List View** appear, and then click that tab.  
  
 In the list view, you can take advantage of the Column Explorer feature. Column Explorer simplifies browsing through the levels of your Active Directory hierarchy by displaying all the child containers of the parent container \(the container for which you opened Column Explorer\) in a single column.  
  
 By using the list view, you can take advantage of the Most Recently Used \(MRU\) list. The MRU list automatically appears under a navigation node when you visit at least one container in this navigation node. The MRU list always contains the last three containers that you visited in a particular navigation node. Every time that you select a particular container, this container is added to the top of the MRU list and the last container in the MRU list is removed from it. You can also view the current MRU list by expanding the Active Directory Administrative Center breadcrumb bar.  
  
 Whether you use the tree view or the list view, you can customize your Active Directory Administrative Center navigation pane anytime by adding various containers from the local domain \(or from any foreign domain\) to the navigation pane as separate nodes. \(A foreign domain is a domain other than the local domain that has an established trust with the local domain.\) Customizing the Active Directory Administrative Center navigation pane can provide quicker access to Active Directory objects. Also, to further customize the navigation pane, you can rename or remove these manually added navigation pane nodes, create duplicates of these nodes, or move them up or down in the navigation pane.  
  
 In Active Directory Administrative Center, you can use different domain controllers to manage your Active Directory domains. You can change a domain controller connection for any node in the navigation pane. However, changing a domain controller connection for any particular node that represents a container in a certain domain also changes that connection for all the other nodes in the navigation pane that represent containers that belong to that same domain.  
  
 For more information, see [Customize the Active Directory Administrative Center Navigation Pane](../Topic/Customize-the-Active-Directory-Administrative-Center-Navigation-Pane.md).  
  
## Breadcrumb bar  
 The breadcrumb bar is the long box at the top of the Active Directory Administrative Center window. You can use the breadcrumb bar to navigate directly to a specific container in a local domain \(or in any trusted foreign domain\) by clicking the breadcrumb bar \(which puts it in edit mode\) and specifying one of the following:  
  
-   A Lightweight Directory Access Protocol \(LDAP\) path for the desired container, for example, **LDAP:\/\/cn\=Users,DC\=contoso,DC\=com**  
  
-   A distinguished name \(also known as DN\) for the desired container, for example, **cn\=Users,DC\=contoso,DC\=com**  
  
-   A hierarchical path for the desired container, for example, **Active Directory Domain Services\\contoso \(local\)\\Users**  
  
 You can use the breadcrumb bar to navigate directly to a specific container only if this container is stored in the domain directory partition of the local domain \(or the trusted foreign domain\) that you are managing in Active Directory Administrative Center. You cannot use the breadcrumb bar to navigate directly to containers that are stored in the configuration, schema, or application directory partitions of the local domain \(or trusted foreign domains\) that you are managing in Active Directory Administrative Center.  
  
 To successfully navigate directly to a container by specifying its hierarchical path in the Active Directory Administrative Center breadcrumb bar, you must be managing the local domain \(or a trusted foreign domain\) that this container belongs to in the selected instance of Active Directory Administrative Center. However, this restriction does not apply to navigation to a specific container by specifying its LDAP path or a distinguished name in the breadcrumb bar.  
  
 For example, if the domains contoso.com \(a local domain\) and fabricam.com \(a foreign domain\) have an established trust relationship, you can specify the LDAP paths or distinguished names of the containers in the breadcrumb bar. You can navigate successfully to the desired containers in both contoso.com and fabricam.com, regardless of whether contoso.com or fabricam.com is currently added to the navigation pane. However, contoso.com and fabricam.com must be added to the navigation pane for you to navigate successfully to the containers in these domains by specifying the hierarchical paths of these containers in the breadcrumb bar.  
  
 You can copy a specified LDAP path, distinguished name, or hierarchical path from the breadcrumb bar. To do this, right\-click the breadcrumb bar, and then click either **Copy Path** or **Copy Distinguished Name**. \(You can also paste these items into the breadcrumb bar.\) This can be very useful if you want to copy and paste a certain path or distinguished name from the Active Directory Administrative Center into other tools and applications, such as the Active Directory module for Windows PowerShell™, an instant message window, or an e\-mail message.  
  
## Object properties page  
 You can use properties pages in Active Directory Administrative Center to modify your Active Directory objects. The object properties page consists of several property page sections and an inline preview feature. You can display, hide, or collapse any property page sections and the inline preview to customize your Active Directory Administrative Center object property page. For more information, see [Customize Object Properties Pages in Active Directory Administrative Center](../Topic/Customize-Object-Properties-Pages-in-Active-Directory-Administrative-Center.md).  
  
## Query\-building search and filtering  
 If you want to locate Active Directory objects quickly, you can use the Active Directory Administrative Center query\-building search and filtering mechanism. When the Active Directory objects that you target are returned as the results of a search or a filter query, you can perform the necessary administrative tasks.  
  
 You can also save the queries that you build and use them again at a later time. Each saved query consists of the query criteria that you select, as well as the customized sorting and column information that you specify. For more information, see [Locate Active Directory Objects in Active Directory Administrative Center](../Topic/Locate-Active-Directory-Objects-in-Active-Directory-Administrative-Center.md).  
  
  