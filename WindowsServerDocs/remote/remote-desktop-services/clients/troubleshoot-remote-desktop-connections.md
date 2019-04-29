---
title: Troubleshooting Remote Desktop connections
description: Troubleshooting procedures arranged by symptom
ms.custom: na

ms.reviewer: rklemen; josh.bender
ms.suite: na

ms.tgt_pltfrm: na
ms.topic: troubleshooting
ms.assetid: 
author: RobVyK
manager: 
ms.author: kaushika; rklemen; josh.bender; v-tea
ms.date: 02/22/2019
ms.localizationpriority: medium
---
# Troubleshooting Remote Desktop connections
For brief explanations of several of the most common Remote Desktop Services (RDS) issues, see [Frequently asked questions about the Remote Desktop clients](https://review.docs.microsoft.com/en-us/windows-server/remote/remote-desktop-services/clients/remote-desktop-client-faq). This article describes several more advanced approaches to troubleshooting connection problems. Many of these procedures apply whether you are troubleshooting a simple configuration, such as one physical computer connecting to another physical computer, or a more complicated configuration. Some procedures address issues that occur only in more complicated multi-user scenarios. For more information about the remote desktop components and how they work together, see [Remote Desktop Services architecture](https://docs.microsoft.com/en-us/windows-server/remote/remote-desktop-services/desktop-hosting-logical-architecture).

> [!NOTE]  
> Many of the procedures that are described in this article require you to access multiple computers, some of which you may have to access remotely. For more information about remote administration tools and how to configure them, see [Remote Server Administration Tools (RSAT) for Windows operating systems](https://support.microsoft.com/en-us/help/2693643/remote-server-administration-tools-rsat-for-windows-operating-systems).

In the following list, identify the type of symptom that you (or your users) are experiencing.

- [The remote desktop client cannot connect to the remote desktop, but there are no specific symptoms or messages (general troubleshooting steps)](#no-specific-symptoms-or-messages-general-troubleshooting-steps)
- [The remote desktop client cannot connect to the remote desktop, and receives a “Class not registered” message](#client-cannot-connect-class-not-registered)
- [The remote desktop client cannot connect to the remote desktop, and receives a "no licenses available" or "security error" message](#client-cannot-connect-no-licenses-available)
- [The user receives an "Access denied" message, or must provide credentials twice](#user-cannot-authenticate-or-must-authenticate-twice)
- [On connecting, the receives a “Remote Desktop Service is currently busy” message](#on-connecting-user-receives-remote-desktop-service-is-currently-busy-message)
- [The remote desktop client disconnects and cannot reconnect to the same session](#rd-client-disconnects-and-cannot-reconnect-to-the-same-session)
- [The user connects to a remote laptop over a wireless network, and then the laptop disconnects from the network](#remote-laptop-disconnects-from-wireless-network).
- [The user experiences poor performance or problems with remote applications](#user-experiences-poor-performance-or-application-problems)

> [!NOTE]  
> For a current list of RDP disconnect codes, see [ExtendedDisconnectReasonCode enumeration](https://docs.microsoft.com/en-us/windows/desktop/TermServ/extendeddisconnectreasoncode). 

## No specific symptoms or messages (general troubleshooting steps)

Use these steps when a Remote Desktop client cannot connect to a remote desktop but does not provide messages or other symptoms that would help identify the cause. To resolve many of the most common causes of this kind of issue, use the following methods:

- [Check the status of the RDP protocol](#check-the-status-of-the-rdp-protocol)
- [Check the status of the RDP services](#check-the-status-of-the-rdp-services)
- [Check that the RDP listener is functioning](#check-that-the-rdp-listener-is-functioning)
- [Check the RDP listener port](#check-the-rdp-listener-port)

### Check the status of the RDP protocol

#### Check the status of the RDP protocol on a local computer

To check and change the status of the RDP protocol on a local computer, see [How to enable Remote Desktop](https://docs.microsoft.com/en-us/windows-server/remote/remote-desktop-services/clients/remote-desktop-allow-access#how-to-enable-remote-desktop).

> [!NOTE]  
> If the remote desktop options are not available, see [Check whether a Group Policy Object is blocking RDP](#check-whether-a-group-policy-object-gpo-is-blocking-rdp-on-a-local-computer).

#### Check the status of the RDP protocol on a remote computer

> [!IMPORTANT]  
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/en-us/help/322756%22%20target=%22_self%22) in case problems occur.

To check and change the status of the RDP protocol on a remote computer, use a network registry connection:

1. Select **Start**, select **Run**, and then enter **regedt32**.
2. In Registry Editor, select **File**, and then select **Connect Network Registry**.
3. In the **Select Computer** dialog box, enter the name of the remote computer, select **Check Names**, and then select **OK**.
4. Navigate to **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Terminal Server**.  
   ![Registry Editor, showing the fDenyTSConnections entry](..\media\troubleshoot-remote-desktop-connections\RegEntry_fDenyTSConnections.png)
   - If the value of the **fDenyTSConnections** key is **0**, then RDP is enabled
   - If the value of the **fDenyTSConnections** key is **1**, then RDP is disabled
5. To enable RDP, change the value of **fDenyTSConnections** from **1** to **0**.

#### Check whether a Group Policy Object (GPO) is blocking RDP on a local computer

If you cannot turn on RDP in the user interface or if the value of **fDenyTSConnections** reverts to **1** after you have changed it, a GPO may be overriding the computer-level settings.

To check the group policy configuration on a local computer, open a Command Prompt window as an administrator, and enter the following command:
```
gpresult /H c:\gpresult.html
```
After this command finishes, open gpresult.html. In **Computer Configuration\\Administrative Templates\\Windows Components\\Remote Desktop Services\\Remote Desktop Session Host\\Connections**, find the **Allow users to connect remotely by using Remote Desktop Services** policy.

- If the setting for this policy is **Enabled**, group policy is not blocking RDP connections.
- If the setting for this policy is **Disabled**, check **Winning GPO**. This is the GPO that is blocking RDP connections.
![An example segment of gpresult.html, in which the domain-level GPO **Block RDP** is disabling RDP.](..\media\troubleshoot-remote-desktop-connections\GPResult_RDSH_Connections_GP.png)
   
  ![An example segment of gpresult.html, in which **Local Group Policy** is disabling RDP.](..\media\troubleshoot-remote-desktop-connections\GPResult_RDSH_Connections_LGP.png)

#### Check whether a GPO is blocking RDP on a remote computer

To check the Group Policy configuration on a remote computer, the command is almost the same as for a local computer:
```
gpresult /S <computer name> /H c:\gpresult-<computer name>.html
```
The file that this command produces (**gpresult-\<computer name\>.html**) uses the same information format as the local computer version (**gpresult.html**) uses.

#### Modifying a blocking GPO

You can modify these settings in the Group Policy Object Editor (GPE) and Group Policy Management Console (GPM). For more information about how to use Group Policy, see [Advanced Group Policy Management](https://docs.microsoft.com/en-us/microsoft-desktop-optimization-pack/agpm/).

To modify the blocking policy, use one of the following methods:

- In GPE, access the appropriate level of GPO (such as local or domain), and navigate to **Computer Configuration\\Administrative Templates\\Windows Components\\Remote Desktop Services\\Remote Desktop Session Host\\Connections**\\**Allow users to connect remotely by using Remote Desktop Services**.  
   1. Set the policy to **Enabled** or **Not Configured**.
   2. On the affected computers, open a Command Prompt window as an administrator, and run the **gpupdate /force** command.
- In GPM, navigate to the OU in which the blocking policy is applied to the affected computers, and delete the policy from the OU.

### Check the status of the RDP services

On both the local (client) computer and the remote (target) computer, the following services should be running:

- Remote Desktop Services (TermService)
- Remote Desktop Services UserMode Port Redirector (UmRdpService)

You can use the Services MMC snap-in to manage the services locally or remotely. You can also use PowerShell locally or remotely (if the remote computer is configured to accept remote PowerShell commands).

![Remote Desktop services in the Services MMC snap-in. Do not modify the default service settings.](..\media\troubleshoot-remote-desktop-connections\RDSServiceStatus.png)

On either computer, if one or both services are not running, start them.

> [!NOTE]  
> If you start the Remote Desktop Services service, click **Yes** to automatically restart the Remote Desktop Services UserMode Port Redirector service.

### Check that the RDP listener is functioning

> [!IMPORTANT]  
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/en-us/help/322756%22%20target=%22_self%22) in case problems occur.

#### Check the status of the RDP listener

For this procedure, use a PowerShell instance that has administrative permissions. For a local computer, you can also use a command prompt that has administrative permissions. However, this procedure uses PowerShell because the same commands work both locally and remotely.

1. Open a PowerShell window. To connect to a remote computer, enter **Enter-PSSession -ComputerName \<computer name\>**.
2. Enter **qwinsta**. 
    ![The qwinsta command lists the processes listening on the computer’s ports.](..\media\troubleshoot-remote-desktop-connections\WPS_qwinsta.png)
3. If the list includes **rdp-tcp** with a status of **Listen**, the RDP listener is working. Proceed to [Check the RDP listener port](#check-the-rdp-listener-port). Otherwise, continue at step 4.
4. Export the RDP listener configuration from a working computer.
    1. Sign in to a computer that has the same operating system version as the affected computer has, and access that computer’s registry (for example, by using Registry Editor).
    2. Navigate to the following registry entry:  
        **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Terminal Server\\WinStations\\RDP-Tcp**
    3. Export the entry to a .reg file. For example, in Registry Editor, right-click the entry, select **Export**, and then enter a filename for the exported settings.
    4. Copy the exported .reg file to the affected computer.
5. To import the RDP listener configuration, open a PowerShell window that has administrative permissions on the affected computer (or open the PowerShell window and connect to the affected computer remotely).
   1. To back up the existing registry entry, enter the following command:  
   
      ```powershell  
      cmd /c 'reg export "HKLM\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-tcp" C:\Rdp-tcp-backup.reg'   
      ```  
   

   2. To remove the existing registry entry, enter the following commands:  
   
      ```powershell  
      Remove-Item -path 'HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-tcp' -Recurse -Force  
      ```
   
   3. To import the new registry entry and then restart the service, enter the following commands:  
   
      ```powershell  
      cmd /c 'regedit /s c:\<filename>.reg'  
      Restart-Service TermService -Force  
      ```   
      where \<filename\> is the name of the exported .reg file.
6. Test the configuration by trying the remote desktop connection again. If you still cannot connect, restart the affected computer.
7. If you still cannot connect, [check the status of the RDP self-signed certificate](#check-the-status-of-the-rdp-self-signed-certificate).

#### Check the status of the RDP self-signed certificate

1. If you still cannot connect, open the Certificates MMC snap-in. When you are prompted to select the certificate store to manage, select **Computer account**, and then select the affected computer.
2. In the **Certificates** folder under **Remote Desktop**, delete the RDP self-signed certificate. 
    ![Remote Desktop certificates in the MMC Certificates snap-in.](..\media\troubleshoot-remote-desktop-connections\MMCCert_Delete.png)
3. On the affected computer, restart the Remote Desktop Services service.
4. Refresh the Certificates snap-in.
5. If the RDP self-signed certificate has not been re-created, [check the permissions of the MachineKeys folder](#check-the-permissions-of-the-machinekeys-folder).

#### Check the permissions of the MachineKeys folder

1. On the affected computer, open Explorer, and then navigate to **C:\\ProgramData\\Microsoft\\Crypto\\RSA\\**.
2. Right-click **MachineKeys**, select **Properties**, select **Security**, and then select **Advanced**.
3. Make sure that the following permissions are configured:
      - Builtin\\Administrators: Full control
      - Everyone: Read, Write

### Check the RDP listener port

On both the local (client) computer and the remote (target) computer, the RDP listener should be listening on port 3389. No other applications should be using this port.

> [!IMPORTANT]  
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/en-us/help/322756%22%20target=%22_self%22) in case problems occur.

To check or change the RDP port, use Registry Editor:

1. Select Start, select **Run**, and then enter **regedt32**.
      - To connect to a remote computer, select **File**, and then select **Connect Network Registry**.
      - In the **Select Computer** dialog box, enter the name of the remote computer, select **Check Names**, and then select **OK**.
2. Open the registry and navigate to **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Terminal Server\\WinStations\\\<listener\>**. 
    ![The PortNumber subkey for the RDP protocol.](..\media\troubleshoot-remote-desktop-connections\RegEntry_PortNumber.png)
3. If **PortNumber** has a value other than **3389**, change it to **3389**. 
   > [!IMPORTANT]  
    > You can operate Remote Desktop services using another port. However, we do not recommend that you do this. Troubleshooting such a configuration is beyond the scope of this article.
4. After you change the port number, restart the Remote Desktop Services service.

#### Check that another application is not trying to use the same port

For this procedure, use a PowerShell instance that has administrative permissions. For a local computer, you can also use a command prompt that has administrative permissions. However, this procedure uses PowerShell because the same commands work locally and remotely.

1. Open a PowerShell window. To connect to a remote computer, enter **Enter-PSSession -ComputerName \<computer name\>**.
2. Enter the following command:  
   
     ```powershell  
    cmd /c 'netstat -ano | find "3389"'  
    ```
  
    ![The netstat command produces a list of ports and the services listening to them.](..\media\troubleshoot-remote-desktop-connections\WPS_netstat.png)
1. Look for an entry for TCP port 3389 (or the assigned RDP port) with a status of **Listening**. 
    > [!NOTE]  
   > The PID (Process Identifier) of the process or service using that port appears under the PID column.
1. To determine which application is using port 3389 (or the assigned RDP port), enter the following command:  
   
     ```powershell  
    cmd /c 'tasklist /svc | find "<pid listening on 3389>"'  
    ```  
  
    ![The tasklist command reports details of a specific process.](..\media\troubleshoot-remote-desktop-connections\WPS_tasklist.png)
1. Look for an entry for the PID number that is associated with the port (from the **netstat** output). The services or processes that are associated with that PID appear on the right.
1. If an application or service other than Remote Desktop Services (TermServ.exe) is using the port, you can resolve the conflict by using one of the following methods:
      - Configure the other application or service to use a different port (recommended).
      - Uninstall the other application or service.
      - Configure RDP to use a different port, and then restart the Remote Desktop Services service (not recommended).

#### Check whether a firewall is blocking the RDP port

Use the **psping** tool to test whether you can reach the affected computer by using port 3389.

1. On a computer that is different from the affected computer, download **psping** from <https://live.sysinternals.com/psping.exe>.
2. Open a Command Prompt window as an administrator, change to the directory in which you installed **psping**, and then enter the following command:  
   
   ```  
   psping -accepteula <computer IP>:3389  
   ```
   
3. Check the output of the **psping** command for results such as the following:  
      - **Connecting to \<computer IP\>**: The remote computer is reachable.
      - **(0% loss)**: All attempts to connect succeeded.
      - **The remote computer refused the network connection**: The remote computer is not reachable.
      - **(100% loss)**: All attempts to connect failed.
1. Run **psping** on multiple computers to test their ability to connect to the affected computer.
1. Note whether the affected computer blocks connections from all other computers, some other computers, or only one other computer.
1. Recommended next steps:
      - Engage your network administrators to verify that the network allows RDP traffic to the affected computer.
      - Investigate the configurations of any firewalls between the source computers and the affected computer (including Windows Firewall on the affected computer) to determine whether a firewall is blocking the RDP port.

## Client cannot connect, “Class not registered”

When you try to connect to a remote computer by using a client that is running Windows 10, version 1709 or later, the client may not connect while the Remote Desktop Session Host server reports a message that contains the "Class not registered (0x80040154)" error code.

This issue occurs if the user who is trying to connect has a mandatory user profile. To resolve this issue, install the [July 24, 2018—KB4338817 (OS Build 16299.579)](https://support.microsoft.com/en-us/help/4338817/windows-10-update-kb4338817) Windows 10 update.

## Client cannot connect, no licenses available

This situation applies to deployments that include an RDSH server and a Remote Desktop Licensing server.

Identify which kind of behavior users are seeing:

- The session was disconnected because no licenses are available or no license server is available
- Access was denied because of a security error

Sign in to the RD Session Host as a domain administrator, and open the RD License Diagnoser. Look for messages such as the following:

  - The grace period for the Remote desktop Session Host server has expired, but the RD Session Host server has not been configured with any license servers. connections to the RD Session Host server will be denied unless a license server is configured for the RD Session Host server.
  - License server \<computer name\> is not available. This could be caused by network connectivity problems, the Remote Desktop Licensing service is stopped on the license server, or RD Licensing is no longer installed on the computer.

These problems tend to be associated with the following user messages:

  - The remote session was disconnected because there are no Remote Desktop client access licenses available for this computer.
  - The remote session was disconnected because there are no Remote Desktop License Servers available to provide a license.

In this case, [configure the RD Licensing service](#configure-the-rd-licensing-service).

If the RD License Diagnoser lists other problems, such as “The RDP protocol component X.224 detected an error in the protocol stream and has disconnected the client,” there may be a problem that affects the license certificates. Such problems tend to be associated with user messages, such as the following:

Because of a security error, the client could not connect to the Terminal server. After making sure that you are logged on to the network, try connecting to the server again.

In this case, [refresh the X509 Certificate registry keys](#refresh-the-x509-certificate-registry-keys).

### Configure the RD Licensing service

The following procedure uses Server Manager to make the configuration changes. For information about how to configure and use Server Manager, see [Server Manager](https://docs.microsoft.com/en-us/windows-server/administration/server-manager/server-manager).

1. Open Server Manager, and then navigate to **Remote Desktop Services**.
2. On **Deployment Overview**, select **Tasks**, and then select **Edit Deployment Properties**.
3. Select **RD Licensing**, and then select the appropriate licensing mode for your deployment (**Per Device** or **Per User**).
4. Enter the fully qualified domain name (FQDN) of your RD License server, and then select **Add**.
5. If you have more than one RD License server, repeat step 4 for each server. 
    ![RD License server configuration options in Server Manager.](..\media\troubleshoot-remote-desktop-connections\RDLicensing_Configure.png)

### Refresh the X509 Certificate registry keys

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

## User cannot authenticate or must authenticate twice

There are several issues that can cause problems that affect user authentication. This section addresses the following cases:

  - [A user is denied access with a "restricted type of logon" message](#access-denied-restricted-type-of-logon)
  - [A user or application is denied access with event 16965, "A remote call to the SAM database has been denied"](#access-denied-a-remote-call-to-the-sam-database-has-been-denied)
  - [A user cannot sign in by using a smart card](#a-user-cannot-sign-in-by-using-a-smart-card)
  - [If the remote PC is locked, a user needs to enter a password twice](#if-the-remote-pc-is-locked-a-user-needs-to-enter-a-password-twice)
  - [A user cannot sign in and receives “authentication error” and “CredSSP encryption oracle remediation” messages](#user-cannot-sign-in-and-receives-authentication-error-and-credssp-encryption-oracle-remediation-messages)
  - [After you update client computers, some users need to sign in twice](#after-you-update-client-computers-some-users-need-to-sign-in-twice).
  - [Users are denied access on a deployment that uses RemoteGuard with multiple RD Connection Brokers](#users-are-denied-access-on-a-deployment-that-uses-remote-credential-guard-with-multiple-rd-connection-brokers)

### Access denied, restricted type of logon

In this situation, a Windows 10 user attempting to connect to Windows 10 or Windows Server 2016 computers is denied access with the following message:

> Remote Desktop Connection:  
> The system administrator has restricted the type of logon (network or interactive) that you may use. For assistance, contact your system administrator or technical support.

This issue occurs when Network Level Authentication (NLA) is required for RDP connections, and the user is not a member of the **Remote Desktop Users** group. It can also occur if the **Remote Desktop Users** group has not been assigned to the **Access this computer from the network** user right.

To remedy this issue, follow one of these steps:

  - [Modify the user’s group membership or user rights assignment](#modify-the-users-group-membership-or-user-rights-assignment).
  - Turn off NLA (not recommended).
  - Use remote desktop clients other than Windows 10. For example, Windows 7 clients do not have this issue.

#### Modify the user’s group membership or user rights assignment

If this issue affects a single user, the most straightforward solution to this issue is to add the user to the **Remote Desktop Users** group.

If the user is already a member of this group (or if multiple group members have the same problem), check the user rights configuration on the remote Windows 10 or Windows Server 2016 computer.

1. Open Group Policy Object Editor (GPE) and connect to the local policy of the remote computer.
2. Navigate to **Computer Configuration\\Windows Settings\\Security Settings\\Local Policies\\User Rights Assignment**, right-click **Access this computer from the network**, and then select **Properties**.
3. Check the list of users and groups for **Remote Desktop Users** (or a parent group).
4. If the list does not include **Remote Desktop Users** (or a parent group, such as **Everyone**) you need to add it to the list (if you have more than one or two computers in your deployment, use a group policy object).  
    For example, the default membership for **Access this computer from the network** includes **Everyone**. If your deployment uses a group policy object to remove **Everyone**, you may need to restore access by updating the group policy object to add **Remote Desktop Users**.

### Access denied, A remote call to the SAM database has been denied

This behavior is most likely to occur if your domain controllers are running Windows Server 2016 or later, and users attempt to connect by using a customized connection app. In particular, applications that access the user’s profile information in Active Directory will be denied access.

This behavior results from a change to Windows. In Windows Server 2012 R2 and earlier versions, when a user logs on to a remote desktop, Remote Connection Manager (RCM) contacts the domain controller (DC) to query the configurations that are specific to Remote Desktop on the user object in Active Directory Domain Services (AD DS). This information is displayed in the Remote Desktop Services Profile tab of a user’s object properties in the Active Directory Users and Computers MMC snap-in.

Starting in Windows Server 2016, RCM no longer queries the users object in AD DS. If you require RCM to query AD DS because you are using the Remote Desktop Services attributes, you must manually enable the previous RCM behavior.

> [!IMPORTANT]  
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/en-us/help/322756%22%20target=%22_self%22) in case problems occur.

To enable the legacy RCM behavior on a RD Session Host server, configure the following registry entries, and then restart the **Remote Desktop Services** service:  
  - **HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows NT\\Terminal Services**
  - **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Terminal Server\\WinStations\\\<Winstation name\>\\**  
      - Name: **fQueryUserConfigFromDC**
      - Type: **Reg\_DWORD**
      - Value: **1** (Decimal)

To enable the legacy RCM behavior on a server other than a RD Session Host server, configure these registry entries and the following additional registry entry (and then restart the service):
  - **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\Terminal Server**

For more information about this behavior, see KB 3200967 [Changes to Remote Connection Manager in Windows Server](https://support.microsoft.com/en-us/help/3200967/changes-to-remote-connection-manager-in-windows-server).

### A user cannot sign in by using a smart card

This article addresses three common circumstances in which a user cannot sign in to a remote desktop by using a smart card:  
  - [The user cannot sign in to a branch office that uses a read-only Domain Controller (RODC)](#cannot-sign-in-with-a-smart-card-in-a-branch-office-with-a-rodc)
  - [The user cannot sign in to a Windows Server 2008 SP2 computer that has recently been updated](#cannot-sign-in-with-a-smart-card-to-a-windows-server-2008-sp2-computer)
  - [The user cannot stay signed in to a Windows computer that has been recently updated, and the Remote Desktop Services service becomes unresponsive (hangs)](#cannot-stay-signed-in-with-a-smart-card-and-remote-desktop-services-service-hangs)

#### Cannot sign in with a smart card in a branch office with a RODC

This issue occurs in deployments that include an RDSH server at a branch site that uses a RODC. The RDSH server is hosted in the root domain. Users at the branch site belong to a child domain, and use smart cards for authentication. The RODC is configured to cache user passwords (the RODC belongs to the **Allowed RODC Password Replication Group**). When users try to sign in to sessions on the RDSH server, they receive messages such as "The attempted logon is invalid. This is either due to a bad username or authentication information."

This is a known issue in the way that the root DC and the RODC manage encryption of the user credentials. The root DC uses an encryption key to encrypts the credentials, and the RODC provides a decryption key to the client. However, the two keys do not match.

To work around this issue, consider changing your DC topology either by turning off password caching on the RODC or by deploying a writeable DC to the branch site. An alternative method is to move the RDSH server to the same child domain as the users. Another alternative is to allow users to sign in without smart cards. Any of these solutions may require compromises in performance or level of security.

#### Cannot sign in with a smart card to a Windows Server 2008 SP2 computer

This issue occurs when users sign in to a Windows Server 2008 SP2 computer that has been updated with KB4093227 (2018.4B). When users attempt to sign in using a smart card, they are denied access with messages such as “No valid certificates found. Check that the card is inserted correctly and fits tightly.” At the same time, the Windows Server computer records the Application event "An error occurred while retrieving a digital certificate from the inserted smart card. Invalid Signature."

To resolve this issue, update the Windows Server computer with the 2018.06 B re-release of KB 4093227, [Description of the security update for the Windows Remote Desktop Protocol (RDP) denial of service vulnerability in Windows Server 2008: April 10, 2018](https://support.microsoft.com/en-us/help/4093227/security-update-for-vulnerabilities-in-windows-server-2008).

#### Cannot stay signed in with a smart card and Remote Desktop Services service hangs

This issue occurs when users sign in to a Windows or Windows Server computer that has been updated with KB 4056446. At first, the user may be able to sign in to the system by using a smart card, but then receives a “SCARD\_E\_NO\_SERVICE” error message. The remote computer may become unresponsive.

To work around this issue, restart the remote computer.

To resolve this issue, update the remote computer with the appropriate fix:

  - Windows Server 2008 SP2: KB 4090928, [Windows leaks handles in the lsm.exe process and smart card applications may display "SCARD\_E\_NO\_SERVICE" errors](https://support.microsoft.com/en-us/help/4090928/scard-e-no-service-errors-when-windows-leaks-handles-in-the-lsm-exe)
  - Windows Server 2012 R2: KB 4103724, [May 17, 2018—KB4103724 (Preview of Monthly Rollup)](https://support.microsoft.com/en-us/help/4103724/windows-81-update-kb4103724)
  - Windows Server 2016 and Windows 10, version 1607: KB 4103720, [May 17, 2018—KB4103720 (OS Build 14393.2273)](https://support.microsoft.com/en-us/help/4103720/windows-10-update-kb4103720)

### If the remote PC is locked, a user needs to enter a password twice

This issue may occur when a user attempts to connect to a remote desktop that is running Windows 10 version 1709 in a deployment in which RDP connections do not require NLA. Under these conditions, if the remote desktop has been locked, the user needs to enter their credential twice when connecting.

To resolve this issue, update the Windows 10 version 1709 computer with KB 4343893, [August 30, 2018—KB4343893 (OS Build 16299.637)](https://support.microsoft.com/en-us/help/4343893/windows-10-update-kb4343893).

### User cannot sign in and receives “authentication error” and “CredSSP encryption oracle remediation” messages

When users try to sign in using any version of Windows from Windows Vista SP2 and later versions or Windows Server 2008 SP2 and later versions, they are denied access and receive messages such as the following:

  - An authentication error has occurred. The function requested is not supported.
  - This could be due to CredSSP encryption oracle remediation

“CredSSP encryption oracle remediation” refers to a set of security updates released in March, April, and May of 2018. CredSSP is an authentication provider that processes authentication requests for other applications. The March 13, 2018, "3B" and subsequent updates addressed an exploit in which an attacker could relay user credentials to execute code on the target system.

The initial updates added support for a new Group Policy Object, **Encryption Oracle Remediation**, that has the following possible settings:

  - **Vulnerable**. Client applications that use CredSSP can fall back to insecure versions, but this behavior exposes the remote desktops to attacks. Services that use CredSSP accept clients that have not been updated.
  - **Mitigated**. Client applications that use CredSSP cannot fall back to insecure versions, but services that use CredSSP accept clients that have not been updated.
  - **Force Updated Clients**. Client applications that use CredSSP cannot fall back to insecure versions, and services that use CredSSP will not accept unpatched clients. 
    Note: This setting should not be deployed until all remote hosts support the newest version.

The May 8, 2018, update changed the default **Encryption Oracle Remediation** setting from **Vulnerable** to **Mitigated**. With this change in place, remote desktop clients that have the updates cannot connect to servers that do not have them (or updated servers that have not been restarted). For more information about the effects of the updates and the types of communication that they block, see KB 4093492, [CredSSP updates for CVE-2018-0886](https://support.microsoft.com/en-us/help/4093492/credssp-updates-for-cve-2018-0886-march-13-2018).

To resolve this issue, ensure that all systems are fully updated and restarted. For a full list of updates and more information about the vulnerabilities, see [CVE-2018-0886 | CredSSP Remote Code Execution Vulnerability](https://portal.msrc.microsoft.com/en-us/security-guidance/advisory/CVE-2018-0886).

To work around this issue until the updates are complete, check KB 4093492 for allowed types of connections. If there are no feasible alternatives you may consider one of the following methods:

  - For the affected client computers, set the **Encryption Oracle Remediation** policy back to **Vulnerable**.
  - Modify the following policies in the **Computer Configuration\\Administrative Templates\\Windows Components\\Remote Desktop Services\\Remote Desktop Session Host\\Security** group policy folder:  
      - **Require use of specific security layer for remote (RDP) connections**: set to **Enabled** and select **RDP**.
      - **Require user authentication for remote connections by using Network Level authentication**: set to **Disabled**.
      > [!IMPORTANT]  
      > These modifications reduce the security of your deployment. They should only be temporary, if you use them at all.

For more information about working with group policy, see [Modifying a blocking GPO](#modifying-a-blocking-gpo).

### After you update client computers, some users need to sign in twice

Users on some Windows 7 or Windows 10 version 1709 sign in to a remote desktop session, and immediately see a second sign-in screen. This issue occurs if the client computers have received the following updates:

  - Windows 7: KB 4103718, [May 8, 2018—KB4103718 (Monthly Rollup)](https://support.microsoft.com/en-us/help/4103718/windows-7-update-kb4103718)
  - Windows 10 1709: KB 4103727, [May 8, 2018—KB4103727 (OS Build 16299.431)](https://support.microsoft.com/en-us/help/4103727/windows-10-update-kb4103727)

To resolve this issue, ensure that the computers that the users want to connect to (as well as RDSH or RDVI servers) are fully updated through June, 2018. This includes the following updates:

  - Windows Server 2016: KB 4284880, [June 12, 2018—KB4284880 (OS Build 14393.2312)](https://support.microsoft.com/en-us/help/4284880/windows-10-update-kb4284880)
  - Windows Server 2012 R2: KB 4284815, [June 12, 2018—KB4284815 (Monthly Rollup)](https://support.microsoft.com/en-us/help/4284815/windows-81-update-kb4284815)
  - Windows Server 2012: KB 4284855, [June 12, 2018—KB4284855 (Monthly Rollup)](https://support.microsoft.com/en-us/help/4284855/windows-server-2012-update-kb4284855)
  - Windows Server 2008 R2: KB 4284826, [June 12, 2018—KB4284826 (Monthly Rollup)](https://support.microsoft.com/en-us/help/4284826/windows-7-update-kb4284826)
  - Windows Server 2008 SP2: KB4056564, [Description of the security update for the CredSSP remote code execution vulnerability in Windows Server 2008, Windows Embedded POSReady 2009, and Windows Embedded Standard 2009: March 13, 2018](https://support.microsoft.com/en-us/help/4056564/security-update-for-vulnerabilities-in-windows-server-2008)

### Users are denied access on a deployment that uses Remote Credential Guard with multiple RD Connection Brokers

This issue occurs in high-availability deployments that use two or more Remote Desktop Connection Brokers, if Windows Defender Remote Credential Guard is in use. Users cannot sign in to remote desktops.

This issue occurs because Remote Credential Guard uses Kerberos for authentication, and restricts NTLM. However, in a high-availability configuration with load balancing, the RD Connection Brokers cannot support Kerberos operations.

If you need to use a high-availability configuration with load-balanced RD Connection Brokers, you can work around this issue by disabling Remote Credential Guard. For more information about how to manage Windows Defender Remote Credential Guard, see [Protect Remote Desktop credentials with Windows Defender Remote Credential Guard](https://docs.microsoft.com/en-us/windows/security/identity-protection/remote-credential-guard#enable-windows-defender-remote-credential-guard).

## On connecting, user receives "Remote Desktop Service is currently busy" message

To determine an appropriate response to this issue, use the following steps:

1. Does the Remote Desktop Services service becomes unresponsive (for example, the remote desktop client appears to “hang” at the Welcome screen).  
      - If the service becomes unresponsive, see [RDSH server memory issue](#rdsh-server-memory-issue).
      - If the client appears to be interacting with the service normally, continue to the next step.
2. If one or more users disconnect their remote desktop sessions, can users connect again?  
   - If the service continues to deny connections no matter how many users disconnect their sessions, see [RD listener issue](#rd-listener-issue).
   - If the service begins accepting connections again after a number of users have disconnected their sessions, [check the connection limit policy](#check-the-connection-limit-policy).

### RDSH server memory issue

A memory leak has been found on some Windows Server 2012 R2 RDSH servers. Over time, these servers begin to refuse both remote desktop connections and local console sign-ins with messages such as the following:

> The task you are trying to do can't be completed because Remote Desktop Service is currently busy. Please try again in a few minutes. Other users should still be able to sign in.

Remote desktop clients attempting to connect also become unresponsive.

To work around this issue, restart the RDSH server.

To resolve this issue, apply KB 4093114, [April 10, 2018—KB4093114 (Monthly Rollup)](file:///C:\\Users\\v-jesits\\AppData\\Local\\Microsoft\\Windows\\INetCache\\Content.Outlook\\FUB8OO45\\April%2010,%202018—KB4093114%20\(Monthly%20Rollup\)), to the RDSH servers.

### RD listener issue

An issue has been noted on some RDSH servers that have been upgraded directly from Windows Server 2008 R2 to Windows Server 2012 R2 or Windows Server 2016. When a remote desktop client connects to the RDSH server, the RDSH server creates an RD listener for the user session. The affected servers keep a count of the RD listeners that increases as users connect, but never decreases.

To work around this issue, you can use the following methods:

  - Restart the RDSH server to reset the count of RD listeners
  - Modify the connection limit policy, setting it to a very large value. For more information about managing the connection limit policy, see [Check the connection limit policy](#check-the-connection-limit-policy).

To resolve this issue, apply the following updates to the RDSH servers:

  - Windows Server 2012 R2: KB 4343891​, [August 30, 2018—KB4343891 (Preview of Monthly Rollup)](https://support.microsoft.com/en-us/help/4343891/windows-81-update-kb4343891)
  - Windows Server 2016: KB 4343884, [August 30, 2018—KB4343884 (OS Build 14393.2457)](https://support.microsoft.com/en-us/help/4343884/windows-10-update-kb4343884)

### Check the connection limit policy

You can set the limit on the number of simultaneous remote desktop connections at the individual computer level or by configuring a group policy object (GPO). By default, the limit is not set.

To check the current settings and identify any existing GPOs on the RDSH server, open a command prompt window as an administrator and enter the following command:
  
```
gpresult /H c:\gpresult.html
```
   
After this command finishes, open gpresult.html, and in **Computer Configuration\\Administrative Templates\\Windows Components\\Remote Desktop Services\\Remote Desktop Session Host\\Connections**, find the **Limit number of connections** policy.

  - If the setting for this policy is **Disabled**, then group policy is not limiting RDP connections.
  - If the setting for this policy is **Enabled**, then check **Winning GPO**. If you need to remove or change the connection limit, edit this GPO.

To enforce policy changes, open a command prompt window on the affected computer, and enter the following command:
  
```
gpupdate /force
```
  
## RD client disconnects and cannot reconnect to the same session

After remote desktop client loses its connection to the remote desktop, the client cannot immediately reconnect. The user receives error messages such as the following:

  - Because of a security error, the client could not connect to the Terminal server. After making sure that you are logged on to the network, try connecting to the server again.
  - Remote desktop disconnected. Because of a security error, the client could not connect to the remote computer. Verify that you are logged onto the network and then try connecting again.

At a later time, the remote desktop client reconnects to the remote desktop. However, instead of connecting the client to the original session, the RDSH server connects the client to a new session. Checking the RDSH server reveals that the original session did not enter a disconnected state, but instead remains active.

To work around this issue, you can enable the **Configure keep-alive connection interval** policy in the **Computer Configuration\\Administrative Templates\\Windows Components\\Remote Desktop Services\\Remote Desktop Session Host\\Connections** group policy folder. If you enable this policy, you must enter a keep-alive interval. The keep-alive interval determines how often, in minutes, the server checks the session state.

This issue can be caused by misconfiguration of your authentication and configuration settings. You can configure these settings at the server level, or by using GPOs. The group policy settings are available in the **Computer Configuration\\Administrative Templates\\Windows Components\\Remote Desktop Services\\Remote Desktop Session Host\\Security** group policy folder.

1. On the RD Session Host server, open Remote Desktop Session Host Configuration.
2. Under **Connections**, right-click the name of the connection, and then click **Properties**.
3. In the **Properties** dialog box for the connection, on the **General** tab, in **Security** layer, select a security method.
4. In **Encryption level**, click the level that you want. You can select **Low**, **Client Compatible**, **High**, or **FIPS Compliant**.

> [!NOTE]  
>  - When communications between clients and RD Session Host servers require the highest level of encryption, use FIPS Compliant encryption.
>  - Any encryption level settings that you configure in Group Policy override the configuration that you set by using the Remote Desktop Services Configuration tool. Also, if you enable the [System cryptography: Use FIPS compliant algorithms for encryption, hashing, and signing](https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2003/cc780081\(v=ws.10\)) policy, this setting overrides the **Set client connection encryption level** policy. The system cryptography policy is in the **Computer Configuration\\Windows Settings\\Security Settings\\Local Policies\\Security Options** folder.
>  - When you change the encryption level, the new encryption level takes effect the next time a user logs on. If you require multiple levels of encryption on one server, install multiple network adapters and configure each adapter separately.
>  - To verify that certificate has a corresponding private key, in Remote Desktop Services Configuration, right-click the connection for which you want to view the certificate, select **General**, select **Edit**, select the certificate that you want to view, and then select **View Certificate**. At the bottom of the **General** tab, the statement, "You have a private key that corresponds to this certificate" should appear. You can also view this information by using the Certificates snap-in.
>  - FIPS-compliant encryption (the **System cryptography: Use FIPS compliant algorithms for encryption, hashing, and signing** policy or the **FIPS Compliant** setting in Remote Desktop Server Configuration) encrypts and decrypts data sent from the client to the server and from the server to the client, with the Federal Information Processing Standard (FIPS) 140-1 encryption algorithms, using Microsoft cryptographic modules. For more information, see [FIPS 140 Validation](https://docs.microsoft.com/en-us/windows/security/threat-protection/fips-140-validation).
>  - The **High** setting encrypts data sent from the client to the server and from the server to the client by using strong 128-bit encryption.
>  - The **Client Compatible** setting encrypts data sent between the client and the server at the maximum key strength supported by the client.
>  - The **Low** setting encrypts data sent from the client to the server using 56-bit encryption.

## Remote laptop disconnects from wireless network

This issue may occur when a remote desktop client connects to a laptop computer by using an 802.1x wireless network. Intermittently, the laptop disconnects from the wireless network and does not automatically reconnect.

This is a known issue that occurs when the network authentication setting for the wireless network connection is **User authentication**.

To work around this issue, set the network authentication setting to **User or computer authentication** or **Computer authentication**.

 > [!NOTE]  
> To change the network authentication settings on a single computer, you may need to use the Network and Sharing Center control panel to create a new wireless connection with the new settings.

For a full description of how to configure wireless network settings using GPOs, see [Configure Wireless Network (IEEE 802.11) Policies](https://docs.microsoft.com/en-us/windows-server/networking/core-network-guide/cncg/wireless/e-wireless-access-deployment#bkmk_policies).

## User experiences poor performance or application problems

This section addresses several common issues that users may experience when they use remote desktop functionality:

  - [Users who connect to new virtual machines Microsoft Azure intermittently experience problems](#intermittent-problems-with-new-microsoft-azure-virtual-machines).
  - [Users who connect to Windows 10 version 1709 remote desktops may have problems playing video](#video-playback-issues-on-windows-10-version-1709).
  - [Users with read-only user profiles who connect to Windows 10 remote desktops cannot share their desktops.](#desktop-sharing-issues-on-windows-10)
  - [Users connecting to Windows 10 remote desktops using clients that run on older versions of Windows 10 experience poor performance when NLA is disabled](#performance-issues-when-mixing-versions-of-windows-10-if-nla-is-disabled)
  - [When users run multiple applications in remote desktop sessions and disconnect and reconnect frequently, they may encounter a black screen on reconnecting.](#black-screen-issue)

### Intermittent problems with new Microsoft Azure virtual machines

This issue affects virtual machines that have been recently provisioned. After the user connects to the virtual machine, the remote desktop session may not load all the user’s settings correctly.

To work around this issue, disconnect from the virtual machine, wait for at least 20 minutes, and then connect again.

To resolve this issue, apply the following updates to the virtual machines, as appropriate:

  - Windows 10 and Windows Server 2016: KB 4343884​, [August 30, 2018—KB4343884 (OS Build 14393.2457)](https://support.microsoft.com/en-us/help/4343884/windows-10-update-kb4343884)
  - Windows Server 2012 R2: KB 4343891​​, [August 30, 2018—KB4343891 (Preview of Monthly Rollup)](https://support.microsoft.com/en-us/help/4343891/windows-81-update-kb4343891)

### Video playback issues on Windows 10 version 1709

This issue occurs when users connect to remote computers that are running Windows 10, version 1709. When these users play video using the VMR9 (Video Mixing Renderer 9) codec, the player shows only a black window.

This is a known issue in Windows 10, version 1709. The issue does not occur in Windows 10 version 1703.

### Desktop sharing issues on Windows 10

This issue occurs when the user has a read-only user profile (and associated registry hive), such as in a kiosk scenario. When such a user connects to a remote computer that is running Windows 10, version 1803, they cannot share their desktop.

To fix this issue, apply the Windows 10 update 4340917​, [July 24, 2018—KB4340917 (OS Build 17134.191)](https://support.microsoft.com/en-us/help/4340917/windows-10-update-kb4340917).

### Performance issues when mixing versions of Windows 10 if NLA is disabled

This issue occurs when NLA is disabled, and remote desktop client computers that run Windows 10 connect to remote desktops that run different versions of Windows 10. Users of remote desktop clients on computers that run Windows 10, version 1709 or earlier versions experience poor performance when they connect to remote desktops that run Windows 10, version 1803 or a later version.

This occurs because, when NLA is disabled, the older client computers use a slower protocol when they connect to Windows 10, version 1803 or a later version.

To resolve this issue, apply KB 4340917​, [July 24, 2018—KB4340917 (OS Build 17134.191)](https://support.microsoft.com/en-us/help/4340917/windows-10-update-kb4340917).

### Black screen issue

This issue occurs in Windows 8.0, Windows 8.1, Windows 10 RTM, and Windows Server 2012 R2. A user launches multiple applications in a remote desktop, then disconnects from the session. Periodically, the user reconnects to the remote desktop to interact with the applications, and then disconnect again. At some point, when the user reconnects, the remote desktop session just shows a black screen. The user must end the remote desktop session from the remote computer’s console (or the RDSH server console). This action stops the applications.

To resolve this issue, apply the following updates as appropriate:

  - Windows 8 and Windows Server 2012: KB4103719, [May 17, 2018—KB4103719 (Preview of Monthly Rollup)](https://support.microsoft.com/en-us/help/4103719/windows-server-2012-update-kb4103719)
  - Windows 8.1 and Windows Server 2012 R2: KB4103724, [May 17, 2018—KB4103724 (Preview of Monthly Rollup)](https://support.microsoft.com/en-us/help/4103724/windows-81-update-kb4103724) and KB ​4284863, [June 21, 2018—KB4284863 (Preview of Monthly Rollup)](https://support.microsoft.com/en-us/help/4284863/windows-81-update-kb4284863)
  - Windows 10: Fixed in KB4284860, [June 12, 2018—KB4284860 (OS Build 10240.17889)](https://support.microsoft.com/en-us/help/4284860/windows-10-update-kb4284860)
