---
title: Copy the CA Certificate and CRL to the Virtual Directory
description: This topic is part of the guide Deploy Server Certificates for 802.1X Wired and Wireless Deployments
manager: dougkim
ms.topic: article
ms.assetid: a1b5fa23-9cb1-4c32-916f-2d75f48b42c7
ms.prod: windows-server
ms.technology: networking
ms.author: lizross
author: eross-msft
ms.date: 07/19/2018
---
# Copy the CA Certificate and CRL to the Virtual Directory

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this procedure to copy the Certificate Revocation List and Enterprise root CA certificate from your certification authority to a virtual directory on your Web server, and to ensure that AD CS is configured correctly. Before running the commands below, ensure that you replace directory and server names with those that are appropriate for your deployment.  
  
To perform this procedure you must be a member of **Domain Admins**.  
  
#### To copy the certificate revocation list from CA1 to WEB1  
  
1.  On CA1, run Windows PowerShell as an Administrator, and then publish the CRL with the following command:  
  
    - Type `certutil -crl`, and then press ENTER.  

    - To copy the CA1 certificate to the file share on your Web server, type `copy C:\Windows\system32\certsrv\certenroll\*.crt \\WEB1\pki`, and then press ENTER.  
    
    - To copy the certificate revocation lists to the file share on your Web server, type `copy C:\Windows\system32\certsrv\certenroll\*.crl \\WEB1\pki`, and then press ENTER.  
  
2.  To verify that your CDP and AIA extension locations are correctly configured, type `pkiview.msc`, and then press ENTER. The pkiview Enterprise PKI MMC opens.  
  
3.  In the left pane, click your CA name.<p>For example, if your CA name is corp-CA1-CA, click **corp-CA1-CA**. 

4. In the Status column of the results pane, verify that the values for the following shows **OK**:

    - **CA Certificate**
    - **AIA Location #1**
    - **CDP Location #1**   
  
  
> [!TIP]  
> If **Status** for any item is not **OK**, do the following:  
> -   Open the share on your Web server to verify that the certificate and certificate revocation list files were successfully copied to the share. If they were not successfully copied to the share, modify your copy commands with the correct file source and share destination and run the commands again.  
> -   Verify that you have entered the correct locations for the CDP and AIA on the CA Extensions tab. Ensure that there are no extra spaces or other characters in the locations that you have provided.  
> -   Verify that you copied the CRL and CA certificate to the correct location on your Web server, and that the location matches the location you provided for the CDP and AIA locations on the CA.  
> -   Verify that you correctly configured permissions for the virtual folder where the CA certificate and CRL are stored.  
  


