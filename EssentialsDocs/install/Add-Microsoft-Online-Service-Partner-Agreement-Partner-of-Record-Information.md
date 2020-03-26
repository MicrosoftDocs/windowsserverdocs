---
title: "Add Microsoft Online Service Partner Agreement Partner-of-Record Information"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9bd191d6-ecc5-4230-a88e-f3fc281cb956
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Add Microsoft Online Service Partner Agreement Partner-of-Record Information

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

##  <a name="BKMK_3rdLevelDomanNames"></a>   
 If you are a Microsoft Online Service Partner Agreement (MOSPA) partner for Office 365, to ensure that you are correctly compensated when a subscription request is originated from  Windows Server Essentials via the Office 365 Integration Module, you need to create a registry key that contains your partner-of-record identification (POR ID). The following information is read and passed to the service provider through the Office 365 sign-up URLs.  
  
-   HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Server\MSO  
  
-   Type = String Value  
  
-   Key name = Partner  
  
-   Value = xxxxx, where xxxxx is your POR ID  
  
#### To add the POR ID key to the registry  
  
1.  On the reference computer, click **Start**, type **regedit**, and then press ENTER.  
  
2.  In the left pane, expand **HKEY_LOCAL_MACHINE**, expand **SOFTWARE**, expand **Microsoft**, and then expand **Windows Server**.  
  
3.  Right-click **Windows Server**, point to **New**, and then click **Key**.  
  
4.  Type **MSO** for the name of the key.  
  
5.  Right-click the key that you just created, and then click **String Value**.  
  
6.  Type **Partner** for the name of the string, and then press ENTER.  
  
7.  Right-click the new **Partner** string in the right pane, and then click **Modify**.  
  
8.  Type your POR ID in the **Value data** text box, and then click **OK**.  
  
## See Also  

 [Creating and Customizing the Image](Creating-and-Customizing-the-Image.md)   
 [Additional Customizations](Additional-Customizations.md)   
 [Preparing the Image for Deployment](Preparing-the-Image-for-Deployment.md)   
 [Testing the Customer Experience](Testing-the-Customer-Experience.md)

 [Creating and Customizing the Image](../install/Creating-and-Customizing-the-Image.md)   
 [Additional Customizations](../install/Additional-Customizations.md)   
 [Preparing the Image for Deployment](../install/Preparing-the-Image-for-Deployment.md)   
 [Testing the Customer Experience](../install/Testing-the-Customer-Experience.md)

