---
title: Migrate a Certification Authority in Windows Server
description: Learn how to migrate your Certification Authority with step-by-step instructions and best practices.
ms.topic: how-to
ms.author: daknappe
author: dknappettmsft
ms.date: 04/22/2025
#customer intent: As a system administrator, I want to migrate the Certification Authority so that I can ensure continuity of certificate services.
---

# Migrate a Certification Authority

Migrating a Certification Authority (CA) ensures the continuity of your organization's certificate services. This guide provides step-by-step instructions and best practices for successfully migrating a CA. It covers essential tasks such as backing up the CA database and private key, removing the CA role service from the source server, and restoring the CA on the destination server. Whether you're using the Certification Authority snap-in, Windows PowerShell, or command-line tools like Certutil, this guide offers detailed steps tailored to various migration scenarios. Follow these instructions to ensure a smooth and secure migration process.

## Prerequisites

Before migrating your Certification Authority (CA), ensure the following prerequisites are met.

You must have:

- Administrative access for both the source and destination servers. For enterprise CAs, ensure you're a member of the Enterprise Admins or Domain Admins group.
- Access to tools such as the Certification Authority snap-in, PowerShell, or Certutil for performing backups and restores.
- A secure and accessible location to store backup files. Ensure the location is protected against unauthorized access.
- Network connectivity between the source and destination servers.
- For Failover Clustering:
  - Shared storage configured and accessible.
  - Cluster nodes that are properly set up and permissions are granted.

By completing these prerequisites, you can ensure a smooth and secure migration of your Certification Authority.

## Perform backups

Before you begin to migrate your CA, you'll first want to back up the:

- CA database
- Private key(s)
- CA registry settings
- CAPolicy.inf file
- The CA templates list (required only for enterprise CAs)

Before proceeding with CA Role removal you should also publish a CRL with an extended validity period.

### Back up a CA database and private key

You can back up the CA database and private key by using the Certification Authority snap-in, PowerShell, or by using Certutil. Complete one of the backup procedures described in this section while logged on to the source CA.

You must use an account that is a CA administrator. On an enterprise CA, the default configuration for CA administrators includes the local Administrators group, the Enterprise Admins group, and the Domain Admins group. On a standalone CA, the default configuration for CA administrators includes the local Administrators group.

> [!NOTE]
> If a hardware security module (HSM) is used by the CA, back up the private keys by following procedures provided by the HSM vendor.

After completing backup steps, the Active Directory Certificate Services service (Certsvc) should be stopped to prevent issuance of more certificates. Before adding the CA role service to the destination server, the CA role service should be removed from the source server.

The backup files created during these procedures should be stored in the same location to simplify the migration. The location should be accessible from the destination server.

# [Server Manager](#tab/server-manager)

The following steps describe how to back up the CA database and private key by starting in Server Manager, and using the Certification Authority snap-in.

1. Choose a backup location and attach media, if necessary.

1. Log on to the source CA.

1. From Server Manager, select **Tools**, then **Certification Authority** to open the snap-in.

1. Right-click the node with the CA name, point to **All Tasks**, and then select **Back Up CA**.

1. On the **Welcome** page of the CA Backup wizard, select **Next**.

1. On the **Items to Back Up** page, select the **Private key and CA certificate** and **Certificate database and certificate database log** check boxes, specify the backup location, and then select **Next**.

1. On the **Select a Password** page, type a password to protect the CA private key, and select **Next**.

1. On the **Completing the Backup Wizard** page, select **Finish**.

1. After the backup completes, verify the following files in the location you specified:

      - *CAName*.p12 containing the CA certificate and private key

      - Database folder containing files certbkxp.dat, edb\#\#\#\#\#.log, and *CAName*.edb

1. Open a Command Prompt window, and type **net stop certsvc** to stop the Active Directory Certificate Services service.

1. Copy all backup files to a location that is accessible from the destination server; for example, a network share or removable media.

# [PowerShell](#tab/powershell)

The following steps describe how to back up the CA database and private key by using the [Backup-CARoleService](/powershell/module/adcsadministration/backup-caroleservice) cmdlet while logged on to the source CA.

1. Log on with local administrative credentials to the CA computer.

1. Right- **Windows PowerShell** and select **Run as Administrator**.

1. Type the following command and press ENTER:

    ```powershell
    Backup-CARoleService –Path "BackupDirectoryPath"
    ```

1. The service must be stopped to prevent issuance of more certificates. Type the following command and press ENTER:

    ```powershell
    Stop-Service -Name "certsvc"
    ```

1. After the backup completes, verify the following files in the location you specified:

      - *CAName*.p12 containing the CA certificate and private key

      - Database folder containing files certbkxp.dat, edb\#\#\#\#\#.log, and *CAName*.edb

1. Copy all backup files to a location that is accessible from the destination server. For example, a network share, or removable media.

# [Certutil](#tab/certutil)

The following procedure describes the steps to back up the CA database and private key by using [Certutil.exe](/windows-server/administration/windows-commands/certutil) while logged on to the source CA. Certutil.exe is a command-line program installed as part of Certificate Services. You can use certutil.exe to display certification authority (CA) configuration information, configure Certificate Services, and back up and restore CA components.

1. Log on with local administrative credentials to the CA computer.

1. Open a Command Prompt window.

1. Type: `certutil –backupdb BackupDirectory` and press ENTER.

1. Type `certutil –backupkey BackupDirectory` and press ENTER.

1. Type a password at the prompt, and press ENTER. You must retain a copy of the password to access the key during CA installation on the destination server.

1. Type: `net stop certsvc` and press ENTER to stop the Active Directory Certificate Services service. The service must be stopped to prevent issuance of more certificates.

1. After the backup completes, verify the following files in the location you specified:

      - *CAName*.p12 containing the CA certificate and private key

      - Database folder containing files certbkxp.dat, edb\#\#\#\#\#.log, and *CAName*.edb

1. Copy all backup files to a location that is accessible from the destination server; for example, a network share or removable media.

---

### Back up CA registry settings

Complete one of the following procedures to back up the CA registry settings.

The files created during the backup procedure should be stored in the same location as the database and private key backup files to simplify the migration. The location should be accessible from the destination server; for example, removable media or a shared folder on the destination server or another domain member.

You must be logged on to the source CA using an account that is a member of the local Administrators group.

#### Back up CA registry settings by using Regedit.exe

1. Select **Start**, point to **Run**, and type **regedit** to open the Registry Editor.

1. In **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\CertSvc**, right-click **Configuration**, and then select **Export**.

1. Specify a location and file name, and then select **Save**. This creates a registry file containing CA configuration data from the source CA.

1. Copy the registry file to a location that is accessible from the destination server; for example, a shared folder or removable media.

### Back up CA registry settings by using Reg.exe

1. Open a Command Prompt window.

1. Type **reg export HKLM\\SYSTEM\\CurrentControlSet\\Services\\CertSvc\\Configuration** *\<output file\>*.reg and press ENTER.

1. Copy the registry file to a location that is accessible from the destination server; for example, a shared folder or removable media.

### Back up CAPolicy.inf

If your source CA is using a custom CAPolicy.inf file, you should copy the file to the same location as the source CA backup files.

The CAPolicy.inf file is located in the %SystemRoot% directory, which is usually **C:\\Windows**.

### Back up a CA templates list

An enterprise CA can have certificate templates assigned to it. You should record the assigned certificate templates before beginning the CA migration. The information isn't backed up with the CA database, or registry settings backup.
This is because certificate templates and their association with enterprise CAs are stored in AD DS. You'll need to add the same list of templates to the destination server to complete CA migration.

> [!NOTE]
> It's important that the certificate templates assigned to the source CA aren't changed after this procedure is completed.

You can determine the certificate templates assigned to a CA by using the Certification Authority snap-in or the **Certutil.exe –catemplates** command.

#### Record a CA templates list by using the Certification Authority snap-in

1. Log on with local administrative credentials to the CA computer.

1. Open the Certification Authority snap-in.

1. In the console tree, expand **Certification Authority**, and select **Certificate Templates**.

1. Record the list of certificate templates by taking a screenshot, or by typing the list into a text file.

#### Record a CA templates list by using Certutil.exe

1. Log on with local administrative credentials to the CA computer.

1. Open a Command Prompt window.

1. Type the following command and press ENTER.

    ```
    certutil.exe –catemplates > catemplates.txt
    ```
1. Verify that the catemplates.txt file contains the templates list.

> [!NOTE]
> If no certificate templates are assigned to the CA, the file contains an error message: 0x80070490 (Element not found).

### Publish a CRL with an extended validity period

Before beginning CA migration, it's a good practice to publish a CRL with a validity period that extends beyond the planned migration period. The validity period of the CRL should be at least the length of time that is planned for the migration. This is necessary to enable certificate validation processes on client computers to continue during the migration period.

You should publish a CRL with an extended validity period for each CA being migrated. This procedure is particularly important for a root CA because of the potentially large number of certificates that would be affected by the unavailability of a CRL.

By default, the CRL validity period is equal to the CRL publishing period plus 10 percent. After determining an appropriate CRL validity period, set the CRL publishing interval and manually publish the CRL by completing the following procedures: [Schedule the publication of the certificate revocation list](https://technet.microsoft.com/library/cc781735(ws.10).aspx), and [Manually publish the certificate revocation list](https://technet.microsoft.com/library/cc778151(ws.10).aspx).

> [!IMPORTANT]
> Record the value of the CRL publishing period before changing it. After migration is complete, the CRL publishing period should be reset to its previous value.
> Client computers download a new CRL only after the validity period of a locally cached CRL expires. Therefore, you shouldn't use a CRL validity period that is excessively long.

## Remove the CA role service from the source server

It's important to remove the CA role service from the source server after completing backup procedures and before installing the CA role service on the destination server. Enterprise CAs and standalone CAs that are domain members store in Active Directory Domain Services (AD DS) configuration data that is associated with the common name of the CA. Removing the CA role service also removes the CAs configuration data from AD DS. Because the source CA and destination CA share the same common name, removing the CA role service from the source server after installing the CA role service on the destination server removes configuration data that is required by destination CA and interferes with its operation.

The CA database, private key, and certificate aren't removed from the source server by removing the CA role service. Therefore, reinstalling the CA role service on the source server restores the source CA if migration fails and performing a rollback is required.

> [!WARNING]
> Although it isn't recommended, some administrators may choose to leave the CA role service installed on the source server to enable the source CA to be brought online quickly if migration fails. If you choose not to remove the CA role service from the source server before installing the CA role service on the destination server, it's important that you disable the Active Directory Certificate Services service (Certsvc) and shut down the source server before installing the CA role service on the destination server. Don't remove the CA role service from the source server after completing the migration to the destination server.

To remove the CA role service, use the **Remove Roles and Features** Wizard in Server Manager.

1. From Server Manager, select **Manage**, then **Remove Roles and Features**.
1. Select **Next** in the wizard until you come to Server Roles.
1. On Server Roles, under Active Directory Certificate Services, clear the check box for Certification Authority.
1. Confirm that you also want to remove features that require Certification Authority.
1. Select **Next** until you come to the Confirmation page. Then select **Remove**.
1. Confirm the role was successfully removed.

## Remove the source server from the domain

Because computer names must be unique within an Active Directory domain, it's necessary to remove the source server from its domain and delete the associated computer account from Active Directory before joining the destination server to the domain.

Complete the following procedure to remove the source server from the domain.

### Remove the source server from the domain by using PowerShell

Use the Windows PowerShell cmdlet [Remove-ADComputer](/powershell/module/activedirectory/remove-adcomputer) to remove the computer account from AD DS.

To remove a specific computer from Active Directory, use the following command:

```powershell
Remove-ADComputer -Identity "COMPUTER_IDENTITY"
```

The `-Identity` parameter is used to specify an Active Directory computer object by providing one of the following property values: distinguished name, GA GUID (objectGUID), security identifier (objectSid), or Security Accounts Manager account name (sAMAccountName).

## Join the destination server to the domain

Before joining the destination server to the domain, change the computer name to the same name as the source server. Then complete the procedure to join the destination server to the domain.

If your destination server is running on the Server Core installation option, you must use the command-line procedure.

To rename the destination server, you must be a member of the local Administrators group. To join the server to the domain, you must be a member of the Domain Admins or Enterprise Admins groups, or have delegated permissions to join the destination server to an organizational unit (OU) in the domain.

> [!IMPORTANT]
> If you're migrating a standalone CA that isn't a domain member, complete only the steps to rename the destination server and don't join the destination server to the domain.

### Join the destination server to the domain by using PowerShell

1. On the destination server, open an elevated PowerShell window.

1. Use the cmdlet [Rename-Computer](/powershell/module/microsoft.powershell.management/rename-computer) by typing:

    ```powershell
    Rename-Computer -NewName "NEW_COMPUTER_NAME" -DomainCredential Domain01\Admin01 -Restart
    ```

1. After the destination server restarts, log on by using an account that has permission to join computers to the domain.

1. Open an elevated PowerShell window, and use the cmdlet [Add-Computer](/powershell/module/microsoft.powershell.management/add-computer) to add a computer to a domain.

    ```powershell
    Add-Computer -DomainName Domain01 -Restart
    ```

## Add the CA role service to the destination server

This section describes two different procedures for adding the CA role service to the destination server, including special instructions for using failover clustering.

Review the following statements to determine which procedures to complete.

- If your destination server is running the Server Core installation option, you can use Windows PowerShell to install the CA using the cmdlet [Install-AdcsCertificationAuthority](/powershell/module/adcsdeployment/install-adcscertificationauthority).

- If you're migrating to a CA that uses an HSM, complete the procedures [Import the CA certificate](#import-the-ca-certificate) and [Add the CA role service](#add-the-ca-role-service).

- If you're migrating to a CA that uses failover clustering, the procedures to [Import the CA certificate](#import-the-ca-certificate) and [Add the CA role service](#add-the-ca-role-service) must be completed on each cluster node. After the CA role service is added to each node, stop the Active Directory Certificate Services service (Certsvc). Also confirm that:
  - The shared storage used by the CA is online and assigned to the node you're adding the CA role service to.
  - The CA database and log files must be located on shared storage.

### Import the CA certificate

If you're adding the CA role service by using Server Manager, complete the following procedure to import the CA certificate.

#### Import the CA certificate

1. Start the Certificates snap-in for the local computer account.

1. In the console tree, double-click **Certificates (Local Computer)**, and select **Personal**.

1. On the **Action** menu, select **All Tasks**, and then select **Import...** to open the Certificate Import Wizard. Select **Next**.

1. Locate the *\<CAName\>*.p12 file created by the CA certificate and private key backup on the source CA, and select **Open**.

1. Type the password, and select **OK**.

1. Select **Place all certificates in the following store**.

1. Verify **Personal** is displayed in **Certificate store**. If it isn't, select **Browse**, select **Personal**, select **OK**.

    > [!NOTE]
    > If you're using a network HSM, complete steps 8 through 10 to repair the association between the imported CA certificate and the private key that is stored in the HSM. Otherwise, select Finish to complete the wizard and select OK to confirm that the certificate was imported successfully.

1. In the console tree, double-click **Personal Certificates**, and select the imported CA certificate.

1. On the **Action** menu, select **Open**. Select the **Details** tab, copy the serial number to the Clipboard, and then select **OK**.

1. Open a Command Prompt window, type **certutil –repairstore My** **"{Serialnumber}"** and then press ENTER.

### Add the CA role service

If your destination server is a domain member, you must use an account that is a member of the Domain Admins or Enterprise Admins group in order for the installation wizard to access objects in AD DS. Add the CA role service either by using Server Manager or PowerShell.

> [!IMPORTANT]
> If you made a backup CAPolicy.inf file from the source CA, review the settings and make adjustments, if necessary. Copy the CAPolicy.inf file to the %windir% folder (C:\Windows by default) of the destination CA before adding the CA role service.

To add the CA role service by using Server Manager, follow these steps.

1. Log on to the destination server, and start Server Manager.

2. In the console tree, select **Roles**.

3. On the **Action** menu, select **Add Roles**.

4. If the **Before you Begin** page appears, select **Next**.

5. On the **Select Server Roles** page, select the **Active Directory Certificate Services** check box, and select **Next**.

6. On the **Introduction to AD CS** page, select **Next**.

7. On the **Role Services** page, select the **Certification Authority** check box, and select **Next**.

    > [!NOTE]
    > If you plan to install other role services on the destination server, you should complete the CA installation first, and then install other role services separately. Installation procedures for other AD CS role services aren't described in this guide.

8. On the **Specify Setup Type** page, specify either **Enterprise** or **Standalone**, to match the source CA, and select **Next**.

9. On the **Specify CA Type** page, specify either **Root CA** or **Subordinate CA**, to match the source CA, and select **Next**.

10. On the **Set Up Private Key** page, select **Use existing private key** and **Select a certificate and use its associated private key**.

    > [!NOTE]
    > If an HSM is used by the CA, select the private key by following procedures provided by the HSM vendor.

11. In the **Certificates** list, select the imported CA certificate, and then select **Next**.

12. On the **CA Database** page, specify the locations for the CA database and log files.

13. On the **Confirmation** page, review the messages, and then select **Configure**.

14. If you're migrating to a failover cluster, stop the Active Directory Certificate Services service (Certsvc) and HSM service if your CA uses an HSM. Then repeat the procedures to import the CA certificate and add the CA role service on other cluster nodes.

If you'd like to install the CA role service using PowerShell, use the [Install-AdcsCertificationAuthority](/powershell/module/adcsdeployment/install-adcscertificationauthority) cmdlet.

## Restore the CA

Now it's time to start to restore the CA. Restore the CA database, CA registry settings, and certificate template list if necessary.

### Restore the CA database and configuration on the destination server

The procedures in this section should be completed only after the CA role service has been installed on the destination server.

If you're migrating to a failover cluster, add the CA role service to all cluster nodes before restoring the CA database. The CA database should be restored on only one cluster node and must be located on shared storage.

Restoring the source CA backup includes the following tasks:

- Restore the source CA database on the destination server
- Restore the source CA registry settings on the destination server
- Verify the certificate extensions on the destination CA
- Restore the certificate templates list (required only for enterprise CAs)

### Restore the source CA database on the destination server

This section describes different procedures for restoring the source CA database backup on the destination server using either the Certification Authority snap-in, PowerShell, or Certutil.

If you're migrating to a Server Core installation, you must use Certutil PowerShell. It's possible to remotely manage a CA running on a Server Core installation by using the Certification Authority snap-in, and Server Manager. However, it's only possible to restore a CA database remotely by using Windows PowerShell.

If you're migrating to a failover cluster, ensure that shared storage is online and restore the CA database on only one cluster node.

# [Server Manager](#tab/server-manager)

To restore the CA database, start from Server Manager, and use the Certification Authority snap-in to complete these steps:

1. Log on to the destination server by using an account that is a CA administrator.

2. Start the Certification Authority snap-in.

3. Right-click the node with the CA name, point to **All Tasks**, and then select **Restore CA**.

4. On the **Welcome** page, select **Next**.

5. On the **Items to Restore** page, select **Certificate database and certificate database log**.

6. Select **Browse**. Navigate to the parent folder that holds the **Database** folder (the folder that contains the CA database files created during the CA database backup).

    > [!WARNING]
    > don't select the Database folder. Select its parent folder.

7. Select **Next** and then select **Finish**.

8. Select **Yes** to start the CA service (certsvc).

# [PowerShell](#tab/powershell)

To restore only the CA database by using Windows PowerShell, follow these steps:

1. Log on to the destination server by using an account that is a CA administrator.

2. Right-click **Windows PowerShell** and select **Run as Administrator**.

3. Type the following command to stop the CA service and press ENTER:

    ```powershell
    Stop-Service -Name "certsvc"
    ```

4. Type the following command and press ENTER:

    ```powershell
    Restore-CARoleService –Path "<CA Database Backup Directory>" -DatabaseOnly -Force
    ```

    > [!NOTE]
    > The value of **CA Database Backup Directory** is the parent directory of the **Database** directory. For example, if the CA database backup files are located in C:\Temp\Database, then the value of **CA Database Backup Directory** is C:\Temp. Include the force flag because an empty CA database will already be present after you perform the steps to add the CA role service.

5. Type the following command to restart the CA service and press ENTER:

    ```powershell
    Start-Service -Name "certsvc"
    ```

# [Certutil](#tab/certutil)

To restore the CA database by using Certutil.exe, follow these steps:

1. Log on to the destination server by using an account that is a CA administrator.

2. Open a Command Prompt window.

3. Type the following command to stop the CA service and press ENTER: `net stop certsvc`

4. Type `certutil.exe -f -restoredb "CA Database Backup Directory"` and press ENTER.

5. Type the following command to restart the CA service and press ENTER: `net start certsvc`

---

### Restore the source CA registry settings on the destination server

The CA configuration information is stored in the registry in: **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\CertSvc**

Before importing the registry settings from the source CA to the target CA, make sure you create a backup of the default target CA registry configuration. Be sure to perform these steps on the target CA and to name the registry file a name such as "DefaultRegCfgBackup.reg" to avoid confusion.

> [!IMPORTANT]
> Some registry parameters should be migrated without changes from the source CA computer, and some shouldn't be migrated. If they're migrated, they should be updated in the target system after migration because some values are associated with the CA itself, whereas others are associated with the domain environment, the physical host, the Windows version, or other factors that may be different in the target system.

A suggested way of performing the registry configuration import is first to open the registry file you exported from the source CA in a text editor and analyze it for settings that may need to be changed or removed.

#### Analyze the registry file

1. Right-click the .reg text file created by exporting the settings from the source CA.

2. Select **Edit** to open the file in a text editor.

3. If the target CA's computer name is different from the source CA's computer name, search the file for the host name of the source CA computer. For each instance of the host name found, ensure that it's the appropriate value for the target environment. Change the host name, if necessary. Update the **CAServerName** value.

4. Check any registry values that indicate local file paths, to ensure drive letter names and paths are correct for the target CA. If there's a mismatch between the source and the target CA, either update the values in the file or remove them from the file so that the default settings are preserved on the target CA.

> [!WARNING]
> Some registry values are associated with the CA, while others are associated with the domain environment, the physical host computer, the Windows version, or even other role services. Consequently, some registry parameters should be migrated without changes from the source CA computer and others shouldn't. Any value that isn't listed in the .reg text file that is restored on the target CA retains its existing setting or default value.

Remove any registry values that you don't want to import into the target CA. Once the .reg text file is edited, it can be imported into the target CA. By importing the source server registry settings back up into the destination server, the source CA configuration is migrated to the destination server.

#### Import the source CA registry backup on the destination CA

1. Log on to the destination server as a member of the local Administrators group.

1. Open a Command Prompt window.

1. Type **net stop certsvc** and press ENTER.

1. Type **reg import "Registry Settings Backup.reg"** and press ENTER.

#### Edit the CA registry settings

1. Select **Start**, type **regedit.exe** in the **Search programs and files** box, and press ENTER to open the Registry Editor.

1. In the console tree, locate the key HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\services\\CertSvc\\Configuration, and select **Configuration**.

1. In the details pane, double-click **DBSessionCount**.

1. Select **Hexadecimal**. In **Value data**, type **64**, and then select **OK**.

1. Verify the locations specified in the following settings are correct for your destination server, and change them as needed to indicate the location of the CA database and log files.

      - DBDirectory

      - DBLogDirectory

      - DBSystemDirectory

      - DBTempDirectory

    > [!IMPORTANT]
    > Complete steps 6 through 8 only if the name of your destination server is different from the name of your source server.

1. In the console tree of the registry editor, expand **Configuration**, and select your CA name.

1. Modify the values of the following registry settings by replacing the source server name with the destination server name.

    > [!NOTE]
    > In the following list, CACertFileName and ConfigurationDirectory values are created only when certain CA installation options are specified. If these two settings aren't displayed, you can proceed to the next step.

      - CAServerName

      - CACertFileName

      - ConfigurationDirectory – This value should appear in Windows Registry under the following location: HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\services\\CertSvc\\Configuration.

### Verify certificate extensions on the destination CA

The steps described for importing the source CA registry settings and editing the registry if there's a server name change are intended to retain the network locations that were used by the source CA to publish CRLs and CA certificates. If the source CA was published to default Active Directory locations, after completing the previous procedure, there should be an extension with publishing options enabled and an LDAP URL that references the source server's NetBIOS name; for example, ldap:///CN=\<CATruncatedName\>\<CRLNameSuffix\>,CN=\<ServerShortName\>,CN=CDP,CN=Public Key Services,CN=Services,\<ConfigurationContainer\>\<CDPObjectClass\>.

Because many administrators configure extensions that are customized for their network environment, it isn't possible to provide exact instructions for configuring CRL distribution point and authority information access extensions.

Carefully review the configured locations and publishing options, and ensure that the extensions are correct according to your organization's requirements.

#### Verify extensions by using the Certification Authority snap-in

1. Review and modify the CRL distribution point and authority information access extensions and publishing options by following example procedures described in [Specify CRL Distribution Points](https://go.microsoft.com/fwlink/?linkid=145848) (https://go.microsoft.com/fwlink/?LinkID=145848).

1. If the destination server name is different from the source server name, add an LDAP URL specifying a location that references the destination server's NetBIOS name with the substitution variable *\<ServerShortName\>*; for example `ldap:///CN=\<CATruncatedName\>\<CRLNameSuffix\>,CN=\<ServerShortName\>,CN=CDP,CN=Public Key Services,CN=Services,\<ConfigurationContainer\>\<CDPObjectClass\>`.

1. Ensure that the CDP options are set so that the former CDP location isn't included in the CDP extension of newly issued certificates or in the Freshest CRL extension of CRLs.

### Restore the certificate templates list

The following procedure is required only for an enterprise CA. A standalone CA doesn't have certificate templates.

#### Assign certificate templates to the destination CA

1. Log on with administrative credentials to the destination CA.

1. Open a command prompt window.

1. Type: `certutil -setcatemplates + <templatelist>` and press ENTER.

    > [!NOTE]
    > Replace **templatelist** with a comma-separated list of the template names that are listed in the catemplates.txt file created during the procedure "To record a CA templates list by using Certutil.exe." For example, **certutil -setcatemplates +Administrator,User,DomainController**.

### Grant permissions on AIA and CDP containers

If the name of the destination server is different from the source server, the destination server must be granted permissions on the source server's CDP and AIA containers in AD DS to publish CRLs and CA certificates. **Complete the following procedure if there's a server name change.**

#### Grant permissions on the AIA and CDP containers

1. Log on as a member of the Enterprise Admins group to a computer on which the Active Directory Sites and Services snap-in is installed. Open Active Directory Sites and Services (dssite.msc).

1. In the console tree, select the top node.

1. On the **View** menu, select **Show services node**.

1. In the console tree, expand **Services**, expand **Public Key Services**, and then select **AIA**.

1. In the details pane, right-click the name of the CA, and then select **Properties**.

1. Select the **Security** tab, and then select **Add**.

1. Select **Object Types**, select **Computers**, and then select **OK**.

1. Type the name of the CA, and select **OK**.

1. In the **Allow** column, select **Full Control**, and select **Apply**.

1. The previous CA computer object is displayed (as **Account Unknown** with a security identifier following it) in **Group or user names**. You can remove that account. To do so, select it and then select **Remove**. Select **OK**.

1. In the console tree, expand **CDP**, and then select the folder with the same name as the CA.

1. In the details pane, right-click the **CRLDistributionPoint** item at the top of the list, and then select **Properties**.

1. Select the **Security** tab, and then select **Add**.

1. Select **Object Types**, select **Computers**, and then select **OK**.

1. Type the name of the destination server, and select **OK**.

1. In the **Allow** column, select **Full Control**, and select **Apply**.

1. The previous CA computer object is displayed (as **Account Unknown** with a security identifier following it) in **Group or user names**. You can remove that account. To do so, select it and then select **Remove**. select **OK**.

1. Repeat steps 13 through 18 for each **CRLDistributionPoint** item.

> [!NOTE]
> If you're using file//\\computer\share syntax in the CDP Extensions for publishing the CRL to a shared folder location, then you may need to adjust the permissions to that shared folder so that the destination CA has the ability to write to that location.
> If you're hosting the CDP on the destination server and using a AIA or CDP path that includes an alias name (for example, pki.contoso.com) for the destination, you may need to adjust the DNS record so that it points to the correct destination IP address.

## Extra procedures for failover clustering

If you're migrating to a failover cluster, complete the following procedures after the CA database and registry settings have been migrated to the destination server.

- Configure failover clustering for the destination CA
- Grant permissions on public key containers
- Edit the DNS name for a clustered CA in AD DS
- Configure CRL distribution points for failover clusters

### Configure failover clustering for the destination CA

If you're migrating to a failover cluster, complete the following procedures to configure failover clustering for AD CS.

#### Configure AD CS as a cluster resource

1. Select **Start**, point to **Run**, type **Cluadmin.msc**, and then select **OK**.

1. In the console tree of the Failover Cluster Management snap-in, select **Services and Applications**.

1. On the **Action** menu, select **Configure a service or Application**. If the **Before you begin** page appears, select **Next**.

1. In the list of services and applications, select **Generic Service**, and select **Next**.

1. In the list of services, select **Active Directory Certificate Services**, and select **Next**.

1. Specify a service name, and select **Next**.

1. Select the disk storage that is still mounted to the node, and select **Next**.

1. To configure a shared registry hive, select **Add**, type **SYSTEM\\CurrentControlSet\\Services\\CertSvc**, and then select **OK**. Select **Next** twice.

1. Select **Finish** to complete the failover configuration for AD CS.

1. In the console tree, double-click **Services and Applications**, and select the newly created clustered service.

1. In the details pane, select **Generic Service**. On the **Action** menu, select **Properties**.

1. Change **Resource Name** to **Certification Authority**, and select **OK**.

If you use a hardware security module (HSM) for your CA, complete the following procedure.

#### To create a dependency between a CA and the network HSM service

1. Open the Failover Cluster Management snap-in. In the console tree, select **Services and Applications**.

1. In the details pane, select the previously created name of the clustered service.

1. On the **Action** menu, select **Add a resource**, and then select **Generic Service**.

1. In the list of available services displayed by the **New Resource** wizard, select the name of the service that was installed to connect to your network HSM. Select **Next** twice, and then select **Finish**.

1. Under **Services and Applications** in the console tree, select the name of the clustered services.

1. In the details pane, select the newly created **Generic Service**. On the **Action** menu, select **Properties**.

1. On the **General** tab, change the service name if desired, and select **OK**. Verify that the service is online.

1. In the details pane, select the service previously named **Certification Authority**. On the **Action** menu, select **Properties**.

1. On the **Dependencies** tab, select **Insert**, select the network HSM service from the list, and select **OK**.

### Grant permissions on public key containers

If you're migrating to a failover cluster, complete the following procedures to grant all cluster nodes permissions to on the following AD DS containers:

- The AIA container
- The Enrollment container
- The KRA container

#### Grant permissions on public key containers in AD DS

1. Log on to a domain member computer as a member of the Domain Admins group or Enterprise Admins group.

1. Select **Start**, point to **Run**, type **dssite.msc**, and then select **OK**.

1. In the console tree, select the top node.

1. On the **View** menu, select **Show services node**.

1. In the console tree, expand **Services**, then **Public Key Services**, and then select **AIA**.

1. In the details pane, right-click the name of the source CA, and then select **Properties**.

1. Select the **Security** tab, and then select **Add**.

1. Select **Object Types**, select **Computers**, and then select **OK**.

1. Type the computer account names of all cluster nodes, and select **OK**.

1. In the **Allow** column, select the **Full Control** check box next to each cluster node, and select **OK**.

1. In the console tree, select **Enrollment Services**.

1. In the details pane, right-click the name of the source CA, and then select **Properties**.

1. Select the **Security** tab, and then select **Add**.

1. Select **Object Types**, select **Computers**, and then select **OK**.

1. Type the computer account names of all cluster nodes, and select **OK**.

1. In the **Allow** column, select the **Full Control** check box next to each cluster node, and select **OK**.

1. In the console tree, select **KRA**.

1. In the details pane, right-click the name of the source CA, then select **Properties**.

1. Select the **Security** tab, and then select **Add**.

1. Select **Object Types**, select **Computers**, and then select **OK**.

1. Type the names of all cluster nodes, and select **OK**.

1. In the **Allow** column, select the **Full Control** check box next to each cluster node, and select **OK**.

### Edit the DNS name for a clustered CA in AD DS

When the CA service was installed on the first cluster node, the Enrollment Services object was created and the DNS name of that cluster node was added to the dNSHostName attribute of the Enrollment Services object. Because the CA must operate on all cluster nodes, the value of the dNSHostName attribute of the Enrollment Services object must be the service name specified in step 6 of the procedure "To configure AD CS as a cluster resource."

If you're migrating to a clustered CA, complete the following procedure on the active cluster node. It's necessary to complete the procedure on only one cluster node.

#### Edit the DNS name for a clustered CA in AD DS

1. Log on to the active cluster node as a member of the Enterprise Admins group.

1. Select **Start**, point to **Run**, type **adsiedit.msc**, and then select **OK**.

1. In the console tree, select **ADSI Edit**.

1. On the **Action** menu, select **Connect to**.

1. In the list of well-known naming contexts, select **Configuration**, and select **OK**.

1. In the console tree, expand **Configuration**, **Services**, and **Public Key Services**, and select **Enrollment Services**.

1. In the details pane, right-click the name of the cluster CA, and select **Properties**.

1. Select **dNSHostName**, and select **Edit**.

1. Type the service name of the CA as displayed under **Failover Cluster Management** in the Failover Cluster Manager snap-in, and select **OK**.

1. Select **OK** to save changes.

### Configure CRL distribution points for failover clusters

In a CA's default configuration, the server's short name is used as part of the CRL distribution point and authority information access locations.

When a CA is running on a failover cluster, the server's short name must be replaced with the cluster's short name in the CRL distribution point and authority information access locations. To publish the CRL in AD DS, the CRL distribution point container must be added manually.

> [!IMPORTANT]
> The following procedures must be performed on the active cluster node.

#### Change the configured CRL distribution points

1. Log on to the active cluster node as a member of the local Administrators group.

1. Select **Start**, select **Run**, type **regedit**, and then select **OK**.

1. Locate the registry key **\\HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\CertSvc\\Configuration**.

1. Select the name of the CA.

1. In the right pane, double-click **CRLPublicationURLs**.

1. In the second line, replace **%2** with the service name specified in step 6 of the procedure "To configure AD CS as a cluster resource."

    > [!TIP]
    > The service name also appears in the Failover Cluster Management snap-in under Services and Applications.

1. Restart the CA service.

1. Open a command prompt, type **certutil -CRL**, and press ENTER.

    > [!NOTE]
    > If a "Directory object not found" error message is displayed, complete the following procedure to create the CRL distribution point container in AD DS.

#### Create the CRL distribution point container in AD DS

1. At a command prompt, type **cd %windir%\\System32\\CertSrv\\CertEnroll**, and press ENTER. The CRL file created by the certutil –CRL command should be located in this directory.

1. To publish the CRL in AD DS, type **certutil -f -dspublish**  *"CRLFile.crl"* and press ENTER.

## Next step

After completing the procedures to migrate the CA, you should complete the procedures described in [Verifying the Certification Authority Migration](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn486770(v=ws.11)).

