---
title: Add the Certificates Snap-in to an MMC
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 67ba15f1-5648-480d-9886-a56a3e622d99
author: Femila
---
# Add the Certificates Snap-in to an MMC
  You can use the Certificates snap\-in to manage certificates for a user, computer, or service account. To switch between managing certificates for your user account, a computer, or a service, you must add separate instances of the Certificates snap\-in to the console.  
  
## Adding the Certificates Snap\-in to an MMC  
  
-   [For a user account](#BKMK_user)  
  
-   [For a computer account](#BKMK_computer)  
  
-   [For a service](#BKMK_service)  
  
####  <a name="BKMK_user"></a> **Users** or **local Administrators** are the minimum group membership required to complete this procedure. Review the details in "Additional considerations" in this topic.  
  
###### To add the Certificates snap\-in to an MMC for a user account  
  
1.  Click **Start**. In **Start Search**, type **mmc**, and then press **ENTER**.  
  
    > [!TIP]  
    >  In Windows XP or Windows Server 2003, click **Run** on the **Start** menu, and then type **mmc** in the **Run** dialog box. In [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], type **mmc** in **Search programs and files**.  
  
2.  On the **File** menu, click **Add\/Remove Snap\-in**.  
  
3.  Under **Available snap\-ins**, double\-click **Certificates**, and then:  
  
    -   If you are logged on as an administrator, click **My user account**, and then click **Finish**.  
  
    -   If you are logged on as a user, Certificates automatically loads.  
  
4.  If you have no more snap\-ins to add to the console, click **OK**.  
  
5.  To save this console, on the **File** menu, click **Save**.  
  
 **Additional considerations**  
  
-   User certificates can be managed by the user or by an administrator.  
  
####  <a name="BKMK_computer"></a> **Local Administrators** is the minimum group membership required to complete this procedure. Review the details in "Additional considerations" in this topic.  
  
###### To add the Certificates snap\-in to an MMC for a computer account  
  
1.  Click **Start**. In **Start Search**, type **mmc**, and then press **ENTER**.  
  
    > [!TIP]  
    >  In Windows XP or Windows Server 2003, click **Run** on the **Start** menu, and then type **mmc** in the **Run** dialog box. In [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], type **mmc** in **Search programs and files**.  
  
2.  On the **File** menu, click **Add\/Remove Snap\-in**.  
  
3.  Under **Available snap\-ins**, double\-click **Certificates**.  
  
4.  Select **Computer account**, and then click **Next**.  
  
5.  Do one of the following:  
  
    -   To manage certificates for the local computer, click **Local computer**, and then click **Finish**.  
  
    -   To manage certificates for a remote computer, click **Another computer** and type the name of the computer, or click **Browse** to select the computer name and then click **Finish**.  
  
6.  If you have no more snap\-ins to add to the console, click **OK**.  
  
7.  To save this console, on the **File** menu, click **Save**.  
  
 **Additional considerations**  
  
-   [!INCLUDE[para10](../Token/para10_md.md)]  
  
-   To manage certificates for another computer, you can either create another instance of Certificates in the console or right\-click **Certificates \(Computer Name\)**, and then click **Connect to Another Computer**.  
  
####  <a name="BKMK_service"></a> **Local Administrators** is the minimum group membership required to complete this procedure. Review the details in "Additional considerations" in this topic.  
  
###### To add the Certificates snap\-in to an MMC for a service  
  
1.  Click **Start**. In **Start Search**, type **mmc**, and then press **ENTER**.  
  
    > [!TIP]  
    >  In Windows XP or Windows Server 2003, click **Run** on the **Start** menu, and then type **mmc** in the **Run** dialog box. In [!INCLUDE[firstref_client_7](../Token/firstref_client_7_md.md)] or [!INCLUDE[firstref_server_7](../Token/firstref_server_7_md.md)], type **mmc** in **Search programs and files**.  
  
2.  On the **File** menu, click **Add\/Remove Snap\-in**.  
  
3.  Under **Available snap\-ins**, double\-click **Certificates**.  
  
4.  Select **Service account**, and then click **Next**.  
  
5.  Do one of the following:  
  
    -   To manage certificates for services on your local computer, click **Local computer**, and then click **Next**.  
  
    -   To manage certificates for service on a remote computer, click **Another computer** and type the name of the computer, or click **Browse** to select the computer name and then click **Next**.  
  
6.  Select the service for which you are managing certificates.  
  
7.  Click **Finish**, and then click **Close**.  
  
8.  If you have no more snap\-ins to add to the console, click **OK**.  
  
9. To save this console, on the **File** menu, click **Save**.  
  
 For more information regarding the creation, use, or application of custom Microsoft Management Consoles, see TechNet Wiki article [Create and Save a Custom Console by Using Microsoft Management Console \(MMC\) using .msc file extension](http://go.microsoft.com/fwlink/?LinkId=208526) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=208526\).  
  
 **Additional considerations**  
  
-   [!INCLUDE[para10](../Token/para10_md.md)]  
  
-   To manage certificates for a service on another computer, you can either create another instance of Certificates in the console or right\-click **Certificates \- Service \(Service Name\) on Computer Name**, and then click **Connect to Another Computer**.  
  
  