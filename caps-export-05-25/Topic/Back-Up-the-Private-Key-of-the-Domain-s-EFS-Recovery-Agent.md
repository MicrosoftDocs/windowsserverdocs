---
title: Back Up the Private Key of the Domain&#39;s EFS Recovery Agent
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: f04e13b1-ba4b-4613-a15a-e556024deaaf
author: Femila
---
# Back Up the Private Key of the Domain&#39;s EFS Recovery Agent
By default, the first promoted domain controller in a [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] domain contains the built\-in Administrator profile that stores the public certificate and the private key for the Encrypting File System \(EFS\) default recovery agent of the domain. EFS is a component of the NTFS file system on Windows 2000, Windows XP Professional, Windows Server 2003, and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] that enables transparent encryption and decryption of files by using advanced, standard, cryptographic algorithms.  
  
You can use EFS to encrypt data files to prevent unauthorized access. EFS uses an encryption key that is dynamically generated to encrypt the file. The File Encryption Key \(FEK\) is encrypted with the EFS public key, and it is added to the file as an EFS attribute that is named Data Decryption Field \(DDF\). To decrypt the FEK, you must have the corresponding EFS private key from the public\-private key pair. After you decrypt the FEK, you can use the FEK to decrypt the file. If your EFS private key is lost, you can use a recovery agent to recover encrypted files. Every time that a file is encrypted, the FEK is also encrypted with the Recovery Agent's public key. The encrypted FEK is attached to the file with the copy that is encrypted with your EFS public key in the Data Recovery Field \(DRF\). If you use the recovery agent's private key, you can decrypt the FEK, and then decrypt the file. For more information, see The Encrypting File System \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=114579](http://go.microsoft.com/fwlink/?LinkId=114579)\).  
  
By default, the first promoted domain controller in a [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] domain contains the public certificate and the private key for the default EFS recovery agent of the domain. Because the private key is stored in a local user profile \(the built\-in Administrator profile\), it is not replicated to the rest of the domain controllers in the domain. The public certificate is imported to the Default Domain Policy, and it is applied to domain clients through Group Policy. If the Administrator profile or the first promoted domain controller in the domain is no longer available, the private key that is used to decrypt the encrypted files is lost, and files cannot be recovered through that recovery agent. Therefore, we highly recommend that you export and back up the domain recovery agent's private key.  
  
By far, the most frequent problem with EFS occurs when EFS encryption keys or recovery keys are not archived. If the keys are not backed up, they cannot be replaced when they are lost. If the keys cannot be used or replaced, data can be lost. If the domain controller’s operating system is reinstalled \(perhaps as the result of a disk crash\) the keys are destroyed. If a user's profile is damaged, keys are destroyed. In these cases, or in any other cases in which keys are damaged or lost and backup keys are not available, the encrypted files cannot be decrypted.  
  
### To export the domain EFS recovery agent's private key  
  
1.  Log on to the first domain controller that was promoted in the domain by using the built\-in Administrator account.  
  
2.  Click **Start**, click **Run**, type **mmc**, and then click **OK**.  
  
3.  On the **File** menu, click **Add\/Remove Snap\-in**, and then click **OK**.  
  
4.  Under **Available Standalone Snap\-ins**, click **Certificates**, and then click **Add**.  
  
5.  Click **My user account**, click **Finish**, and then click **OK**.  
  
6.  Locate the certificate that displays the words "File Recovery" \(without the quotation marks\) in the **Intended Purposes** column.  
  
7.  Right\-click the certificate that you located in step 9, point to **All Tasks**, and then click **Export**. The Certificate Export Wizard starts.  
  
8.  Click **Next**.  
  
9. Click **Yes, export the private key**, and then click **Next**.  
  
10. Click **Personal Information Exchange – PKCS \#12 \(.PFX\)**.  
  
    > [!NOTE]  
    > We strongly recommend that you select the **Enable strong protection \(requires IE 5.0, NT 4.0 SP4 or above\)** check box to protect your private key from unauthorized access.  
    >   
    > If you select the **Delete the private key if the export is successful** check box, the private key is removed from the domain controller. As a best practice, we recommend that you use this option. Install the recovery agent's private key only in situations when you need it to recover files. In all other situations, export and then store the recovery agent's private key offline to help maintain its security.  
  
11. Click **Next**.  
  
12. Specify \(and confirm\) a password, and then click **Next**.  
  
13. Specify a file name and location where you want to export the certificate and the private key, and then click **Next**.  
  
    > [!NOTE]  
    > We recommend that you back up the file to a disk or to a removable media device, and then store the backup in a location where you can confirm the physical security of the backup.  
  
14. Verify the settings that are displayed on the **Completing the Certificate Export Wizard** page, and then click **Finish**.  
  
For more information, see the following:  
  
-   Best practices for the Encrypting File System \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=114580](http://go.microsoft.com/fwlink/?LinkId=114580)\).  
  
-   EFS Recovery Agent Cannot Export Private Keys \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=114586](http://go.microsoft.com/fwlink/?LinkId=114586)\).  
  
