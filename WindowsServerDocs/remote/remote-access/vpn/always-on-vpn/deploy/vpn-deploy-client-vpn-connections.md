---
title: Configure Windows 10 Client Always On VPN Connections
ms.author: pashort
author: shortpatti
---

# Configure Windows 10 Client Always On VPN Connections

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows 10

The final step in the Always On VPN deployment process, unless you are migrating from DirectAccess to Always On VPN, is to configure the Always On VPN connection in Windows 10 client.


You can use several technologies to configure Windows 10 VPN clients, including
Windows PowerShell, System Center Configuration Manager, and Intune in which all three require an XML VPN profile to configure the appropriate VPN settings.


>[!NOTE] Group Policy does not include administrative templates to configure the Windows 10 Remote Access Always On VPN client, however you can use logon scripts.

In this guide’s scenario, you use Protected Extensible Authentication Protocol (PEAP) to secure communication between the client and the server. Unlike a simple user name and password, this connection requires a unique EAPConfiguration section in the VPN profile to work.

Rather than describing how to create the XML markup for that section from scratch, you can use the Windows user interface to create a template VPN profile, and then use Windows PowerShell to consume the EAPConfiguration portion from that template to create the final ProfileXML that you will deploy later in the guide.

## Prerequisites
- Make sure you review the [ProfileXML Overview](../../profile-overview.md) to have an understanding of the ProfileXML conifuguration files. The ProfileXML Overview section also includes the [MakeProfile.ps1 Full Script](../../profile-overview.md#makeprofile-full-script) section includes all of the code to generate two files: VPN_Profile.xml and VPN_Profile.ps1. 
- Ensure you have the host name or FQDN of the NPS from the server's certificate and the name of the CA that issued the certificate.



### Configure the VPN client by using Windows PowerShell

To configure the VPNv2 CSP on a Windows 10 client computer, run the
VPN_Profile.ps1 Windows PowerShell script that you created in the section
“Create the ProfileXML configuration files.” Open Windows PowerShell as an
Administrator; otherwise, you’ll receive an error saying, “Access denied.”

After running VPN_Profile.ps1 to configure the VPN profile, you can verify at
any time that it was successful by running the following command in the Windows
PowerShell ISE:

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Get-WmiObject -Namespace root\cimv2\mdm\dmmap -Class MDM_VPNv2_01
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Successful results look similar to Listing 2.

Listing 2. Successful results from the Get-WmiObject cmdlet

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
__GENUS : 2
__CLASS : MDM_VPNv2_01
__SUPERCLASS:
__DYNASTY   : MDM_VPNv2_01
__RELPATH   : MDM_VPNv2_01.InstanceID="Contoso%20AlwaysOn%20VPN",ParentID
  ="./Vendor/MSFT/VPNv2"
__PROPERTY_COUNT: 10
__DERIVATION: {}
__SERVER: WIN01
__NAMESPACE : root\cimv2\mdm\dmmap
__PATH  : \\WIN01\root\cimv2\mdm\dmmap:MDM_VPNv2_01.InstanceID="Conto
  so%20AlwaysOn%20VPN",ParentID="./Vendor/MSFT/VPNv2"
AlwaysOn: True
ByPassForLocal  :
DnsSuffix   : corp.contoso.com
EdpModeId   :
InstanceID  : Contoso%20AlwaysOn%20VPN
LockDown:
ParentID: ./Vendor/MSFT/VPNv2
ProfileXML  : <VPNProfile><RememberCredentials>true</RememberCredentials>
  <AlwaysOn>true</AlwaysOn><DnsSuffix>corp.contoso.com</DnsSu
  ffix><TrustedNetworkDetection>corp.contoso.com</TrustedNetw
  orkDetection><NativeProfile><Servers>vpn.contoso.com;vpn.co
  ntoso.com</Servers><RoutingPolicyType>SplitTunnel</RoutingP
  olicyType><NativeProtocolType>Ikev2</NativeProtocolType><Au
  thentication><UserMethod>Eap</UserMethod><MachineMethod>Eap
  </MachineMethod><Eap><Configuration><EapHostConfig xmlns="h
  ttp://www.microsoft.com/provisioning/EapHostConfig"><EapMet
  hod><Type xmlns="https://www.microsoft.com/provisioning/EapC
  ommon">25</Type><VendorId xmlns="https://www.microsoft.com/p
  rovisioning/EapCommon">0</VendorId><VendorType xmlns="http:
  //www.microsoft.com/provisioning/EapCommon">0</VendorType><
  AuthorId xmlns="https://www.microsoft.com/provisioning/EapCo
  mmon">0</AuthorId></EapMethod><Config xmlns="http://www.mic
  rosoft.com/provisioning/EapHostConfig"><Eap xmlns="http://w
  ww.microsoft.com/provisioning/BaseEapConnectionPropertiesV1
  "><Type>25</Type><EapType xmlns="https://www.microsoft.com/p
  rovisioning/MsPeapConnectionPropertiesV1"><ServerValidation
  ><DisableUserPromptForServerValidation>true</DisableUserPro
  mptForServerValidation><ServerNames>NPS</ServerNames><Trust
  edRootCA>3f 07 88 e8 ac 00 32 e4 06 3f 30 f8 db 74 25 e1
  2e 5b 84 d1 </TrustedRootCA></ServerValidation><FastReconne
  ct>true</FastReconnect><InnerEapOptional>false</InnerEapOpt
  ional><Eap xmlns="https://www.microsoft.com/provisioning/Bas
  eEapConnectionPropertiesV1"><Type>13</Type><EapType xmlns="
  https://www.microsoft.com/provisioning/EapTlsConnectionPrope
  rtiesV1"><CredentialsSource><CertificateStore><SimpleCertSe
  lection>true</SimpleCertSelection></CertificateStore></Cred
  entialsSource><ServerValidation><DisableUserPromptForServer
  Validation>true</DisableUserPromptForServerValidation><Serv
  erNames>NPS</ServerNames><TrustedRootCA>3f 07 88 e8 ac 00
  32 e4 06 3f 30 f8 db 74 25 e1 2e 5b 84 d1 </TrustedRootCA><
  /ServerValidation><DifferentUsername>false</DifferentUserna
  me><PerformServerValidation xmlns="https://www.microsoft.com
  /provisioning/EapTlsConnectionPropertiesV2">true</PerformSe
  rverValidation><AcceptServerName xmlns="http://www.microsof
  t.com/provisioning/EapTlsConnectionPropertiesV2">true</Acce
  ptServerName></EapType></Eap><EnableQuarantineChecks>false<
  /EnableQuarantineChecks><RequireCryptoBinding>false</Requir
  eCryptoBinding><PeapExtensions><PerformServerValidation xml
  ns="https://www.microsoft.com/provisioning/MsPeapConnectionP
  ropertiesV2">true</PerformServerValidation><AcceptServerNam
  e xmlns="https://www.microsoft.com/provisioning/MsPeapConnec
  tionPropertiesV2">true</AcceptServerName></PeapExtensions><
  /EapType></Eap></Config></EapHostConfig></Configuration></E
  ap></Authentication></NativeProfile><DomainNameInformation>
  <DomainName>corp.contoso.com</DomainName><DnsServers>10.10.
  0.2,10.10.0.3</DnsServers><AutoTrigger>true</AutoTrigger></
  DomainNameInformation></VPNProfile>
RememberCredentials : True
TrustedNetworkDetection : corp.contoso.com
PSComputerName  : WIN01
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The ProfileXML configuration must be correct in structure, spelling,
configuration, and sometimes letter case. If you see something different in
structure to Listing 1, the ProfileXML markup likely contains an error.

If you need to troubleshoot the markup, it is easier to put it in an XML editor
than to troubleshoot it in the Windows PowerShell ISE. In either case, start
with the simplest version of the profile, and add components back one at a time
until the issue occurs again.

Configure the VPN client by using System Center Configuration Manager
---------------------------------------------------------------------

In System Center Configuration Manager, you can deploy VPN profiles by using the
ProfileXML CSP node, just like you did in Windows PowerShell. Here, you use the
VPN_Profile.ps1 Windows PowerShell script that you created in the section
[Create the ProfileXML configuration files](#bkmk_ProfileXML).

To use System Center Configuration Manager to deploy a Remote Access Always On
VPN profile to Windows 10 client computers, you must start by creating a group
of machines or users to whom you will deploy the profile. In this scenario,
create a user group to deploy the configuration script.

**To create a user group**

1.  In the Configuration Manager console, open Assets and Compliance\\User
    Collections.

2.  On the **Home** ribbon, in the **Create** group, click **Create User
    Collection**.

3.  On the General page, complete the following steps:

    1.  In **Name**, type **VPN Users**.

    2.  Click **Browse**, click **All Users**, and click **OK**.

    3.  Click **Next**.

4.  On the Membership Rules page, complete the following steps:

    1.  In **Membership rules**, click **Add Rule**, and click **Direct Rule**.
        In this example, you’re adding individual users to the user collection.
        However, you might use a query rule to add users to this collection
        dynamically for a larger-scale deployment.

    2.  On the **Welcome** page, click **Next**.

    3.  On the Search for Resources page, in **Value**, type the name of the
        user you want to add. The resource name includes the user’s domain. To
        include results based on a partial match, insert the **%** character at
        either end of your search criterion. For example, to find all users
        containing the string “lori,” type **%lori%**. Click **Next**.

    4.  On the Select Resources page, select the users you want to add to the
        group, and click **Next**.

    5.  On the Summary page, click **Next**.

    6.  On the Completion page, click **Close**.

5.  Back on the Membership Rules page of the Create User Collection Wizard,
    click **Next**.

6.  On the Summary page, click **Next**.

7.  On the Completion page, click **Close**.

After you create the user group to receive the VPN profile, you can create a
package and program to deploy the Windows PowerShell configuration script that
you created in the section [Create the ProfileXML configuration
files](#bkmk_ProfileXML).

**To create a package containing the ProfileXML configuration script**

1.  Host the script VPN_Profile.ps1 on a network share that the site server
    computer account can access.

2.  In the Configuration Manager console, open Software Library\\Application
    Management\\Packages.

3.  On the **Home** ribbon, in the **Create** group, click **Create Package** to
    start the Create Package and Program Wizard.

4.  On the Package page, complete the following steps:

    1.  In **Name**, type **Windows 10 Always On VPN Profile**.

    2.  Select the **This package contains source files** check box, and click
        **Browse**.

    3.  In the Set Source Folder dialog box, click **Browse**, select the file
        share containing VPN_Profile.ps1, and click **OK**.

Make sure you select a network path, not a local path. In other words, the path
should be something like *\\fileserver\\vpnscript*, not *c:\\vpnscript.*.

1.  Click **Next**.

2.  On the Program Type page, click **Next**.

3.  On the Standard Program page, complete the following steps:

    1.  In **Name**, type **VPN Profile Script**.

    2.  In **Command line**, type **PowerShell.exe -ExecutionPolicy Bypass -File
        "VPN_Profile.ps1"**.

    3.  In **Run mode**, click **Run with administrative rights**.

    4.  Click **Next**.

4.  On the Requirements page, complete the following steps:

    1.  Select **This program can run only on specified platforms**.

    2.  Select the **All Windows 10 (32-bit)** and **All Windows 10 (64-bit)**
        check boxes.

    3.  In **Estimated disk space**, type **1**.

    4.  In **Maximum allowed run time (minutes)**, type **15**.

    5.  Click **Next**.

5.  On the Summary page, click **Next**.

6.  On the Completion page, click **Close**.

With the package and program created, you need to deploy it to the **VPN Users**
group.

**To deploy the ProfileXML configuration script**

1.  In the Configuration Manager console, open Software Library\\Application
    Management\\Packages.

2.  In **Packages**, click **Windows 10 Always On VPN Profile**.

3.  On the **Programs** tab, at the bottom of the details pane, right-click
    **VPN Profile Script**, click **Properties**, and complete the following
    steps:

    1.  On the **Advanced** tab, in **When this program is assigned to a
        computer**, click **Once for every user who logs on**.

    2.  Click **OK**.

4.  Right-click **VPN Profile Script,** and click **Deploy** to start the Deploy
    Software Wizard.

5.  On the General page, complete the following steps:

    1.  Beside **Collection**, click **Browse**.

    2.  In the **Collection Types** list (top left), click **User Collections**.

    3.  Click **VPN Users**, and click **OK**.

    4.  Click **Next**.

6.  On the Content page, complete the following steps:

    1.  Click **Add**, and click **Distribution Point**.

    2.  In **Available distribution points**, select the distribution points to
        which you want to distribute the ProfileXML configuration script, and
        click **OK**.

    3.  Click **Next**.

7.  On the Deployment settings page, click **Next**.

8.  On the Scheduling page, complete the following steps:

    1.  Click **New** to open the Assignment Schedule dialog box.

    2.  Click **Assign immediately after this event**, and then click **OK**.

    3.  Click **Next**.

9.  On the User Experience page, complete the following steps:

    1.  Select the **Software Installation** check box.

    2.  Click **Summary**.

10. On the Summary page, click **Next**.

11. On the Completion page, click **Close**.

With the ProfileXML configuration script deployed, sign in to a Windows 10
client computer with the user account you selected when you built the user
collection. Verify configuration of the VPN client.

>   [!NOTE] The script VPN_Profile.ps1 will not work in a Remote Desktop
>   session. Likewise, it will not work in a Hyper-V enhanced session. If you’re
>   testing a Remote Access Always On VPN in virtual machines, disable enhanced
>   session on your client VMs before continuing.

**To verify configuration of the VPN client**

1.  In Control Panel, click **Configuration Manager**. **Configuration Manager**
    is under **System**\\**Security**.

2.  In the Configuration Manager Properties dialog box, on the **Actions** tab,
    complete the following steps:

    1.  Click **Machine Policy Retrieval & Evaluation Cycle**, click **Run
        Now**, and click **OK**.

    2.  Click **User Policy Retrieval & Evaluation Cycle**, click **Run Now**,
        and click **OK**.

    3.  Click **OK**.

3.  Close Control Panel.

You should see the new VPN profile shortly.

Configure the VPN client by using Intune
----------------------------------------

To use Intune to deploy Windows 10 Remote Access Always On VPN profiles, you can
configure the ProfileXML CSP node by using the VPN profile you created in the
section [Create the ProfileXML configuration files](#bkmk_ProfileXML).

In this example, you use the profile stored in VPN_Profile.xml.

>   [!NOTE]

>   Client computers and users appear in Intune after you have configured Azure
>   Active Directory Connect and enrolled the devices in Intune. This guide
>   doesn’t explain how to enroll devices in Intune. For details on how to
>   manage devices with Intune, see [Enroll your Windows 10 device in
>   Intune](https://docs.microsoft.com/intune-user-help/enroll-your-w10-device-access-work-or-school).

>   This guide describes how to deliver certificates to domain-joined devices by
>   using autoenrollment only. For information about using Intune to deliver
>   certificates to devices, see [How to configure certificates in Microsoft
>   Intune](https://docs.microsoft.com/intune/certificates-configure).

### Create a VPN Users group for managed users or devices

To deploy a Windows 10 Remote Access Always On VPN profile, start by creating a
group that contains the managed users or devices that should receive the VPN
profile.

**Create a group that contains the managed users or devices**

1.  Sign in to <https://manage.microsoft.com> as an Intune administrator.

2.  In the Intune Admin Console, click **GROUPS**, and click **Groups**.

3.  Click **Access your groups in the new Azure portal by clicking here**. You
    now manage Intune groups in the Azure Portal. For this reason, you’ll be
    redirected to the Azure Portal when you click the **Create Groups** link.

4.  In the Azure Portal, near the top of the page, click **New group**.

5.  In **Name**, type **VPN Users**.

6.  In **Membership type**, click **Assigned**. In this example, you’re
    assigning individual users to the **VPN Users** group. Alternatively, you
    could create a dynamic rule to include users based on a query result.

7.  Click **Members**, and complete the following steps:

    1.  In **Select**, begin typing the name of a user you want to add to the
        group.

    2.  In the list, select the check box next to that user’s full name.

    3.  Repeat the previous two steps for each person you want to add to the
        group.

    4.  Click **Select**.

8.  Click **Create** to create the group.

9.  Close the Azure Portal.

### Create the Always On VPN configuration policy

After creating the VPN Users group, create the VPN configuration policy with
which to configure the Windows 10 client computers for the users you added to
the group. You will copy the contents of the VPN_Profile.xml file that you
created in the section “Create the ProfileXML configuration files” into the
policy’s value.

**To create the Always On VPN configuration policy**

1.  In the Intune Admin Console, click **POLICY**, and click **Configuration
    Policies**.

2.  In the Policies workspace, click **Add** to start the Create a New Policy
    Wizard.

3.  On the Select a template for the new policy page, under **Windows**, click
    **Custom Configuration (Windows 10 Desktop and Mobile and later)**, and then
    click **Create Policy**. You will notice a configuration policy called VPN
    Profile (Windows 10 Desktop and Mobile and later). This configuration policy
    doesn’t provide the ability to configure the Always On setting. To configure
    Always On triggering, you must configure the ProfileXML node of the VPNv2
    CSP by using the OMA-URI in the Custom Configuration (Windows 10 Desktop and
    Mobile and later) configuration policy.

4.  In **Name**, type **Contoso Always On VPN Profile**.

5.  In the **OMA-URI Settings** section, click **Add** to open the Add or edit
    OMA-URI Setting dialog box, and complete the following steps:

    1.  In **Setting name**, type **Windows 10 Always On VPN**.

    2.  In **Setting description**, type **ProfileXML Settings for Always On
        VPN**.

    3.  In **Data type**, click **String (XML)**.

    4.  In **OMA-URI**, type **./User/Vendor/MSFT/VPNv2/ContosoVPN/ProfileXML**.
        **ContosoVPN** is the profile name and is visible to the user in
        **Settings**. Change this name to the profile name you want users to
        see. If the name contains spaces, escape each space with %20. (e.g.,
        Contoso VPN would be Contoso%20VPN).

    5.  Click **Browse**, and open VPN_Profile.xml, which you created in the
        section [Create the ProfileXML configuration files](#bkmk_ProfileXML).
        The following illustration depicts the completed **OMA-URI** setting for
        Contoso.

![Completed OMA-URI setting](media/31496f23ec18f0d474a053db0f445f06.jpg)

    Completed OMA-URI setting

1.  Click **OK** to add the setting to the configuration policy.

2.  Click **Save Policy** to save the configuration policy.

3.  On the Deploy Policy dialog box, click **Yes**.

4.  Click the **VPN Users** group, click **Add**, and click **OK**.

### Sync with Intune

To test the configuration policy, sign in to a Windows 10 client computer as the
user you added to the **Always On VPN Users** group, and then sync with Intune.

**To sync the Always On VPN configuration policy**

1.  On the Start menu, click **Settings**.

2.  In Settings, click **Accounts**, and click **Access work or school**.

3.  Click the MDM profile, and click **Info**.

4.  Click **Sync** to force an Intune policy evaluation and retrieval.

5.  Close Settings.

After synchronization, you should see the VPN profile available on the computer.
