---
title: Configure IPAM VMM Integration
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 43643ffc-4634-4e8d-8df3-0667a163219e
---
# Configure IPAM VMM Integration
[Deploy IPAM VMM Integration](../Topic/Deploy-IPAM-VMM-Integration.md) > **Configure IPAM VMM Integration**  
  
To enable IPAM and Virtual Machine Manager \(VMM\) integration, you must first configure a user account for VMM on the IPAM server and then configure the IPAM network service plugin in VMM.  
  
When you have completed this procedure, see [Synchronize IPAM and VMM](../Topic/Synchronize-IPAM-and-VMM.md) for procedures to add a logical network using IPAM or using VMM and then view the network using either console.  
  
See the following sections for detailed step by step instructions:  
  
-   [Configure IPAM](../Topic/Configure-IPAM-VMM-Integration.md#ipam)  
  
-   [Configure VMM](../Topic/Configure-IPAM-VMM-Integration.md#vmm)  
  
Membership in the **Administrators** group, or equivalent, is the minimum required to complete the following procedures. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
## <a name="ipam"></a>Configure IPAM  
  
-   [To create the VMM user account](../Topic/Configure-IPAM-VMM-Integration.md#create)  
  
-   [To assign permissions to the VMM user account](../Topic/Configure-IPAM-VMM-Integration.md#assign)  
  
VMM must be granted permission to view and modify IP address space in IPAM, and to perform remote management of the IPAM server. VMM uses a “Run As” account to provide these permissions to the IPAM network service plugin. The “Run As” account must be configured with appropriate permission on the IPAM server.  
  
Use the following procedure to assign permissions to an account that will be used by VMM to access the IPAM server. Any local or domain account can be used, but it is recommended to use a unique domain account that will only be used by VMM to connect to the IPAM server. When adding this account to the IPAM network service in VMM, you must provide the domain\\username and password.  
  
> [!TIP]  
> The procedure to create the domain account “vmmuser” is not shown here. To create this account, see [Create a new user account](http://technet.microsoft.com/library/cc784390.aspx).  
  
### <a name="create"></a>To create the VMM user account  
  
1.  On the IPAM server, open an elevated command prompt, type **lusrmgr.msc**, and press ENTER. The **Local Users and Groups** console will open.  
  
2.  In the console tree, right\-click **Groups** and click **New Group**.  
  
3.  In the **New Group** dialog box, next to **Group name**, type a name for the group, for example **VMM Users**.  
  
4.  Click **Add**, and under **Enter the object names to select**, type the username of the VMM user account, for example **vmmuser**, and then click **OK**.  
  
5.  Confirm that the user account was added to the **VMM Users** group, and then click **Create**. See the following example.  
  
    ![](../Image/IPAM_vmmuser.png)  
  
6.  Click **Close** to close the **New Group** dialog box.  
  
7.  Leave the **Local Users and Groups** console open for the following procedure.  
  
### <a name="assign"></a>To assign permissions to the VMM user account  
  
1.  In the IPAM server console, in the upper navigation pane, click **ACCESS CONTROL**, right\-click **Access Policies** in the lower navigation pane, and then click **Add Access Policy**.  
  
2.  On the **Add Access Policy** page, click **Add**, type the name of the **VMM Users** group that was created in the previous procedure, for example **VMM Users**, and then click **OK**. See the following example.  
  
    ![](../Image/IPAM_vmmuser2.png)  
  
3.  Click **Access Settings**, click **New**, and then choose **IPAM ASM Administrator Role** from the drop\-down list under **Select role**.  
  
4.  Verify that the **Global** access scope is selected, click **Add Setting**, and then click **OK**.  
  
5.  In the **Local Users and Groups** console, right\-click **Remote Management Users** and click **Add to Group**.  
  
6.  Click **Add**, and under **Enter the object names to select**, type the username of the VMM user account, for example **vmmuser**, and then click **OK**.  
  
7.  Click **OK** to close **Remote Management Users Properties**.  
  
## <a name="vmm"></a>Configure VMM  
Perform the following procedure using the System Center VMM console.  
  
#### To configure VMM  
  
1.  In the **Fabric** workspace, expand the **Networking** node and then click **Network Service**.  
  
2.  Right\-click **Network Service**, and click **Add Network Service**.  
  
3.  In the **Add Network Service Wizard**, on the **Name** page, next to **Name**, type **IPAM** and then click **Next**. The **Description** field is optional.  
  
4.  On the **Manufacturer and Model** page, next to **Manufacturer**, choose **Microsoft** and next to **Model**, choose **Microsoft Windows Server IP Address Management**, and then click **Next**.  
  
5.  On the **Credentials** page, next to **Run As account**, click **Browse** and then click **Create Run As Account**.  
  
6.  On the **Create Run As Account** page, next to **Name** type a name for the account, for example **VMM User**.  
  
7.  Next to **User name**, **Password** and **Confirm password**, enter the username and password for the account that was created on the IPAM server in the previous procedure, for example **contoso\\vmmuser**. A description is optional. See the following example. Click **OK** to continue.  
  
    ![](../Image/IPAM_runas.png)  
  
8.  Click **OK** to close the **Select a Run As Account** dialog box.  
  
9. Click **Next**, and then on the **Connection String** page, type the fully qualified domain name \(FQDN\) of the IPAM server, for example **ipam1.contoso.com**. Click **Next** to continue.  
  
10. On the **Provider** page, verify that **Microsoft IP Address Management Provider** is selected next to **Configuration provider**, and then click **Test**.  
  
11. Verify that **Passed** is displayed next to **Test open connection**, **Test capability discovery**, and **Test system info**. See the following example.  
  
    ![](../Image/IPAM_vmmtest.png)  
  
    If one or more tests fail, verify that permissions are configured correctly on the IPAM server for the Run As account, verify the FQDN of the IPAM server is entered correctly on the Connection String page, and verify that VMM can resolve and connect to the IPAM server.  
  
12. Click **Next**, and then on the **Host Group** page select the **All Hosts** checkbox to enable IPAM integration with all logical networks in VMM.  
  
    > [!TIP]  
    > If you wish to enable IPAM integration for a subset of VMM logical networks, these must already be created in VMM. The available logical networks in VMM will be displayed on the Host Group page and can be individually selected for IPAM integration. Host groups that are not selected will not appear in IPAM and cannot be modified by IPAM.  
  
13. Click **Next** and then on the **Summary** page click **Finish**.  
  
14. By default, the **Jobs** dialog box will display status of VMM provisioning. Verify that a status of **Completed** is displayed next to **Add network service device** and **Create new RunAs Account**.  
  
## See also  
[Install IPAM Server](../Topic/Install-IPAM-Server.md)  
  
