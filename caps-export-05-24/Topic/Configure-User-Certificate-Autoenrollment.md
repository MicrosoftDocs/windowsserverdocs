---
title: Configure User Certificate Autoenrollment
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 19452bab-a202-4ecb-a32a-116ed060fb36
---
# Configure User Certificate Autoenrollment
You can use this procedure to automatically enroll, or autoenroll, user certificates to members of the Domain Users group in Active Directory Domain Services \(AD DS\).  
  
Membership in both the **Enterprise Admins** and the root domain's **Domain Admins** group is the minimum required to complete this procedure.  
  
### To configure user certificate autoenrollment  
  
1.  On the computer where AD DS is installed, open [!INCLUDE[wps_1](../Token/wps_1_md.md)], type **mmc**, and then press ENTER. The Microsoft Management Console opens.  
  
2.  In the MMC, on the **File** menu, click **Add\/Remove Snap\-in**. The **Add or Remove Snap\-ins** dialog box opens.  
  
3.  In **Available snap\-ins**, scroll down to and double\-click **Group Policy Management Editor**. The Group Policy Wizard opens.  
  
    > [!IMPORTANT]  
    > Ensure that you select **Group Policy Management Editor** and not **Group Policy Management**. If you select **Group Policy Management**, your configuration using these instructions will fail and a server certificate will not be autoenrolled to your users.  
  
4.  In **Select Group Policy Object**, click **Browse**. The **Browse for a Group Policy Object** dialog box opens.  
  
5.  In **Domains, OUs, and linked Group Policy Objects**, click **Default Domain Policy**, and then click **OK**.  
  
6.  Click **Finish**, and then click **OK**.  
  
7.  In the MMC, expand the following path: **Default Domain Policy**, **User Configuration**, **Policies**, **Windows Settings**, **Security Settings**, **Public Key Policies**.  
  
8.  In the MMC, click **Public Key Policies**. In the details pane, double\-click **Certificate Services Client \- Auto\-Enrollment**. The **Certificate Services Client \- Auto\-Enrollment Properties** dialog box opens. Configure the following items, and then click **OK**:  
  
    1.  In **Configuration Model**, select **Enabled**.  
  
    2.  Select the **Renew expired certificates, update pending certificates, and remove revoked certificates** check box.  
  
    3.  Select the **Update certificates that use certificate templates** check box.  
  
