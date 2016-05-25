---
title: Configure the Workstation Authentication Certificate Template_1
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 16efcca0-f8ec-4497-a907-60702eee6fc1
author: vhorne
---
# Configure the Workstation Authentication Certificate Template_1
You can use this procedure to configure the certificate template that Active Directory® Certificate Services \(AD CS\) uses as the basis for computer certificates that are enrolled to domain member client computers, or to members of other groups that you specify.  
  
> [!NOTE]  
> If you want to enroll computer certificates to members of groups other than the Domain Computers group, remove the Domain Computers group from the template's access control list \(ACL\) while performing this procedure, and then add the groups you prefer to the ACL. After you add new groups to the ACL, ensure that you allow Enroll and Autoenroll permissions.  
  
Membership in both the **Enterprise Admins** and the root domain's **Domain Admins** group is the minimum required to complete this procedure.  
  
### To configure the certificate template and autoenrollment  
  
1.  On CA1, in Server Manager, click **Tools**, and then click **Certification Authority**. The Certification Authority Microsoft Management Console \(MMC\) opens.  
  
2.  In the MMC, double\-click the CA name, right\-click **Certificate Templates**, and then click **Manage**.  
  
3.  The **Certificate Templates** console opens. All of the certificate templates are displayed in the details pane.  
  
4.  In the details pane, click the **Workstation Authentication** template.  
  
5.  On the **Action** menu, click **Duplicate Template**. The **Properties** dialog box for the certificate template opens.  
  
6.  On the **General** tab, in **Display Name**, type a new name for the certificate template or keep the default name.  
  
7.  Click the **Subject Name** tab. Ensure that **Build from this Active Directory information** is selected. In **Subject name format**, select **Fully distinguished name**.  
  
8.  Click the **Security** tab. In **Group or user names**, click **Domain Computers**.  
  
9. In **Permissions for Domain Computers**, under **Allow**, ensure that **Enroll** is selected, and then select the **Autoenroll** check box. Click **OK**, and close the Certificate Templates MMC.  
  
10. In the Certification Authority MMC, click **Certificate Templates**. On the **Action** menu, point to **New**, and then click **Certificate Template to Issue**. The **Enable Certificate Templates** dialog box opens.  
  
11. Click the name of the certificate template you just configured, and then click **OK**. For example, if you did not change the default certificate template name, click **Copy of Workstation Authentication**, and then click **OK**.  
  
