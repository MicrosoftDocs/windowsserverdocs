---
title: KMS and MAK Activation Scenarios for Volume Activation
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: df66a0cc-b4bc-4b2f-be26-4ebdbc9ead41
author: jaimeo
---
# KMS and MAK Activation Scenarios for Volume Activation
The following sections describe key scenarios for KMS and MAK activation.  
  
## On this page  
  
-   [KMS Scenarios](#KMSScenarios)  
  
-   [MAK Scenarios](#MAKScenarios)  
  
-   [VAMT Support for KMS Activation](#VAMTSupport)  
  
-   [Converting KMS to MAK Activation](#Converting)  
  
### <a name="KMSScenarios"></a>KMS scenarios  
KMS can support simple, single\-site networks and global networks. The following scenarios show:  
  
-   The default implementation of KMS.  
  
-   The implementation expanded to support a global network.  
  
#### Default KMS implementation for a single\-site network  
Contoso has 100 [!INCLUDE[nextref_client_7ent](includes/nextref_client_7ent_md.md)] clients and a mixed set of [!INCLUDE[nextref_vista](includes/nextref_vista_md.md)], [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)], and [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)] systems. Contoso is a flat domain \(Contoso.com\). The DNS server runs Microsoft DNS in its default configuration. This configuration supports DNS dynamic update protocol and DNS record scavenging to remove stale records.  
  
Contoso purchases a license agreement that provides a KMS key, which will activate all of its systems. The information technology \(IT\) administrator installs Contoso’s KMS host key \(CSVLK\) on two KMS hosts running [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)] by using the following command run locally at an elevated command prompt:  
  
```  
Slmgr.vbs /ipk <KMS_host_key>  
```  
  
The IT administrator then creates a Security Group in Active Directory® Domain Services \(AD DS\) named KMS\_Hosts. The administrator adds the servers KMS\_1 and KMS\_2 to the KMS\_Hosts membership.  
  
The host KMS\_1 is activated against Microsoft via the Internet: **Slmgr.vbs \/ato**. KMS\_1 automatically publishes its SRV resource records \(RRs\) to DNS. The IT administrator accesses the DNS server, locates the RR for \_vlmcs.\_tcp.contoso.com, and changes its permissions to give KMS\_Hosts Read, Write, and Delete permission to the record. The host KMS\_2 is now activated against Microsoft via the Internet: **Slmgr.vbs \/ato**.  
  
Finally, the administrator confirms that the KMS host exclusion is enabled in Windows Firewall. The Key Management Service firewall exception needs to be enabled.  
  
KMS clients on the Contoso network query DNS and receive the SRV records for both KMS hosts. The clients pick one or the other host and are activated \(as soon as the KMS count rises above the threshold\). See the section, “Activation Policy Values,” for more information about KMS count requirements.  
  
#### KMS implementation in a complex, global network  
Contoso has expanded into two domains, east.contoso.com and west.contoso.com. Network traffic can pass privately between the two networks through a firewalled wide area network \(WAN\) link. This link has limited bandwidth, so resources \(including DNS\) are replicated on both sides of the WAN link to reduce traffic when possible.  
  
Contoso uses image\-based deployment. Its client systems are standardized on [!INCLUDE[nextref_vista](includes/nextref_vista_md.md)], but the [!INCLUDE[nextref_vista](includes/nextref_vista_md.md)] systems are being replaced by [!INCLUDE[nextref_client_7](includes/nextref_client_7_md.md)] clients.  
  
Users regularly travel geographically, and their network connection changes from one domain to the other. Clients’ IP addressing is provided dynamically by DHCP, including specifying the local DNS host, local gateway address, and so on.  
  
To provide activation support for the existing [!INCLUDE[nextref_vista](includes/nextref_vista_md.md)] clients and the new [!INCLUDE[nextref_client_7](includes/nextref_client_7_md.md)] clients, Contoso installs four KMS hosts \(using its KMS B key\). Two KMS hosts are configured in east.contoso.com, and two are configured in west.contoso.com.  
  
The IT administrator configures the KMS hosts so that the DNS SRV records drive [!INCLUDE[nextref_client_7](includes/nextref_client_7_md.md)] and [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)] clients in the east domain to KMS\_E1, if available, or to KMS\_E2. If neither is available, the clients will attempt KMS\_W1 and, finally, KMS\_W2. Likewise, DNS in the west domain is configured so that [!INCLUDE[nextref_client_7](includes/nextref_client_7_md.md)] clients in the west domain will prefer contacting KMS\_W1, then KMS\_W2 and only when these fail will attempt activation with KMS\_E1 and KMS\_E2 on the far side of the WAN link.  
  
The IT administrator accomplishes this by making the following configuration changes \(see Table 5\):  
  
-   KMS\_E\* hosts are added to the security group KMS\_E. This group is given Read, Write, and Delete rights to the record \_vlmcs.\_tcp.east.contoso.com.  
  
-   KMS\_W\* hosts are added to the security group KMS\_W. This group is given Read, Write, and Delete rights to the record \_vlmcs.\_tcp.west.contoso.com.  
  
-   DHCP servers are configured to add east.contoso.com and west.contoso.com to the DNS suffix search list for all clients.  
  
-   Firewalls between east and west domains are configured to allow RPC traffic to the KMS hosts on port 1688.  
  
**Table 5. KMS Host Configuration**  
  
|**Description**|**Configuration**|**Host**|  
|-------------------|---------------------|------------|  
|Configure east.contoso.com SRV priority and weight so that clients will contact KMS\_E\* hosts if available before trying KMS\_W\* hosts. Traffic will be divided: 75% to the KMS\_\*1 hosts and 25% to the KMS\_\*2 hosts.|HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\SoftwareProtectionPlatform DnsDomainPublishList\=<br /><br />KMS\_E1, 10, 75<br /><br />KMS\_E2, 10, 25<br /><br />KMS\_W1, 90, 75<br /><br />KMS\_W2, 90, 25|KMS\_E1<br /><br />KMS\_E2|  
|Configure west.contoso.com SRV priority and weight so that clients will contact KMS\_W\* hosts if available before trying KMS\_E\* hosts. Traffic will be divided: 75% to the KMS\_\*1 hosts and 25% to the KMS\_\*2 hosts.|HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\SoftwareProtectionPlatform DnsDomainPublishList\=<br /><br />KMS\_W1, 10, 75<br /><br />KMS\_W2, 10, 25<br /><br />KMS\_E1, 90, 75<br /><br />KMS\_E2, 90, 25|KMS\_W1<br /><br />KMS\_W2|  
  
Then, the administrator confirms that the Windows Firewall exceptions are set to allow KMS client traffic and configures client computers, as Table 6 describes.  
  
**Table 6. KMS Client Configuration**  
  
|**Description**|**Configuration**|  
|-------------------|---------------------|  
|Disable KMS host caching|Slmgr \/ckhc|  
|A customer URL is set to direct users with activation issues to the Contoso help desk|HKEY\_LOCAL\_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\SoftwareProtectionPlatform\\Activation<br /><br />AlternateURL \= http:\/\/contoso.com\/help|  
  
The client reference computer is KMS activated, then **sysprep \/generalize** is run. The system is shut down and imaged using ImageX from the [!INCLUDE[nextref_client_7](includes/nextref_client_7_md.md)] Windows Automated Installation Kit \(Windows AIK\). The Windows AIK is available to download at [http:\/\/go.microsoft.com\/fwlink\/?LinkId\=136976](http://go.microsoft.com/fwlink/?LinkId=136976).  
  
[Top Of Page](#Top)  
  
### <a name="MAKScenarios"></a>MAK scenarios  
The following sections describe scenarios for MAK activation. This section involves network and workgroup environments that are typical within large enterprises.  
  
In the Core Network environment, all computers are within a common network managed by AD DS. The Secure Zone represents higher\-security Core Network computers that have addition firewall protection.  
  
The Isolated Lab environment is a workgroup that is physically separate from the Core Network, and its computers do not have Internet access. The network security policy states that no information that could identify a specific computer or user may be transferred out of the Isolated Lab.  
  
#### MAK independent activation  
The VAMT allows automation of MAK deployment and activation over the network by distributing MAKs from a centralized console. VAMT queries Microsoft activation servers to get the number of remaining activations for a given MAK, then lists the activation status of all MAK\-activated systems in the environment. This count is a snapshot in time, not a real\-time count. VAMT version 3.1 is included in the Windows ADK. For more information about VAMT, see [Volume Activation Management Tool \(VAMT\) Technical Reference](http://technet.microsoft.com/library/hh824825.aspx), and [VAMT How\-To Topics](http://technet.microsoft.com/library/hh824887.aspx)  
  
In this scenario, the VAMT is deployed in the Core Network environment. The VAMT is installed on a central computer with network access to all client computers. Both the VAMT host and client computers have Internet access. The following instructions describe how to perform independent activation:  
  
1.  Install and launch the VAMT on a networked host computer:  
  
    1.  Install the Windows ADK on the host computer.  
  
    2.  Click Start, and then click **VAMT** to open the VAMT console.  
  
2.  Configure the Windows Management Instrumentation \(WMI\) firewall exception on target computers. Ensure that the WMI firewall exception has been enabled for all target computers.  
  
3.  Add computers to the computer information list \(CIL\):  
  
    1.  On the VAMT console, click **Action**, and then click **Add Computers** to display the **Add Computers** dialog box.  
  
    2.  Enter a Computer Group name such as Core Network Group to identify the group of computers you are activating.  
  
    3.  Click the drop\-down list to select a search option. You can search for computers in a workgroup, in an AD DS domain, or by individual computer name or IP address.  
  
    4.  If you are searching by individual computer name or IP address, enter that information in the text box below the drop\-down list.  
  
    5.  If you are searching a domain or a workgroup, select the domain or workgroup from the additional drop\-down list displayed for those options. Use the **Filter by computer name** field to search for a specific computer within the domain or workgroup.  
  
    6.  Click **OK**.  
  
        The VAMT queries Active Directory Domain Services \(AD DS\) via Lightweight Directory Access Protocol \(LDAP\) and adds the computers it finds to the CIL.  
  
4.  Collect status information from the discovered computers:  
  
    1.  For the VAMT to perform an action on a computer, it must have current license status data for that computer. Collect status from individual computers by directly selecting one or more computers in the computer list view pane. To perform operations for an entire group, in the tree view pane, select the Status Unknown node or the User Defined Groups\\Core Network Group node.  
  
    2.  Right\-click the group or the desired computers, and then click **Refresh Computer Status**.  
  
    3.  If you are activating computers that require administrator credentials different from the ones you are currently using, select **Use Alternate Credentials**.  
  
    4.  Click **OK**.  
  
    5.  Provide a Domain Administrator account \(to collect status from all computers in the domain\) and password when prompted.  
  
        The VAMT displays the **Collecting computer information** dialog box while it collects the status of all selected computers. When the process is finished, the refreshed status of each computer appears in the computer list view pane of the VAMT console.  
  
        > [!NOTE]  
        > To retrieve the licensing status on the selected computers, the VAMT must have administrative permissions on the remote computers, and WMI must be accessible through Windows Firewall. In addition, for workgroup computers, a registry key must be created to enable remote administrative actions under User Account Control \(UAC\). For more information about configuring systems for VAMT remote management, see the VAMT help.  
  
5.  Add a MAK, and determine its remaining activation count:  
  
    1.  Click **Options**, and then click **Manage MAKs** to open the **Manage MAK Keys** dialog box.  
  
    2.  Click **Add** to enter a MAK.  
  
    3.  Enter the MAK, and then click **Validate**.  
  
        Once validated, the **Edition** field is automatically populated.  
  
    4.  Provide a meaningful description, and then click **Add**.  
  
        The MAK is now listed in the **Manage MAK Keys** dialog box.  
  
    5.  Click **Refresh remaining count** to retrieve the number of remaining activations for the listed MAKs from Microsoft. \(This step requires Internet connectivity.\)  
  
    6.  Click **Exit** to close the dialog box.  
  
6.  Install the MAK, and activate the client computers:  
  
    1.  Select the computers to be activated, either by clicking a group in the tree view pane or by selecting individual computers in the list view pane.  
  
    2.  Right\-click the selected group or computers, and then click **MAK Independent Activate** to display the **MAK Independent Activate** dialog box.  
  
    3.  Select the appropriate MAK from the **Install MAK** list.  
  
    4.  Select the Install **MAK \(overwrite existing\)** and **Activate Now** check boxes to instruct the selected computers to activate immediately by contacting Microsoft Windows Activation over the Internet.  
  
        If an asterisk \(\*\) appears next to the text for these check boxes, the action will apply only to applicable computers. For example, a computer installed with a [!INCLUDE[nextref_vista](includes/nextref_vista_md.md)] retail edition cannot be activated using a MAK.  
  
    5.  If you are activating computers that require administrator credentials different from the those you are currently using, select **Use Alternate Credentials**.  
  
    6.  Click **OK**.  
  
        VAMT displays the **Assigning Product Keys** dialog box, and then displays the **Activating Computers** dialog box until it completes the requested action. If you selected **Use Alternate Credentials**, you will be prompted to enter the credentials prior to these dialog boxes.  
  
#### MAK proxy activation  
In this scenario, the VAMT is used to activate workgroup computers within an Isolated Lab environment. For workgroups such as this, which are completely isolated from the larger network, you can perform MAK proxy activation by installing a second VAMT on a computer within the isolated workgroup and using removable media to transfer VAMT CILs between that computer and another VAMT host that has Internet access. For more information about configuring systems for VAMT remote management, see the VAMT help. The following steps describe how to use the VAMT tool for proxy activation:  
  
1.  Install a VAMT on a workgroup computer in the Isolated Lab:  
  
    1.  Install the Windows AIK on a host computer in the Isolated Lab workgroup.  
  
        This computer can be running Windows XP with Service Pack 2 \(SP2\), Windows Server 2003, [!INCLUDE[nextref_vista](includes/nextref_vista_md.md)], [!INCLUDE[nextref_client_7](includes/nextref_client_7_md.md)], [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)], or [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)].  
  
    2.  Click Start, and then click **VAMT** to open the VAMT console.  
  
    3.  Configure the Windows Management Instrumentation \(WMI\) firewall exception on target computers. Ensure that the WMI firewall exception has been enabled for all target computers.  
  
2.  Add computers to the CIL:  
  
    1.  On the VAMT console, click **Action**, and then click **Add Computers** to open the **Add Computers** dialog box.  
  
    2.  Enter a Group name such as Isolated Lab Group to identify the group of computers you are activating.  
  
    3.  Select the **Workgroup** option, and specify the name of the workgroup, and then click **OK**.  
  
        The VAMT searches the workgroup for computers.  
  
        > [!NOTE]  
        > For the VAMT to discover client computers in a workgroup, the network discovery Windows Firewall exception must be enabled.  
  
3.  Collect status from the discovered computers:  
  
    1.  For the VAMT to perform an action on a computer, it must have current license status data for that computer. Collect status from individual computers by directly selecting one or more computers in the computer list view pane. To perform operations for an entire group, in the left pane, select the Status Unknown node or the User Defined Groups\\Isolated Lab Group node.  
  
    2.  Right\-click the group or the desired computers, and then click **Refresh Computer Status**.  
  
    3.  If you are activating computers that require administrator credentials different from the those you are currently using, select **Use Alternate Credentials**.  
  
    4.  Click **OK**. When prompted, provide the credentials for an account that has local administrative rights on the selected workgroup computers.  
  
        The VAMT displays the **Collecting computer information** dialog box while it collects the status of all selected computers. When the process is finished, the refreshed status of each computer appears in the computer list view pane of the VAMT console.  
  
        > [!NOTE]  
        > To retrieve the licensing status on the selected computers, the VAMT must have administrative permissions on the remote computers, and WMI must be accessible through Windows Firewall. In addition, for workgroup computers, a registry key must be created to enable remote administrative actions under UAC.  
  
4.  Add a MAK:  
  
    1.  Click **Options**, and then click **Manage MAKs** to open the Manage **MAK Keys** dialog box.  
  
    2.  Click **Add** to enter a MAK.  
  
    3.  Enter the MAK, and then click **Validate**.  
  
        Once validated, the **Edition** field is automatically populated.  
  
    4.  Provide a meaningful description, and then click **Add**.  
  
        The MAK is now be listed in the **Manage MAK Keys** dialog box.  
  
    5.  Click **Exit** to close the dialog box.  
  
        > [!NOTE]  
        > Because the VAMT is not installed on a computer with Internet access, the **Refresh Remaining Count** option will not operate. This feature requires Internet access.  
  
5.  Install the MAK on the Isolated Lab computers:  
  
    1.  Select the Isolated Lab group in the tree view pane.  
  
    2.  Right\-click the selected group, and then click **MAK Proxy Activate** to display the **MAK Proxy Activate** dialog box.  
  
    3.  Select the appropriate MAK from the **Install MAK** list.  
  
    4.  Select **Install MAK \(overwrite existing\)**.  
  
        If an asterisk \(\*\) appears next to the text for this checkbox, the action will apply only to applicable computers. For example, a computer installed with a [!INCLUDE[nextref_vista](includes/nextref_vista_md.md)] retail edition cannot be activated using a MAK.  
  
    5.  Clear the **Get Confirmation ID from Microsoft** check box, because this computer does not have Internet access.  
  
    6.  Clear the **Apply Confirmation ID and Activate** check box, because confirmation IDs \(CIDs\) have not yet been requested.  
  
    7.  If you are activating computers that require administrator credentials different from the those you are currently using, select **Use Alternate Credentials**, and then click **OK**.  
  
        VAMT displays the Assigning Product Keys dialog box until it completes the requested action. If you selected Use Alternate Credentials, you will be prompted to enter the credentials prior to this dialog box.  
  
        > [!NOTE]  
        > Selecting the **Install MAK \(overwrite existing\)** check box force\-installs a MAK on a client computer. This must be done with care. If the pre\-SP1 version of [!INCLUDE[nextref_vista](includes/nextref_vista_md.md)] has been installed on the computer for more than 30 days, then its Initial Grace period has expired, and the computer will enter Reduced Functionality Mode \(RFM\) if activation is not completed successfully before the next logon. However, you can use MAK proxy activation to recover properly configured computers from RFM as long as the computers are accessible to the VAMT host. RFM only applies to the pre\-SP1 version of [!INCLUDE[nextref_vista](includes/nextref_vista_md.md)]. Windows Vista with SP1 or later, [!INCLUDE[nextref_client_7](includes/nextref_client_7_md.md)], [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)], or [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)] will not enter RFM.  
  
6.  Save the CIL:  
  
    In this step, the full CIL is saved on the local \(that is, workgroup\) VAMT host. In MAK proxy activation, it is critical to retain this file, because the VAMT uses it to apply the CIDs to the proper computers.  
  
    1.  Using the VAMT tree view or list view pane, select the group or the individual computers that successfully received a MAK.  
  
    2.  From the **File** menu, click **Save** to display the Save the **Computer Information List** dialog box.  
  
    3.  Select a directory, and then enter a CIL file name such as *IsolatedLabGroup.CIL*.  
  
    4.  Click **Save**.  
  
7.  Export the CIL:  
  
    As stated previously, the enterprise’s security policy states that no information that could identify a specific computer or user may be transferred out of the Isolated Lab. Therefore, this type of data must be excluded from the CIL file to be transferred to the Core Network VAMT host.  
  
    1.  Using the VAMT tree view or list view pane, select the group or the individual computers that successfully received a MAK.  
  
    2.  Right\-click the selected group or computers, and then click **Export Computers** to display the **Save the Computer Information List** dialog box.  
  
    3.  Select **Exclude any sensitive environment data**.  
  
    4.  Click **Browse** to display the **Save As** dialog box.  
  
    5.  Select a directory, and then enter a CIL file name such as *IsolatedLabGroupSecureExport.CIL*.  
  
    6.  Click **Save**.  
  
    7.  Copy the IsolatedLabGroupSecureExport.CIL file to removable media \(disk drive, CD\/DVD, or USB flash drive \[UFD\]\).  
  
        > [!NOTE]  
        > Selecting the **Exclude any sensitive environment data** check box excludes Personally Identifiable Information \(PII\) from being saved in the CIL. As a result, the CIL must be re\-imported in this VAMT host and into the full\-save CIL file so that the CIDs requested from Microsoft can be correctly assigned to the computers in the Isolated Lab group.  
  
8.  Import the CIL on a VAMT host with Internet access:  
  
    1.  Copy IsolatedLabGroupSecureExport.CIL from the removable media to a drive on a VAMT host that has Internet access.  
  
    2.  Open the VAMT console.  
  
    3.  From the **File** menu, click **Import** to open the **Open Computer Information List** dialog box.  
  
    4.  Locate and select **IsolatedLabGroupSecureExport.CIL** and then click **Open** to load the CIL into the VAMT.  
  
    5.  Confirm that the computer, group, and workgroup names are not visible.  
  
9. Request CIDs from Microsoft:  
  
    1.  Right\-click the imported computers, and then click **MAK Proxy Activate** to open the **MAK Proxy Activate** dialog box.  
  
    2.  Clear the **Install MAK \(overwrite existing\)** check box.  
  
    3.  Clear the **Get Confirmation ID from Microsoft** check box.  
  
    4.  Clear the **Apply Confirmation ID and Activate** check box, because this VAMT host is not on the same network as the selected computers.  
  
    5.  Click **OK**.  
  
        The VAMT displays the **Acquiring Confirmation ID online** dialog box while it contacts Microsoft and collects the CIDs.  
  
10. Export the CIL from the Internet\-connected VAMT host:  
  
    1.  After the CIDs have been retrieved for all computers, save the CIL file. In the VAMT console, scroll to the right and confirm that the **PendingCID** column has values.  
  
    2.  From the **File** menu, click **Save As**, and provide a new name for the file, such as *IsolatedLabGroupSecureExportwithCID.CIL*.  
  
    3.  Copy the updated file IsolatedLabGroupSecureExportwithCID.CIL to removable media \(disk drive, CD\/DVD, or UFD\).  
  
11. Import the CIL on the original VAMT host within the Isolated Lab:  
  
    1.  Copy IsolatedLabGroupSecureExportwithCID.CIL from the removable media onto a drive on the VAMT host in the Isolated Lab.  
  
    2.  Open the VAMT console.  
  
    3.  From the **File** menu, click **Open** to display the Open **Computer Information List** dialog box.  
  
    4.  Locate and select IsolatedLabGroup.CIL, and then click **Open** to load the CIL into the VAMT.  
  
        This displays the previously discovered computers and their license states in the computer list view pane.  
  
    5.  From the **File** menu, click **Import** and browse to the file that contains the CIDs \(IsolatedLabGroupSecureExportwithCID.CIL\).  
  
        This starts the merge process that matches the CIDs to the computers’ IIDs.  
  
    6.  From the **File** menu, click **Save**, and then enter a file name such as IsolatedLabGroupwithCID.CIL to save this file that associates the IIDs with the corresponding CIDs.  
  
        > [!IMPORTANT]  
        > Saving this file is critical for reimaging scenarios. It is strongly recommended that you back up this file and protect it from being overwritten.  
  
12. Apply the CIDs, and activate the Isolated Lab computers:  
  
    1.  Right\-click the Isolated Lab group in the tree view pane, and then click **MAK Proxy Activate** to open the **MAK Proxy Activate** dialog box.  
  
    2.  Clear the **Install MAK \(overwrite existing\)** check box, because the selected computers already have a MAK installed.  
  
    3.  Clear the **Get Confirmation ID from Microsoft** check box.  
  
    4.  Select the Apply Confirmation ID and Activate check box to instruct the VAMT to activate the selected computers by installing their CIDs.  
  
    5.  Click **OK**.  
  
        The VAMT displays the **Assigning Confirmation IDs** dialog box while it installs the CIDs on the selected computers.  
  
13. Optionally, reactivate reimaged computers in the Isolated Lab:  
  
    If the computers in the Isolated Lab have been reimaged but the underlying hardware has not changed, the VAMT can reactivate them using the IsolatedLabGroupwithCID.CIL file.  
  
    1.  Redeploy Windows to each computer using the same computer names as before.  
  
    2.  Open the VAMT console on the local \(workgroup\) VAMT host.  
  
    3.  From the **File** menu, click **Open**, and then select the IsolatedLabGroupwithCID.CIL file.  
  
    4.  In the tree view pane, right\-click the **Isolated Lab** group, and then click **Reapply Confirmation ID** to display the **MAK Proxy Reactivate** dialog box.  
  
    5.  Leave the **Install MAK \(overwrite existing\)** check box selected, and ensure that the previously used MAK is selected from the list.  
  
    6.  Leave the **Reapply Confirmation ID and Reactivate** check box selected to reapply the stored CIDs from the IsolatedLabGroupwithCID.CIL file.  
  
    7.  Leave the Require exact IID match check box selected if the hardware has not changed since the initial MAK Proxy Activation and you are using the same MAK to reactivate the computer.  
  
        Clear this check box if the hardware has changed but you would still like VAMT to attempt a reactivation using the previously stored CID. Note that Windows might not be successfully reactivated in this scenario.  
  
    8.  If you are activating a computer that requires administrator credentials different from those you are currently using, select the **Use Alternate Credentials** check box.  
  
    9. Click **OK**.  
  
        The VAMT displays the **Assigning Product Keys** dialog box while it applies the MAK to the Isolated Lab Group.  
  
        The VAMT displays the **Assigning Confirmation IDs** dialog box while it installs the CIDs on the selected computers.  
  
        > [!NOTE]  
        > Selecting the **Install MAK \(overwrite existing\)** check box force\-installs a MAK. This must be done with care. If the pre\-SP1 version of [!INCLUDE[nextref_vista](includes/nextref_vista_md.md)] has been installed for more than 30 days, then its Initial Grace period has expired and it will enter RFM if activation is not completed successfully before the next logon. VAMT can be used to recover properly configured remote computers from RFM as long as they are accessible on the network. RFM only applies to the pre\-SP1 version of [!INCLUDE[nextref_vista](includes/nextref_vista_md.md)]. Windows Vista with SP1 or later, [!INCLUDE[nextref_client_7](includes/nextref_client_7_md.md)], [!INCLUDE[nextref_longhorn](includes/nextref_longhorn_md.md)], and [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)] will not enter RFM.  
  
[Top Of Page](#Top)  
  
### <a name="VAMTSupport"></a>VAMT support for KMS activation  
In this scenario, the VAMT is used to install and activate KMS client keys on either Core Network or Isolated Lab computers. The procedure described below assumes that the VAMT has been installed and the computers have been added to the CIL. These tasks are described in steps 1–4 in either Scenario 1 \(for the Core Network\) or Scenario 2 \(for the Isolated Lab workgroup\).  
  
1.  Open the VAMT console.  
  
2.  Select the computers to be activated, either by clicking a group in the tree view pane or by selecting individual computers in the list view pane.  
  
3.  Right\-click the selected group or computers, and then click **Configure for KMS Activation** to display the **KMS Configuration** dialog box.  
  
4.  Select **Install KMS Client Key \(overwrite existing\)** to instruct the VAMT to install a KMS client key on a client computer.  
  
5.  Select the appropriate activation option:  
  
    -   **Auto\-Discover KMS host using DNS.** The VAMT first clears any previously configured KMS host on the target computer, then instructs the computer to query DNS to locate a KMS host and attempt activation.  
  
    -   **Use specific KMS host and port.** The VAMT sets the specified KMS host name and port on the target computer, and then instruct the computer to attempt activation with that specific KMS host.  
  
6.  If you are activating computers that require administrator credentials different from those you are currently using, select the **Use Alternate Credentials** check box, and then click **OK**.  
  
    The VAMT displays the **Assigning Product Keys** dialog box, and then displays the **Activating Computers** dialog box until it completes the requested action. If you selected the **Use Alternate Credentials** check box, you will be prompted to enter the credentials prior to these dialog boxes.  
  
[Top Of Page](#Top)  
  
### <a name="Converting"></a>Converting KMS to MAK activation  
[!INCLUDE[nextref_client_7](includes/nextref_client_7_md.md)] and [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)] install automatically as KMS clients. To convert a KMS client to MAK activation, install a MAK. A MAK can be installed during or anytime after operating system installation.  
  
A MAK key can be installed on a reference image of [!INCLUDE[nextref_client_7](includes/nextref_client_7_md.md)] and [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)] to make all installations from that image use MAK activation instead of the default KMS activation. Doing so alleviates the need to specify a MAK in an unattended installation file.  
  
#### Installing a MAK during operating system installation  
You can convert a KMS client to a MAK client during the initial installation of [!INCLUDE[nextref_client_7](includes/nextref_client_7_md.md)] or [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)] by including a MAK in an unattended setup \(Unattend.xml\) file. The Unattend.xml file can be used with Setup.exe or Windows Deployment Services. For more information, see the Unattended Windows Setup Reference help file in the Windows AIK at [http:\/\/go.microsoft.com\/fwlink\/?LinkId\=136976](http://go.microsoft.com/fwlink/?LinkId=136976).  
  
> [!NOTE]  
> The MAK is stored in clear text in the Unattend.xml file. During an unattended installation, the file Unattend.xml or AutoUnattend.xml is copied to the %SystemRoot%\\Panther folder of the target computer. However, at the end of the Setup process, the Setup program replaces it with “SENSITIVE\*DATA\*DELETED.”  
  
### Installing a MAK after operating system installation  
You can configure a volume edition of [!INCLUDE[nextref_client_7](includes/nextref_client_7_md.md)] or [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)] to use MAK activation by using the Control Panel System item or by running the Slmgr.vbs script:  
  
-   To install a MAK by using System Center, click the **Change your product key** link, and then type the MAK in the **Change your product key for activation** dialog box.  
  
-   To install a MAK by using Slmgr.vbs, run the following command at a command prompt:  
  
    ```  
    slmgr.vbs /ipk <MultipleActivationKey>  
    ```  
  
    where *MultipleActivationKey* is the MAK.  
  
If users install a MAK by using the user interface \(UI\), the MAK client attempts to activate itself over the Internet one time. If the users install a MAK key by using the Slmgr.vbs script, the MAK client does not try to activate automatically. The user can use **Slmgr.vbs \/ato** to manually activate the MAK over Internet.  
  
[Top Of Page](#Top)  
  
## See also  
  
-   [Volume Activation Technical Reference](Volume-Activation-Technical-Reference.md)  
  
-   [Volume Activation Overview](Volume-Activation-Overview.md)  
  

