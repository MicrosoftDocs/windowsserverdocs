---
title: Remote Access: Post-migration Tasks
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b28fde10-5b54-440a-a73c-d7652ba0d7f1
---
# Remote Access: Post-migration Tasks
Perform the following post\-migration tasks to complete your migration:  
  
-   [Completing the migration](#bkmk_1)  
  
-   [Configuring firewall rules for VPN](#bkmk_2)  
  
-   [Configuring firewall rules for DirectAcces](#bkmk_3)  
  
-   [Restoring Remote Access in the event of migration failure](#bkmk_4)  
  
-   [Retiring Remote Access on your source server](#bkmk_5)  
  
-   [Troubleshooting cmdlet\-based migration](#bkmk_6)  
  
> [!NOTE]  
> The post\-migration tasks for the source server are optional, depending on your migration scenario.  
  
## <a name="bkmk_1"></a>Completing the migration  
Migration is complete as soon as verification efforts demonstrate that the destination server has replaced the source server in serving the network.  
  
If your verification efforts indicate that the migration failed, follow the steps in [Restoring Routing and Remote Access in the event of migration failure](#BKMK_4) to return to the previous valid configuration. The following list identifies some settings that must be manually configured after the migration is complete.  
  
-   **Server name**: If the source server is to be decommissioned, the same name is available to be configured on the destination server. If the IP addresses of the intranet and internet interfaces have changed, it is important to ensure that the intranet and internet DNS servers are updated with the new name and IP addresses. These configuration details also need to be deployed to your users by updating their connection profiles so that they can connect to the correct server.  
  
-   **Perimeter network firewall or NAT**: If the destination server is in a perimeter network, the firewall or NAT through which the server is accessed from the Internet must be configured with the new IP address of the RRAS server. Refer to the documentation for your Firewall or NAT router for the relevant configuration instructions.  
  
## <a name="bkmk_2"></a>Configuring firewall rules for VPN  
Firewall rules that permit VPN network traffic are included with the Windows Firewall with Advanced Security, but they are disabled by default. The rules that enable the required inbound network traffic must be enabled on the destination server. If there were any other rules explicitly configured on the source server to support RRAS or its roles, they should be configured on the destination server also. If you use non\-Microsoft firewall software, refer to the documentation that is provided by the vendor for instructions about how to configure the appropriate rules.  
  
When you migrate RRAS from the source server to the destination server, the firewall rules are not automatically enabled. You must use Windows Firewall with Advanced Security or a Group Policy setting to enable the rules that correspond to the types of RRAS network traffic that must enter your server. The following is a list of rules that you should enable, depending on which RRAS protocols you use:  
  
-   Routing and Remote Access \(GRE\-In\)  
  
-   Routing and Remote Access \(L2TP\-In\)  
  
-   Routing and Remote Access \(PPTP\-In\)  
  
-   Secure Socket Tunneling Protocol \(SSTP\-In\)  
  
If you change the default firewall behavior to blocking all traffic that does not match an allow rule then you must enable the outbound allow rules in addition to the inbound rules.  
  
## <a name="BKMK_3"></a>Configuring firewall rules for DirectAccess  
When using additional firewalls in your deployment, apply the following Internet\-facing firewall exceptions for Remote Access traffic when the Remote Access server is on the IPv4 Internet:  
  
-   Teredo traffic—User Datagram Protocol \(UDP\) destination port 3544 inbound, and UDP source port 3544 outbound.  
  
-   6to4 traffic—IP Protocol 41 inbound and outbound.  
  
-   IP\-HTTPS—Transmission Control Protocol \(TCP\) destination port 443, and TCP source port 443 outbound. When the Remote Access server has a single network adapter, and the network location server is on the Remote Access server, then TCP port 62000 is also required.  
  
    > [!NOTE]  
    > This exemption must be configured on the Remote Access server, while all the other exemptions have to be configured on the edge firewall.  
  
> [!NOTE]  
> For Teredo and 6to4 traffic, these exceptions should be applied for both of the Internet\-facing consecutive public IPv4 addresses on the Remote Access server. For IP\-HTTPS the exceptions need only be applied to the address where the public name of the server resolves.  
  
When using additional firewalls, apply the following Internet\-facing firewall exceptions for Remote Access traffic when the Remote Access server is on the IPv6 Internet:  
  
-   IP Protocol 50  
  
-   UDP destination port 500 inbound, and UDP source port 500 outbound.  
  
-   Internet Control Message Protocol for IPv6 \(ICMPv6\) traffic inbound and outbound – for Teredo implementations only.  
  
When using additional firewalls, apply the following internal network firewall exceptions for Remote Access traffic:  
  
-   ISATAP—Protocol 41 inbound and outbound  
  
-   TCP\/UDP for all IPv4\/IPv6 traffic  
  
-   ICMP for all IPv4\/IPv6 traffic  
  
## <a name="BKMK_4"></a>Restoring Remote Access in the event of migration failure  
If migration of Remote Access to the destination server fails, you can put the source server back into operation by following these steps:  
  
-   If the source server has not been repurposed and the computer name and IP address have not been migrated from the source to the destination server, simply connect the source server to the network and start the Routing and Remote Access service to allow users to connect again.  
  
-   If the computer name and IP address have been migrated from the source server to the destination server, rename the destination server to a temporary name and change its IP address to a different IP address. Set the source server computer name and IP address to the values that were used before the migration, and restart the Routing and Remote Access service on the source server.  
  
-   If the previous steps are not valid options, such as when the source server has been repurposed or is otherwise unavailable, use the backup files that were created from the source server, as described in [Remote Access: Prepare to Migrate](../Topic/Remote-Access--Prepare-to-Migrate.md). You can use the backup files any time after migration to restore the original Routing and Remote Access source server if a catastrophic failure occurs.  
  
### Estimated time to complete a rollback  
You should be able to complete a rollback in one to two hours.  
  
## <a name="bkmk_5"></a>Retiring Remote Access on your source server  
After you verify that the migration is complete, the source server can be disconnected from the network and removed from service. Stop RRAS before you remove the computer from the network and turn it off. You can keep this computer as a backup server in the event that you want to revert to your previous Routing and Remote Access configuration.  
  
## <a name="bkmk_6"></a>Troubleshooting cmdlet\-based migration  
The [!INCLUDE[wsmt](../Token/wsmt_md.md)] deployment log file is located at %*windir*%\\Logs\\SmigDeploy.log. Additional [!INCLUDE[wsmt](../Token/wsmt_md.md)] log files are created at the following locations.  
  
-   %*windir*%\\Logs\\ServerMigration.log  
  
-   On [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]: %*localappdata*%\\SvrMig\\Log  
  
-   On Windows Server 2003: %*userprofile*%\\Local Settings\\Application Data\\SvrMig\\Log  
  
If migration log files cannot be created in the preceding locations, **ServerMigration.log** and **SmigDeploy.log** are created in %*temp*%, and other logs are created in %*windir*%\\System32.  
  
If you are migrating Remote Access and a failure occurs while running the **Import\-SmigServerSetting** cmdlet, review the Setupact.log, Setuperr.log, and ServerMigration.log files under %localappdata%\\SvrMig\\Log. Information about how the Remote Access components migrated is included in the Servermigration.log file.  
  
If a migration cmdlet fails, and the [!INCLUDE[wps_2](../Token/wps_2_md.md)] session closes unexpectedly with an access violation error message, look for a message similar to the following example in the %*localappdata*%\\SvrMig\\Logs\\setuperr.log file.  
  
**FatalError \[0x090001\] PANTHR Exception \(code 0xC0000005: ACCESS\_VIOLATION\) occurred at 0x000007FEEDE9E050 in C:\\Windows\\system32\\migwiz\\unbcl.dll \(\+000000000008E050\).  Minidump attached \(317793 bytes\).**This failure occurs when the server cannot contact domain controllers that are associated with domain users or groups who are members of local groups, or who have rights to files or shares that are being migrated. When this happens, each domain user or group is displayed in the GUI as an unresolved security identifier \(SID\). An example of a SID is **S\-1\-5\-21\-1579938362\-1064596589\-3161144252\-1006**.  
  
To prevent this problem, verify that required domain controllers or global catalog servers are running, and that network connectivity allows communication between both source and destination servers and required domain controllers or global catalog servers.  Then, run the cmdlets again.  
  
#### If connections between either the source or destination servers and the domain controllers or global catalog servers cannot be restored, do the following.  
  
1.  Before you run **Export\-SmigServerSetting**, **Import\-SmigServerSetting** or **Get\-SmigServerFeature** again, remove all unresolved domain users or groups who are members of local groups from the server on which you are running the cmdlet.  
  
2.  Before you run **Send\-SmigServerData** or **Receive\-SmigServerData** again, remove all unresolved domain users or groups who have user rights to files, folders, or shares on the migration source server.  
  
### Viewing the content of Windows Server Migration Tools result objects  
All [!INCLUDE[wsmt](../Token/wsmt_md.md)] cmdlets return results as objects. You can save result objects, and query them for more information about settings and data that were migrated. You can also use result objects as input for other [!INCLUDE[wps_2](../Token/wps_2_md.md)] commands and scripts.  
  
#### Result object descriptions  
The [!INCLUDE[wsmt](../Token/wsmt_md.md)]**Import\-SmigServerSetting** and **Export\-SmigServerSetting** cmdlets return results in a list of **MigrationResult** objects. Each **MigrationResult** object contains information about the data or setting that the cmdlet processes, the result of the operation, and any related error or warning messages. The following table describes the properties of a **MigrationResult** object.  
  
|Property name|Type|Definition|  
|-----------------|--------|--------------|  
|ItemType|Enum|The type of item being migrated. Values include **General**, **WindowsFeatureInstallation**, **WindowsFeature**, and **OSSetting**.|  
|ID|String|The ID of the migrated item. Examples of values include **Local User**, **Local Group**, and **DHCP**.|  
|Success|Boolean|The value **True** is displayed if migration was successful; otherwise, **False** is displayed.|  
|DetailsList|List <MigrationResultDetails>|A list of **MigrationResultDetails** objects.|  
  
**Send\-SmigServerData** and **Receive\-SmigServerData** cmdlets return results in a list of **MigrationDataResult** objects. Each **MigrationDataResult** object contains information about the data or share that the cmdlet processes, the result of the operation, any error or warning messages, and other related information. The following table describes the properties of a **MigrationDataResult** object.  
  
|Property name|Type|Definition|  
|-----------------|--------|--------------|  
|ItemType|Enum|The type of migrated item. Values include **File**, **Folder**, **Share**, and **Encrypted File**.|  
|SourceLocation|String|The source location of the item, shown as a path name.|  
|DestinationLocation|String|The destination location of the item, shown as a path name.|  
|Success|Boolean|The value **True** is displayed if migration was successful; otherwise, **False** is displayed.|  
|Size|Integer|The item size, in bytes.|  
|ErrorDetails|List <MigrationResultDetails>|A list of **MigrationResultDetails** objects.|  
|Error|Enum|Errors enumeration for errors that occurred.|  
|WarningMessageList|List <String>|A list of warning messages.|  
  
The following table describes the properties of objects within the **MigrationResultDetails** object that are common to both **MigrationResult** and **MigrationDataResult** objects.  
  
|Property name|Type|Definition|  
|-----------------|--------|--------------|  
|FeatureId|String|The name of the migration setting that is related to the item. Examples of values include **IPConfig** and **DNS**. This property is empty for data migration.|  
|Messages|List <String>|A list of detailed event messages.|  
|DetailCode|Integer|The error or warning code associated with each event message.|  
|Severity|Enum|The severity of an event, if events occurred. Examples of values include **Information**, **Error**, and **Warning**.|  
|Title|String|Title of the result object. Examples of values include NIC physical address for IP configuration, or user name for local user migration.|  
  
#### Examples  
The following examples show how to store the list of the result objects in a variable, and then use the variable in a query to return the content of result objects after migration is complete.  
  
###### To store a list of result objects as a variable for queries  
  
1.  To run a cmdlet and save the result in variable, type a command in the following format, and then press **Enter**.  
  
    **$***VariableName***\=** $\(*Cmdlet*\)  
  
    The following is an example.  
  
    **$ImportResult \= $\(Import\-SmigServerSetting \-FeatureId DHCP \-User all \-Group \-Path D:\\rmt\\DemoStore \-force \-Verbose\)**  
  
    This command runs the **Import\-SmigServerSetting** cmdlet with several parameters specified, and then saves result objects in the variable **ImportResult**.  
  
2.  After the **Import\-SmigServerSetting** cmdlet has completed its operations, return the information contained in the result object by typing a command in the following format, and then pressing **Enter**.  
  
    **$***VariableName*  
  
    In the following example, the variable is named **ImportResult**.  
  
    **$***ImportResult*  
  
    This command returns information contained in the result objects that were returned by **Import\-SmigServerSetting** in the example shown in step 1. The following is an example of the output that is displayed by calling the **ImportResult** variable.  
  
    ```  
          ItemType  ID                              Success  DetailsList  
          --------  --                              -------  -----------  
         OSSetting  Local User                         True  {Local User, Loc...  
         OSSetting  Local Group                        True  {Local Group, Lo...  
    WindowsFeature  DHCP                               True  {}  
  
    ```  
  
    Each line of the preceding sample is a migration result for an item that was migrated by using the **Import\-SmigServerSetting** cmdlet. The column heading names are properties of **MigrationResult** objects. You can incorporate these properties into another command to return greater detail about result objects, as shown by examples in step 3 and forward.  
  
3.  To display a specific property for all result objects in the list, type a command in the following format, and then press **Enter**.  
  
    **$<VariableName>| Select\-Object \-ExpandProperty <PropertyName>**  
  
    The following is an example.  
  
    **$importResult | Select\-Object \-ExpandProperty DetailsList**  
  
4.  You can run more advanced queries to analyze result objects by using [!INCLUDE[wps_2](../Token/wps_2_md.md)] cmdlets. The following are examples.  
  
    -   The following command returns only those details of result objects that have the ID **Local User**.  
  
        **$ImportResult | Where\-Object { $\_.ID \-eq "Local User" } | Select\-Object \-ExpandProperty DetailsList**  
  
    -   The following command returns only those details of result objects with an ID of **Local User** that have a message severity equal to **Warning**.  
  
        **$ImportResult | Where\-Object { $\_.ID \-eq "Local User" } | Select\-Object \-ExpandProperty DetailsList | ForEach\-Object { if \($\_.Severity \-eq "Warning"\) {$\_} }**  
  
    -   The following command returns only the details of result objects with an ID of **Local User** that also have the title **Remote Desktop Users**.  
  
        **$ImportResult | Where\-Object { $\_.ID \-eq "Local Group" } | Select\-Object \-ExpandProperty DetailsList | ForEach\-Object { if \($\_.Title \-eq "Remote DesktopUsers"\) {$\_} }**  
  
#### More information about querying results  
For more information about the cmdlets that are used in the preceding examples, see the following additional resources.  
  
-   [Where\-Object](http://go.microsoft.com/fwlink/?LinkId=134853) on the Microsoft Script Center Web site \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=134853\).  
  
-   [Select\-Object](http://go.microsoft.com/fwlink/?LinkId=134858) on the Microsoft Script Center Web site \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=134858\).  
  
-   [ForEach\-Object](http://go.microsoft.com/fwlink/?LinkId=134860) on the Microsoft Script Center Web site \(http:\/\/www.microsoft.com\/technet\/scriptcenter\/topics\/msh\/cmdlets\/foreach\-object.mspx\)  
  
For more information about [!INCLUDE[wps_2](../Token/wps_2_md.md)] scripting techniques, see [What Can I Do With Windows PowerShell? \- Scripting Techniques](http://go.microsoft.com/fwlink/?LinkId=134862) on the Microsoft Script Center Web site \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=134862\).  
  
## See Also  
[Migrate Remote Access to Windows Server 2012](../Topic/Migrate-Remote-Access-to-Windows-Server-2012.md)  
[Remote Access: Prepare to Migrate](../Topic/Remote-Access--Prepare-to-Migrate.md)  
[Remote Access: Migrate Remote Access](../Topic/Remote-Access--Migrate-Remote-Access.md)  
[Remote Access: Verify the Migration](../Topic/Remote-Access--Verify-the-Migration.md)  
  
