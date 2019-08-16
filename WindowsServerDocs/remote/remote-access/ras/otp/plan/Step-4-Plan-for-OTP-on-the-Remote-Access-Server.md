---
title: Step 4 Plan for OTP on the Remote Access Server
description: This topic is part of the guide Deploy Remote Access with OTP Authentication in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-ras
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4b97b2fd-767a-45c1-a64e-5b3edd0c8a47
ms.author: pashort
author: shortpatti
---
# Step 4 Plan for OTP on the Remote Access Server

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

After planning for the one-time password (OTP) RADIUS server and certificate settings, the final step in planning a Remote Access OTP deployment is to plan for client OTP settings on the Remote Access server.  
  
|Task|Description|  
|----|--------|  
|[4.1 Plan for OTP client exemptions](#bkmk_4_1_Exemptions)|Plan for exemptions for users that you do not require to authentication using OTP.|  
|[4.2 Plan for Windows 7 clients](#bkmk_4_2_Win7)|Plan to deploy the DirectAccess Connectivity Assistant (DCA) 2.0 to  Windows 7  client computers.|  
|[4.3 Plan for smart cards](#BKMK_smartcard)|Plan for the use of smart cards for additional authorization.|  
  
## <a name="bkmk_4_1_Exemptions"></a>4.1 Plan for OTP client exemptions  
When OTP authentication is enabled, by default all users are required to authenticate using a combination of user name and password, and OTP credentials. However, you can allow selected users to authenticate using a user name and password only, without OTP. To do this, create a security group and add any users that you want to exempt from OTP authentication.  
  
> [!NOTE]  
> Only client computers from a single forest may be exempted due to the fact that only one security group can be selected for client exemptions.  
  
## <a name="bkmk_4_2_Win7"></a>4.2 Plan for Windows 7 clients  
By default,  Windows 7  client computers cannot authenticate using OTP.  Windows 7  client computers require DCA 2.0 to authenticate using OTP in a  Windows Server 2012  Remote Access deployment. For more information about DCA 2.0, see [DirectAccess Connectivity Assistant 2.0](https://go.microsoft.com/fwlink/?LinkId=253699) on the Microsoft Download Center.  
  
## <a name="BKMK_smartcard"></a>4.3 Plan for smart cards  
When OTP authentication is enabled, the option to enable the use of smart cards for additional authorization is available. Create a security group to allow temporary access in the event that a user's smart card is not functional.  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Configure DirectAccess with OTP authentication](https://technet.microsoft.com/windows-server-docs/networking/remote-access/ras/otp/deploy-ra-otp)  
  


