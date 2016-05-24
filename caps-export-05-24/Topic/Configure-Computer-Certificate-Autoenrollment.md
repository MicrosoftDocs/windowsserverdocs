---
title: Configure Computer Certificate Autoenrollment
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4e4d4081-4243-4edc-bea4-47930c516320
---
# Configure Computer Certificate Autoenrollment
You can use this procedure to automatically enroll, or autoenroll, client computer certificates to domain member computers.  
  
> [!NOTE]  
> In this procedure, you are instructed to enable the **Certificate Services Client \- Auto\-Enrollment** Group Policy setting. If you have previously deployed server certificates and configured autoenrollment of server certificates, you do not need to perform this procedure again; however, you can use this procedure to verify that Group Policy is configured correctly to autoenroll certificates.  
  
Membership in both the **Enterprise Admins** and the root domain's **Domain Admins** group is the minimum required to complete this procedure.  
  
### To configure client computer certificate autoenrollment  
  
1.  On the computer where AD DS is installed, open [!INCLUDE[wps_1](../Token/wps_1_md.md)], type **mmc**, and then press ENTER. The Microsoft Management Console opens.  
  
2.  In the MMC, on the **File** menu, click **Add\/Remove Snap\-in**. The **Add or Remove Snap\-ins** dialog box opens.  
  
3.  In the **Add or Remove Snap\-ins** dialog box, in **Available snap\-ins**, scroll down to and double\-click **Group Policy Management Editor**. The Group Policy Wizard opens.  
  
    > [!IMPORTANT]  
    > Ensure that you select **Group Policy Management Editor** and not **Group Policy Management**. If you select **Group Policy Management**, your configuration using these instructions will fail and a server certificate will not be autoenrolled to your computers.  
  
4.  In **Select Group Policy Object**, click **Browse**. The **Browse for a Group Policy Object** dialog box opens.  
  
5.  In **Domains, OUs, and linked Group Policy Objects**, click **Default Domain Policy**, and then click **OK**.  
  
6.  Click **Finish**, and then click **OK**.  
  
7.  In the MMC, expand the following path: **Default Domain Policy**, **Computer Configuration**, **Policies**, **Windows Settings**, **Security Settings**, **Public Key Policies**.  
  
8.  Click **Public Key Policies**, and then in the details pane double\-click **Certificate Services Client \- Auto\-Enrollment**. The **Certificate Services Client \- Auto\-Enrollment Properties** dialog box opens. Configure the following items, and then click **OK**:  
  
    1.  In **Configuration Model**, select **Enabled**.  
  
    2.  Select the **Renew expired certificates, update pending certificates, and remove revoked certificates** check box.  
  
    3.  Select the **Update certificates that use certificate templates** check box.  
  
