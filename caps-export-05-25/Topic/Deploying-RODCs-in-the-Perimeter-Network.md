---
title: Deploying RODCs in the Perimeter Network
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: f3b89418-bc56-4f76-a518-441c0ec9da54
author: Femila
---
# Deploying RODCs in the Perimeter Network
  This topic describes how to deploy a read only domain controller \(RODC\) in a perimeter network, thereby extending the corporate forest into the perimeter network.  
  
##  <a name="step_by_step_inst_deploy_RODC"></a> Deploying an RODC in the perimeter network  
 To deploy an RODC in a perimeter network:  
  
-   [Prepare the intranet forest and domain for the RODC](../Topic/Deploying-RODCs-in-the-Perimeter-Network.md#prepare_the_corp_forest_domain_for_RODC)  
  
-   [Prepare the server that is to be promoted to be the RODC](../Topic/Deploying-RODCs-in-the-Perimeter-Network.md#prepare_server_tobe_promoted_RODC)  
  
-   [Prepare firewall rules for communication from the RODC to the writeable domain controller](../Topic/Deploying-RODCs-in-the-Perimeter-Network.md#prepare_firewall_rules_RODC_writeable_dc_communication)  
  
-   [Promote the RODC server](../Topic/Deploying-RODCs-in-the-Perimeter-Network.md#dcrpomo_RODC_server)  
  
-   [Configure DHCP on the RODC for DNS name resolution and registration](../Topic/Deploying-RODCs-in-the-Perimeter-Network.md#configure_the_RODC)  
  
-   [Add computers to the perimeter network site](../Topic/Deploying-RODCs-in-the-Perimeter-Network.md#add_servers_tothe_perimeter_network_site)  
  
###  <a name="prepare_the_corp_forest_domain_for_RODC"></a> Prepare the intranet forest and domain for the RODC  
 Complete the following procedure to prepare the corporate forest and domain for the RODC. Membership in **Enterprise Admins**, or equivalent, is the minimum required to prepare the corporate forest for an RODC. Membership in **Domain Admins**, or equivalent, is the minimum required if you are preparing a domain for a RODC. [!INCLUDE[review_details](../Token/review_details_md.md)]  
  
##### To prepare the intranet forest and domain for the RODC  
  
1.  Ensure that you have completed the prerequisites for deployment of an RODC in domain and forests. For more information about RODC deployment, see Prerequisites for Deploying an RODC \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=133514](http://go.microsoft.com/fwlink/?LinkId=133514)\).  
  
2.  Create an Active Directory site in the perimeter network, and call it the PerimeterNetwork site. For more information about creating a site in Active Directory Domain Services, see Adding a New Site \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=93237](http://go.microsoft.com/fwlink/?LinkID=93237)\).  
  
3.  Create another Active Directory site in the internal corporate network. This site will be the closet intranet site to the perimeter network. It will contain the only writable domain controllers that RODCs in the perimeter network can access. Call this site the PerimeterNetwork Support Site.  
  
4.  Create a site link between the PerimeterNetwork Site and the PerimeterNetwork Support Site with a 24x7x15 schedule and higher cost than normal. For more information about site linking, see Linking Sites for Replication \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=133515](http://go.microsoft.com/fwlink/?LinkId=133515)\) and Changing Site Link Properties \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=133517](http://go.microsoft.com/fwlink/?LinkId=133517)\).  
  
    > [!NOTE]  
    >  The higher cost of the site link between the site where the perimeter network’s RODCs live and the intranet helps avoid the possibility of client computers in the corporate network site preferring the RODC site to another corporate site if a domain controller fails in the PerimeterNetwork Support Site.  
  
5.  Install two or more domain controllers in each domain that must validate users in the PerimeterNetwork Support Site. For information about installing an additional Windows Server 2008 domain controller, see Installing an Additional Windows Server 2008 Domain Controller \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=133258](http://go.microsoft.com/fwlink/?LinkID=133258)\). For more information about installing a new Windows Server 2008 child domain, see Installing a New Windows Server 2008 Child Domain \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=133519](http://go.microsoft.com/fwlink/?LinkId=133519)\).  
  
6.  Create a delegated RODC administrator account on each domain in the perimeter network. This can be a group or user account, but the best practice is for this account to be a group account. For more information about best practices for RODC administration, see “Delegating local administration of an RODC” in RODC Administration \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=133521](http://go.microsoft.com/fwlink/?LinkId=133521)\).  
  
7.  Add the perimeter network administrator users, which can belong to PerimeterNetwork domain or UsersDomain, to the properly domain\-linked, delegated RODC administrator group.  
  
8.  Create a PerimeterNetworkAllow group per domain.  
  
9. Create a PerimeterNetworkDeny group per domain.  
  
10. Add the delegated administrator group to the domain PerimeterNetworkAllow group for every domain.  
  
11. If no other RODC will act as the Dynamic Host Configuration Protocol \(DHCP\) server in the domain, allow the DHCP role to run on the RODC. For more information about DHCP, see article 822048 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=133526](http://go.microsoft.com/fwlink/?LinkId=133526)\). For more information about DHCP on a RODC, see Applications That Are Known to Work with RODCs \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=133779](http://go.microsoft.com/fwlink/?LinkId=133779)\).  
  
    > [!NOTE]  
    >  If you are not using DHCP in your perimeter network, you can skip this step as DHCP is not required.  
  
12. Create required Group Policy objects \(GPOs\) for the Perimeter Network domain:  
  
    1.  IPsec RODC\-to\-writeable domain controller communication policy  
  
    2.  Computer local firewall filter  
  
     For more information about the IPsec RODC\-to\-writeable domain controller communication policy and computer local firewall filter, see the Step\-by\-Step Guide to Internet Protocol Security \(IPsec\) \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=136018](http://go.microsoft.com/fwlink/?LinkId=136018)\) and Checklist: Implementing a Standalone Server Isolation Policy Design \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=133780](http://go.microsoft.com/fwlink/?LinkId=133780)\).  
  
###  <a name="prepare_server_tobe_promoted_RODC"></a> Prepare the server that is to be promoted to be the RODC  
 Complete the following procedure to prepare a server to assume the role of an RODC in the perimeter network. To complete this procedure, you need local server administrator credentials.  
  
##### To prepare the server that is to be promoted to be the RODC  
  
1.  Install Windows Server 2008 in a secure configuration on the computer that will become an RODC.  
  
2.  Configure the network adapter of the server that will become an RODC with the appropriate static IP configuration.  
  
3.  Configure the IPsec Local policy definition to allow RODC\-to\-writeable domain controller communication based on the writeable domain controller’s IPsec policy definition.  
  
    > [!NOTE]  
    >  While it is suggested that RODC promotion be performed from the perimeter network local area network \(LAN\), it is not possible to promote the first RODC in the perimeter network by using IPsec as the only means of communication with writeable domain controllers. Therefore, the promotion must be performed with full communication to a writeable domain controller by placing it temporarily on an internal network. In this case, the IPsec policy that belongs to the local computer’s GPO does not have to be active.  
    >   
    >  If you install a second RODC in the perimeter network, you can use the IPsec policy to promote the server to an RODC.  
  
###  <a name="prepare_firewall_rules_RODC_writeable_dc_communication"></a> Prepare firewall rules for communication from the RODC to the writeable domain controller  
 Complete the following procedure to prepare the firewall for RODC\-to\-writeable domain controller communication. To complete this procedure, you need local server administrator credentials.  
  
> [!NOTE]  
>  This procedure is only applicable is you are using IPsec. If you do not plan to use IPsec, you can skip this procedure.  
  
##### To prepare the firewall rules for communication from the RODC to the writeable domain controller  
  
1.  Prepare ports for RODC\-to\-writeable domain controller communication.  
  
     The choice of which ports to open depends in part on your decisions about:  
  
    1.  Which authentication method to use for IPsec communication: certificates or the Kerberos authentication protocol.  
  
    2.  Whether DNS updates are to be performed directly by client computers in the perimeter network or by a DHCP server.  
  
2.  Configure domain\-based IPsec policy to enable communication between writeable domain controllers and RODCs after the RODC is placed in the perimeter network.  
  
     You must make a choice between certificates and the Kerberos protocol. Certificates eliminate the requirement for Kerberos port 88 to be open on the firewall. For more information about certificates, see Certificates \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=136020](http://go.microsoft.com/fwlink/?LinkId=136020)\) and Certificate stores \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=136019](http://go.microsoft.com/fwlink/?LinkId=136019)\).  
  
     For example, you might:  
  
    1.  Modify IPsec policy settings in Group Policy that applies to the domain controllers that must communicate with IPsec.  
  
    2.  Use the settings and methods in the following table.  
  
        |Encryption|Integrity|Diffie Hellman|  
        |----------------|---------------|--------------------|  
        |3DES|SHA1|2|  
        |3DES|MD5|2|  
        |DES|SHA1|1|  
        |DES|MD5|1|  
  
         IPFILTER: Ensure that the IP filter encompasses the writable domain controllers and the RODC that is being promoted.  
  
         AUTHENTICATION: Add **Certificate** as an authentication mechanism and select the root certification authority \(CA\) for your enterprise. Ensure that the certificate method has priority over Kerberos authentication.  
  
         FILTER ACTION: Set the security methods **Integrity Only** and **Integrity and Encryption**. Select the **Fall back to unsecured communication if secure not established** check box.  
  
         When the settings are in place, mark the policy as assigned.  
  
3.  Prepare the certificate store on the RODC:  
  
    1.  Import the Root CA from the corporate CA into the Computer certificate store under **Trusted Root CAs**.  
  
    2.  Import the IPsec CA from the corporate CA into the Computer certificate store under **Personal Certificates**.  
  
4.  Create a local IPsec policy on the computer to be **RODC**. The policy should include the following:  
  
    1.  An appropriate IPFILTER to specify communication between the RODC and writeable domain controllers  
  
    2.  The AUTHENTICATION method set to Certificates with the Corporate Root CA cert specified  
  
    3.  The FILTER ACTION that specifies methods and configuration that match the domain\-based IPsec policy  
  
5.  Assign the local IPsec policy, and test that communication between the RODC and the writeable domain controller is successful.  
  
###  <a name="dcrpomo_RODC_server"></a> Promote the RODC server  
 Complete the following two procedures to promote the RODC server. To complete the tasks in part 1 and part 2 of this procedure, you must have delegated RODC administrator credentials.  
  
##### To promote the RODC server \(part 1\)  
  
1.  Precreate the RODC account.  
  
2.  Add the PerimeterNetworkAllow group to the RODC PRP Allow list.  
  
3.  Add the PerimeterNetworkDeny group to the RODC PRP Deny list.  
  
4.  Add the delegated RODC administrator group as a delegated administrator of RODC.  
  
##### To promote the RODC server \(part 2\)  
  
1.  Install the RODC computer with a Secure Base Image.  
  
2.  Configure the RODC network adapter with the appropriate static IP configuration for the LAN where promotion will take place.  
  
3.  Import the IPsec Local policy definition to allow RODC\-to\-writeable domain controller communication based on the writeable domain controller IPsec policy definition. \(Complete this step only if promotion is being performed from the perimeter network LAN.\)  
  
4.  Run Dcpromo.exe with delegated RODC administrator account credentials using an answer file if you are using a Windows Server 2008 Core installation.  
  
     For more information about using an answer file to run Dcpromo.exe on a server, see Installing a New Windows Server 2008 Forest by Using an Answer File \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=133800](http://go.microsoft.com/fwlink/?LinkId=133800)\).  
  
     The answer file should include a replication\/source writeable domain controller.  
  
5.  Run a quality control test after you reboot the server.  
  
    > [!NOTE]  
    >  Repeat the Dcpromo operation for each RODC to be installed in the perimeter network.  
  
###  <a name="configure_the_RODC"></a> Configure DHCP on the RODC for DNS name resolution and registration  
 Complete the following procedure to configure DHCP on the RODC server in the perimeter network for DNS name resolution and registration.  This is the recommended configuration for DNS name resolution and registration for clients in the perimeter network.  If you do not plan to install the DHCP role on the RODC, then you must use one of the methods detailed in [Configuring DNS for name resolution and registration](http://go.microsoft.com/fwlink/?LinkId=214036) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=214036\) for DNS name resolution and registration.  
  
##### To configure DHCP on the RODC  
  
1.  Install the DHCP Service on the RODC.  
  
2.  Add scope for the subnets in the Perimeter Network site.  
  
3.  Configure the scope options with the RODC’s IP address as the DNS address. Use the RODC’s IP address as the DNS setting for perimeter network clients.  
  
4.  Set the DHCP option to overwrite client requests and update DNS on behalf of client requests.  
  
5.  Configure a domain account to be used for performing DNS updates on behalf of client computers.  
  
6.  Add reservations for known client media access control \(MAC\) addresses in the perimeter network to associate them with IP addresses for servers in the Perimeter Network site.  
  
###  <a name="add_servers_tothe_perimeter_network_site"></a> Add computers to the perimeter network site  
 In this section, you will find instructions and a sample script that can be used to domain join a Windows Server 2008, Windows Server 2008 R2 or Windows Vista SP 1 machine to a perimeter network.  
  
> [!NOTE]  
>  For read\-only domain joins on Windows Server 2003 or Windows XP client computers, install the RODC compatibility pack.  For more information about the installation of the RODC compatibility pack see the Microsoft support article, [http:\/\/go.microsoft.com\/fwlink\/?LinkID\=122974](http://go.microsoft.com/fwlink/?LinkID=122974).  
  
#### Assumptions  
 The following conditions are assumed to be in place in order to complete a domain join through a read\-only domain controller \(RODC\):  
  
-   The perimeter network and the intranet are separated by a firewall.  
  
-   The client computer can communicate with the RODC in the perimeter network but not with domain controllers in the internal network.  
  
-   The RODC can communicate with a domain controller in the internal network at the time of the domain join.  
  
-   The first four procedures have been completed before the join is attempted.  
  
-   If NETBIOS name resolution is required in the perimeter network, ensure Windows Internet Name Service \(WINS\) is enabled.  
  
#### Performing a domain join through an RODC  
 Complete the following tasks to perform a domain join through an RODC. Domain Admin credentials are required to perform these tasks.  
  
-   [Precreate the computer account](../Topic/Deploying-RODCs-in-the-Perimeter-Network.md#precreate_comp_acct)  
  
-   [Set a nondefault password for the computer account](../Topic/Deploying-RODCs-in-the-Perimeter-Network.md#set_nondef_pass_computer_acct)  
  
-   [Make the account cacheable at the RODC](../Topic/Deploying-RODCs-in-the-Perimeter-Network.md#mk_acct_cacheable_RODC)  
  
-   [Replicate the secrets of the computer account to the RODC](../Topic/Deploying-RODCs-in-the-Perimeter-Network.md#rep_screts_comp_acct_rodc)  
  
-   [Run the join script on the client computer or use offline domain join to join the client computer to the domain](../Topic/Deploying-RODCs-in-the-Perimeter-Network.md#run_join_script)  
  
#####  <a name="precreate_comp_acct"></a> Precreate the computer account  
 In the following procedure, you precreate the computer account that you plan to join to the domain through an RODC.  
  
###### To precreate the computer account  
  
1.  Log on to a domain controller in the internal network.  
  
2.  Click **Start**, right\-click **Command Prompt**, and then click **Run as administrator**.  
  
3.  If the **User Account Control** dialog appears, confirm that the action it displays is what you want, and then click **Continue**.  
  
4.  At the elevated command prompt, type the following command, and then press ENTER:  
  
     `net computer \\comp1 /add`  
  
     Replace `comp1` with the name of the computer account that is to join the domain.  
  
#####  <a name="set_nondef_pass_computer_acct"></a> Set a nondefault password for the computer account  
 In the following procedure, you set a nondefault password for the computer account. In general, whenever you create a computer account, a default password is created.  
  
###### To set a nondefault password for the computer account  
  
1.  Log on to a domain controller in the intranet.  
  
2.  Click **Start**, right\-click **Command Prompt**, and then click **Run as administrator**.  
  
3.  If the **User Account Control** dialog appears, confirm that the action it displays is what you want, and then click **Continue**.  
  
4.  At the elevated command prompt, type the following command, and then press ENTER:  
  
     `net user comp1$ <password>`  
  
     Replace `comp1` with the name of the computer account that is to join the domain.  
  
#####  <a name="mk_acct_cacheable_RODC"></a> Make the account cacheable at the RODC  
 In the following procedure, you make the computer account cacheable at the RODC. There are two approaches you can take to make the computer account cacheable at the RODC. Both approaches are described here, but the second approach is the recommended approach because it is more secure.  
  
###### Approach 1: To make the computer account cacheable at all the RODCs in the domain  
  
1.  Log on to a domain controller in the intranet.  
  
2.  Click **Start**, right\-click **Command Prompt**, and then click **Run as administrator**.  
  
3.  If the **User Account Control** dialog appears, confirm that the action it displays is what you want, and then click **Continue**.  
  
4.  To make the computer account cacheable at all RODCs, type the following command at the elevated command prompt, and then press ENTER:  
  
     `net localgroup Allowed RODC Password Replication Group comp1$ /add`  
  
     Replace `comp1` with the name of the computer account that is to be cacheable at all RODCs.  
  
###### Approach 2: To make the computer account cacheable at the perimeter network RODC  
  
1.  Log on to a domain controller in the intranet.  
  
2.  Click **Start**, right\-click **Command Prompt**, and then click **Run as administrator**.  
  
3.  If the **User Account Control** dialog appears, confirm that the action it displays is what you want, and then click **Continue**.  
  
4.  To make the computer account cacheable at the RODC, type the following command at the elevated command prompt, and then press ENTER:  
  
     `net localgroup <administrator created domain local group used to store user and computer accounts that are cacheable at the RODC> comp1$ /add`  
  
     Replace `comp1` with the name of the computer account that you want to be cacheable at the RODC.  
  
     The placeholder `<administrator created domain local group used to store user and computer accounts that are cacheable at the RODC>` is a domain local group that you create to store user and computers accounts that you want to cache at the RODC.  
  
     For example, you can create a domain local group, RODC1 Cached Accounts, and add any user or computer account to that group that you want to make cacheable at the RODC, RODC1.  
  
#####  <a name="rep_screts_comp_acct_rodc"></a> Replicate the secrets of the computer account to the RODC  
 In the following procedure, you replicate the secrets of the computer account to the RODC.  
  
###### To replicate the secrets of the computer account to the RODC  
  
1.  Log on to a domain controller in the intranet.  
  
2.  Click **Start**, right\-click **Command Prompt**, and then click **Run as administrator**.  
  
3.  If the **User Account Control** dialog appears, confirm that the action it displays is what you want, and then click **Continue**.  
  
4.  At the elevated command prompt, type the following command, and then press ENTER:  
  
     `repadmin /rodcpwdrepl RODC1 DC1 CN=comp1,CN=Computers,DC=fabrikam,DC=com`  
  
    1.  Replace `RODC1` with the name of the RODC computer account.  
  
    2.  Replace `DC1` with the name of the RWDC located in the intranet.  
  
    3.  Replace `CN=comp1,CN=Computer,DC=fabrikam,DC=com` with the distinguished name of the computer account that will have its secrets replicated to the RODC.  
  
#####  <a name="run_join_script"></a> Run the join script on the client computer or use offline domain join to join the client computer to the domain  
 You can use the following two methods to join a client computer to a domain through a RODC:  
  
-   Offline Domain Join – For more information on using offline domain join see, [Offline Domain Join](http://go.microsoft.com/fwlink/?LinkID=195444) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=195444\)  
  
-   Sample Script for RODC Domain Join – The following procedure details how to run a sample script to join a client machine to the domain through a RODC.  
  
###### To run the join script on the client computer  
  
1.  Log on to the client computer that will join the domain through the RODC.  
  
2.  Create a new text file titled Join Script.  
  
3.  Copy the contents from the following section, [Sample script for RODC domain join](../Topic/Deploying-RODCs-in-the-Perimeter-Network.md#sample_script_RODC_join), to this text file.  
  
4.  Rename the file to Join Script.vbs, and then double\-click the file to run the script.  
  
     You can customize this script to meet the needs of your organization.  
  
5.  Open a registry editor, such as regedit.exe  
  
6.  Navigate to: **HKLM\\System\\CurrentControlSet\\Services\\Netlogon\\Parameters**  
  
7.  In the right pane, create a new **String Value** titled SiteName and for the **Value Name** type the name of the site in which the client computer resides.  
  
8.  Close the registry editor and restart the client computer to have registry changes take effect.  
  
##  <a name="sample_script_RODC_join"></a> Sample script for RODC domain join  
  
```c#  
' JoinScript.vbs  
'   
'     Script to join a computer to a domain.  
'       
'  
'  
  
sub Usage  
   wscript.echo " |------------------------------------------------|"  
   wscript.echo " |   Joins a computer to a domain or workgroup    |"  
   wscript.echo " |------------------------------------------------|"  
   wscript.echo ""  
   wscript.echo "Usage: "  
   wscript.echo " cscript JoinScript.vbs [/domain <domainname> | /workgroup <workgroupname>]"   
   wscript.echo "                        [/unjoin] [user <username>] [/password <password>]"  
   wscript.echo "                        [/machinepassword <password>] [/readonly] [/createaccount]"  
   wscript.echo "                        [/unsecure]"  
   wscript.echo ""  
   wscript.echo "domain           Specifies the name of a domain to join"   
   wscript.echo "                 This option requires user, password"  
   wscript.echo ""  
   wscript.echo "workgroup        Specifies the name of a workgroup to join"  
   wscript.echo ""  
   wscript.echo "unjoin           Unjoin from a domain if currently joined."  
   wscript.echo ""  
   wscript.echo "disable          Disable the account when unjoining the domain."  
   wscript.echo "                 This option requires unjoin, user, and password."  
   wscript.echo ""  
   wscript.echo "createaccount    Specifies to create the computer account in AD"  
   wscript.echo ""  
   wscript.echo "machinepassword  Specifies a password which is used to"  
   wscript.echo "                 authenticate as the machine account to the DC"  
   wscript.echo ""  
   wscript.echo "readonly         Specifies the domain join will be read only"   
   wscript.echo "                 and will not require a writable DC. This option"    
   wscript.echo "                 requires machinepassword and that an Administrator"  
   wscript.echo "                 has pre-created the computer account and set a"  
   wscript.echo "                 password matching the machinepassword parameter."  
   wscript.echo ""  
   wscript.echo "DC               Specifies a DC to use during domain join."  
   wscript.echo "                 If readonly is specified this is mandatory, otherwise optional."  
   wscript.echo ""  
   wscript.echo "OU               Specifies an OU where the machine account is created, this is optional."  
   wscript.echo ""  
   wscript.echo ""  
   wscript.echo "Unsecure         Specifies a an unsecure domain join."  
   wscript.echo ""  
   wscript.echo " |------------------------------------------------|"  
   wscript.echo " |Examples: Run 'cscript JoinScript.vbs <args>'   |"  
   wscript.echo " |          <args>: Choose a scenario below       |"  
   wscript.echo " | * Note lines have been wrapped for readability |"  
   wscript.echo " |------------------------------------------------|"  
   wscript.echo ""  
   wscript.echo "  Join domain: /domain <domainname> /user <username>"  
   wscript.echo "               /password <password> /createaccount"  
   wscript.echo ""  
   wscript.echo "  Join domain with existing account: /domain <domainname>"  
   wscript.echo "                                     /user <username>"  
   wscript.echo "                                     /password <password>"  
   wscript.echo ""  
   wscript.echo "  Unjoin from a domain: /unjoin /user <username> /password <password>"  
   wscript.echo "                        "  
   wscript.echo ""  
   wscript.echo "  Read Only join domain: /domain <domainname> /machinepassword <password>"  
   wscript.echo "                         /dc <rodcname> /readonly"  
   wscript.echo ""  
   wscript.echo "  Join workgroup: /workgroup <workgroupname>"  
   wscript.echo ""  
   wscript.echo ""  
   wscript.quit -1  
end sub  
  
'  
' Get the command line arguments  
'  
Set Args = Wscript.Arguments  
'Set ArgCount = Args.Count  
  
' Validation and Usage   
if Args.Count = 0 then  
   wscript.echo "Help Requested"  
   wscript.echo ""  
   Usage  
end if  
  
if Args.Count > 0 then  
   if Args(0) = "/?" or Args(0) = "-?" or Args(0) = "help" then  
      wscript.echo "Help Requested"  
      wscript.echo ""  
      Usage  
   end if  
   if Args.Count < 1 then  
      wscript.echo "Help Requested"  
      wscript.echo ""  
      Usage  
   end if  
end if  
  
' NetJoinDomain flags  
Const NETSETUP_JOIN_DOMAIN = 1   
Const NETSETUP_ACCT_CREATE = 2   
Const NETSETUP_ACCT_DELETE = 4   
Const NETSETUP_WIN9X_UPGRADE = 16   
Const NETSETUP_DOMAIN_JOIN_IF_JOINED = 32   
Const NETSETUP_JOIN_UNSECURE = 64   
Const NETSETUP_MACHINE_PWD_PASSED = 128   
Const NETSETUP_DEFER_SPN_SET = 256   
Const NETSETUP_JOIN_READONLY = 2048  
Const NETSETUP_INSTALL_INVOCATION = 262144   
  
' Local state to track limited parameter validation  
Options = 0  
ReadOnly = 0  
Unsecure = 0  
JoinWorkgroup = 0   
UnjoinDomain = 0  
MachinePassword = 0  
  
' Inputs for the join call  
strDC = ""  
strOU = ""  
strDomainName = ""  
strDomainNameAndDC = ""  
strPassword = ""  
strUserName = ""  
  
' Collect parameters  
ArgNum = 0  
  
do while ArgNum < Args.Count   
  
   if Args(ArgNum) = "/domain" or Args(ArgNum) = "/Domain" then  
      strDomainName = Args(ArgNum+1)  
      Options = Options + NETSETUP_JOIN_DOMAIN  
      ArgNum = ArgNum + 1  
   end if  
  
   if Args(ArgNum) = "/user" or Args(ArgNum) = "/User" then  
      strUserName = Args(ArgNum+1)  
      ArgNum = ArgNum + 1  
   end if  
  
   if Args(ArgNum) = "/password" or Args(ArgNum) = "/Password" then  
      strPassword = Args(ArgNum+1)  
      ArgNum = ArgNum + 1  
   end if  
  
   if Args(ArgNum) = "/machinepassword" or Args(ArgNum) = "/MachinePassword" then  
      strPassword = Args(ArgNum+1)  
      MachinePassword = 1  
      Options = Options + NETSETUP_MACHINE_PWD_PASSED  
      ArgNum = ArgNum + 1  
   end if  
  
   if Args(ArgNum) = "/readonly" or Args(ArgNum) = "/ReadOnly" then  
      Options = Options + NETSETUP_JOIN_READONLY  
      ReadOnly = 1        
   end if  
  
   if Args(ArgNum) = "/unsecure" or Args(ArgNum) = "/Unsecure" then  
      Options = Options + NETSETUP_JOIN_UNSECURE  
      Unsecure = 1        
   end if  
  
   if Args(ArgNum) = "/workgroup" or Args(ArgNum) = "/WorkGroup" then  
      JoinWorkgroup = 1   
      strDomainName = Args(ArgNum+1)  
      ArgNum = ArgNum + 1  
   end if  
  
   if Args(ArgNum) = "/dc" or Args(ArgNum) = "/DC" then  
      strDC = Args(ArgNum+1)  
      ArgNum = ArgNum + 1  
   end if  
  
   if Args(ArgNum) = "/ou" or Args(ArgNum) = "/OU" then  
      strOU = Args(ArgNum+1)  
      ArgNum = ArgNum + 1  
   end if  
  
   if Args(ArgNum) = "/unjoin" or Args(ArgNum) = "/Unjoin" then  
      UnjoinDomain = 1  
      ArgNum = ArgNum + 1  
   end if  
  
   if Args(ArgNum) = "/disable" or Args(ArgNum) = "/disable" then  
      Disable = 1  
      Options = Options + NETSETUP_ACCT_DELETE         
   end if  
  
   if Args(ArgNum) = "/createaccount" or Args(ArgNum) = "/CreateAccount" then   
      Options = Options + NETSETUP_ACCT_CREATE        
   end if  
  
   ArgNum = ArgNum + 1  
  
loop                
  
' Error reporting  
if ReadOnly = 1 then  
   if MachinePassword = 0 then  
       wscript.echo "ReadOnly requires MachinePassword"  
       wscript.quit(-1)         
   end if  
end if    
  
if Disable = 1 and UnjoinDomain = 0 then  
       wscript.echo "Disable is only valid with the unjoin option"  
       wscript.quit(-1)         
end if  
  
' The username is optional and may need to be NULL when passed to the join API below  
if strUserName = "" then optionAux = NULL else optionAux = strUserName  
  
' The OU is optional and may need to be NULL when passed to the join API below  
if strOU = "" then optionOU = NULL else optionOU = strOU  
  
' Handle the case where this is a domain join and a DC was specified  
if strDC = "" then strDomainNameAndDC = strDomainName else strDomainNameAndDC = strDomainName & "\" & strDC  
  
wscript.echo strDomainNameAndDC  
  
Set objNetwork = CreateObject("WScript.Network")   
strComputer = objNetwork.ComputerName   
  
Set objComputer = GetObject("winmgmts:{impersonationLevel=Impersonate}!\\" & strComputer & "\root\cimv2:Win32_ComputerSystem.Name='" & strComputer & "'")   
'ReturnValue = objComputer.JoinDomainOrWorkGroup(strDomainName, strPassword, strDomainName & "\" & strUserName, NULL, NETSETUP_JOIN_DOMAIN + NETSETUP_JOIN_READONLY + NETSETUP_MACHINE_PWD_PASSED)  
  
' Perform the join/unjoin operation  
if UnjoinDomain = 1 then  
   ReturnValue = objComputer.UnjoinDomainOrWorkGroup(strPassword, optionAux, Options)  
else  
   ReturnValue = objComputer.JoinDomainOrWorkGroup(strDomainNameAndDC, strPassword, optionAux, optionOU, Options)  
end if  
  
' Report success messages  
if ReturnValue = 0 then  
      if JoinWorkgroup = 1 then  
         wscript.echo "Welcome to the workgroup: " & strDomainName  
         wscript.quit(0)  
      end if  
  
      if UnjoinDomain = 1 then  
         wscript.echo "The machine was unjoined from the domain."  
         wscript.quit(0)  
      end if  
  
      if JoinWorkgroup = 0 then  
         wscript.echo "Welcome to the domain: " & strDomainName  
         wscript.quit(0)  
      end if  
else  
    wscript.echo "Error: " & ReturnValue  
end if  
```  
  
  