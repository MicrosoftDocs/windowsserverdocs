---
title: Create IPAM Provisioning GPOs
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1626b340-702f-463e-87df-127dcee4e119
---
# Create IPAM Provisioning GPOs
[Checklist: Deploy IPAM Server](../Topic/Checklist--Deploy-IPAM-Server.md) > [Install IPAM Server](../Topic/Install-IPAM-Server.md) > [Choose an IPAM Provisioning Method](../Topic/Choose-an-IPAM-Provisioning-Method.md) > [Configure Server Discovery](../Topic/Configure-Server-Discovery.md) > [Discover Servers on the Network](../Topic/Discover-Servers-on-the-Network.md) | [Manually Add a Server to Server Inventory](../Topic/Manually-Add-a-Server-to-Server-Inventory.md) > **Create IPAM Provisioning GPOs**  
  
If you have chosen the Group Policy based provisioning method, you must also provide a GPO name prefix in the provisioning wizard. After providing a GPO name prefix, the wizard will display the GPO names that must be created in domains that will be managed by IPAM. The following GPOs are not created by the provisioning wizard and must be created in each domain that will be managed by the IPAM server:  
  
-   **<GPO\-prefix>\_DHCP**: For managed DHCP servers.  
  
-   **<GPO\-prefix>\_DNS**: For managed DNS servers.  
  
-   **<GPO\-prefix>\_DC\_NPS**: For managed domain controllers and NPS servers.  
  
You must create GPOs with these names in order for them to be automatically applied by IPAM when a server in the server inventory is marked as managed. GPOs are also removed automatically when a server is marked as unmanaged. Addition and removal of these GPOs is accomplished by modifying security filtering for the GPO. Server names are added when they are marked as managed, or removed if they are marked as unmanaged.  
  
If you have chosen the manual provisioning method, you can also create IPAM provisioning GPOs and use them to apply access settings to managed servers. In this case, specific GPO names are not required.  However, you must apply GPOs manually to managed servers by adding or removing the managed server to GPO security filtering as needed. For steps to modify GPO security filtering, see [Configuring IPAM GPO security filtering](../Topic/Create-IPAM-Provisioning-GPOs.md#security_filtering). This procedure is not necessary if you have chosen the automatic GPO\-based provisioning method.  
  
For more information about choosing a provisioning method, see [Choosing a provisioning method](../Topic/Getting-Started-with-IPAM.md#choose_method).  
  
Membership in the **Domain Admins** group, or equivalent, is the minimum required to complete this procedure. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
## Creating IPAM provisioning GPOs  
In the following procedure, the **Invoke\-IpamGpoProvisioning** Windows PowerShell cmdlet is used to create IPAM provisioning GPOs.  
  
#### To create IPAM provisioning GPOs  
  
1.  Run the Invoke\-IpamGpoProvisioning cmdlet at an elevated Windows PowerShell prompt. Invoke\-IpamGpoProvisioning has the following parameters:  
  
    ```  
    Invoke-IpamGpoProvisioning [-Domain] <String> [-GpoPrefixName] <String> [-DelegatedGpoGroup <String[]> ] [-DelegatedGpoUser <String[]> ] [-DomainController <String> ] [-Force] [-IpamServerFqdn <String> ] [-PassThru] [ <CommonParameters>]  
    ```  
  
2.  When prompted in the command output, press ENTER to confirm creation of the GPOs. You can also add the –Force parameter to bypass this confirmation. A full list of available parameters is provided in the following table.  
  
3.  Confirm that no errors are displayed.  
  
|Value|Description|  
|---------|---------------|  
|Invoke\-IpamGpoProvisioning|The Windows PowerShell cmdlet for creating and linking group policies in the specified domain for provisioning required access settings on the servers managed by the specified IPAM server.|  
|\-Domain|Required. Specifies the FQDN of the domain for which the IPAM GPOs are created and linked. Only one domain name should be specified. This cmdlet needs to be invoked for each domain in the Active Directory \(AD\) forest that needs to be managed by the IPAM server.|  
|\-GpoPrefixName|Required. Specifies the unique GPO prefix name used while creating the Group Policy Objects. The GPO prefix name specified here must be same as the one specified in the IPAM provisioning wizard if the Group Policy Based provisioning method was chosen. Three IPAM GPOs are created with the suffixes \_DHCP, \_DNS, and \_DC\_NPS appended to this parameter value. These suffixes signify the three different types of access settings that are applied depending on the type of server roles selected on the managed server.|  
|\-DelegatedGpoGroup|Optional. Specifies the comma separated list of security groups which are delegated edit permissions on the three IPAM GPOs created by this cmdlet. The standard GPO delegation privilege of **Edit settings**, **Delete**, and **Modify Security** is enabled for these groups. Delegation for users or groups without domain administrator privileges can also be enabled from GPMC or GPO cmdlets for the existing IPAM GPOs. This delegation is leveraged by the IPAM server to permit editing of the manageability status in a security context of the logged in user who is modifying manageability status from the IPAM server inventory view.|  
|\-DelegatedGpoUser|Optional. Specifies the comma separated list of domain users who are delegated edit permissions on the three IPAM GPOs created by this cmdlet. The standard GPO delegation privilege of **Edit settings**, **Delete**, and **Modify Security** is enabled for these groups. Delegation for users or groups without domain administrator privileges can also be enabled from GPMC or GPO cmdlets for the existing IPAM GPOs. This delegation is leveraged by the IPAM server to permit editing of the manageability status in a security context of the logged in user who is modifying manageability status from the IPAM server inventory view.|  
|\-DomainController|Optional. Specifies the name of the domain controller that is contacted to complete the GPO operation. Either the FQDN or simply the host name of the domain controller can be specified. By default the computer running the IPAM server contacts the PDC emulator of the specified domain unless this parameter is explicitly provided.|  
|\-Force|Optional. Forces the command to run without asking for user confirmation.|  
|\-IpamServerFqdn|Optional. Specifies the fully qualified domain name \(FQDN\) of the IPAM server for which the GPOs enable access settings. By default IPAM uses the FQDN of the IPAM server that runs the cmdlet to create GPOs. The specified computer account is added to the universal group named **IPAMUG** created by this cmdlet.|  
|\-PassThru|Optional. Returns an object representing the item with which you are working. By default, this cmdlet does not generate any output.|  
|CommonParameters|Optional. This cmdlet supports the common parameters: \-Verbose, \-Debug, \-ErrorAction, \-ErrorVariable, \-OutBuffer, and \-OutVariable.|  
  
### Sample Usage  
In the following example, three GPOs are created \(IPAM1\_DHCP, IPAM1\_DNS, IPAM1\_DC\_NPS\) and linked to the contoso.com domain. These GPOs enable access for the server ipam1.contoso.com using the domain administrator account user1. Note: In this example, the hostname of the IPAM server is used as a GPO prefix, however this is not required.  
  
```  
Invoke-IpamGpoProvisioning -Domain contoso.com -GpoPrefixName IPAM1 -DelegatedGpoUser user1 -IpamServerFqdn ipam1.contoso.com  
```  
  
## <a name="security_filtering"></a>Configuring IPAM GPO security filtering  
It is not necessary to configure IPAM GPO security filtering if you are using the automatic Group Policy based provisioning method. If you are using the manual provisioning method with IPAM GPOs, you must add and remove individual servers from the appropriate GPOs by editing GPO security filters.  
  
#### To configure IPAM GPO security filtering  
  
1.  On a domain controller, IPAM server, or other domain member server with the Group Policy Management feature installed, type **gpmc.msc** at an elevated command prompt and press ENTER.  
  
2.  In in the Group Policy Management console tree, navigate to Forest\\Domains\\<domain>\\Group Policy Objects\\  
  
3.  Click the GPO to configure. For example, if you are adding a managed DHCP server, click the GPO name ending in \_DHCP.  
  
4.  On the **Scope** tab, under **Security Filtering**, click **Add** to add a new server to this GPO.  
  
    If you are removing a managed server from security filtering, click the name of the managed server, click **Remove**, and then click **OK** when you are prompted to confirm removal of this delegation privilege. You can close Group Policy Management if you are finished configuring security filters.  
  
5.  To continue adding a managed server to security filtering, in **Select User, Computer, or Group** click **Object Types**, select the **Computers** checkbox, and then click **OK**.  
  
6.  Under **Enter the object name to select**, type the name of the managed server and click **Check Names**.  
  
7.  Verify that the server name is underlined, and then click **OK**. The managed server name will be displayed under **Security Filtering**.  
  
8.  Close **Group Policy Management**.  
  
## See Also  
[Manually Configure DHCP Access Settings](../Topic/Manually-Configure-DHCP-Access-Settings.md)  
[Manually Configure DNS Access Settings](../Topic/Manually-Configure-DNS-Access-Settings.md)  
[Manually Configure DC and NPS Access Settings](../Topic/Manually-Configure-DC-and-NPS-Access-Settings.md)  
  
