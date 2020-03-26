---
title: "Add Third-Level Domain Names"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e5b4a362-1881-4024-ae4e-cc3b05e50103
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Add Third-Level Domain Names

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

You can add the ability for users to request third-level domain names in the Set Up Domain Name Wizard. You do this by creating and installing a code assembly that is used by the Domain Manager in the operating system.  
  
## Create a provider of third-level domain names  
 You can make third-level domain names available by creating and installing a code assembly that provides the domain names to the wizard. To do this, you complete the following tasks:  
  
-   [Add an implementation of the IDomainSignupProvider interface to the assembly](Add-Third-Level-Domain-Names.md#BKMK_DomainSignup)  
  
-   [Add an implementation of the IDomainMaintenanceProvider interface to the assembly](Add-Third-Level-Domain-Names.md#BKMK_DomainMaintenance)  
  
-   [Sign the assembly with an Authenticode signature](Add-Third-Level-Domain-Names.md#BKMK_SignAssembly)  
  
-   [Install the assembly on the reference computer](Add-Third-Level-Domain-Names.md#BKMK_InstallAssembly)  
  
-   [Restart the Windows Server Domain Name Management service](Add-Third-Level-Domain-Names.md#BKMK_RestartService)  
  
###  <a name="BKMK_DomainSignup"></a> Add an implementation of the IDomainSignupProvider interface to the assembly  
 The IDomainSignupProvider interface is used to add domain offerings to the wizard.  
  
##### To add the IDomainSignupProvider code to the assembly  
  
1.  Open Visual Studio 2008 as an administrator by right-clicking the program in the **Start** menu and selecting **Run as administrator**.  
  
2.  Click **File**, click **New**, and then click **Project**.  
  
3.  In the **New Project** dialog box, click **Visual C#**, click **Class Library**, enter a name for the solution, and then click **OK**.  
  
4.  Rename the Class1.cs file. For example, MyDomainNameProvider.cs  
  
5.  Add references to the Wssg.Web.DomainManagerObjectModel.dll, CertManaged.dll, WssgCertMgmt.dll, and WssgCommon.dll files.  
  
6.  Add the following using statements.  
  
    ```c#  
  
    using System.Collections.ObjectModel;  
    using System.Net;  
    using System.Net.Sockets;  
    using Microsoft.WindowsServerSolutions.Certificates;  
    using Microsoft.WindowsServerSolutions.CertificateManagement;  
    using Microsoft.WindowsServerSolutions.Common;  
    using Microsoft.Win32;  
    ```  
  
7.  Change the namespace and the class header to match the following example.  
  
    ```c#  
    namespace Microsoft.WindowsServerSolutions.RemoteAccess.Domains  
    {  
        public class MyDomainNameProvider : IDomainSignupProvider  
        {  
        }  
    }  
    ```  
  
8.  Add the Initialize method and the required variables to the class, which defines the offerings that are presented in the wizard.  
  
    > [!NOTE]
    >  The Initialize method defines an identifier for the domain provider that must be unique. A typical way to do this is to define a GUID as the identifier. For more information about creating a GUID, see [Create Guid (guidgen.exe)](https://go.microsoft.com/fwlink/?LinkId=116098).  
  
     The following code example shows the Initialize method.  
  
    ```c#  
  
    static readonly Guid MyID = new Guid("8C999DF5-696A-47af-822D-94F1673D3397");  
    public Guid ID { get { return MyID; } }  
    public string Name { get { return "My Provider"; } }  
    List<Offering> offerings = new List<Offering>();  
  
    public void Initialize(DomainProviderSettings config)  
    {  
       var offer1 = new Offering()  
       {  
          Description = "My Domain Provider",  
          Name = "Offering 1",  
          ProviderID = ID,  
          MoreInfoUrl = new Uri("http://www.contoso.com"),  
          MembershipServiceName = "My Membership",  
          EulaUrl = new Uri("http://www.contoso.com"),  
       };  
  
       this.offerings.Add(offer1);  
       RegistryKey key =   
          Registry.LocalMachine.CreateSubKey(@"Software\Microsoft\Windows Server\Domain Manager\Settings");  
       key.Close();  
    }  
    ```  
  
9. Add the GetOfferings method, which returns the list of offerings that was initialized in the previous step. The following code example shows the GetOfferings method.  
  
    ```c#  
  
    public ReadOnlyCollection<Offering> GetOfferings()  
    {  
       return this.offerings.AsReadOnly();  
    }  
    ```  
  
10. Add the FindOfferingForDomain method, which returns the offering from the list. The following code example shows the FindOfferingForDomain method.  
  
    ```  
  
    public Offering FindOfferingForDomain(string domain)  
    {  
       // Return the offering that has the domain name.  
       return offerings[0];  
    }  
  
    ```  
  
11. Add the SetCredentials method, which defines the credentials that are required to access the offerings. The following code example shows the SetCredentials method.  
  
    ```c#  
  
    private string currentUser { get; set; }  
    private string currentPassword { get; set; }  
  
    public bool SetCredentials(DomainNameRequest request,   
       DomainProviderCredentials credentials, bool validate)  
    {  
       currentUser = credentials.UserName;  
       currentPassword = credentials.Password;  
       if (validate)  
       {  
          return ValidateCredentials();  
       }  
  
       return true;  
    }  
    ```  
  
12. Add the ValidateCredentials method, which validates the credentials defined by SetCredentials. The following code example shows the ValidateCredentials method.  
  
    ```c#  
  
    public static readonly string offerUser = "user1@contoso.com";  
    public static readonly string offerPassword = "password1";  
  
    public bool ValidateCredentials()  
    {  
       if (IsUser())  
          return string.Equals(currentPassword, offerPassword);  
       else  
          return false;  
    }   
  
    private bool IsUser()  
    {  
       return string.Equals(currentUser, offerUser, StringComparison.OrdinalIgnoreCase);  
    }  
    ```  
  
13. Add the GetAvailableDomainRoots method, which returns the list of root domain names that are supported by the offering specified in the request. This list of root domain names must not be empty. The following code example shows the GetAvailableDomainRoots method.  
  
    ```c#  
  
    public ReadOnlyCollection<string> GetAvailableDomainRoots(DomainNameRequest request)  
    {  
       List<string> list = new List<string>();  
       list.Add("domain1.com");  
       list.Add("domain1.org");  
  
       return list.AsReadOnly();  
    }  
    ```  
  
14. Add the GetUserDomainNames method, which returns a list of domain names that the current user already owns, relative to the current offering. This list may be empty. The following code example shows the GetUserDomainNames method.  
  
    ```c#  
  
    public static readonly string AvailableDomain1 = "available.domain1.com",  
       AvailableDomain2 = "available.domain2.com";  
    public static readonly string OccupiedDomain1 = "occupied.domain1.com",  
       OccupiedDomain2 = "occupied.domain2.com";  
  
    public ReadOnlyCollection<string> GetUserDomainNames(DomainNameRequest request)  
    {  
       var userDomains = new List<string>();  
       userDomains.Add(OccupiedDomain1);  
       userDomains.Add(AvailableDomain1);  
  
       return userDomains.AsReadOnly();  
    }  
    ```  
  
15. Add the GetUserDomainQuota method, which returns the maximum number of domains that the specified offering allows. If a maximum is not applicable, this method should return 0. The following example shows the GetUserDomainQuota method.  
  
    ```c#  
  
    public int GetUserDomainQuota(DomainNameRequest request)  
    {  
       return 0;  
    }  
    ```  
  
16. Add the CheckDomainAvailability method, which checks for the availability of the requested domain name and can return a list of suggestions. The following code example shows the CheckDomainAvailability method.  
  
    ```c#  
  
    public bool CheckDomainAvailability(DomainNameRequest request,   
       out ReadOnlyCollection<string> suggestions)  
    {  
       suggestions = null;  
  
       return true;  
    }  
    ```  
  
17. Add the CommitDomain method, which commits the requested domain name. Successful completion of this method implies that the domain name is associated with the user account, the maintenance provider will be called immediately to retrieve the certificate if the state is FullyOperational, and the provider and offering become active. The following code example shows the CommitDomain method.  
  
    ```c#  
  
    public DomainStatus CommitDomain(DomainNameRequest request)  
    {              
       ReadOnlyCollection<string> suggestions;  
       if (!CheckDomainAvailability(request, out suggestions))  
       {  
          throw new DomainException(FailureReason.InvalidDomainName, null, null);  
       }  
  
       return DomainStatus.Ready;  
    }  
    ```  
  
18. Add the ReleaseDomain method, which informs the provider that the user wants to release the domain name. The following code example shows the ReleaseDomain method.  
  
    ```c#  
  
    public bool ReleaseDomain(DomainNameRequest request)  
    {  
       return true;  
    }  
    ```  
  
19. Add the GetProviderLandingUrl method, which returns the URL for landing page in the domain signup workflow. The following code example shows the GetProviderLandingUrl method.  
  
    ```c#  
  
    public Url GetProviderLandingUrl(DomainNameRequest request)  
    {  
       return new Url("www.contoso.com");  
    }  
    ```  
  
20. Add the GetDomainMaintenanceProvider method, which returns an instance of IDomainMaintenanceProvider that is used for domain maintenance tasks. This method is called after the CommitDomain method is successful, and when the Domain Manager starts. The following code example shows the GetDomainMaintenanceProvider method.  
  
    ```c#  
  
    public IDomainMaintenanceProvider GetDomainMaintenanceProvider()  
    {  
       return new MyDomainMaintenanceProvider();  
    }  
    ```  
  
21. Save the project and do not close it because you will add to it with the next procedure. You will not be able to build the project until you complete the next procedure.  
  
###  <a name="BKMK_DomainMaintenance"></a> Add an implementation of the IDomainMaintenanceProvider interface to the assembly  
 The IDomainMaintenanceProvider is used to maintain the domain after it is created.  
  
##### To add the IDomainMaintenanceProvider code to the assembly  
  
1.  Add the class header for the domain maintenance provider. Ensure that the name you define for the provider matches the name in the GetDomainMaintenanceProvider method that you previously defined.  
  
    ```c#  
  
    public class MyDomainMaintenanceProvider : IDomainMaintenanceProvider  
    {  
    }  
    ```  
  
2.  Add the Activate method, which sets the active provider. The following code example shows the Activate method.  
  
    ```c#  
  
    string DomainName { get; set; }  
    protected DomainProviderSettings Settings { get; set; }  
  
    public void Activate(DomainProviderSettings settings,   
       DomainNameConfiguration config, DomainProviderCredentials credentials)  
    {  
       Settings = settings;  
       SetCredentials(credentials);  
       DomainName = config.AutoConfiguredAnywhereAccessFullName.Punycode;  
    }  
    ```  
  
3.  Add the Deactivate method, which is used to deactivate all actions. The following code example shows the Deactivate method.  
  
    ```  
  
    public void Deactivate()  
    {  
       //Deactivate all actions  
    }  
  
    ```  
  
4.  Add the SetCredentials method, which updates the user credentials. For example, this method may be called to update credentials that are no longer valid. The following code example shows the SetCredentials method.  
  
    ```c#  
  
    protected DomainProviderCredentials Credentials { get; set; }  
  
    public bool SetCredentials(DomainProviderCredentials credentials)  
    {  
       this.Credentials = credentials;  
  
       return true;  
    }  
    ```  
  
5.  Add the ValidateCredentials method, which validates the specified credentials. The following code example shows the ValidateCredentials method.  
  
    ```c#  
  
    public static readonly string offerUser = "user1@contoso.com";  
    public static readonly string offerPassword = "password1";  
  
    public bool ValidateCredentials()  
    {  
       if (string.Equals(this.Credentials.UserName,   
          offerUser,   
          StringComparison.OrdinalIgnoreCase) &&   
             string.Equals(this.Credentials.Password, offerPassword))  
          return true;  
  
       return false;  
    }  
    ```  
  
6.  Add the GetPublicAddress method, which returns external IP address of the server. The following code example shows the GetPublicAddress method.  
  
    ```c#  
  
    public IPAddress GetPublicIPAddress()  
    {  
       string PublicIP = "0.0.0.0";  
       using (RegistryKey key = ProductInfo.RegKey.OpenSubKey("Domain Manager\\Settings", true))  
       {  
          PublicIP = (key == null) ? "0.0.0.0" : key.GetValue("PublicIP", "0.0.0.0").ToString();  
       }  
       IPAddress ip = IPAddress.Parse(PublicIP);  
  
       if (PublicIP == "0.0.0.0")  
       {  
          string strHostName = Dns.GetHostName();  
          IPHostEntry ipEntry = Dns.GetHostEntry(strHostName);  
  
          IPAddress[] addr = ipEntry.AddressList;  
          foreach (IPAddress add in addr)  
          {  
             if (add.AddressFamily == AddressFamily.InterNetwork)  
             {  
                return add;  
             }  
          }  
       }  
       else  
       {  
          return IPAddress.Parse(PublicIP);  
       }  
  
       return null;    
    }  
    ```  
  
7.  Add the SubmitCertificateRequest method, which submits the certificate request for the currently configured domain name.  
  
    ```c#  
  
    string cert=null;  
  
    public void SubmitCertificateRequest(string certificateRequest)  
    {  
       cert = CertManaged.SubmitRequest(certificateRequest, CertCommon.CAServerFQDN + "\\" +      
          CertCommon.CAName,   
          Microsoft.WindowsServerSolutions.CertificateManagement.CRFlags.Base64Header,   
          CertCommon.CATemplate,   
          EncodingFlags.Base64);  
    }  
    ```  
  
8.  Add the GetCertificateResponse method, which returns the certificate response if the domain status is FullyOperational. This method is called for both new certificate requests and for certificate renewal requests. The following code example shows the GetCertificateResponse method.  
  
    ```c#  
  
    public string GetCertificateResponse(bool renew)  
    {  
       return cert;  
    }  
    ```  
  
9. Add the SubmitRenewCertificateRequest method, which processes the renewal of the certificate. The following code example shows the SubmitRenewCertificateRequest method.  
  
    ```c#  
  
    public void SubmitRenewCertificateRequest()  
    {  
       // Add certificate renewal code   
    }  
    ```  
  
10. Add the UpdateDNSRecords method, which updates the DNS records stored by the provider. The following code example shows the UpdateDNS method.  
  
    ```c#  
  
    public bool UpdateDnsRecords(IList<DnsRecord> records)  
    {  
       string UpdateDNS = "true";  
       using (RegistryKey key = ProductInfo.RegKey.OpenSubKey("Domain Manager\\Settings", true))  
       {  
          UpdateDNS = (key == null) ? "true" : key.GetValue("UpdateDNS", "true").ToString();  
       }  
  
       return UpdateDNS == "true";  
    }  
  
    ```  
  
11. Add the TestConnection method, which attempts to establish a connection to backend service. If this method requires authentication, an appropriate exception should be thrown. The following code example shows the TestConnection method.  
  
    ```c#  
  
    public bool TestConnection()  
    {  
       // Add code to test connection  
  
       return true;  
    }  
    ```  
  
12. Add the GetDomainState method, which returns the current state of the domain. The following code example shows the GetDomainState method.  
  
    ```c#  
  
    public DomainState GetDomainState()  
    {  
       string domainstatus = "FullyOperational";  
       long expirationDate = 365;  
       using (RegistryKey key = ProductInfo.RegKey.OpenSubKey("Domain Manager\\Settings", true))  
       {  
          domainstatus = (key == null) ? "Ready" : key.GetValue("DomainStatus", "Ready").ToString();  
          expirationDate = Int64.Parse(key.GetValue("ExpirationDate", "365").ToString());  
       }  
  
       switch (domainstatus)  
       {  
          case "Failed":  
             return new DomainState(DomainStatus.Failed,   
                null,   
                DateTime.Now.AddDays(expirationDate));  
          case "Ready":  
             return new DomainState(DomainStatus.Ready,   
                null,   
                DateTime.Now.AddDays(expirationDate));  
          case "InRenewal":  
             return new DomainState(DomainStatus.InRenewal,   
                null,   
                DateTime.Now.AddDays(expirationDate));  
          case "InRenewalCustomerInterventionRequired":  
             return new DomainState(DomainStatus.InRenewalCustomerInterventionRequired,   
                null,   
                DateTime.Now.AddDays(expirationDate));  
          case "Pending":  
             return new DomainState(DomainStatus.Pending,   
                null,   
                DateTime.Now.AddDays(expirationDate));  
          case "PendingCustomerInterventionRequired":  
             return new DomainState(DomainStatus.PendingCustomerInterventionRequired,   
                null,   
                DateTime.Now.AddDays(expirationDate));  
          case "RenewalFailed":  
             return new DomainState(DomainStatus.RenewalFailed,   
                null,   
                DateTime.Now.AddDays(expirationDate));  
          default:  
             return new DomainState(DomainStatus.Unknown,   
                null,   
                DateTime.Now.AddDays(expirationDate));                   
          }  
    }  
    ```  
  
13. Add the GetCertificateState method, which returns the current state of the certificate. The following code example shows the GetCertificateState method.  
  
    ```c#  
  
    public CertificateState GetCertificateState(bool renew)  
    {  
       return new CertificateState(CertificateStatus.Ready, string.Empty);  
    }  
    ```  
  
14. Save and build the solution.  
  
###  <a name="BKMK_SignAssembly"></a> Sign the assembly with an Authenticode signature  
 You must Authenticode sign the assembly for it to be used in the operating system. For more information about signing the assembly, see [Signing and Checking Code with Authenticode](https://msdn.microsoft.com/library/ms537364\(VS.85\).aspx#SignCode).  
  
###  <a name="BKMK_InstallAssembly"></a> Install the assembly on the reference computer  
 Place the assembly in a folder on the reference computer. Make a note of the folder path because you will enter it into the registry in the next step.  
  
### Add a key to the registry  
 You add a registry entry to define the characteristics and location of the assembly.  
  
##### To add a key to the registry  
  
1.  On the reference computer, click **Start**, enter **regedit**, and then press **Enter**.  
  
2.  In the left pane, expand **HKEY_LOCAL_MACHINE**, expand **SOFTWARE**, expand **Microsoft**, expand **Windows Server**, expand **Domain Managers**, and then expand **Providers**.  
  
3.  Right-click **Providers**, point to **New**, and then click **Key**.  
  
4.  Type the identifier for the provider as the name for the key. The identifier is the GUID that you defined for the provider in step 8 of [Add an implementation of the IDomainSignupProvider interface to the assembly](Add-Third-Level-Domain-Names.md#BKMK_DomainSignup).  
  
5.  Right-click the key that you just created, and then click **String Value**.  
  
6.  Type **Assembly** for the name of the string, and then press **Enter**.  
  
7.  Right-click the new **Assembly** string in the right pane, and then click **Modify**.  
  
8.  Type the full path to the assembly file that you previously created, and then click **OK**.  
  
9. Right-click the key again, and then click **String Value**.  
  
10. Type **Enabled** for the name of the string, and then press **Enter**.  
  
11. Right-click the new **Enabled** string in the right pane, and then click **Modify**.  
  
12. Type **True**, and then click **OK**.  
  
13. Right-click the key again, and then click **String Value**.  
  
14. Type **Type** for the name of the string, and then press **Enter**.  
  
15. Right-click the new **Type** string in the right pane, and then click **Modify**.  
  
16. Type the full class name of your provider defined in the assembly, and then click **OK**.  
  
###  <a name="BKMK_RestartService"></a> Restart the Windows Server Domain Name Management service  
 You must restart the Windows Server Domain Management service for the provider to become available to the operating system.  
  
##### Restart the service  
  
1.  Click **Start**, type **mmc**, and then press **Enter**.  
  
2.  If the Services snap-in is not listed in the console, add it by completing the following steps:  
  
    1.  Click **File**, and then click **Add/Remove Snap-in**.  
  
    2.  In the **Available snap-ins** list, click **Services**, and then click **Add**.  
  
    3.  In the **Services** dialog box, ensure that **local computer** is selected, and then click **Finish**.  
  
    4.  Click **OK** to close the **Add/Remove snap-ins** dialog box.  
  
3.  Double-click **Services**, scroll down and select **Windows Server Domain Management**, and then click **Restart the service**.  
  
## See Also  
 [Creating and Customizing the Image](Creating-and-Customizing-the-Image.md)   
 [Additional Customizations](Additional-Customizations.md)   
 [Preparing the Image for Deployment](Preparing-the-Image-for-Deployment.md)   
 [Testing the Customer Experience](Testing-the-Customer-Experience.md)