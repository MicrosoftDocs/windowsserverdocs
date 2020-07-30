---
title: Configure server certificate auto-enrollment
description: This topic is part of the guide Deploy Server Certificates for 802.1X Wired and Wireless Deployments
manager: brianlic
ms.topic: article
ms.assetid: c81e85cb-ecb8-442a-ad27-442c2f9e40df
ms.prod: windows-server
ms.technology: networking
ms.author: lizross
author: eross-msft
---
# Configure certificate auto-enrollment

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

> [!NOTE]
> Before you perform this procedure, you must configure a server certificate template by using the Certificate Templates Microsoft Management Console snap-in on a CA that is running AD CS.
Membership in both the **Enterprise Admins** and the root domain's **Domain Admins** group is the minimum required to complete this procedure.

## Configure server certificate auto-enrollment

1. On the computer where AD DS is installed, open Windows PowerShell&reg;, type **mmc**, and then press ENTER. The Microsoft Management Console opens.
2. On the **File** menu, click **Add/Remove Snap-in**. The **Add or Remove Snap-ins** dialog box opens.
3. In **Available snap-ins**, scroll down to and double-click **Group Policy Management Editor**. The **Select Group Policy Object** dialog box opens.

     > [!IMPORTANT]
     > Ensure that you select **Group Policy Management Editor** and not **Group Policy Management**. If you select **Group Policy Management**, your configuration using these instructions will fail and a server certificate will not be autoenrolled to your NPSs.

4. In **Group Policy Object**, click **Browse**. The **Browse for a Group Policy Object** dialog box opens.
5. In **Domains, OUs, and linked Group Policy Objects,** click **Default Domain Policy**, and then click **OK**.
6. Click **Finish**, and then click **OK**.
7. Double-click **Default Domain Policy**. In the console, expand the following path: **Computer Configuration**, **Policies**, **Windows Settings**, **Security Settings**, and then **Public Key Policies**.
8. Click **Public Key Policies**. In the details pane, double-click **Certificate Services Client - Auto-Enrollment**. The **Properties** dialog box opens. Configure the following items, and then click **OK**:

     1. In **Configuration Model**, select **Enabled**.
     2. Select the **Renew expired certificates, update pending certificates, and remove revoked certificates** check box.
     3. Select the **Update certificates that use certificate templates** check box.

9. Click **OK**.

## Configure user certificate auto-enrollment

1. On the computer where AD DS is installed, open Windows PowerShell&reg;, type **mmc**, and then press ENTER. The Microsoft Management Console opens.
2. On the **File** menu, click **Add/Remove Snap-in**. The **Add or Remove Snap-ins** dialog box opens.
3. In **Available snap-ins**, scroll down to and double-click **Group Policy Management Editor**. The **Select Group Policy Object** dialog box opens.

     > [!IMPORTANT]
     > Ensure that you select **Group Policy Management Editor** and not **Group Policy Management**. If you select **Group Policy Management**, your configuration using these instructions will fail and a server certificate will not be autoenrolled to your NPSs.

4. In **Group Policy Object**, click **Browse**. The **Browse for a Group Policy Object** dialog box opens.
5. In **Domains, OUs, and linked Group Policy Objects,** click **Default Domain Policy**, and then click **OK**.
6. Click **Finish**, and then click **OK**.
7. Double-click **Default Domain Policy**. In the console, expand the following path: **User Configuration**, **Policies**, **Windows Settings**, **Security Settings**.
8. Click **Public Key Policies**. In the details pane, double-click **Certificate Services Client - Auto-Enrollment**. The **Properties** dialog box opens. Configure the following items, and then click **OK**:

     1. In **Configuration Model**, select **Enabled**.
     2. Select the **Renew expired certificates, update pending certificates, and remove revoked certificates** check box.
     3. Select the **Update certificates that use certificate templates** check box.

9. Click **OK**.

## Next Steps

[Refresh Group Policy](refresh-group-policy.md)
