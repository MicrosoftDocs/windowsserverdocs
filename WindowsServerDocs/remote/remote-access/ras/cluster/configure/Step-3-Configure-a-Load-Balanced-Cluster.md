---
title: Step 3 Configure a Load-Balanced Cluster
description: This topic is part of the guide Deploy Remote Access in a Cluster in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-ras
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f000066e-7cf8-4085-82a3-4f4fe1cb3c5c
ms.author: lizross
author: eross-msft
---
# Step 3 Configure a Load-Balanced Cluster

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

After preparing servers for the cluster, configure load-balancing on the single server, configure the required certificates, and deploy the cluster.  
  
|Task|Description|  
|----|--------|  
|[3.1 Configure the IPv6 prefix](#BKMK_Prefix)|If the corporate environment is IPv4+IPv6, or IPv6-only, then on the single Remote Access server, ensure that the IPv6 prefix assigned to DirectAccess client computers is large enough to cover all of the servers in your cluster.|  
|[3.2 Enable load balancing](#BKMK_NLB)|Enable load balancing on the single Remote Access server.|  
|[3.3 Install the IP-HTTPS certificate](#BKMK_InstallIPHTTP)|Each server in the cluster requires a server certificate to authenticate IP-HTTPS connection.  Export the IP-HTTPS certificate from the single Remote Access server and deploy it on each server you will add to the cluster. This is required only if using non-self-signed certificates.|  
|[3.4 Install the network location server certificate](#BKMK_NLS)|If the single server has the network location server deployed locally, then you will need to deploy the network location server certificate on each server in the cluster. If the network location server is hosted on an external server, a certificate on each server is not required. This is required only if using non-self-signed certificates.|  
|[3.5 Add servers to the cluster](#BKMK_Add)|Add all servers to the cluster. Remote Access must not be configured on the servers to be added.|  
|[3.6 Remove a server from the cluster](#BKMK_remove)|Instructions for removing a server from the cluster.|  
|[3.7 Disable load balancing](#BKBK_disable)|Instructions for disabling load balancing.|  
  
> [!NOTE]  
> The IP address that is selected for the DIP must not be in use on the network adapters of the first Remote Access server in the cluster. Beginning the DirectAccess deployment with both VIP and DIP added to the network adapter will result in failure.  
  
> [!NOTE]  
> Make sure not to use a DIP that is already present on another machine on the network.  
  
## <a name="BKMK_Prefix"></a>3.1 Configure the IPv6 prefix  
  
### <a name="configDA"></a>To configure the prefix  
  
1.  On the Remote Access server, click **Start**, and then click **Remote Access Management**. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.  
  
2.  In the Remote Access Management Console, click **Configuration**.  
  
3.  In the middle pane of the console, in the **Step 2 DirectAccess Server** area, click **Edit**.  
  
4.  Click **Prefix Configuration**. On the **Prefix Configuration** page, in **IPv6 prefix assigned to DirectAccess client computers**, enter the IPv6 prefix used for DirectAccess client computers with a subnet length of 59, for example, **2001:db8:1:1000::/59**. If VPN were also enabled with IPv6, then an IPv6 prefix would be displayed, and the subnet length would need to be changed to 59. Click **Next**.  
  
5.  In the middle pane of the console, click **Finish**.  
  
6.  On the **Remote Access Review** dialog box, review the configuration settings, and then click **Apply**. On the **Applying Remote Access Setup Wizard Settings** dialog box, click **Close**.  
  
## <a name="BKMK_NLB"></a>3.2 Enable load balancing  
  
#### To enable load balancing  
  
1.  On the configured DirectAccess server, click **Start**, and then click **Remote Access Management**. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.  
  
2.  In the Remote Access Management console, in the left pane, click **Configuration**, and then in the **Tasks** pane, click **Enable Load Balancing**.  
  
3.  In the Enable Load Balancing Wizard, click **Next**.  
  
4.  Depending on what you chose in planning steps:  
  
    1.  Windows NLB: On the **Load Balancing Method** page, click **Use Windows Network Load Balancing (NLB)**, and then click **Next**.  
  
    2.  External load balancer: On the **Load Balancing Method** page, click **Use an external load balancer**, and then click **Next**.  
  
5.  In a single network adapter deployment, on the **Dedicated IP Addresses** page, do the following, and then click **Next**:  
  
    1.  In the **IPv4 address** box, enter the new IPv4 address for this Remote Access server; the current IPv4 address will be the virtual IP address (VIP) of the load-balanced cluster. In the **Subnet mask** box, enter the subnet mask.  
  
    2.  If the corporate environment is native IPv6, then in the **IPv6 address** box, enter the new IPv6 address for this Remote Access server; the current IPv6 address will be the VIP of the load-balanced cluster. In the **Subnet prefix length** box, enter the subnet prefix length.  
  
6.  In a two network adapter deployment, on the **External Dedicated IP Addresses** page, do the following, and then click **Next**:  
  
    1.  In the **IPv4 address** box, enter the new external IPv4 address for this Remote Access server; the current IPv4 address will be the virtual IP address (VIP) of the load balancing cluster. In the **Subnet mask** box, enter the subnet mask.  
  
    2.  If there are currently native IPv6 addresses configured on the internet-facing network adapter of the Remote Access server, in the **IPv6 address** box, enter the new external IPv6 address for this Remote Access server; the current IPv6 address will be the VIP of the load balancing cluster. In the **Subnet prefix length** box, enter the subnet prefix length.  
  
7.  In a two network adapter deployment, on the **Internal Dedicated IP Addresses** page, do the following, and then click **Next**:  
  
    1.  In the **IPv4 address** box, enter the new internal IPv4 address for this Remote Access server; the current IPv4 address will be the VIP of the load balancing cluster. In the **Subnet mask** box, enter the subnet mask.  
  
    2.  If the corporate environment is native IPv6, then in the **IPv6 address** box, enter the new internal IPv6 address for this Remote Access server; the current IPv6 address will be the VIP of the load balancing cluster. In the **Subnet prefix length** box, enter the subnet prefix length.  
  
8.  On the **Summary** page, click **Commit**.  
  
9. On the **Enable Load Balancing** dialog box, click **Close**.  
  
10. In the Enable Load Balancing Wizard, click **Close**.  
  
    > [!NOTE]  
    > If external load balancing is being used, note the Virtual IPs and provide them as on the external load balancers.  
  
![Windows PowerShell](../../../../media/Step-3-Configure-a-Load-Balanced-Cluster/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
If you chose to use Windows NLB in the planning steps, then execute the following:  
  
```  
Set-RemoteAccessLoadBalancer -InternetDedicatedIPAddress "2.1.1.20/255.255.255.0" -InternalDedicatedIPAddress @("10.1.1.30/255.255.255.0","3ffe::20/64") -InternetVirtualIPAddress @("2.1.1.1/255.255.255.0","2.1.1.2/255.255.255.0") -InternalVirtualIPAddress @("10.1.1.2/255.255.255.0","3ffe::2/64")  
```  
  
If you chose to use an external load balancer in the planning steps: then execute the following:  
  
```  
Set-RemoteAccessLoadBalancer -InternetDedicatedIPAddress "2.1.1.20/255.255.255.0" -InternalDedicatedIPAddress @("10.1.1.30/255.255.255.0","3ffe::20/64") -UseThirdPrtyLoadBalancer  
```  
  
> [!NOTE]  
> It is recommended to not include changes to load-balancer settings with changes to any other settings, if you are using staging GPOs. Any changes to load-balancer settings must be applied first and then other configuration changes should be made. Also, after configuring load-balancer on a new DirectAccess server, please allow some time for the IP changes to be applied and replicated across the DNS servers in the enterprise, before you change other DirectAccess settings related to the new cluster.  
  
## <a name="BKMK_InstallIPHTTP"></a>3.3 Install the IP-HTTPS certificate  
Membership in the local **Administrators** group, or equivalent, is the minimum required to complete this procedure.  
  
### <a name="IPHTTPSCert"></a>To install the IP-HTTPS certificate  
  
1.  On the configured Remote Access server, click **Start**, type **mmc** and press ENTER. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.  
  
2.  In the MMC console, on the **File** menu, click **Add/Remove Snap-in**.  
  
3.  On the **Add or Remove Snap-ins** dialog box, click **Certificates**, click **Add**, click **Computer account**, click **Next**, click **Finish**, and then click **OK**.  
  
4.  In the left pane of the console, navigate to **Certificates (Local Computer)\Personal\Certificates**. Right-click the IP-HTTPS certificate, point to **All Tasks** and click **Export**.  
  
5.  On the **Welcome to the Certificate Export Wizard** page, click **Next**.  
  
6.  On the **Export Private Key** page, click **Yes, export the private key**, and then click **Next**.  
  
7.  On the **Export File Format** page, click **Personal Information Exchange - PKCS #12 (.PFX)**, and then click **Next**.  
  
8.  On the **Security** page, select the **Password** check box, enter a password in the **Password** box and confirm the password, and then click **Next**.  
  
9. On the **File to Export** page, enter a name for the certificate file and save it to the desktop, and then click **Next**.  
  
10. On the **Completing the Certificate Export Wizard** page, click **Finish**.  
  
11. On the **Certificate Export Wizard** dialog box, click **OK**.  
  
12. Copy the certificate to all servers that you want to be cluster members.  
  
13. On the new DirectAccess server, click **Start**, type **mmc** and press ENTER. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.  
  
14. In the MMC console, on the **File** menu, click **Add/Remove Snap-in**.  
  
15. On the **Add or Remove Snap-ins** dialog box, click **Certificates**, click **Add**, click **Computer account**, click **Next**, click **Finish**, and then click **OK**.  
  
16. In the left pane of the console, navigate to **Certificates (Local Computer)\Personal\Certificates**. Right click the **Certificates** node, point to **All Tasks**, and then click **Import**.  
  
17. On the **Welcome to the Certificate Import Wizard** page, click **Next**.  
  
18. On the **File to Import** page, click **Browse** to locate the certificate. Select the certificate and then click **Next**.  
  
19. On the **Private key protection** page, in the **Password** box, type the password, and then click **Next**.  
  
20. On the **Certificate Store** page, click **Next**.  
  
21. On the **Completing the Certificate Import Wizard** page, click **Finish**.  
  
22. On the **Certificate Import Wizard** dialog box, click **OK**.  
  
23. Repeat steps 13-22 on all servers that you want to be cluster members.  
  
## <a name="BKMK_NLS"></a>3.4 Install the network location server certificate  
Membership in the local **Administrators** group, or equivalent, is the minimum required to complete this procedure.  
  
#### To install a certificate for network location  
  
1.  On the Remote Access server, click **Start**, type **mmc**, and then press ENTER. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.  
  
2.  Click **File**, and then click **Add/Remove Snap-ins**.  
  
3.  Click **Certificates**, click **Add**, click **Computer account**, click **Next**, click **Local computer**, click **Finish**, and then click **OK**.  
  
4.  In the console tree of the Certificates snap-in, open **Certificates (Local Computer)\Personal\Certificates**.  
  
5.  Right-click **Certificates**, point to **All Tasks**, and then click **Request New Certificate**.  
  
6.  Click **Next** twice.  
  
7.  On the **Request Certificates** page, click the Web Server certificate template, and then click **More information is required to enroll for this certificate**.  
  
    If the Web Server certificate template does not appear, ensure that the Remote Access server computer account has enroll permissions for the Web Server certificate template. For more information, see [Configure Permissions on the Web Server Certificate Template](https://msdn.microsoft.com/library/ee649249.aspx).  
  
8.  On the **Subject** tab of the **Certificate Properties** dialog box, in **Subject name**, for **Type**, select **Common name**.  
  
9. In **Value**, type the fully qualified domain name (FQDN) for the intranet name of the network location server website (for example, nls.corp.contoso.com), and then click **Add**.  
  
10. Click **OK**, click **Enroll**, and then click **Finish**.  
  
11. In the details pane of the Certificates snap-in, verify that a new certificate with the FQDN was enrolled with **Intended Purposes** of **Server Authentication**.  
  
12. Right-click the certificate, and then click **Properties**.  
  
13. In **Friendly Name**, type **Network Location Certificate**, and then click **OK**.  
  
    > [!TIP]  
    > Steps 12 and 13 are optional, but make it easier for you to select the certificate for network location when configuring Remote Access.  
  
14. Repeat this procedure on all servers that you want to be cluster members.  
  
## <a name="BKMK_Add"></a>3.5 Add servers to the cluster  
 
  
#### To add servers to the cluster  
  
1.  On the configured DirectAccess server, click **Start**, and then click **Remote Access Management**. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.  
  
2.  In the Remote Access Management Console, click **Configuration**. In the **Tasks** pane, under **Load Balanced Cluster**, click **Add or Remove Servers**.  
  
3.  On the **Add or Remove Servers** dialog box, click **Add Server**.  
  
4.  On the **Add a Server** dialog box, on the **Select Server** page, enter the name of the additional Remote Access server, and then click **Next**.  
  
5.  On the **Network Adapters** page, do one the following:  
  
    -   If you are deploying a topology with two network adapters, in **External adapter**, select the adapter that is connected to the external network. In **Internal adapter**, select the adapter that is connected to the internal network.  
  
    -   If you are deploying a topology with one network adapter, in **Network adapter**, select the adapter that is connected to the internal network.  
  
6.  On the **Network Adapters** page, in **Select the certificate used to authenticate IP-HTTPS connections**, click **Browse** to locate and select the IP-HTTPS certificate, and then click **Next**.  
  
7.  On the **Network Location Server** page, click **Browse** to select the certificate for the network location server website running on the Remote Access server, and then click **Next**.  
  
    > [!NOTE]  
    > The **Network Location Server** page appears only when the network location server website is running on the Remote Access server.  
  
    > [!NOTE]  
    > If VPN were also configured on the Remote Access server, then you would be asked to add the VPN IP address pool information at this point.  
  
8.  On the **Summary** page, click **Add**.  
  
9. On the **Completion** page, click **Close**.  
  
10. Repeat this procedure for all Remote Access servers to be added to the cluster.  
  
11. On the **Add or Remove Servers** dialog box, click **Commit**.  
  
12. On the **Adding and Removing Servers** dialog box, click **Close**.  
  
![Windows PowerShell](../../../../media/Step-3-Configure-a-Load-Balanced-Cluster/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
```  
Add-RemoteAccessLoadBalancerNode -RemoteAccessServer <server name>  
```  
  
> [!NOTE]  
> If VPN has not been enabled in a load balanced cluster, you should not provide any VPN address ranges when adding a new server to the cluster using Windows PowerShell cmdlets. If you have done so by mistake, remove the server from the cluster, and add it again to the cluster without specifying the VPN address ranges.  
  
## <a name="BKMK_remove"></a>3.6 Remove a server from the cluster  
 
  
#### To remove a server from the cluster  
  
1.  On the configured Remote Access server, click **Start**, and then click **Remote Access Management**. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.  
  
2.  In the Remote Access Management Console, click **Configuration**. In the **Tasks** pane, under **Load Balanced Cluster**, click **Add or Remove Servers**.  
  
3.  On the **Add or Remove Servers** dialog box, select the Remote Access server you want to remove, and then click **Remove Server**.  
  
4.  On the **Remove Server Warning** dialog box, make sure you chose the right server, and then click **OK**.  
  
5.  Repeat this procedure for all Remote Access servers to be removed from the cluster.  
  
6.  On the **Add or Remove Servers** dialog box, click **Commit**.  
  
7.  On the **Adding and Removing Servers** dialog box, click **Close**.  
  
![Windows PowerShell](../../../../media/Step-3-Configure-a-Load-Balanced-Cluster/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
```  
Remove-RemoteAccessLoadBalancerNode -RemoteAccessServer <server name>  
```  
  
## <a name="BKBK_disable"></a>3.7 Disable load balancing  
[Do this step using Windows PowerShell](assetId:///7a817ca0-2b4a-4476-9d28-9a63ff2453f9)  
  
#### To disable load balancing  
  
1.  On the configured DirectAccess server, click **Start**, and then click **Remote Access Management**. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.  
  
2.  In the Remote Access Management Console, click **Configuration**. In the **Tasks** pane, under **Load Balanced Cluster**, click **Disable Load Balancing**.  
  
3.  On the **Disable Load Balancing** dialog box, click **Ok**.  
  
4.  On the **Disable Load Balancing** dialog box, click **Close**.  
  
![Windows PowerShell](../../../../media/Step-3-Configure-a-Load-Balanced-Cluster/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
```  
set-RemoteAccessLoadBalancer -disable  
```  
  
Disabling load balancing will remove Remote Access settings and NLB settings (if configured) from all servers except the server from which it is being executed. On this Remote Access server, NLB settings will be removed (if it was configured) but Remote Access settings will remain.  
  
Clicking **Remove configuration settings** will remove Remote Access and NLB (if configured) from all servers in the deployment.  
  
> [!NOTE]  
> -   If Remote Access is uninstalled when load balancing is deployed, all the servers are left with DIPs. The VIPs are removed. This causes all routes in the corporate network that are targeted to the VIPs addresses to fail. This also affects DNS entries which were resolved to the VIPs, such as the network location server certificate subject name. To avoid this issue, disable load balancing, which leaves the VIPs on the last Remote Access server, and then uninstall Remote Access.  
> -   After using the **Set-RemoteAccessLoadBalancer** cmdlet to disable load balancing, wait for 2 minutes before running any other cmdlet. This should also be done in any scripts that run another cmdlet after the **Set-RemoteAccessLoadBalancer -disable** cmdlet.  
> -   Disabling load balancing changes the virtual IP address of the cluster into a dedicated IP address. As a result, any operation that queries for the name of the server will fail until the cached DNS entry on the server expires. Make sure that you do not run any Remote Access PowerShell cmdlets after disabling load balancing until the cache on the server has expired. This problem is more common if you try to disable load balancing on a machine from another machine that is in another domain. This also occurs if you disable load balancing from the Remote Access Management console and may prevent the configuration from loading. The configuration will load after the cache has expired or has been flushed.  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Step 4: Verifying the cluster](Step-4-Verify-the-Cluster.md)  
  


