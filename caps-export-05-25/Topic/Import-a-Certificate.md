---
title: Import a Certificate
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 68340bf6-9412-4a41-bb36-2ccc8c1ab5cf
author: Femila
---
# Import a Certificate
  You should only import certificates obtained from trusted sources. Importing an unreliable certificate could compromise the security of any system component that uses the imported certificate.  
  
 You can import a certificate into any logical or physical store. In most cases, you will import certificates into the Personal store or the Trusted Root Certification Authorities store, depending on whether the certificate is intended for you or if it is a root CA certificate.  
  
 **Users** or **local Administrators** are the minimum group memberships required to complete this procedure. Review the details in "Additional considerations" in this topic.  
  
### To import a certificate  
  
1.  Open the Certificates snap\-in for a user, computer, or service.  
  
2.  In the console tree, click the logical store where you want to import the certificate.  
  
3.  On the **Action** menu, point to **All Tasks** and then click **Import** to start the Certificate Import Wizard.  
  
4.  Type the file name containing the certificate to be imported. \(You can also click **Browse** and navigate to the file.\)  
  
5.  If it is a PKCS \#12 file, do the following:  
  
    -   Type the password used to encrypt the private key.  
  
    -   \(Optional\) If you want to be able to use strong private key protection, select the **Enable strong private key protection** check box.  
  
    -   \(Optional\) If you want to back up or transport your keys at a later time, select the **Mark key as exportable** check box.  
  
6.  Do one of the following:  
  
    -   If the certificate should be automatically placed in a certificate store based on the type of certificate, click **Automatically select the certificate store based on the type of certificate**.  
  
    -   If you want to specify where the certificate is stored, select **Place all certificates in the following store**, click **Browse**, and choose the certificate store to use.  
  
 **Additional considerations**  
  
-   User certificates can be managed by the user or by an administrator. Certificates issued to a computer or service can only be managed by an administrator or user who has been given the appropriate permissions.  
  
-   To open the Certificates snap\-in, see [Add the Certificates Snap-in to an MMC](../Topic/Add-the-Certificates-Snap-in-to-an-MMC.md).  
  
-   Enabling strong private key protection will ensure that you are prompted for a password every time the private key is used. This is useful if you want to make sure that the private key is not used without your knowledge.  
  
-   The file from which you import certificates will remain intact after you have completed importing the certificates. You can use Windows Explorer to delete the file if it is no longer needed.  
  
  