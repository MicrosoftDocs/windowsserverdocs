---
title: Clients cannot connect with no licenses available error
description: Troubleshooting no licenses available error with remote deskotp connection
audience: ITPro ​
ms.custom: na
ms.reviewer: rklemen; josh.bender
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: troubleshooting
ms.assetid: 
author: kaushika-msft
manager: 
ms.author: kaushika; rklemen; josh.bender; v-tea; delhan
ms.date: 06/23/2019
ms.localizationpriority: medium
---

# Clients cannot connect with no licenses available error

This situation applies to deployments that include an RDSH server and a Remote Desktop Licensing server.

Identify which kind of behavior users are seeing:

- The session was disconnected because no licenses are available or no license server is available
- Access was denied because of a security error

Sign in to the RD Session Host as a domain administrator, and open the RD License Diagnoser. Look for messages such as the following:

  - The grace period for the Remote Desktop Session Host server has expired, but the RD Session Host server has not been configured with any license servers. connections to the RD Session Host server will be denied unless a license server is configured for the RD Session Host server.
  - License server \<computer name\> is not available. This could be caused by network connectivity problems, the Remote Desktop Licensing service is stopped on the license server, or RD Licensing is no longer installed on the computer.

These problems tend to be associated with the following user messages:

  - The remote session was disconnected because there are no Remote Desktop client access licenses available for this computer.
  - The remote session was disconnected because there are no Remote Desktop License Servers available to provide a license.

In this case, [configure the RD Licensing service](#configure-the-rd-licensing-service).

If the RD License Diagnoser lists other problems, such as “The RDP protocol component X.224 detected an error in the protocol stream and has disconnected the client,” there may be a problem that affects the license certificates. Such problems tend to be associated with user messages, such as the following:

Because of a security error, the client could not connect to the Terminal server. After making sure that you are logged on to the network, try connecting to the server again.

In this case, [refresh the X509 Certificate registry keys](#refresh-the-x509-certificate-registry-keys).

## Configure the RD Licensing service

The following procedure uses Server Manager to make the configuration changes. For information about how to configure and use Server Manager, see [Server Manager](https://docs.microsoft.com/en-us/windows-server/administration/server-manager/server-manager).

1. Open Server Manager, and then navigate to **Remote Desktop Services**.
2. On **Deployment Overview**, select **Tasks**, and then select **Edit Deployment Properties**.
3. Select **RD Licensing**, and then select the appropriate licensing mode for your deployment (**Per Device** or **Per User**).
4. Enter the fully qualified domain name (FQDN) of your RD License server, and then select **Add**.
5. If you have more than one RD License server, repeat step 4 for each server. 
    ![RD License server configuration options in Server Manager.](../media/troubleshoot-remote-desktop-connections/RDLicensing_Configure.png)

## Refresh the X509 Certificate registry keys

> [!IMPORTANT]  
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/en-us/help/322756%22%20target=%22_self%22) in case problems occur.

To resolve this problem, back up and then remove the X509 Certificate registry keys, restart the computer, and then reactivate the RD Licensing server. To do this, follow these steps.

> [!NOTE]  
> Perform the following procedure on each of the RDSH servers.

1. Open Registry Editor, and navigate to **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Terminal Server\\RCM**.
2. On the Registry menu, select **Export Registry File**.
3. Type **exported- Certificate** in the **File name** box, and then select **Save**.
4. Right-click each of the following values, select **Delete**, and then select **Yes** to verify the deletion:  
      - **Certificate**
      - **X509 Certificate**
      - **X509 Certificate ID**
      - **X509 Certificate2**
5. Exit Registry Editor, and then restart the RDSH server.
