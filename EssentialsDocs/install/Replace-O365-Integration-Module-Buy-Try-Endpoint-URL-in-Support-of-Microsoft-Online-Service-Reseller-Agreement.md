---
title: "Replace O365 Integration Module Buy-Try Endpoint URL in Support of Microsoft Online Service Reseller Agreement"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9860a6b9-baea-4bf0-9a9f-6f1a288f996e
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Replace O365 Integration Module Buy-Try Endpoint URL in Support of Microsoft Online Service Reseller Agreement

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

##  <a name="BKMK_O365"></a>   
 If you are a Microsoft Online Service Reseller Agreement (MOSRA) partner, to ensure that customer signup transactions are processed via your portal, you will need to replace the endpoint URLs used by the  Windows Server Essentials Office 365 integration module.  
  
 The integration module uses the following four endpoint URLs:  
  
1.  An Office 365 Enterprise subscription purchase endpoint.  
  
    -   HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Server\MSO\  
  
    -   Type = REG-SZ  
  
    -   Key name = MOSRASTDBUY  
  
    -   Value = *xxxxx*, where xxxxx is your enterprise subscription purchase URL. For example, Value = http://syndicatepartner.office365.com/enterprisebuy.html  
  
2.  An Office 365 Enterprise subscription trial endpoint.  
  
    -   HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Server\MSO\  
  
    -   Type = REG-SZ  
  
    -   Key name = MOSRASTDTRY  
  
    -   Value = *xxxxx*, where xxxxx is your enterprise subscription purchase URL. For example, Value = http://syndicatepartner.office365.com/enterprisetry.html  
  
3.  An  Office 365 Small Business Premium subscription purchase endpoint.  
  
    -   HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Server\MSO\  
  
    -   Type = REG-SZ  
  
    -   Key name = MOSRALITEBUY  
  
    -   Value = *xxxxx*, where xxxxx is your enterprise subscription purchase URL. For example, Value = http://syndicatepartner.office365.com/smallbizbuy.html  
  
4.  An  Office 365 Small Business Premium subscription trial endpoint.  
  
    -   HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Server\MSO\  
  
    -   Type = REG-SZ  
  
    -   Key name = MOSRALITETRY  
  
    -   Value = *xxxxx*, where xxxxx is your enterprise subscription purchase URL. For example, Value = http://syndicatepartner.office365.com/smallbiztry.html  
  
#### To add an endpoint URL key to the registry  
  
1.  On the reference computer, click **Start**, type **regedit**, and then press ENTER.  
  
2.  In the left pane, expand **HKEY_LOCAL_MACHINE**, expand **SOFTWARE**, expand **Microsoft**, expand **Windows Server**, and then expand **MSO**.  
  
3.  If MSO does not exist, right-click **Windows Server**, point to **New**, click **Key**, and then type **MSO** for the name of the key.  
  
4.  Right-click MSO, and then click **String Value**. Type one of the following endpoint string names for the name of the string:  
  
    -   MOSRASTDBUY  
  
    -   MOSRASTDTRY  
  
    -   MOSRALITEBUY  
  
    -   MOSRALITETRY  
  
5.  Right-click the new string in the right pane, and then click **Modify**.  
  
6.  Type your new endpoint URL in the **Value data** text box, and then click **OK**.  
  
7.  Repeat steps 4-6 for each string name listed in step 4.  
  
## See Also  

 [Creating and Customizing the Image](Creating-and-Customizing-the-Image.md)   
 [Additional Customizations](Additional-Customizations.md)   
 [Preparing the Image for Deployment](Preparing-the-Image-for-Deployment.md)   
 [Testing the Customer Experience](Testing-the-Customer-Experience.md)
 [Creating and Customizing the Image](../install/Creating-and-Customizing-the-Image.md)   
 [Additional Customizations](../install/Additional-Customizations.md)   
 [Preparing the Image for Deployment](../install/Preparing-the-Image-for-Deployment.md)   
 [Testing the Customer Experience](../install/Testing-the-Customer-Experience.md)

