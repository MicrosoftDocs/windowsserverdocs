---
title: Configure a Multi-Forest Deployment
description: This topic is part of the guide Deploy Remote Access in a Multi-Forest Environment in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-ras
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3c8feff2-cae1-4376-9dfa-21ad3e4d5d99
ms.author: lizross
author: eross-msft
---
# Configure a Multi-Forest Deployment

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic describes how to configure a Remote Access multi-forest deployment in several possible scenarios. All of the scenarios assume that DirectAccess is currently deployed on a single forest called Forest1, and that you are configuring DirectAccess to work with a new forest called Forest2.  
  
## <a name="AccessForest2"></a>Access resources from Forest2  
In this scenario, DirectAccess is already deployed on Forest1, and is configured to allow clients from Forest1 to access the corporate network. By default, clients connected via DirectAccess can access only resources in Forest1 and cannot access any servers in Forest2.  
  
#### To enable DirectAccess clients to access resources from Forest2  
  
1.  If the DNS suffix of Forest2 is not part of the DNS suffix of Forest1, add NRPT rules with the suffixes of the domains in Forest2, and optionally, add the suffixes of the domains in Forest2 to the DNS suffix search list.  
  
2.  Add the relevant internal IPv6 prefixes in Forest2 if IPv6 is deployed on the internal network.  
  
## <a name="EnableForest2DA"></a>Enable clients from Forest2 to connect via DirectAccess  
In this scenario, you configure the Remote Access deployment to allow clients from Forest2 to access the corporate network. It is assumed that you have created the required security groups for client computers in Forest2.   
  
#### To allow clients from Forest2 to access the corporate network  
  
1.  Add the security group of the clients from Forest2.  
  
2.  If the DNS suffix of Forest2 is not part of the DNS suffix of Forest1, add NRPT rules with the suffixes of the clients' domain in Forest2 to enable access to the domain controllers for authentication, and optionally, add the suffixes of the domains in Forest2 to the DNS suffix search list. 
  
3.  Add the internal IPv6 prefixes in Forest2 to enable DirectAccess to create the IPsec tunnel to the domain controllers for authentication.  
  
4.  Refresh the management servers list.  
  
## <a name="AddEPForest2"></a>Add entry points from Forest2  
In this scenario, DirectAccess is deployed in a multisite configuration on Forest1, and you want to add a Remote Access server, named DA2, from Forest2 as an entry point to the existing DirectAccess multisite deployment.  
  
#### To add a Remote Access server from Forest2 as an entry point  
  
1.  Make sure that the Remote Access administrator has sufficient permissions to write GPOs on the domain of DA2, and that the Remote Access administrator is a local administrator on DA2.  
  
2.  Add DA2 as an entry point.   
  
3.  Add NRPT rules with the suffixes of the domains in Forest2 to enable access to the domain controllers for authentication, and optionally, add the suffixes of the domains in Forest2 to the DNS suffix search list.  
  
4.  Add the relevant internal IPv6 prefixes in Forest2, if required, to enable Remote Access to establish the IPsec tunnel to the corporate resources and to make sure that NCSI probes work correctly.  
  
5.  Refresh the management servers list.  
  
## <a name="OTPMultiForest"></a>Configure OTP in a multi-forest deployment  
Note the following terms when configuring OTP in a multi-forest deployment:  
  
-   Root CA-The forest(s) main PKI tree CA.  
  
-   Enterprise CA-All other CAs.  
  
-   Resource Forest-The forest that contains the Root CA, and is considered to be the 'Managing forest\domain'.  
  
-   Account Forest-All other forests in the topology.  
  
The PowerShell script, PKISync.ps1, is required for this procedure. See [AD CS: PKISync.ps1 Script for Cross-forest Certificate Enrollment](https://technet.microsoft.com/library/ff961506.aspx).  
  
> [!NOTE]  
> This topic includes sample Windows PowerShell cmdlets that you can use to automate some of the procedures described. For more information, see [Using Cmdlets](https://go.microsoft.com/fwlink/p/?linkid=230693).  
  
### <a name="BKMK_CertPub"></a>Configure CAs as certificate publishers  
  
1.  Enable LDAP referral support on all of the enterprise CAs in all of the forests by running the following command from an elevated command prompt:  
  
    ```  
    certutil -setreg Policy\EditFlags +EDITF_ENABLELDAPREFERRALS  
    ```  
  
2.  Add all enterprise CA computer accounts to the Active Directory Cert Publishers security groups in each of the account forests.  
  
3.  Restart all of the certsvc services on all of the CA computers in all of the forests by running the following command from an elevated command prompt:  
  
    ```  
    net stop certsvc && net start certsvc  
    ```  
  
4.  Extract the root CA certificate by running the following command from an elevated command prompt:  
  
    ```  
    certutil -config <Computer-Name>\<Root-CA-Name> -ca.cert <root-ca-cert-filename.cer>  
    ```  
  
    (If you run the command on the root CA you can omit the connection information, -config <Computer-Name>\\<Root-CA-Name>)  
  
    1.  Import the Root CA certificate from the previous step on the Account Forest CA by running the following command from an elevated command prompt:  
  
        ```  
        certutil -dspublish -f <root-ca-cert-filename.cer> RootCA  
        ```  
  
    2.  Grant Resource Forest certificate templates Read/Write permissions to the \<Account Forest\>\\<Administrator account\>.  
  
    3.  Extract all resource forest enterprise CA certificates by running the following command from an elevated command prompt:  
  
        ```  
        certutil -config <Computer-Name>\<Enterprise-CA-Name> -ca.cert <enterprise-ca-cert-filename.cer>  
        ```  
  
        (If you run the command on the root CA you can omit the connection information, -config <Computer-Name>\\<Root-CA-Name>)  
  
    4.  Import the Enterprise CA certificates from the previous step on the Account Forest CA by running the following commands from an elevated command prompt:  
  
        ```  
        certutil -dspublish -f <enterprise-ca-cert-filename.cer> NTAuthCA  
        certutil -dspublish -f <enterprise-ca-cert-filename.cer> SubCA  
        ```  
  
    5.  Remove account forest OTP certificate templates from the list of issued Certificate Templates.  
  
### <a name="BKMK_DelImp"></a>Delete and import OTP certificate templates  
  
1.  Delete OTP certificate templates from the Account Forest; that is, Forest2.  
  
2.  Copy certificate templates and Oid objects from the Resource Forest to each of the Account Forests using the following PowerShell commands:  
  
    ```  
    .\PKISync.ps1 -sourceforest <resource forest DNS> -targetforest <account forest DNS> -type Template -cn <DA OTP registration authority template common name>.  
    .\PKISync.ps1 -sourceforest <resource forest DNS> -targetforest <account forest DNS> -type Template -cn <Secure DA OTP logon certificate template common name>.  
    .\PKISync.ps1 -sourceforest <resource forest DNS> -targetforest <account forest DNS> -type Oid -f  
    ```  
  
### <a name="BKMK_Publish"></a>Publish OTP certificate templates  
  
-   Issue the newly imported certificate templates on all Account Forests CAs.  
  
### <a name="BKMK_Extract"></a>Extract and Synchronize the CA  
  
1.  Extract all Enterprise CA certificates from the Account Forests by running the following commands from an elevated command prompt:  
  
    ```  
    certutil -config <Computer-Name>\<Enterprise-CA-Name> -ca.cert <enterprise-ca-cert-filename.cer>  
    ```  
  
2.  Synchronize CAs across forests from the Account Forests to the Resource Forest using the following PowerShell command:  
  
    ```  
    .\PKISync.ps1 -sourceforest <account forest DNS> -targetforest <resource forest DNS> -type CA -cn <enterprise CA sanitized name> -f  
    ```  
  
3.  Synchronize CAs across forests from the Resource Forest to the Account Forests using the following PowerShell command:  
  
    ```  
    .\PKISync.ps1 -sourceforest <resource forest DNS> -targetforest <account forest DNS> -type CA -cn <enterprise CA sanitized name> -f  
    ```  
  
## Configuration procedures  
The following sections contain the configuration procedures for the above scenario deployments. After completing a procedure, return to the scenario to continue.  
  
### <a name="NRPT_DNSSearchSuffix"></a>Add NRPT rules and DNS suffixes  
Clients that connect via DirectAccess to the corporate network use the Name Resolution Policy Table (NRPT) to determine which DNS server should be used to resolve the address of different resources. This allows the client to resolve corporate resource addresses and helps the client maintain a proper inside-corporate/outside-corporate classification, which is required to keep DirectAccess working. The DirectAccess configuration tools automatically detect the root DNS suffix of Forest1 and add it to the NRPT table. However, the FQDN suffixes of Forest2 are not added automatically to the NRPT table, and the Remote Access administrator must add them manually.  
  
The DNS suffix search list allows the clients to use short label names instead of FQDNs. The Remote Access configuration tools automatically add all the domains in Forest1 to the DNS suffix search list. If you want to enable clients to use short label names for resources in Forest2, you need to add them manually.  
  
##### To add a DNS suffix to the NRPT table and domain suffixes to the DNS suffix search list  
  
1.  In the middle pane of the Remote Access Management console, in the **Step 3 Infrastructure Servers** area, click **Edit**.  
  
2.  On the **Network Location Server** page, click **Next**.  
  
3.  On the **DNS** page, in the table, enter any additional name suffixes that are part of the corporate network in Forest 2. In **DNS Server Address**, enter the DNS server address manually, or by clicking **Detect**. If you don't enter the address, the new entries are applied as NRPT exemptions. Then click **Next**.  
  
4.  Optional: On the **DNS Suffix Search List** page, add any DNS suffixes by entering the suffix in the **New Suffix** box, and then clicking **Add**. Then click **Next**.  
  
5.  On the **Management** page, click **Finish**.  
  
6.  In middle pane of the Remote Access Management console, click **Finish**.  
  
7.  On the **Remote Access Review** dialog box, click **Apply**.  
  
8.  On the **Applying Remote Access Setup Wizard Settings** dialog box, click **Close**.  
  
### <a name="IPv6Prefix"></a>Add internal IPv6 prefix  
  
> [!NOTE]  
> Adding an internal IPv6 prefix is relevant only when IPv6 is deployed on the internal network.  
  
Remote Access manages a list of IPv6 prefixes for corporate resources. Only resources with these IPv6 prefixes may be accessed by clients that are connected via DirectAccess. Because the Remote Access Management console and Windows PowerShell commands automatically add the IPv6 prefixes of Forest1, and might not add the prefixes of other forests, you must add any missing prefixes of Forest2 manually.  
  
##### To add an IPv6 prefix  
  
1.  In the middle pane of the Remote Access Management console, in the **Step 2 Remote Access Server** area, click **Edit**.  
  
2.  In the Remote Access Server Setup wizard, click **Prefix Configuration**.  
  
3.  On the **Prefix Configuration** page, in **Internal network IPv6 prefixes**, add any additional IPv6 prefixes separated by semicolons, for example, 2001:db8:1::/64;2001:db8:2::/64. Then click **Next**.  
  
4.  On the **Authentication** page, click **Finish**.  
  
5.  In middle pane of the Remote Access Management console, click **Finish**.  
  
6.  On the **Remote Access Review** dialog box, click **Apply**.  
  
7.  On the **Applying Remote Access Setup Wizard Settings** dialog box, click **Close**.  
  
### <a name="SGs"></a>Add client security groups  
To enable Windows 8 client computers from Forest2 to access resources through DirectAccess, you must add the security group from Forest2 to the Remote Access deployment.  
  
##### To add Windows 8 client security groups  
  
1.  In the middle pane of the Remote Access Management console, in the **Step 1 Remote Clients** area, click **Edit**.  
  
2.  In the DirectAccess Client Setup wizard, click **Select Groups**, and then on the **Select Groups** page, click **Add**.  
  
3.  On the **Select Groups** dialog box, select the security groups containing DirectAccess client computers. Then click **Next**.  
  
4.  On the **Network Connectivity Assistant** page, click **Finish**.  
  
5.  In middle pane of the Remote Access Management console, click **Finish**.  
  
6.  On the **Remote Access Review** dialog box, click **Apply**.  
  
7.  On the **Applying Remote Access Setup Wizard Settings** dialog box, click **Close**.  
  
To enable  Windows 7  client computers from Forest2 to access resources through DirectAccess when multisite is enabled, you must add the security group from Forest2 to the Remote Access deployment for each entry point. For information about adding  Windows 7  security groups, see the description of the **Client Support** page in 3.6. Enable the multisite deployment.  
  
### <a name="RefreshMgmtServers"></a>Refresh the management servers list  
Remote Access automatically discovers the infrastructure servers in all the forests that contain DirectAccess configuration GPOs. If DirectAccess was deployed on a server from Forest1, the server GPO will be written to its domain in Forest1. If you enabled access to DirectAccess for clients from Forest2, the client GPO will be written to a domain in Forest2.  
  
The automatic discovery process of infrastructure servers is required to allow access through DirectAccess to the domain controllers and Microsoft Endpoint Configuration Manager. You must manually start the discovery process.  
  
##### To refresh the management servers list  
  
1.  In the Remote Access Management console, click **Configuration**, and then in the **Tasks** pane, click **Refresh Management Servers**.  
  
2.  On the **Refreshing Management Servers** dialog box, click **Close**.  
  


