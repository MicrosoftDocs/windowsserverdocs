---
title: Step 2 Configure the RADIUS Server
description: This topic is part of the guide Deploy Remote Access with OTP Authentication in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-ras
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0326818f-9144-496c-b946-f82be4eefbd3
ms.author: pashort
author: shortpatti
---
# Step 2 Configure the RADIUS Server

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

Before you configure the Remote Access server to support DirectAccess with OTP support, you configure the RADIUS server.  
  
|Task|Description|  
|----|--------|  
|[2.1. Configure the RADIUS software distribution tokens](#BKMK_1.1)|On the RADIUS server configure software distribution tokens.|  
|[2.2. Configure the RADIUS security information](#BKMK_1.2)|On the RADIUS server configure the ports and shared secret to be used.|  
|[2.3 Adding user account for OTP probing](#BKMK_Probe)|On the RADIUS server create a new user account for OTP probing.|  
|[2.4 Synchronize with Active Directory](#BKMK_Active)|On the RADIUS server create user accounts synchronized with Active Directory accounts.|  
|[2.5 Configure the RADIUS authentication agent](#BKMK_AuthAgent)|Configure the Remote Access server as a RADIUS authentication agent.|  
  
## <a name="BKMK_1.1"></a>2.1 Configure the RADIUS software distribution tokens  
The RADIUS server must be configured with the necessary license and software and/or hardware distribution tokens to be used by DirectAccess with OTP. This process will be specific to each RADIUS vendor implementation.  
  
## <a name="BKMK_1.2"></a>2.2 Configure the RADIUS security information  
The RADIUS server uses UDP ports for communication purposes, and each RADIUS vendor has its own default UDP ports for incoming and outgoing communication. For the RADIUS server to work with the Remote Access server, make sure that all firewalls in the environment are configured to allow UDP traffic between the DirectAccess and OTP servers over the required ports as needed.  
  
The RADIUS server uses a shared secret for authentication purposes. Configure the RADIUS server with a strong password for the shared secret, and note that this will be used when configuring the DirectAccess server's client computer configuration for use with DirectAccess with OTP.  
  
## <a name="BKMK_Probe"></a>2.3 Adding user account for OTP probing  
On the RADIUS server create a new user account called **DAProbeUser** and give it the password **DAProbePass**.  
  
## <a name="BKMK_Active"></a>2.4 Synchronize with Active Directory  
The RADIUS server must have user accounts that correspond to the users in Active Directory that will be using DirectAccess with OTP.  
  
#### To synchronize the RADIUS and Active Directory users  
  
1.  Record the user information from Active Directory for all DirectAccess with OTP users.  
  
2.  Use the vendor specific procedure to create identical user **domain\username** accounts in the RADIUS server that were recorded.  
  
## <a name="BKMK_AuthAgent"></a>2.5 Configure the RADIUS authentication agent  
The Remote Access server must be configured as a RADIUS authentication agent for the DirectAccess with OTP implementation. Follow the RADIUS vendor instructions to configure the Remote Access server as a RADIUS authentication agent.  
  


