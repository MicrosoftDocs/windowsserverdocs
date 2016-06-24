---
title: Configure trusted certificates on RD Connection Broker servers and clients
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bb58cc93-d39a-4677-9bde-d8d816a7e636
author: lizap
---
# Configure trusted certificates on RD Connection Broker servers and clients
Use the following steps to configure trusted certificates.  
  
1. Connect to the RDMS server:   
  
    1.  In the Azure portal click **Browse > Virtual Machines**.  
    2.  Select the new RDSH virtual machine (for example, Contoso-CB1).  
    3.  Click **Connect > Open** to open the Remote Desktop client.  
    4.  In the client, click **Connect**, and then click **Use another user account**. Enter the user name and password for the local administrator account.  
    5.  Click **Yes** when warned about the certificate.  
  
2. Create and install self-signed certificates for the RD Connection Broker servers. (This procedure will differ if you're using certificates from a trusted certificate authority.)  
  
    1. In Server Manager, click **Remote Desktop Services > Overview > Tasks > Edit Deployment Properties**.   
  
    2. Expand **Certificates**.   
  
    3. Scroll down to the table, and then click **RD Connection Broker – Enable Single Sign On > Create new certificate**.  
  
    4. Enter the certificate name, using the internal FQDN of the Connection Broker load balancer (for example,  CBLB.contoso.com), and a password.   
  
    5. Select **Store this certificate**, and then browse to the shared folder that you created (for example,  \Contoso-CB1\Certificates).  
  
    6. Enter a file name for the certificate (for example, ContosoCBLBCert), and then click **Save**.   
  
    7. Select **Allow the certificate to be added to the Trusted Root Certificate Authorities certificate store on the destination computers**, and then click **OK**.   
  
    8. Click **Apply**. Wait for the certificate to be successfully applied to the RD Connection Broker server   
  
    9. Back in the Certificates view, click **RD Connection Broker – Publishing > Select existing certificate**.   
  
    10. Browse to the certificate created for the RD Gateway server (for example, ContosoCBLBCert), and then click **Open**.   
  
    11. Enter the password for the certificate, then select **Allow the certificate to be added to the Trusted Root Certificate store on the destination computers**, and click **OK**.   
  
    12. Click **Apply**.   
  
3. Install the server-side certificates on other Connection Brokers:  
  
    1. Connect to the other RD Connection Broker Server, following the details in Step 1.   
  
    2. Open the File Explorer, and navigate to the Certificates share (for example, \Contoso-CB1\Certificates).   
  
    3. Right-click the certificate you created in the previous step (for example, ContosoCBLBCert), and click **Install PFX**.   
  
    4. In the Certificate Import Wizard, click **Local Machine > Next**, and then click **Yes**.   
  
    5. Click **Next**, type in the password for the private key, and click **Next** again.   
  
    6. Select **Place all certificates in the following store**, and then browse to the Truested Root Certification Authorities. Click **OK**, **Next**, **Finish**, and finally **OK**.   
  
4. Export self-signed public certificates and copy to a client computer:   
  
    1. Launch certlm.msc.  
  
    2. In the left-hand pane, expand **Personal**, and click **Certificates**.  
  
    3. Right-click the RD Connection Broker Load-Balancing certificate intended for Client Authentication (for example, CBLB.Contoso.com).   
  
    4. Click **All Tasks > and Export**.   
  
    5. Accept the defaults in the Certificate Export Wizard until you get to the **File to Export** page.   
  
    6. Browse to the shared folder for certificates (for example, \Contoso-CB1\Certificates).    
  
    8. Enter a file name (for example, ContosoCBLBClientCert), and click **Save**.   
  
    9. Click **Next**, and then click **Finish**.   
  
    10. Right-click the exported clients, and click **Copy**.   
  
    11. Save the copied certificates to the local client computer's hard drive.   
  
5. Install the self-signed certificates on the client computer:   
  
    1. Sign into the client computer with an administrative account.  
  
    2. Navigate to the folder where the certificates were copied, right-click the load-balanced connection broker certificate file, and then click **Install certificate**.   
  
    3. In the Certificate Import Wizard, click **Local Machine**, and **Place all certificates in the following store.  
      
    4. Browse to the Trusted Root Certification Authorities, and then click **OK**.  
      
    5. Click **Next**, **Finish**, and finally **OK**.   

