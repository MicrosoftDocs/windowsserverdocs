---
title: Offline Migration Steps
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: acbc9a23-e51c-4020-95f5-a4e56059dd0b
author: vhorne
---
# Offline Migration Steps
This topic describes the steps required to perform an offline migration from Forefront UAG SP1 DirectAccess to DirectAccess in [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)].  
  
|Task|Description|  
|--------|---------------|  
|Step 1: Install the Remote Access role|Configure the [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] computer as a Remote Access server.|  
|Step 2: Configure IP addresses|Configure IP addresses on the Remote Access server.|  
|Step 3: Obtain a server certificate for IP\-HTTPS connections|DirectAccess in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] provides two options for the IP\-HTTPS certificate. You can obtain a certificate from a CA, in a similar way to Forefront UAG DirectAccess, or you can configure [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] DirectAccess to automatically issue a self\-signed certificate for IP\-HTTPS authentication.|  
|Step 4: Prepare GPOs|Prepare the required GPOs.|  
|Step 5: Additional steps||  
  
## <a name="BKMK_Step1"></a>Step 1: Install the Remote Access role  
Export the settings using the following procedure.  
  
#### To install the role  
  
1.  In the dashboard of the Server Manager console click **Add roles**.  
  
2.  Click **Next** until you reach the **Select Server Roles** dialog.  
  
3.  On the **Select Server Roles** dialog, select **Remote Access**. Click **Add Required Features**, and then click **Next**.  
  
4.  On the **Select features** dialog, expand **Remote Server Administration Tools**. Expand **Role Administration Tools**, and then select **Remote Access Management Tools**. Click **Next** until you reach the **Confirm installation selections** dialog.  
  
5.  On the **Confirm installation selections** dialog, click **Install**.  
  
6.  On the **Installation progress** dialog, verify that the installation was successful, and then click **Close**.  
  
## <a name="BKMK_Step2"></a>Step 2: Configure IP addresses  
Configure the IP addresses using the following procedure.  
  
#### To configure addresses  
  
1.  On the external network adapter, use the value specified in **DirectAccess server Internet\-facing address**, in the **DirectAccess Server Settings** section of the exported Forefront UAG configuration setting file as the first IP address. For the second IP address, use this address increased by one. For example, 1.2.3.4 and 1.2.3.5.  
  
2.  To ensure that ISATAP is not configured, configure an arbitrary IPv6 unique local address \(prefix fc00::\/7\) on the internal network adapter.  
  
3.  For the internal network adapter, use the address specified in the **DirectAccess server internal address**, in the **DirectAccess Server Settings** section of the exported Forefront UAG configuration settings file.  
  
4.  On the **Select features** dialog, expand **Remote Server Administration Tools**. Expand **Role Administration Tools**, and then select **Remote Access Management Tools**. Click **Next** until you reach the **Confirm installation selections** dialog.  
  
5.  On the **Confirm installation selections** dialog, click **Install**.  
  
6.  On the **Installation progress** dialog, verify that the installation was successful, and then click **Close**.  
  
## <a name="BKMK_Step3"></a>Step 3: Obtain an IP\-HTTPS certificate  
Obtain a web server certificate with a subject name that matches the FQDN of the Forefront UAG server. If you want to export the certificate from Forefront UAG and import it to the Remote Access server, see [Export a certificate with the private key](http://technet.microsoft.com/library/cc754329.aspx) for instructions.  Note that exporting the private key is only possible if the **Make private key exportable** option was checked when the original Forefront UAG certificate was created. Otherwise, the private key cannot be exported, and a new certificate with the same FQDN for the Remote Access server must be created.  
  
## <a name="BKMK_Step4"></a>Step 4: Prepare GPOs  
Prepare GPOs for the Remote Access server, DirectAccess clients, and application servers. DirectAccess administrators should have the correct permissions \(edit settings, delete, modify security\) to modify the GPOs.  
  
## <a name="BKMK_Step5"></a>Step 5: Configure DirectAccess  
Configure DirectAccess using the instructions described in [Side\-by\-side migration steps](../Topic/Side-by-Side-Migration-Steps.md#BKMK_Step8).  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Offline Migration of Forefront UAG DirectAccess](../Topic/Offline-Migration-of-Forefront-UAG-DirectAccess.md)  
  
