---
ms.assetid: 8738c03d-6ae8-49a7-8b0c-bef7eab81057
title: Deploy a Central Access Policy (Demonstration Steps)
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Deploy a Central Access Policy (Demonstration Steps)

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

In this scenario, the finance department security operations is working with central information security to specify the need for a central access policy so that they can protect archived finance information stored on file servers. The archived finance information from each country can be accessed as read-only by finance employees from the same country. A central finance admin group can access the finance information from all countries.  

Deploying a central access policy includes the following phases:  

|Phase|Description  
|---------|---------------  
|[Plan: Identify the need for policy and the configuration required for deployment](Deploy-a-Central-Access-Policy--Demonstration-Steps-.md#BKMK_1.2)|Identify the need for a policy and the configuration required for deployment. 
|[Implement: Configure the components and policy](Deploy-a-Central-Access-Policy--Demonstration-Steps-.md#BKMK_1.3)|Configure the components and policy.  
|[Deploy the central access policy](Deploy-a-Central-Access-Policy--Demonstration-Steps-.md#BKMK_1.4)|Deploy the policy.  
|[Maintain: Change and stage the policy](Deploy-a-Central-Access-Policy--Demonstration-Steps-.md#BKMK_1.5)|Policy changes and staging. 

## <a name="BKMK_1.1"></a>Set up a test environment  
Before you begin, you need to set up lab to test this scenario. The steps for setting up the lab are explained in detail in [Appendix B: Setting Up the Test Environment](Appendix-B--Setting-Up-the-Test-Environment.md).  

## <a name="BKMK_1.2"></a>Plan: Identify the need for policy and the configuration required for deployment  
This section provides the high-level series of steps that aid in the planning phase of your deployment.  

||Step|Example|  
|-|--------|-----------|  
|1.1|Business determines that a central access policy is needed|To protect finance information that is stored on file servers, the finance department security operations is working with central information security to specify the need for a central access policy.|  
|1.2|Express the access policy|Finance documents should only be read by members of the Finance department. Members of the Finance department should only access documents in their own country. Only Finance Administrators should have write-access. An exception will be allowed for members of the FinanceException group. This group will have Read access.|  
|1.3|Express the access policy in  Windows Server 2012  constructs|Targeting:<br /><br />-   Resource.Department Contains Finance<br /><br />Access rules:<br /><br />-   Allow read User.Country=Resource.Country AND User.department = Resource.Department<br />-   Allow Full control User.MemberOf(FinanceAdmin)<br /><br />Exception:<br /><br />Allow read memberOf(FinanceException)|  
|1.4|Determine the file properties required for the policy|Tag files with:<br /><br />-   Department<br />-   Country|  
|1.5|Determine the claim types and groups required for the policy|Claim types:<br /><br />-   Country<br />-   Department<br /><br />User groups:<br /><br />-   FinanceAdmin<br />-   FinanceException|  
|1.6|Determine the servers on which to apply this policy|Apply the policy on all finance file servers.|  

## <a name="BKMK_1.3"></a>Implement: Configure the components and policy  
This section presents an example that deploys a central access policy for finance documents.  

|No|Step|Example|  
|------|--------|-----------|  
|2.1|Create claim types|Create the following claim types:<br /><br />-   Department<br />-   Country|  
|2.2|Create resource properties|Create and enable the following resource properties:<br /><br />-   Department<br />-   Country|  
|2.3|Configure a central access rule|Create a Finance Documents rule that includes the policy determined in the previous section.|  
|2.4|Configure a central access policy (CAP)|Create a CAP called Finance Policy and add the Finance Documents rule to that CAP.|  
|2.5|Target central access policy to the file servers|Publish the Finance Policy CAP to the file servers.|  
|2.6|Enable KDC Support for claims, compound authentication and Kerberos armoring.|Enable KDC Support for claims, compound authentication and Kerberos armoring for contoso.com.|  

In the following procedure, you create two claim types: Country and Department.  

#### To create claim types  

1. Open Server DC1 in Hyper-V Manager and log on as contoso\administrator, with the password <strong>pass@word1</strong>.  

2. Open Active Directory Administrative Center.  

3. Click the **Tree View icon**, expand **Dynamic Access Control**, and then select **Claim Types**.  

   Right-click **Claim Types**, click **New**, and then click **Claim Type**.  

   > [!TIP]  
   > You can also open a **Create Claim Type:** window from the **Tasks** pane. On the **Tasks** pane, click **New**, and then click **Claim Type**.  

4. In the **Source Attribute** list, scroll down the list of attributes, and click **department**. This should populate the **Display name** field with **department**. Click **OK**.  

5. In **Tasks** pane, click **New**, and then click **Claim Type**.  

6. In the **Source Attribute** list, scroll down the list of attributes, and then click the **c** attribute (Country-Name). In the **Display name** field, type **country**.  

7. In the **Suggested Values** section, select **The following values are suggested:**, and then click **Add**.  

8. In the **Value** and **Display name** fields, type **US**, and then click **OK**.  

9. Repeat the above step. In the **Add a suggest value** dialog box, type **JP** in the **Value** and **Display name** fields, and then click **OK**.  

![solution guides](media/Deploy-a-Central-Access-Policy--Demonstration-Steps-/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  

The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  


    New-ADClaimType country -SourceAttribute c -SuggestedValues:@((New-Object Microsoft.ActiveDirectory.Management.ADSuggestedValueEntry("US","US","")), (New-Object Microsoft.ActiveDirectory.Management.ADSuggestedValueEntry("JP","JP","")))  
    New-ADClaimType department -SourceAttribute department  



> [!TIP]  
> You can use the Windows PowerShell History Viewer in Active Directory Administrative Center to look up the Windows PowerShell cmdlets for each procedure you perform in Active Directory Administrative Center. For more information, see [Windows PowerShell History Viewer](https://technet.microsoft.com/library/hh831702)  

The next step is to create resource properties. In the following procedure you create a resource property that is automatically added to the Global Resource Properties list on the domain controller, so that it is available to the file server.  

#### To create and enable pre-created resource properties  

1.  In the left pane of Active Directory Administrative Center, click **Tree View**. Expand **Dynamic Access Control**, and then select **Resource Properties**.  

2.  Right-click **Resource Properties**, click **New**, and then click **Reference Resource Property**.  

    > [!TIP]  
    > You can also choose a resource property from the **Tasks** pane. Click **New** and then click **Reference Resource Property**.  

3.  In **Select a claim type to share its suggested values list**, click **country**.  

4.  In the **Display name** field, type **country**, and then click **OK**.  

5.  Double-click the **Resource Properties** list, scroll down to the **Department** resource property. Right-click, and then click **Enable**. This will enable the built-in **Department** resource property.  

6.  In the **Resource Properties** list on the navigation pane of the Active Directory Administrative Center, you will now have two enabled resource properties:  

    -   Country  

    -   Department  

![solution guides](media/Deploy-a-Central-Access-Policy--Demonstration-Steps-/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  

The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  

```  
New-ADResourceProperty Country -IsSecured $true -ResourcePropertyValueType MS-DS-MultivaluedChoice -SharesValuesWith country  
Set-ADResourceProperty Department_MS -Enabled $true  
Add-ADResourcePropertyListMember "Global Resource Property List" -Members Country  
Add-ADResourcePropertyListMember "Global Resource Property List" -Members Department_MS  

```  

The next step is to create central access rules that define who can access resources. In this scenario the business rules are:  

-   Finance documents can be read only by members of the Finance department.  

-   Members of the Finance department can access only documents in their own country.  

-   Only Finance Administrators can have Write access.  

-   We will allow an exception for members of the FinanceException group. This group will have Read access.  

-   The administrator and document owner will still have full access.  

Or to express the rules with  Windows Server 2012  constructs:  

Targeting: Resource.Department Contains Finance  

Access Rules:  

-   Allow Read User.Country=Resource.Country AND User.department = Resource.Department  

-   Allow Full control User.MemberOf(FinanceAdmin)  

-   Allow Read User.MemberOf(FinanceException)  

#### To create a central access rule  

1. In the left pane of the Active Directory Administrative Center, click **Tree View**, select **Dynamic Access Control**, and then click **Central Access Rules**.  

2. Right-click **Central Access Rules**, click **New**, and then click **Central Access Rule**.  

3. In the **Name** field, type **Finance Documents Rule**.  

4. In the **Target Resources** section, click **Edit**, and in the **Central Access Rule** dialog box, click **Add a condition**. Add the following condition:   
   [**Resource**] [**Department**] [**Equals**] [**Value**] [**Finance**], and then click **OK**.  

5. In the **Permissions** section, select **Use following permissions as current permissions**, click **Edit**, and in the **Advanced Security Settings for Permissions** dialog box click **Add**.  

   > [!NOTE]  
   > **Use the following permissions as proposed permissions** option lets you create the policy in staging. For more information on how to do this refer to the Maintain: Change and stage the policy section in this topic.  

6. In the **Permission entry for Permissions** dialog box, click **Select a principal**, type **Authenticated Users**, and then click **OK**.  

7. In the **Permission Entry for Permissions** dialog box, click **Add a condition**, and add the following conditions:   
   [**User**] [**country**] [**Any of**] [**Resource**] [**country**]   
    Click **Add a condition**.   
    [**And**]   
   Click [**User**] [**Department**] [**Any of**] [**Resource**] [**Department**]. Set the **Permissions** to **Read**.  

8. Click **OK**, and then click **Add**. Click **Select a principal**, type **FinanceAdmin**, and then click **OK**.  

9. Select the **Modify, Read and Execute, Read, Write** permissions, and then click **OK**.  

10. Click **Add**, click **Select a principal**, type **FinanceException**, and then click **OK**. Select the permissions to be **Read** and **Read and Execute**.  

11. Click **OK** three times to finish and return to Active Directory Administrative Center.  

    ![solution guides](media/Deploy-a-Central-Access-Policy--Demonstration-Steps-/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  

    The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  


~~~
$countryClaimType = Get-ADClaimType country  
$departmentClaimType = Get-ADClaimType department  
$countryResourceProperty = Get-ADResourceProperty Country  
$departmentResourceProperty = Get-ADResourceProperty Department  
$currentAcl = "O:SYG:SYD:AR(A;;FA;;;OW)(A;;FA;;;BA)(A;;0x1200a9;;;S-1-5-21-1787166779-1215870801-2157059049-1113)(A;;0x1301bf;;;S-1-5-21-1787166779-1215870801-2157059049-1112)(A;;FA;;;SY)(XA;;0x1200a9;;;AU;((@USER." + $countryClaimType.Name + " Any_of @RESOURCE." + $countryResourceProperty.Name + ") && (@USER." + $departmentClaimType.Name + " Any_of @RESOURCE." + $departmentResourceProperty.Name + ")))"  
$resourceCondition = "(@RESOURCE." + $departmentResourceProperty.Name + " Contains {`"Finance`"})"  
New-ADCentralAccessRule "Finance Documents Rule" -CurrentAcl $currentAcl -ResourceCondition $resourceCondition  
~~~


> [!IMPORTANT]  
> In the above cmdlet example, the security identifiers (SIDs) for the group FinanceAdmin and users is determined at creation time and will be different in your example. For example, the provided SID value (S-1-5-21-1787166779-1215870801-2157059049-1113) for the FinanceAdmins needs to be replaced with the actual SID for the FinanceAdmin group that you would need to create in your deployment. You can use Windows PowerShell to look up the SID value of this group, assign that value to a variable, and then use the variable here. For more information, see [Windows PowerShell Tip: Working with SIDs](https://go.microsoft.com/fwlink/?LinkId=253545).  

You should now have a central access rule that allows people to access documents from the same country and the same department. The rule allows the FinanceAdmin group to edit the documents, and it allows the FinanceException group to read the documents. This rule targets only documents classified as Finance.  

#### To add a central access rule to a central access policy  

1. In the left pane of the Active Directory Administrative Center, click **Dynamic Access Control**, and then click **Central Access Policies**.  

2. In the **Tasks** pane, click **New**, and then click **Central Access Policy**.  

3. In **Create Central Access Policy:**, type **Finance Policy** in the **Name** box.  

4. In **Member central access rules**, click **Add**.  

5. Double-click the **Finance Documents Rule** to the add it to the **Add the following central access rules** list , and then click **OK**.  

6. Click **OK** to finish. You should now have a central access policy named Finance Policy.  

   ![solution guides](media/Deploy-a-Central-Access-Policy--Demonstration-Steps-/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  

   The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  

   ```  
   New-ADCentralAccessPolicy "Finance Policy" Add-ADCentralAccessPolicyMember   
   -Identity "Finance Policy"   
   -Member "Finance Documents Rule"  

   ```  

#### To apply the central access policy across file servers by using Group Policy  

1.  On the **Start** screen, in the **Search** box, type **Group Policy Management**. Double-click **Group Policy Management**.  

    > [!TIP]  
    > If the **Show Administrative tools** setting is disabled, the **Administrative Tools** folder and its contents will not appear in the **Settings** results.  

    > [!TIP]  
    > In your production environment, you should create a File Server Organization Unit (OU) and add all your file servers to this OU, to which you want to apply this policy. You can then create a group policy and add this OU to that policy..  

2.  In this step, you edit the group policy object you created in [Build the domain controller](Appendix-B--Setting-Up-the-Test-Environment.md#BKMK_Build) section in the Test Environment to include the central access policy that you created. In the Group Policy Management Editor, navigate to and select the organizational unit in the domain (contoso.com in this example): **Group Policy Management**, **Forest: contoso.com**, **Domains**, **contoso.com**, **Contoso**, **FileServerOU**.  

3.  Right-click **FlexibleAccessGPO**, and then click **Edit**.  

4.  In the Group Policy Management Editor window, navigate to **Computer Configuration**, expand **Policies**, expand **Windows Settings**, and click **Security Settings**.  

5.  Expand **File System**, right-click **Central Access Policy**, and then click **Manage Central access policies**.  

6.  In the **Central Access Policies Configuration** dialog box, add **Finance Policy**, and then click **OK**.  

7.  Scroll down to **Advanced Audit Policy Configuration**, and expand it.  

8.  Expand **Audit Policies**, and select **Object Access**.  

9. Double-click **Audit Central Access Policy Staging**. Select all three check boxes and then click **OK**. This step allows the system to receive audit events related to Central Access Staging Policies.  

10. Double-click **Audit File System Properties**. Select all three check boxes then click **OK**.  

11. Close the Group Policy Management Editor. You have now included the central access policy to the Group Policy.  

For a domain's domain controllers to provide claims or device authorization data, the domain controllers need to be configured to support dynamic access control.  

#### To enable support for claims and compound authentication for contoso.com  

1.  Open Group Policy Management, click **contoso.com**, and then click **Domain Controllers**.  

2.  Right-click **Default Domain Controllers Policy**, and then click **Edit**.  

3.  In the Group Policy Management Editor window, double-click **Computer Configuration**, double-click **Policies**, double-click **Administrative Templates**, double-click **System**, and then double-click **KDC**.  

4.  Double-click **KDC Support for claims, compound authentication and Kerberos armoring**. In the **KDC Support for claims, compound authentication and Kerberos armoring** dialog box, click **Enabled** and select **Supported** from the **Options** drop-down list. (You need to enable this setting to use user claims in central access policies.)  

5.  Close **Group Policy Management**.  

6.  Open a command prompt and type `gpupdate /force`.  

## <a name="BKMK_1.4"></a>Deploy the central access policy  

||Step|Example|  
|-|--------|-----------|  
|3.1|Assign the CAP to the appropriate shared folders on the file server.|Assign the central access policy to the appropriate shared folder on the file server.|  
|3.2|Verify that access is appropriately configured.|Check the access for users from different countries and departments.|  

In this step you will assign the central access policy to a file server. You will log onto a file server that is receiving the central access policy that you created the previous steps and assign the policy to a shared folder.  

#### To assign a central access policy to a file server  

1. In Hyper-V Manager, connect to server FILE1. Log on to the server by using contoso\administrator with the password: <strong>pass@word1</strong>.  

2. Open an elevated command prompt and type: **gpupdate /force**. This ensures that your Group Policy changes take effect on your server.  

3. You also need to refresh the Global Resource Properties from Active Directory. Open an elevated Windows PowerShell window and type `Update-FSRMClassificationpropertyDefinition`. Click ENTER, and then close Windows PowerShell.  

   > [!TIP]
   > You can also refresh the Global Resource Properties by logging on to the file server. To refresh the Global Resource Properties from the file server, do the following  
   > 
   > 1. Logon to File Server FILE1 as contoso\administrator, using the password <strong>pass@word1</strong>.  
   > 2. Open File Server Resource Manager. To open File Server Resource Manager, click **Start**, type **file server resource manager**, and then click **File Server Resource Manager**.  
   > 3. In the File Server Resource Manager, click **File Classification Management** , right-click **Classification Properties** and then click **Refresh**.  

4. Open Windows Explorer, and in the left pane, click drive D. Right-click the **Finance Documents** folder, and click **Properties**.  

5. Click the **Classification** tab, click **Country**, and then select **US** in the **Value** field.  

6. Click **Department**, then select **Finance** in the **Value** field and then click **Apply**.  

   > [!NOTE]  
   > Remember that the central access policy was configured to target files for the Department of Finance. The previous steps mark all documents in the folder with the Country and Department attributes.  

7. Click the **Security** tab, and then click **Advanced**. Click the **Central Policy** tab.  

8. Click **Change**, select **Finance Policy** from the drop-down menu, and then click **Apply**. You can see the **Finance Documents Rule** listed in the policy. Expand the item to view all of the permissions that you set when you created the rule in Active Directory.  

9. Click **OK** to return to Windows Explorer.  

In the next step, you ensure that access is appropriately configured.  User accounts need to have the appropriate Department attribute set (set this using Active Directory Administrative Center). The simplest way to view the effective results of the new policy is to use the **Effective Access** tab in Windows Explorer. The **Effective Access** tab shows the access rights for a given user account.  

#### To examine the access for various users  

1.  In Hyper-V Manager, connect to server FILE1. Log on to the server by using contoso\administrator. Navigate to D:\ in Windows Explorer. Right-click the **Finance Documents** folder, and then click **Properties**.  

2.  Click the **Security** tab, click **Advanced**, and then click the **Effective Access** tab.  

3.  To examine the permissions for a user, click **Select a user**, type the user's name, and then click  **View effective access** to see the effective access rights. For example:  

    -   Myriam Delesalle (MDelesalle) is in the Finance department and should have Read access to the folder.  

    -   Miles Reid (MReid) is a member of the FinanceAdmin group and should have Modify access to the folder.  

    -   Esther Valle (EValle) is not in the Finance department; however, she is a member of the FinanceException group and should have Read access.  

    -   Maira Wenzel (MWenzel) is not in the Finance department and is not a member of either the FinanceAdmin or FinanceException group. She should not have any access to the folder.  

    Notice that the last column named **Access limited by** in the effective access window. This column tells you which gates are effecting the person's permissions. In this case, the Share and NTFS permissions allow all users full control. However, the central access policy restricts access based on the rules you configured earlier.  

## <a name="BKMK_1.5"></a>Maintain: Change and stage the policy  

||||  
|-|-|-|  
|Number|Step|Example|  
|4.1|Configure Device Claims for Clients|Set the group policy setting to enable device claims|  
|4.2|Enable a claim for devices.|Enable the country claim type for devices.|  
|4.3|Add a staging policy to the existing central access rule that you would like to modify.|Modify the Finance Documents Rule to add a staging policy.|  
|4.4|View the results of the staging policy.|Check for Ester Velle's permissions.|  

#### To set up group policy setting to enable claims for devices  

1.  Log on to DC1, open Group Policy Management, click **contoso.com**, click **Default Domain Policy**, right-click and select **Edit**.  

2.  In the Group Policy Management Editor window, navigate to **Computer Configuration**, **Policies**, **Administrative Templates**, **System**, **Kerberos**.  

3.  Select **Kerberos client support for claims, compound authentication and Kerberos armoring** and click **Enable**.  

#### To enable a claim for devices  

1. Open Server DC1 in Hyper-V Manager and log on as contoso\Administrator, with the password <strong>pass@word1</strong>.  

2. From the **Tools** menu, open Active Directory Administrative Center.  

3. Click **Tree View**, expand **Dynamic Access Control**, double-click **Claim Types**, and double-click the **country** claim.  

4. In **Claims of this type can be issued for the following classes**, select the **Computer** check box. Click **OK**.   
   Both the **User** and **Computer** check boxes should now be selected. The country claim can now be used with devices in addition to users.  

The next step is to create a staging policy rule. Staging policies can be used to monitor the effects of a new policy entry before you enable it. In the following step, you will create a staging policy entry and monitor the effect on your shared folder.  

#### To create a staging policy rule and add it to the central access policy  

1. Open Server DC1 in Hyper-V Manager and log on as contoso\Administrator, with the password <strong>pass@word1</strong>.  

2. Open Active Directory Administrative Center.  

3. Click **Tree View**, expand **Dynamic Access Control**, and select **Central Access Rules**.  

4. Right-click **Finance Documents Rule**, and then click **Properties**.  

5. In the **Proposed Permissions** section, select the **Enable permission staging configuration** check box, click **Edit**, and then click **Add**. In the **Permission Entry for Proposed Permissions** window, click the **Select a Principal** link, type **Authenticated Users**, and then click **OK**.  

6. Click the **Add a condition** link and add the following condition:   
    [**User**] [**country**] [**Any of**] [**Resource**] [**Country**].  

7. Click **Add a condition** again, and add the following condition:  
   [**And**]   
    [**Device**] [**country**] [**Any of**] [**Resource**] [**Country**]  

8. Click **Add a condition** again, and add the following condition.  
   [And]   
    [**User**] [**Group**] [**Member of any**] [**Value**]\(**FinanceException**)  

9. To set the FinanceException, group, click **Add items** and in the **Select User, Computer, Service Account, or Group** window, type **FinanceException**.  

10. Click **Permissions**, select **Full Control**, and click **OK**.  

11. In the Advance Security Settings for Proposed Permissions window, select **FinanceException** and click **Remove**.  

12. Click **OK** two times to finish.  

![solution guides](media/Deploy-a-Central-Access-Policy--Demonstration-Steps-/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  

The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  

```  
Set-ADCentralAccessRule  
-Identity: "CN=FinanceDocumentsRule,CN=CentralAccessRules,CN=ClaimsConfiguration,CN=Configuration,DC=Contoso.com"  
-ProposedAcl: "O:SYG:SYD:AR(A;;FA;;;BA)(A;;FA;;;SY)(A;;0x1301bf;;;S-1-21=1426421603-1057776020-1604)"  
-Server: "WIN-2R92NN8VKFP.Contoso.com"  

```  

> [!NOTE]  
> In the above cmdlet example, the Server value reflects the Server in the test lab environment. You can use the Windows PowerShell History Viewer to look up the Windows PowerShell cmdlets for each procedure you perform in Active Directory Administrative Center. For more information, see [Windows PowerShell History Viewer](https://technet.microsoft.com/library/hh831702)  

In this proposed permissions set, members of the FinanceException group will have Full Access to files from their own country when they access them through a device from the same country as the document. Audit entries are available in the File Servers security log when someone from the Finance department attempts to access files. However, security settings are not enforced until the policy is promoted from staging.  

In the next procedure, you verify the results of the staging policy. You access the shared folder with a user name that has permissions based on the current rule. Esther Valle (EValle) is a member of FinanceException, and she currently has Read rights. According to our staging policy, EValle should not have any rights.  

#### To verify the results of the staging policy  

1. Connect to the File Server FILE1 in Hyper-V Manager and log on as contoso\administrator, with the password <strong>pass@word1</strong>.  

2. Open a Command Prompt window and type **gpupdate /force**. This ensures that your Group Policy changes will take effect on your server.  

3. In Hyper-V Manager, connect to server CLIENT1. Log off the user who is currently logged on. Restart the virtual machine, CLIENT1. Then log on to the computer by using contoso\EValle pass@word1.  

4. Double-click the desktop shortcut to \\\FILE1\Finance Documents. EValle should still have access to the files. Switch back to FILE1.  

5. Open **Event Viewer** from the shortcut on the desktop. Expand **Windows Logs**, and then select **Security**. Open the entries with **Event ID 4818**under the **Central Access Policy Staging** task category. You will see that EValle was allowed access; however, according to the staging policy, the user would have been denied access.  

## Next Steps  
If you have a central server management system such as System Center Operations Manager, you can also configuring monitoring for events. This allows Administrators to monitor the effects of central access policies before enforcing them.  


