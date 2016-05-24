---
title: Assign Appropriate Credentials
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 546bf652-9df4-453a-8be9-382d0892abe0
author: Femila
---
# Assign Appropriate Credentials
Assign appropriate credentials to the users who are responsible for preparing the forest and domain for an Active Directory upgrade. The **adprep \/forestprep** command requires a user account that is a member of the Schema Admins, Enterprise Admins, and Domain Admins groups. The **adprep \/domainprep** command requires a user account that is a member of the Domain Admins group in the targeted domain. The **adprep \/rodcprep** command requires a user account that is a member of the Enterprise Admins group.  
  
In addition, the security context can affect the ability of an administrator to complete the upgrade of domain controllers. Members of the Builtin\\Administrators group can upgrade the operating system and install software on a computer. The following groups are members of the Builtin\\Administrators group by default:  
  
-   The Enterprise Admins group is a member of Builtin\\Administrators in the forest root domain and in each regional domain in the forest.  
  
-   The Domain Admins group is a member of Builtin\\Administrators in their domain.  
  
-   The Domain Admins group is a member of Builtin\\Administrators on member servers in their domain.  
  
The following table shows the credentials that are required to upgrade servers, depending on the domain membership of the servers.  
  
|Credential|Domain controller in forest root domain|Member server in forest root domain|Domain controller in regional domain|Member server in regional domain|  
|--------------|-------------------------------------------|---------------------------------------|----------------------------------------|------------------------------------|  
|Enterprise Admins in forest root domain|![](../Image/table-bullet.gif)||![](../Image/table-bullet.gif)||  
|Domain Admins in forest root domain|![](../Image/table-bullet.gif)|![](../Image/table-bullet.gif)|||  
|Builtin\\Administrators in forest root domain|![](../Image/table-bullet.gif)||||  
|Domain Admins in regional domain|||![](../Image/table-bullet.gif)|![](../Image/table-bullet.gif)|  
|Builtin\\Administrators in regional domain|||![](../Image/table-bullet.gif)||  
  
You also need to ensure that the administrator who is upgrading the domain controllers has the following rights:  
  
-   **Backup files and directories** \(SE\_BACKUP\_NAME\)  
  
-   **Modify firmware environment values** \(SE\_SYSTEM\_ENVIRONMENT\_NAME\)  
  
-   **Restore files and directories** \(SE\_RESTORE\_NAME\)  
  
-   **Shut down the system** \(SE\_SHUTDOWN\_NAME\)  
  
The setup program cannot run properly if these rights are not defined or if they are disabled by a domain Group Policy setting on the computer.  
  
Membership in the local **Administrator** account, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
### To verify if user rights assignments are disabled by a domain Group Policy setting  
  
1.  In the **Run** dialog box, type **mmc**, and then click **OK**.  
  
2.  Click **File**, and then click **Add\/Remove snap\-in**.  
  
3.  In the **Available snap\-ins** dialog box, select **Group Policy Management Editor**, and then click **Add**.  
  
4.  On the **Welcome to the Group Policy Wizard** page, verify that **Local Computer** appears in the **Group Policy Object** box, and then click **Finish**.  
  
5.  In the console tree, navigate to the Local Computer Policy\\Computer Configuration\\Policies\\Windows Settings\\Security Settings\\Local Policies\\User Rights Assignment folder.  
  
6.  In the details pane, verify that the user who will perform the upgrade is a member in one of the groups that has the necessary rights assigned. The policies are named identically to the user rights listed above.  
  
Assign the appropriate credentials in advance to allow both Active Directory domain upgrade testing and deployment to proceed without unexpected security delays.  
  
