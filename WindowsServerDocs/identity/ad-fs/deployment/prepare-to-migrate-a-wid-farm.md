---
title: Prepare to migrate an AD FS WID farm
description:Provides information on getting ready to migrate an AD FS server WID farm to Windows Server 2012.
author: billmath
ms.author: billmath
manager: femila
ms.date: 06/28/2017
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: identity-adfs
---

# Prepare to migrate a WID farm  
 To prepare to migrate AD FS 2.0 federation servers that belong to a Windows Internal Database (WID) farm to Windows Server 2012, you must export and back up the AD FS configuration data from these servers.  
  
 To export the AD FS configuration data, perform the following tasks:  
  
-   [Step 1: - Export service settings](../Topic/Prepare%20to%20Migrate%20the%20AD%20FS%202.0%20Federation%20Server.md#W_1)  
  
-   [Step 2: Back up custom attribute stores](../Topic/Prepare%20to%20Migrate%20the%20AD%20FS%202.0%20Federation%20Server.md#W_2)  
  
-   [Step 3: Back up webpage customizations](../Topic/Prepare%20to%20Migrate%20the%20AD%20FS%202.0%20Federation%20Server.md#W_3)  
  
###  <a name="W_1"></a> Step 1: - Export service settings  
 To export service settings, perform the following procedure:  
  
##### To export service settings  
  
1.  Record the certificate subject name and thumbprint value of the SSL certificate used by the federation service. To find the SSL certificate, open the Internet Information Services (IIS) management console, select **Default Web Site** in the left pane, click **Bindings…** in the **Action** pane, find and select the https binding, click **Edit**, then click **View**.  
  
    > [!NOTE]
    >  Optionally, you can also export the SSL certificate and its private key to a .pfx file. For more information, see [Export the Private Key Portion of a Server Authentication Certificate](../Topic/Export%20the%20Private%20Key%20Portion%20of%20a%20Server%20Authentication%20Certificate.md).  
    >   
    >  This step is optional because this certificate is stored in the local computer Personal certificates store and will be preserved in the operating system upgrade.  
  
2.  Export any token-signing, token-encryption, or service-communications certificates and keys that are not internally generated, in addition to self-signed certificates.  
  
     You can view all the certificates that are in use on your server by using Windows PowerShell. Open Windows PowerShell and run the following command to add the AD FS cmdlets to your Windows PowerShell session: `PSH:>add-pssnapin “Microsoft.adfs.powershell”`. Then run the following command to view all certificates that are in use on your server `PSH:>Get-ADFSCertificate`. The output of this command includes StoreLocation and StoreName values that specify the store location of each certificate.  You can then use the guidance in [Export the Private Key Portion of a Server Authentication Certificate](../Topic/Export%20the%20Private%20Key%20Portion%20of%20a%20Server%20Authentication%20Certificate.md) to export each certificate and its private key to a .pfx file.  
  
    > [!NOTE]
    >  This step is optional, because all external certificates are preserved during the operating system upgrade.  
  
3.  Record the identity of the AD FS 2.0 federation service account and the password of this account.  
  
     To find the identity value, examine the **Log On As** column of **AD FS 2.0 Windows Service** in the **Services** console and manually record the value.  
  
###  <a name="W_2"></a> Step 2: Back up custom attribute stores  
 You can find information about custom attribute stores in use by AD FS by using Windows PowerShell. Open Windows PowerShell and run the following command to add the AD FS cmdlets to your Windows PowerShell session: `PSH:>add-pssnapin “Microsoft.adfs.powershell”`. Then run the following command to find information about the custom attribute stores: `PSH:>Get-ADFSAttributeStore`. The steps to upgrade or migrate custom attribute stores vary.  
  
###  <a name="W_3"></a> Step 3: Back up webpage customizations  
 To back up any webpage customizations, copy the AD FS webpages and the **web.config** file from the directory that is mapped to the virtual path **“/adfs/ls”** in IIS. By default, it is in the **%systemdrive%\inetpub\adfs\ls** directory.  