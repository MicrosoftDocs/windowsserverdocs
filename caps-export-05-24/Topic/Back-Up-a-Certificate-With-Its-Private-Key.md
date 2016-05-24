---
title: Back Up a Certificate With Its Private Key
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: bf24c6b5-c229-4586-8c76-6857fc3f0296
author: Femila
---
# Back Up a Certificate With Its Private Key
  Certificates are important credentials. Their loss or corruption can cause serious harm. Such harm can come from delays in authenticating your identity to an inability to retrieve encrypted data. You can back up certificates to protect them from loss or corruption, or to move them to a different computer.  
  
 **Users** or **local Administrators** are the minimum group memberships required to complete this procedure. Review the details in "Additional considerations" in this topic.  
  
### To export a certificate with the private key  
  
1.  Open the Certificates snap\-in for a user, computer, or service.  
  
2.  Do one of the following:  
  
    -   If you are in Logical Certificate Stores view mode, in the console tree, click **Certificates**.  
  
    -   If you are in Certificate purpose view mode, in the console tree, click **Purpose**.  
  
3.  In the details pane, click the certificate you want to export.  
  
4.  On the **Action** menu, point to **All Tasks**, and then click **Export**.  
  
5.  In the Certificate Export Wizard, click **Yes, export the private key**. \(This option will appear only if the private key is marked as exportable and you have access to the private key.\)  
  
6.  Under **Export File Format**, select one of the available certificate file\-format options. Also, do one or all of the following, if available, and then click **Next**.  
  
    -   To include all certificates in the certification path, select the **Include all certificates in the certification path if possible** check box.  
  
    -   To include all extended properties of the certificate, select **Export all extended properties**.  
  
    -   To delete the private key if the export is successful, select the **Delete the private key if the export is successful** check box.  
  
7.  If required, In **Password**, type a password to encrypt the private key you are exporting. In **Confirm password**, type the same password again, and then click **Next**.  
  
8.  In **File name**, type a file name and path for the PKCS \#12 file that will store the exported certificate and private key, click **Next**, and then click **Finish**.  
  
 **Additional considerations**  
  
-   User certificates can be managed by the user or by an administrator. Certificates issued to a computer or service can only be managed by an administrator or user who has been given the appropriate permissions.  
  
-   To open the Certificates snap\-in, see [Add the Certificates Snap-in to an MMC](../Topic/Add-the-Certificates-Snap-in-to-an-MMC.md).  
  
-   Strong protection \(also known as iteration count\) is enabled by default in the Certificate Export Wizard when you export a certificate with its associated private key.  
  
-   Strong protection is not compatible with older applications.  
  
-   After the Certificate Export Wizard is finished, the certificate will remain in the certificate store in addition to being in the newly\-created file. If you want to remove the certificate from the certificate store, you will need to delete it.  
  
  