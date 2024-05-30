---
title: Reactivate or deactivate the Remote Desktop Services license server
description: Reactivate or deactivate the Remote Desktop Services license server.
ms.topic: article
author: meaghanlewis
ms.author: wscontent
ms.date: 05/14/2024
manager: femila
---
# Reactivate or deactivate a Remote Desktop Services license server

## Reactive a license server

You must reactivate a Remote Desktop license server when any of the following occur: 

- The license server certificate is corrupted.
- The license server certificate is expired. 
- The license server private key is compromised. 

Reactivate a license server by using one of the following methods: 

- [Reactivate a license server automatically](#reactivate-a-license-server-automatically)
- [Reactivate a license server using a web browser](#reactivate-a-license-server-using-a-web-browser) 
- [Reactivate a license server by telephone](#reactivate-a-license-server-by-telephone)

### Prerequisites

Membership in the **Administrators** group, or equivalent, is required to complete either reactivation or deactivation.

### Reactivate a license server automatically 

The automatic reactivation method requires internet connectivity from the computer running the Remote Desktop Licensing Manager tool. Complete the following steps to reactivate a license server automatically:

1. In Server Manager, select **Remote Desktop Services** > **Servers**. Right-click the server where you installed the Remote Desktop Licensing role and select **RD Licensing Manager**. 
1. Verify that the connection method for the license server is set to **Automatic connection (recommended)** by right-clicking the license server that you want to reactivate, and then clicking **Properties**. On the **Connection Method** tab, change the connection method if necessary. 
1. Right-click the license server that you want to reactivate, point to **Advanced**, and then select **Reactivate Server**. The Reactivate Server Wizard starts.
1. On the **Welcome** page, select **Next**. 
1. On the **Information Needed** page, provide the requested information, and then select **Next**. 
1. Your request to reactivate the license server is sent to the Microsoft Clearinghouse for processing, and the license server is reactivated. 
1. On the Completing the Reactivate Server Wizard page, select **Finish**. 

### Reactivate a license server using a web browser 

The web reactivation method can be used when the computer running the Terminal Services Licensing Manager tool doesn't have internet connectivity, but you have access to the web from another computer. The URL for the web method is displayed in the Reactivate Server Wizard. 

### Reactivate a license server by telephone 

The telephone reactivation method allows you to talk to a Microsoft customer service representative to complete the reactivation process. The appropriate telephone number depends on the country/region that is configured for the Terminal Services license server, and that telephone number is displayed in the Reactivate Server Wizard. 

To reactivate a Terminal Services license server by telephone, complete the following steps:

1. Select **Start**, point to Administrative Tools, point to Terminal Services, and then click **TS Licensing Manager**. 
1. Verify that the connection method for the Terminal Services license server is set to **Telephone** by right-clicking the license server that you want to reactivate, and then clicking **Properties**. On the **Connection Method** tab, change the connection method, if necessary, ensure that the correct country or region is selected in the Select Country or Region list, and then select **OK**. 
1. Right-click the license server that you want to reactivate, point to **Advanced**, and then select **Reactivate Server**. The Reactivate Server Wizard starts. 
1. On the **Welcome** page, select **Next**. 
1. Call Microsoft by using the telephone number that is displayed on the **License Server Reactivation** page, and then provide the Microsoft customer support representative with the product ID and license server ID that is displayed on your screen. 
1. The representative processes your request to reactivate the license server, and provides you with a new license server ID. On the **License Server Reactivation** page in the Reactivate Server Wizard, type the new license server ID that the representative provides, and then select **Next**. The license server is reactivated. 
1. On the **Completing the Reactivate Server Wizard** page, select **Finish**.

## Deactive a license server

You may have to deactivate a license server if the certificate of the server expires, gets damaged, or if you redeploy the server.

The following steps describe how to deactivate a license server:

1. Select **Start**, point to Administrative Tools, point to Terminal Services, and then click TS Licensing Manager.
1. In the console tree, right-click the license server that you want to deactivate, point to **Advanced**, and then select **Deactivate Server**. 
1. After the Licensing Wizard starts, confirm that your name, your phone number (optional), and your e-mail address that are listed under Information Needed are correct. Then select **Next**. Your request to deactivate the license server is sent to Microsoft where it is processed.
    > [!NOTE]
    > Your e-mail address is required if you are using the Internet method.
1. Select Finish. 

When you deactivate a license server, you can't license other client computers from this server until the license server is reactivated. You're prompted to reactivate the license server when its registration expires. 