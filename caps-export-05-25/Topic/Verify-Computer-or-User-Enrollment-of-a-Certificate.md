---
title: Verify Computer or User Enrollment of a Certificate
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ed369411-2573-44b4-9da2-e94a0afb176e
author: vhorne
---
# Verify Computer or User Enrollment of a Certificate
You can use this procedure to view the certificates that are in the certificate store to verify that a computer certificate, a user certificate, or both are enrolled on the local computer.  
  
To perform this procedure to verify enrollment of a computer certificate, the computer must be a member of **Domain Computers** or of the custom group that you specify, and you must be logged on to the computer with an account that has Administrator privileges. To perform this procedure to verify enrollment of a user certificate, you must be logged on to the computer with an account that is a member of the **Domain Users** group, or of the custom group that you specify.  
  
### To verify computer or user enrollment of a certificate  
  
1.  Open [!INCLUDE[wps_1](../Token/wps_1_md.md)], type **mmc**, and then press ENTER. The Microsoft Management Console opens.  
  
    > [!NOTE]  
    > If you are logged on to the computer with an account that does not have Administrator privileges, and if you want to view the Local Computer certificate store, you must open [!INCLUDE[wps_2](../Token/wps_2_md.md)] with the parameter **Run as administrator**, and then provide the credentials for an account that has Administrator privileges.  
  
2.  In the MMC, on the **File** menu, click **Add\/Remove Snap\-in**. The **Add or Remove Snap\-ins** dialog box opens.  
  
3.  In **Available snap\-ins**, click **Certificates**, and then click **Add**. Select one of the following.  
  
    -   To create a snap\-in for your user account: In **Certificates snap\-in**, ensure that **My user account** is selected, and then click **Finish**.  
  
    -   To create a snap\-in for your computer account: In **Certificates snap\-in**, ensure that **Computer account** is selected, and then click **Next**. In **Select Computer**, ensure that **Local computer** is selected, and then click **Finish**.  
  
    > [!TIP]  
    > To create a snap\-in that displays both the user account and computer account certificate stores, repeat the previous step and add the account snap\-in that you did not select during the first selection process.  
  
4.  To close the **Add or Remove Snap\-ins** dialog box, click **OK**. In the MMC, the certificate store for the **Current User**, the certificate store for the **Local Computer**, or both are displayed, depending on your selections in the previous step.  
  
5.  Expand the certificate store that you want to view, click **Personal**, and in **Object Type**, double\-click **Certificates**. The certificate enrolled to the computer or user is displayed in this store. For example, if you are viewing the **Certificates \(Local Computer\)** certificate store and your computer is named Client1 and your domain is named corp.contoso.com, the Personal Certificates store contains a certificate named **Client1.corp.contoso.com**. In another example, if you are viewing the **Certificates – Current User** certificate store, your user name is User1 and your domain name is corp.contoso.com, the Personal Certificates store contains a certificate named **User1.corp.contoso.com**.  
  
