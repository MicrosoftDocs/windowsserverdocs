---
ms.assetid: 22347a94-aeea-44b4-85fb-af2c968f432a
title: Deploy Security Auditing with Central Audit Policies (Demonstration Steps)
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adds
---

# Deploy Security Auditing with Central Audit Policies (Demonstration Steps)

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

In this scenario, you will audit access to files in the Finance Documents folder by using the Finance Policy that you created in [Deploy a Central Access Policy &#40;Demonstration Steps&#41;](Deploy-a-Central-Access-Policy--Demonstration-Steps-.md). If a user who is not authorized to access the folder attempts to access it, the activity is captured in the event viewer.   
 The following steps are required to test this scenario.  
  
|Task|Description|  
|--------|---------------|  
|[Configure Global Object Access](Deploy-Security-Auditing-with-Central-Audit-Policies--Demonstration-Steps-.md#BKMK_1)|In this step, you configure the global object access policy on the domain controller.|  
|[Update Group Policy Settings](Deploy-Security-Auditing-with-Central-Audit-Policies--Demonstration-Steps-.md#BKMK_2)|Sign in to the file server and apply the Group Policy update.|  
|[Verify that the global object access policy has been applied](Deploy-Security-Auditing-with-Central-Audit-Policies--Demonstration-Steps-.md#BKMK_3)|View the relevant events in the event viewer. The events should include metadata for the country and document type.|  
  
## <a name="BKMK_1"></a>Configure global object access policy  
In this step, you configure the global object access policy in the domain controller.  
  
#### To configure a global object access policy  
  
1. Sign in to the domain controller DC1 as contoso\administrator with the password <strong>pass@word1</strong>.  
  
2. In Server Manager, point to **Tools**, and then click **Group Policy Management**.  
  
3. In the console tree, double-click **Domains**, double-click **contoso.com**, click **Contoso**, and then double-click **File Servers**.  
  
4. Right-click **FlexibleAccessGPO**, and click **Edit**.  
  
5. Double-click **Computer Configuration**, double-click **Policies**, and then double-click **Windows Settings**.  
  
6. Double-click **Security Settings**, double-click **Advanced Audit Policy Configuration**, and then double-click **Audit Policies**.  
  
7. Double-click **Object Access**, and then double-click **Audit File System**.  
  
8. Select the **Configure the following events** check box, select the **Success** and **Failure** check boxes, and then click **OK**.  
  
9. In the navigation pane, double-click **Global Object Access Auditing**, and then double-click **File system**.  
  
10. Select the **Define this policy setting** check box, and click **Configure**.  
  
11. In the **Advanced Security Settings for Global File SACL** box, click **Add**, then click **Select a principal**, type **Everyone**, and then click **OK**.  
  
12. In the **Auditing Entry for Global File SACL** box, select **Full control** in the **Permissions** box.  
  
13. In the **Add a condition:** section, click **Add a condition** and in the drop-down lists select   
    [**Resource**] [**Department**] [**Any of**] [**Value**] [**Finance**].  
  
14. Click **OK** three times to complete the configuration of the global object access audit policy setting.  
  
15. In the navigation pane, click **Object Access**, and in the results pane, double-click **Audit Handle Manipulation**. Click **Configure the following audit events**, **Success**, and **Failure**, click **OK**, and then close the flexible access GPO.  
  
## <a name="BKMK_2"></a>Update Group Policy settings  
In this step, you update the Group Policy settings after you have created the audit policy.  
  
#### To update Group Policy settings  
  
1. Sign in to the file server, FILE1 as contoso\Administrator, with the password <strong>pass@word1</strong>.  
  
2. Press the Windows key+R, then type **cmd** to open a Command Prompt window.  
  
   > [!NOTE]  
   > If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**.  
  
3. Type **gpupdate /force** and then press ENTER.  
  
## <a name="BKMK_3"></a>Verify that the global object access policy has been applied  
After the Group Policy settings have been applied, you can verify that the audit policy settings were applied correctly.  
  
#### To verify that the global object access policy has been applied  
  
1.  Sign in to client computer, CLIENT1 as Contoso\MReid. Browse to the folder  HYPERLINK "file:///\\\\\\\ID_AD_FILE1\\\Finance" \\\ FILE1\Finance Documents, and modify Word Document 2.  
  
2.  Sign in to the file server, FILE1 as contoso\administrator. Open Event Viewer, browse to **Windows Logs**, select **Security**, and confirm that your activities resulted in audit events **4656** and **4663** (even though you did not set explicit auditing SACLs on the files or folders that you created, modified, and deleted).  
  
> [!IMPORTANT]  
> A new logon event is generated on the computer where the resource is located, on behalf of the user for whom effective access is being checked. When analyzing security audit logs for user sign-in activity, to differentiate between logon events that are generated because of effective access and those generated because of an interactive network user sign in, the Impersonation Level information is included. When the logon event is generated because of effective access, the Impersonation Level will be Identity. A network interactive user sign in typically generates a logon event with the Impersonation Level = Impersonation or Delegation.  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Scenario: File Access Auditing](Scenario--File-Access-Auditing.md)  
  
-   [Plan for File Access Auditing](Plan-for-File-Access-Auditing.md)  
  
-   [Dynamic Access Control: Scenario Overview](Dynamic-Access-Control--Scenario-Overview.md)  
  

