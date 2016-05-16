---
title: Authorization Rules and Security Features of Windows PowerShell Web Access_1
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-management-and-automation
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 790b3285-8998-405b-8a1a-2a8a84b7b176
---
# Authorization Rules and Security Features of Windows PowerShell Web Access_1
[!INCLUDE[pswa_1](includes/pswa_1_md.md)] in [!INCLUDE[winthreshold_server_1](includes/winthreshold_server_1_md.md)] has a restrictive security model. Users must explicitly be granted access before they can sign in to the [!INCLUDE[pswa_2](includes/pswa_2_md.md)] gateway and use the web\-based [!INCLUDE[wps_2](includes/wps_2_md.md)] console.

-   [Configuring authorization rules and site security](#BKMK_auth)

-   [Session management](#BKMK_sesmgmt)

## <a name="BKMK_auth"></a>Configuring authorization rules and site security
After [!INCLUDE[pswa_2](includes/pswa_2_md.md)] is installed and the gateway is configured, users can open the sign\-in page in a browser, but they cannot sign in until the [!INCLUDE[pswa_2](includes/pswa_2_md.md)] administrator grants users access explicitly. [!INCLUDE[pswa_2](includes/pswa_2_md.md)] access control is managed by using the set of [!INCLUDE[wps_2](includes/wps_2_md.md)] cmdlets described in the following table. There is no comparable GUI for adding or managing authorization rules. For more detailed information about [!INCLUDE[pswa_2](includes/pswa_2_md.md)] cmdlets, see the cmdlet reference topics, [Windows PowerShell Web Access Cmdlets](http://technet.microsoft.com/library/hh918342.aspx).

Administrators can define 0\-*n* authentication rules for [!INCLUDE[pswa_2](includes/pswa_2_md.md)]. The default security is restrictive rather than permissive; zero authentication rules means no users have access to anything.

Add\-PswaAuthorizationRule and Test\-PswaAuthorizationRule in [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)] include a Credential parameter that allows you to add and test [!INCLUDE[pswa_2](includes/pswa_2_md.md)] authorization rules from a remote computer, or from within an active [!INCLUDE[pswa_2](includes/pswa_2_md.md)] session. As with other [!INCLUDE[wps_2](includes/wps_2_md.md)] cmdlets that have a Credential parameter, you can specify a PSCredential object as the value of the parameter. To create a PSCredential object that contains credentials you want to pass to a remote computer, run the [Get-Credential](http://technet.microsoft.com/library/hh849815.aspx) cmdlet.

[!INCLUDE[pswa_2](includes/pswa_2_md.md)] authentication rules are whitelist rules. Each rule is a definition of an allowed connection between users, target computers, and particular [!INCLUDE[wps_2](includes/wps_2_md.md)][session configurations](http://technet.microsoft.com/library/dd819508.aspx) \(also referred to as endpoints or runspaces\) on specified target computers.

> [!IMPORTANT]
> A user needs only one rule to be true to get access. If a user is given access to one computer with either full language access or access only to [!INCLUDE[wps_2](includes/wps_2_md.md)] remote management cmdlets, from the web\-based console, the user can log on \(or hop\) to other computers that are connected to the first target computer. The most secure way to configure [!INCLUDE[pswa_2](includes/pswa_2_md.md)] is to allow users access only to constrained session configurations \(also called endpoints or runspaces\) that allow them to accomplish specific tasks that they normally need to perform remotely.

|Name|Description|Parameters|
|--------|---------------|--------------|
|[Add-PswaAuthorizationRule](http://technet.microsoft.com/library/jj592890.aspx)|Adds a new authorization rule to the [!INCLUDE[pswa_2](includes/pswa_2_md.md)] authorization rule set.|-   ComputerGroupName<br />-   ComputerName<br />-   ConfigurationName<br />-   RuleName<br />-   UserGroupName<br />-   UserName<br />-   Credential \([!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] and later\)|
|[Remove-PswaAuthorizationRule](http://technet.microsoft.com/library/jj592893.aspx)|Removes a specified authorization rule from [!INCLUDE[pswa_2](includes/pswa_2_md.md)].|-   Id<br />-   RuleName|
|[Get-PswaAuthorizationRule](http://technet.microsoft.com/library/jj592891.aspx)|Returns a set of [!INCLUDE[pswa_2](includes/pswa_2_md.md)] authorization rules. When it is used without parameters, the cmdlet returns all rules.|-   Id<br />-   RuleName|
|[Test-PswaAuthorizationRule](http://technet.microsoft.com/library/jj592892.aspx)|Evaluates authorization rules to determine if a specific user, computer, or session configuration access request is authorized. By default, if no parameters are added, the cmdlet evaluates all authorization rules. By adding parameters, administrators can specify an authorization rule or a subset of rules to test.|-   ComputerName<br />-   ConfigurationName<br />-   RuleName<br />-   UserName<br />-   Credential \([!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] and later\)|

The preceding cmdlets create a set of access rules which are used to authorize a user on the [!INCLUDE[pswa_2](includes/pswa_2_md.md)] gateway. The rules are different from the access control lists \(ACLs\) on the destination computer, and provide an additional layer of security for web access. More details about security are described in the following section.

If users cannot pass any of the preceding security layers, they receive a generic “access denied” message in their browser windows. Although security details are logged on the gateway server, end users are not shown information about how many security layers they passed, or at which layer the sign\-in or authentication failure occurred.

For more information about configuring authorization rules, see [Configuring authorization rules](#BKMK_configrules) in this topic.

### <a name="BKMK_sec"></a>Security
The [!INCLUDE[pswa_2](includes/pswa_2_md.md)] security model has four layers between an end user of the web\-based console, and a target computer. [!INCLUDE[pswa_2](includes/pswa_2_md.md)] administrators can add security layers through additional configuration in the IIS Manager console. For more information about securing websites in the IIS Manager console, see [Configure Web Server Security (IIS 7)](http://technet.microsoft.com/library/cc731278(v=WS.10).aspx). For more information about IIS best practices and preventing denial\-of\-service attacks, see [Best Practices for Preventing DoS/Denial of Service Attacks](http://technet.microsoft.com/library/cc750213.aspx). An administrator can also buy and install additional, retail authentication software.

The following table describes the four layers of security between end users and target computers.

|Order|Layer|Description|
|---------|---------|---------------|
|1|Web Server \(IIS\) security features, such as client certificate authentication|[!INCLUDE[pswa_2](includes/pswa_2_md.md)] users must always provide a user name and password to authenticate their accounts on the gateway. However, [!INCLUDE[pswa_2](includes/pswa_2_md.md)] administrators can also turn optional client certificate authentication on or off \(see step 10 of “To use IIS Manager to configure the gateway in an existing website” in [Install and Use Windows PowerShell Web Access](Install-and-Use-Windows-PowerShell-Web-Access.md)\). The optional client certificate feature requires end users to have a valid client certificate, in addition to their user names and passwords, and is part of Web Server \(IIS\) configuration. When the client certificate layer is enabled, the [!INCLUDE[pswa_2](includes/pswa_2_md.md)] sign\-in page prompts users to provide valid certificates before their sign\-in credentials are evaluated. Client certificate authentication automatically checks for the client certificate.<br /><br />If a valid certificate is not found, [!INCLUDE[pswa_2](includes/pswa_2_md.md)] informs users, so they can provide the certificate. If a valid client certificate is found, [!INCLUDE[pswa_2](includes/pswa_2_md.md)] opens the sign\-in page for users to provide their user names and passwords.<br /><br />This is one example of additional security settings that are offered by Web Server \(IIS\). For more information about other IIS security features, see [Configure Web Server Security (IIS 7)](http://technet.microsoft.com/library/cc731278(WS.10).aspx).|
|2|[!INCLUDE[pswa_2](includes/pswa_2_md.md)] forms\-based gateway authentication|The [!INCLUDE[pswa_2](includes/pswa_2_md.md)] sign\-in page requires a set of credentials \(user name and password\) and offers users the option of providing different credentials for the target computer. If the user does not provide alternate credentials, the primary user name and password that are used to connect to the gateway are also used to connect to the target computer.<br /><br />The required credentials are authenticated on the [!INCLUDE[pswa_2](includes/pswa_2_md.md)] gateway. These credentials must be valid user accounts on either the local [!INCLUDE[pswa_2](includes/pswa_2_md.md)] gateway server, or in Active Directory®.<br /><br />After a user is authenticated at the gateway, [!INCLUDE[pswa_2](includes/pswa_2_md.md)] checks authorization rules to verify if the user has access to the requested target computer. After successful authorization, the user’s credentials are passed along to the target computer.|
|3|[!INCLUDE[pswa_2](includes/pswa_2_md.md)] authorization rules|After a user is authenticated at the gateway, [!INCLUDE[pswa_2](includes/pswa_2_md.md)] checks authorization rules to verify if the user has access to the requested target computer. After successful authorization, the user’s credentials are passed along to the target computer.<br /><br />These rules are evaluated only after a user has been authenticated by the gateway, and before a user can be authenticated on a target computer.|
|4|Target authentication and authorization rules|The final layer of security for Windows PowerShell Web Access is the target computer’s own security configuration. Users must have the appropriate access rights configured on the target computer, and also in the [!INCLUDE[pswa_2](includes/pswa_2_md.md)] authorization rules, to run a [!INCLUDE[wps_2](includes/wps_2_md.md)] web\-based console that affects a target computer through [!INCLUDE[pswa_2](includes/pswa_2_md.md)].<br /><br />This layer offers the same security mechanisms that would evaluate connection attempts if users tried to create a remote [!INCLUDE[wps_2](includes/wps_2_md.md)] session to a target computer from within [!INCLUDE[wps_2](includes/wps_2_md.md)] by running the **Enter\-PSSession** or **New\-PSSession** cmdlets.<br /><br />By default, [!INCLUDE[pswa_2](includes/pswa_2_md.md)] uses the primary user name and password for authentication on both the gateway and the target computer. The web\-based sign\-in page, in a section titled **Optional connection settings**, offers users the option of providing different credentials for the target computer, if they are required. If the user does not provide alternate credentials, the primary user name and password that are used to connect to the gateway are also used to connect to the target computer.<br /><br />Authorization rules can be used to allow users access to a particular session configuration. You can create restricted runspaces or session configurations for [!INCLUDE[pswa_2](includes/pswa_2_md.md)], and allow specific users to connect only to specific session configurations when they sign in to [!INCLUDE[pswa_2](includes/pswa_2_md.md)]. You can use access control lists \(ACLs\) to determine which users have access to specific endpoints, and further restrict access to the endpoint for a specific set of users by using authorization rules described in this section. For more information about restricted runspaces, see [Constrained Runspaces](http://msdn.microsoft.com/library/windows/desktop/ee706589.aspx) on MSDN.|

### <a name="BKMK_configrules"></a>Configuring authorization rules
Administrators likely want the same authorization rule for [!INCLUDE[pswa_2](includes/pswa_2_md.md)] users that is already defined in their environment for [!INCLUDE[wps_2](includes/wps_2_md.md)] remote management. The first procedure in this section describes how to add a secure authorization rule that grants access to one user, signing in to manage one computer, and within a single session configuration. The second procedure describes how to remove an authorization rule that is no longer needed.

If you plan to use custom session configurations to allow specific users to work only within restricted runspaces in [!INCLUDE[pswa_2](includes/pswa_2_md.md)], create your custom session configurations before you add authorization rules that refer to them. You cannot use the [!INCLUDE[pswa_2](includes/pswa_2_md.md)] cmdlets to create custom session configurations. For more information about creating custom session configurations, see [about_Session_Configuration_Files](http://msdn.microsoft.com/library/windows/desktop/hh847838.aspx) on MSDN.

[!INCLUDE[pswa_2](includes/pswa_2_md.md)] cmdlets support one wildcard character, an asterisk \( \* \). Wildcard characters within strings are not supported; use a single asterisk per property \(users, computers, or session configurations\).

> [!NOTE]
> For more ways you can use authorization rules to grant access to users and help secure the [!INCLUDE[pswa_2](includes/pswa_2_md.md)] environment, see [Other authorization rule scenario examples](#BKMK_others) in this topic.

#### <a name="BKMK_arar"></a>To add a restrictive authorization rule

1.  Do one of the following to open a [!INCLUDE[wps_2](includes/wps_2_md.md)] session with elevated user rights.

    -   On the Windows desktop, right\-click **Windows PowerShell** on the taskbar, and then click **Run as Administrator**.

    -   On the Windows **Start** screen, right\-click **Windows PowerShell**, and then click **Run as Administrator**.

2.  **Optional step for restricting user access by using session configurations:** Verify that session configurations that you want to use in your rules already exist. If they have not yet been created, use instructions for creating session configurations in [about_Session_Configuration_Files](http://msdn.microsoft.com/library/windows/desktop/hh847838.aspx) on MSDN.

3.  Type the following, and then press **Enter**.

    ```
    Add-PswaAuthorizationRule –UserName <domain\user | computer\user> -ComputerName <computer_name> -ConfigurationName <session_configuration_name>
    ```

    This authorization rule allows a specific user access to one computer on the network to which they typically have access, with access to a specific session configuration that is scoped to the user’s typical scripting and cmdlet needs. In the following example, a user named `JSmith` in the `Contoso` domain is granted access to manage the computer `Contoso_214`, and use a session configuration named `NewAdminsOnly`.

    ```
    Add-PswaAuthorizationRule –UserName Contoso\JSmith -ComputerName Contoso_214 -ConfigurationName NewAdminsOnly
    ```

4.  Verify that the rule has been created by running either the **Get\-PswaAuthorizationRule** cmdlet, or **Test\-PswaAuthorizationRule \-UserName <domain\\user | computer\\user> \-ComputerName** <computer\_name>. For example, **Test\-PswaAuthorizationRule –UserName Contoso\\JSmith –ComputerName Contoso\_214**.

##### To remove an authorization rule

1.  If a [!INCLUDE[wps_2](includes/wps_2_md.md)] session is not already open, see step 1 of [To add a restrictive authorization rule](#BKMK_arar) in this section.

2.  Type the following, and then press **Enter**, where *rule ID* represents the unique ID number of the rule that you want to remove.

    ```
    Remove-PswaAuthorizationRule -ID <rule ID>
    ```

    Alternatively, if you do not know the ID number, but know the friendly name of the rule you want to remove, you can get the name of the rule, and pipe it to the `Remove-PswaAuthorizationRule` cmdlet to remove the rule, as shown in the following example: Get\-PswaAuthorizationRule \-RuleName <*rule name*> | Remove\-PswaAuthorizationRule.

    > [!NOTE]
    > You are not prompted to confirm whether you want to delete the specified authorization rule; the rule is deleted when you press **Enter**. Be sure that you want to remove the authorization rule before running the **Remove\-PswaAuthorizationRule** cmdlet.

#### <a name="BKMK_others"></a>Other authorization rule scenario examples
Every [!INCLUDE[wps_2](includes/wps_2_md.md)] session uses a session configuration; if one is not specified for a session, [!INCLUDE[wps_2](includes/wps_2_md.md)] uses the default, built\-in [!INCLUDE[wps_2](includes/wps_2_md.md)] session configuration, called Microsoft.PowerShell. The default session configuration includes all cmdlets that are available on a computer. Administrators can restrict access to all computers by defining a session configuration with a restricted runspace \(a limited range of cmdlets and tasks that their end users could perform\). A user who is granted access to one computer with either full language access or only the [!INCLUDE[wps_2](includes/wps_2_md.md)] remote management cmdlets can connect to other computers that are connected to the first computer. Defining a restricted runspace can prevent users from accessing other computers from their allowed [!INCLUDE[wps_2](includes/wps_2_md.md)] runspace, and improves the security of your [!INCLUDE[pswa_2](includes/pswa_2_md.md)] environment. The session configuration can be distributed \(by using Group Policy\) to all computers that administrators want to make accessible through [!INCLUDE[pswa_2](includes/pswa_2_md.md)]. For more information about session configurations, see [about_Session_Configurations](http://technet.microsoft.com/library/dd819508.aspx). The following are some examples of this scenario.

-   An administrator creates an endpoint, called **PswaEndpoint**, with a restricted runspace. Then, the administrator creates a rule, **\*,\*,PswaEndpoint**, and distributes the endpoint to other computers. The rule allows all users to access all computers with the endpoint **PswaEndpoint**. If this is the only authorization rule defined in the rule set, computers without that endpoint would not be accessible.

-   The administrator created an endpoint with a restricted runspace called **PswaEndpoint**,and wants to restrict access to specific users. The administrator creates a group of users called **Level1Support**, and defines the following rule: **Level1Support,\*,PswaEndpoint**. The rule grants any users in the group **Level1Support** access to all computers with the **PswaEndpoint** configuration. Similarly, access can be restricted to a specific set of computers.

-   Some administrators provide certain users more access than others. For example, an administrator creates two user groups, **Admins** and **BasicSupport**. The administrator also creates an endpoint with a restricted runspace called **PswaEndpoint**, and defines the following two rules: **Admins,\*,\*** and **BasicSupport,\*,PswaEndpoint**. The first rule provides all users in the **Admin** group access to all computers, and the second rule provides all users in the **BasicSupport** group access only to those computers with **PswaEndpoint**.

-   An administrator has set up a private test environment, and wants to allow all authorized network users access to all computers on the network to which they typically have access, with access to all session configurations to which they typically have access. Because this is a private test environment, the administrator creates an authorization rule that is not secure. The administrator runs the cmdlet `Add-PswaAuthorizationRule * * *`, which uses the wildcard character **\*** to represent all users, all computers, and all configurations. This rule is the equivalent of the following: `Add-PswaAuthorizationRule –UserName * -ComputerName * -ConfigurationName *`.

    > [!IMPORTANT]
    > This rule is not recommended in a secure environment, and bypasses the authorization rule layer of security provided by [!INCLUDE[pswa_2](includes/pswa_2_md.md)].

-   An administrator must allow users to connect to target computers in an environment that includes both workgroups and domains, where workgroup computers are occasionally used to connect to target computers in domains, and computers in domains are occasionally used to connect to target computers in workgroups. The administrator has a gateway server, *PswaServer*, in a workgroup; and target computer *srv1.contoso.com* is in a domain. User *Chris* is an authorized local user on both the workgroup gateway server and the target computer. His user name on the workgroup server is *chrisLocal*; and his user name on the target computer is *contoso\\chris*. To authorize access to srv1.contoso.com for Chris, the administrator adds the following rule.

    ```
    Add-PswaAuthorizationRule –userName PswaServer\chrisLocal –computerName srv1.contoso.com –configurationName Microsoft.PowerShell
    ```

    The preceding rule example authenticates Chris on the gateway server, and then authorizes his access to *srv1*. On the sign\-in page, Chris must provide a second set of credentials in the **Optional connection settings** area \(*contoso\\chris*\). The gateway server uses the additional set of credentials to authenticate him on the target computer, *srv1.contoso.com*.

    In the preceding scenario, [!INCLUDE[pswa_2](includes/pswa_2_md.md)] establishes a successful connection to the target computer only after the following have been successful, and allowed by at least one authorization rule.

    1.  Authentication on the workgroup gateway server by adding a user name in the format *server\_name*\\*user\_name* to the authorization rule

    2.  Authentication on the target computer by using alternate credentials provided on the sign\-in page, in the **Optional connection settings** area

    > [!NOTE]
    > If gateway and target computers are in different workgroups or domains, a trust relationship must be established between the two workgroup computers, the two domains, or between the workgroup and the domain. This relationship cannot be configured by using [!INCLUDE[pswa_2](includes/pswa_2_md.md)] authorization rule cmdlets. Authorization rules do not define a trust relationship between computers; they can only authorize users to connect to specific target computers and session configurations. For more information about how to configure a trust relationship between different domains, see [Creating Domain and Forest Trusts](http://technet.microsoft.com/library/cc794775.aspx). For more information about how to add workgroup computers to a trusted hosts list, see [Remote Management with Server Manager](http://technet.microsoft.com/library/dd759202.aspx).

### Using a single set of authorization rules for multiple sites
Authorization rules are stored in an XML file. By default, the path name of the XML file is %windir%\\Web\\PowershellWebAccess\\data\\AuthorizationRules.xml.

The path to the authorization rules XML file is stored in the **powwa.config** file, which is found in %windir%\\Web\\PowershellWebAccess\\data. The administrator has the flexibility to change the reference to the default path in **powwa.config** to suit preferences or requirements. Allowing the administrator to change the location of the file lets multiple [!INCLUDE[pswa_2](includes/pswa_2_md.md)] gateways use the same authorization rules, if such a configuration is desired.

## <a name="BKMK_sesmgmt"></a>Session management
By default, [!INCLUDE[pswa_2](includes/pswa_2_md.md)] limits a user to three sessions at one time. You can edit the web application’s **web.config** file in IIS Manager to support a different number of sessions per user. The path to the **web.config** file is $Env:Windir\\Web\\PowerShellWebAccess\\wwwroot\\Web.config.

By default, Web Server \(IIS\) is configured to restart the application pool if any settings are edited. For example, the application pool is restarted if changes are made to the **web.config** file. Because [!INCLUDE[pswa_2](includes/pswa_2_md.md)] uses in\-memory session states, users signed in to [!INCLUDE[pswa_2](includes/pswa_2_md.md)] sessions lose their sessions when the application pool is restarted.

### Setting default parameters on the sign\-in page
If your [!INCLUDE[pswa_2](includes/pswa_2_md.md)] gateway is running on [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)], you can configure default values for the settings that are displayed on the [!INCLUDE[pswa_2](includes/pswa_2_md.md)] sign\-in page. You can configure values in the **web.config** file that is described in the preceding paragraph. Default values for the sign\-in page settings are found in the **appSettings** section of the web.config file; the following is an example of the **appSettings** section. Valid values for many of these settings are the same as those for the corresponding parameters of the [New-PSSession](http://technet.microsoft.com/library/hh849717.aspx) cmdlet in [!INCLUDE[wps_2](includes/wps_2_md.md)]. For example, the `defaultApplicationName` key, as shown in the following code block, is the value of the **$PSSessionApplicationName** preference variable on the target computer.

```
<appSettings>
        <add key="maxSessionsAllowedPerUser" value="3"/>
        <add key="defaultPortNumber" value="5985"/>
        <add key="defaultSSLPortNumber" value="5986"/>
        <add key="defaultApplicationName" value="WSMAN"/>
        <add key="defaultUseSslSelection" value="0"/>
        <add key="defaultAuthenticationType" value="0"/>
        <add key="defaultAllowRedirection" value="0"/>
        <add key="defaultConfigurationName" value="Microsoft.PowerShell"/>
</appSettings>
```

### Time\-outs and unplanned disconnections
[!INCLUDE[pswa_2](includes/pswa_2_md.md)] sessions time out. In [!INCLUDE[pswa_2](includes/pswa_2_md.md)] running on [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], A time\-out message is displayed to signed\-in users after 15 minutes of session inactivity. If the user does not respond within five minutes after the time\-out message is displayed, the session is ended, and the user is signed out. You can change time\-out periods for sessions in the website settings in IIS Manager.

In [!INCLUDE[pswa_2](includes/pswa_2_md.md)] running on [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)], sessions time out, by default, after 20 minutes of inactivity. If users are disconnected from sessions in the web\-based console because of network errors or other unplanned shutdowns or failures, and not because they have closed the sessions themselves, the [!INCLUDE[pswa_2](includes/pswa_2_md.md)] sessions continue to run, connected to target computers, until the time\-out period on the client side lapses. The session is disconnected after either the default 20 minutes, or after the time\-out period specified by the gateway administrator, whichever is shorter.

If the gateway server is running [!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)], [!INCLUDE[pswa_2](includes/pswa_2_md.md)] lets users reconnect to saved sessions at a later time, but when network errors, unplanned shutdowns, or other failures disconnect sessions, users cannot see or reconnect to saved sessions until after the time\-out period specified by the gateway administrator has lapsed.

## See Also
[Install and Use Windows PowerShell Web Access](Install-and-Use-Windows-PowerShell-Web-Access.md)
[about_Session_Configurations](http://technet.microsoft.com/library/dd819508.aspx)
[Windows PowerShell Web Access Cmdlets](http://technet.microsoft.com/library/hh918342.aspx)


