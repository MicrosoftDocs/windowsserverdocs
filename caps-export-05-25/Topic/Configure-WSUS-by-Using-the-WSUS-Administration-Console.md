---
title: Configure WSUS by Using the WSUS Administration Console
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c0be0a81-c22d-4144-ae05-547dca44ed18
author: britw
---
# Configure WSUS by Using the WSUS Administration Console
This topic describes how to configure the [!INCLUDE[wsus_firstref_30SP2](../Token/wsus_firstref_30SP2_md.md)] 3.0 SP2 settings by using the WSUS Administration Console. You must configure WSUS directly after you install the WSUS server software on a computer.  
  
You can alternatively configure WSUS by using the WSUS server configuration wizard. For more information about this option, see [Configure WSUS by using the WSUS server configuration wizard](assetId:///ea86ec38-ddaa-4d97-a14b-714d18063ccb).  
  
> [!IMPORTANT]  
> We recommend that you use the WSUS server configuration wizard the first time that you configure WSUS.  
  
This topic includes a procedure to start the WSUS Administration Console after it is installed. The WSUS Administration Console is installed on the WSUS server when you install the WSUS server software. You can also install the WSUS Administration Console on other computers in the same or in a trusted domain. For more information about how to install the WSUS Administration Console, see [Install the WSUS 3.0 SP2 Administration Console](assetId:///88dac4e9-5c85-4007-acfb-11d19ae69761) in this deployment guide.  
  
## <a name="opencon"></a>Open the WSUS Administration Console  
Members of the local Administrators group \(or the WSUS Administrators group on the server on which WSUS is installed\) can use all the features of the WSUS Administration Console. Members of the WSUS Reporters group have read\-only access to the WSUS Administration Console, and read\-only access to the WSUS data.  
  
For more information about WSUS administrators, see [Create WSUS administrators](../Topic/Secure-the-WSUS-3.0-SP2-Deployment.md#admins) in this deployment guide.  
  
### <a name="procopen"></a>To open the WSUS Administration Console  
  
1.  Log on to the computer by using an account that has the permissions described earlier in this topic.  
  
2.  Click **Start**, click **All Programs**, click **Administrative Tools**, and then click **Windows Server Update Services**.  
  
    > [!NOTE]  
    > If you install the WSUS Administration Console on a computer that is running a client operating system \(such as [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)]\), the Start menu might not display Administrative Tools. If Administrative Tools does not display in **All Programs**, perform the following procedure:  
    >   
    > 1.  Right\-click **Start**, and then click **Properties**.  
    > 2.  Click **Customize**.  
    > 3.  In the **Customize Start Menu** dialog box, scroll to **System Administrative Tools**, and select the **Display on the All Programs menu** check box.  
    > 4.  Click **OK** twice to save this setting and exit.  
  
In this topic:  
  
-   [Customize the WSUS Administration Console](../Topic/Customize-the-WSUS-Administration-Console.md)  
  
-   [Select the WSUS update source using the WSUS Administration Console](../Topic/Select-the-WSUS-update-source-using-the-WSUS-Administration-Console.md)  
  
-   [Change the WSUS proxy server specification using the WSUS Administration Console](../Topic/Change-the-WSUS-proxy-server-specification-using-the-WSUS-Administration-Console.md)  
  
-   [Select WSUS update products and classifications filters using the WSUS Administration Console](../Topic/Select-WSUS-update-products-and-classifications-filters-using-the-WSUS-Administration-Console.md)  
  
-   [Change WSUS update storage settings using the WSUS Administration Console](../Topic/Change-WSUS-update-storage-settings-using-the-WSUS-Administration-Console.md)  
  
-   [Select WSUS update languages using the WSUS Administration Console](../Topic/Select-WSUS-update-languages-using-the-WSUS-Administration-Console.md)  
  
-   [Schedule WSUS synchronizations using the WSUS Administration Console](../Topic/Schedule-WSUS-synchronizations-using-the-WSUS-Administration-Console.md)  
  
-   [Configure automatic approvals using the WSUS Administration Console](../Topic/Configure-automatic-approvals-using-the-WSUS-Administration-Console.md)  
  
-   [Set up email notifications using the WSUS Administration Console](../Topic/Set-up-email-notifications-using-the-WSUS-Administration-Console.md)  
  
