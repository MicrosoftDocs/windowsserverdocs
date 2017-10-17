---
title: Prepare the CAPolicy.inf File
description: This topic is part of the guide Deploy Server Certificates for 802.1X Wired and Wireless Deployments
manager: brianlic
ms.topic: article
ms.assetid: c36201de-7eb6-4e38-87da-cf7dd981a442
ms.prod: windows-server-threshold
ms.technology: networking
ms.author: jamesmci
author: jamesmci
---
# Prepare the CAPolicy.inf File

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

On CA1, you must prepare the CAPolicy.inf file before installing Active Directory Certificate Services.  
  
To perform this procedure, you must be a member of the Administrators group.  
  
#### To prepare the CAPolicy.inf file  
  
1.  Open Windows PowerShell, type **notepad c:\Windows\CAPolicy.inf** and press ENTER.  
  
2.  When prompted to create a new file, click **Yes**.  
  
3.  Enter the following as the contents of the file:  
  
    ```  
    [Version]  
    Signature="$Windows NT$"  
    [PolicyStatementExtension]  
    Policies=InternalPolicy  
    [InternalPolicy]  
    OID=1.2.3.4.1455.67.89.5  
    Notice="Legal Policy Statement"  
    URL=http://pki.corp.contoso.com/pki/cps.txt  
    [Certsrv_Server]  
    RenewalKeyLength=2048  
    RenewalValidityPeriod=Years  
    RenewalValidityPeriodUnits=5  
    CRLPeriod=weeks  
    CRLPeriodUnits=1  
    LoadDefaultTemplates=0  
    AlternateSignatureAlgorithm=1  
    [CRLDistributionPoint]  
    [AuthorityInformationAccess]  
    ```  
  
4.  Click **File**, and then click **Save As**. Ensure the following:  
  
    -   **File name** is set to **CAPolicy.inf**  
  
    -   **Save as type** is set to **All Files**  
  
    -   **Encoding** is **ANSI**  
  
5.  When you are prompted to overwrite the file, click **Yes**.  
  
    ![Notepad dialog box](../../../media/Prepare-the-CAPolicy-inf-File/001-SaveCAPolicyORCA1.gif)  
  
    > [!CAUTION]  
    > Be sure to save the CAPolicy.inf with the inf extension. If you do not specifically type **.inf** at the end of the file name and select the options as described, the file will be saved as a text file and will not be used during CA installation.  
  
6.  Close Notepad.  
  
> [!IMPORTANT]  
> In the CAPolicy.inf, you can see there is a line specifying the URL http://pki.corp.contoso.com/pki/cps.txt. The Internal Policy section of the CAPolicy.inf is just shown as an example of how you would specify the location of a certificate practice statement (CPS). In this guide, you are not instructed to create the certificate practice statement (CPS).  
  


