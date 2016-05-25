---
title: Create SDN Server Groups in Active Directory
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8f5000f5-802b-4d59-bcf0-d21837fb7fa3
author: vhorne
---
# Create SDN Server Groups in Active Directory
You can use these procedures to create new groups in Active Directory for your Software Defined Networking (SDN) infrastructure servers that are configured as Network Controller or Software Load Balancing Multiplexer (MUX) servers, and to add servers to the new groups.  
  
>[!NOTE]  
>Because the **RAS and IAS Servers** group already exists in Active Directory, you do not need to create a group for RAS Gateway servers or servers that are running Network Policy Server (NPS).   
  
Later in this deployment guide, you will use these new SDN server groups while configuring certificate autoenrollment so that every server that is a member of the groups is autoenrolled a server certificate by your certification authority (CA).  
  
Following are two procedures - one procedure to create two groups in Active Directory, and the other procedure to add members to the new groups. There are two possible methods for each procedure - you can use Windows PowerShell or you can use the Windows interface.   
  
Membership in **Account Operators**, **Domain Admins**, **Enterprise Admins**, or equivalent, is the minimum required to complete these procedures.  
  
## Create New Group Accounts  
  
You can use one of the following procedures to create new group accounts in Active Directory. The first procedure is accomplished with Windows PowerShell, the second procedure is accomplished by using the Windows interface.  
  
## To create new group accounts using Windows PowerShell  
To perform this procedure by using Windows PowerShell, run Windows PowerShell as an Administrator, type the following commands at the Windows PowerShell prompt, and then press ENTER. Ensure that you replace all variables, such as group names and domain, with values that are appropriate for your deployment. These commands as presented create two groups in Active Directory, the Network Controller Servers and MUX Servers groups.  
    
    New-ADGroup -Name "Network Controller Servers" -SamAccountName NCServers -GroupCategory Security -GroupScope Global -DisplayName "Network Controller Servers" -Path "CN=Users,DC=corp,DC=contoso,DC=com" -Description "Members of this group are Network Controller Servers"  
  
    New-ADGroup -Name "MUX Servers" -SamAccountName MUXServers -GroupCategory Security -GroupScope Global -DisplayName "MUX Servers" -Path "CN=Users,DC=corp,DC=contoso,DC=com" -Description "Members of this group are Software Load Balancing Multiplexer (MUX) Servers"  
  
## To create new group accounts using the Windows interface  
1.	In **Server Manager**, click **Tools**, and then click **Active Directory Users and Computers**. The **Active Directory Users and Computers** console opens.  
2.	In **Active Directory Users and Computers**, double click your domain name to expand the view. For example, if your domain is named corp.contoso.com, double-click **corp.contoso.com**. Right-click the folder **Users**, point to **New**, and then click **Group**.  
3.	Type the name of the new group that you want to use for Network Controller servers. For example, type **Network Controller Servers**.  
4.	In **Group scope**, click one of the options.  
5.	Ensure that **Group type** is set to **Security**, and then click **OK**.  
6.	Repeat steps 2-5 to create a group for Software Load Balancing Multiplexer (MUX) servers. For example, when you type the group name, type **MUX Servers**.  
  
## Add Members to Groups  
You can use one of the following procedures to add members to the new group accounts in Active Directory. The first procedure is accomplished with Windows PowerShell, the second procedure is accomplished by using the Windows interface.  
>[!NOTE]  
>RAS servers automatically add themselves to the **RAS and IAS Servers** group, however computers that are running NPS are not automatically added to this group.   
>  
>To add an NPS server to this group, you must open the NPS console, right\-click **NPS (Local)**, and then click **Register server in Active Directory**. The **Network Policy Server** dialog box opens. In **Network Policy Server**, click **OK**, and then click **OK** again.  
  
  
## To add members to the groups using Windows PowerShell  
  
To perform this procedure by using Windows PowerShell, use the command **Add-ADGroupMember**. For more information, see [Add-ADGroupMember](https://technet.microsoft.com/%5Clibrary/hh852331(v=wps.630).aspx).  
  
## To add members to the groups using the Windows interface  
  
1. In **Server Manager**, click **Tools**, and then click **Active Directory Users and Computers**. The **Active Directory Users and Computers** console opens.  
2. In **Active Directory Users and Computers**, double click your domain name to expand the view. For example, if your domain is named corp.contoso.com, double-click **corp.contoso.com**.   
3. Click **Users**, and then double-click the name of a group you just created. For example, if you created a group named Network Controller Servers, double-click **Network Controller Servers**. The **Properties** dialog box opens.  
4. In the **Properties** dialog box, click the **Members** tab, and then click **Add**. The **Select Users, Contacts, Computers, Service Accounts, or Groups** dialog box opens.  
5. In  **Select Users, Contacts, Computers, Service Accounts, or Groups**, click **Object Types**. The **Object Types** dialog box opens.  
6. In the **Object Types** dialog box, in **Object Types**, deselect all of the default options, and then select **Computers**. Click **OK**.  
7. In  **Select Users, Contacts, Computers, Service Accounts, or Groups**, in **Enter the object names to select**, type the names of the SDN infrastructure servers, separated by semi-colons, that you want to add to the group. For example, if you are adding the Network Controller servers NC1 and NC2 to the group, type **NC1; NC2**. Click **OK** to close the **Select Users, Contacts, Computers, Service Accounts, or Groups** dialog box and add the computers to the group.  
8. In the group **Properties** dialog box, in **Members**, verify that you have added all required members to the group, and then click **OK**.  
  
>[!TIP]  
>In the future you might decide to add servers to your deployment. If you want the new servers to automatically enroll server certificates, you can add them to the appropriate Active Directory groups. After you add new servers to the groups, the new servers will also autoenroll a server certificate after they have restarted or after you have manually refreshed Group Policy on the servers.  
