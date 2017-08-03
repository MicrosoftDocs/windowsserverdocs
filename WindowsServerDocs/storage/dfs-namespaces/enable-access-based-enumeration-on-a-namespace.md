Published: October 22, 2009

Updated: October 16, 2013

Applies To: Windows Server 2008 R2, Windows Server 2012, Windows Server 2012 R2

Access-based enumeration hides files and folders that users do not have permission to access. By default, this feature is not enabled for DFS namespaces. You can enable access-based enumeration of DFS folders by using DFS Management. To control access-based enumeration of files and folders in folder targets, you must enable access-based enumeration on each shared folder by using Share and Storage Management.

To enable access-based enumeration on a namespace, all namespace servers must be running Windows ServerÂ 2008 or newer. Additionally, domain-based namespaces must use the Windows ServerÂ 2008 mode. For information about the requirements of the Windows ServerÂ 2008 mode, see [Choose a Namespace Type](https://technet.microsoft.com/en-us/library/cc770287(v=ws.11).aspx).

In some environments, enabling access-based enumeration can cause high CPU utilization on the server and slow response times for users. For more information, see the Microsoft Web site (<http://go.microsoft.com/fwlink/?LinkId=140356>).

<table>
<colgroup>
<col width="100%" />
</colgroup>
<thead>
<tr class="header">
<th><img src="https://i-technet.sec.s-msft.com/areas/global/content/clear.gif" title="note" alt="note" id="note" class="cl_IC101471" />Note</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>If you upgrade the domain functional level to Windows ServerÂ 2008 while there are existing domain-based namespaces, DFS Management will allow you to enable access-based enumeration on these namespaces. However, you will not be able to edit permissions to hide folders from any groups or users unless you migrate the namespaces to the Windows ServerÂ 2008 mode. For more information, see <a href="https://technet.microsoft.com/en-us/library/cc753875(v=ws.11).aspx">Migrate a Domain-based Namespace to Windows Server 2008 Mode</a>.
<p></p></td>
</tr>
</tbody>
</table>

To use access-based enumeration with DFS Namespaces to control which groups or users can view which DFS folders, you must follow these steps.

-   Enable access-based enumeration on a namespace
-   Control which users and groups can view individual DFS folders

<table>
<colgroup>
<col width="100%" />
</colgroup>
<thead>
<tr class="header">
<th><img src="https://i-technet.sec.s-msft.com/dynimg/IC1429.gif" title="Caution" alt="Caution" id="Caution" />Caution</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>Access-based enumeration does not prevent users from getting a referral to a folder target if they already know the DFS path. Only the share permissions or the NTFS file system permissions of the folder target (shared folder) itself can prevent users from accessing a folder target. DFS folder permissions are used only for displaying or hiding DFS folders, not for controlling access, making Read access the only relevant permission at the DFS folder level. For more information, see <a href="https://technet.microsoft.com/en-us/library/dd834874(v=ws.11).aspx">Using Inherited Permissions with Access-Based Enumeration</a>.
<p></p></td>
</tr>
</tbody>
</table>

Enabling access-based enumeration on a namespace
------------------------------------------------

-   [Using the Windows interface](#BKMK_UI)
-   [Using a command line](#BKMK_CMD)

<table>
<colgroup>
<col width="100%" />
</colgroup>
<thead>
<tr class="header">
<th><img src="https://i-technet.sec.s-msft.com/dynimg/IC115537.gif" title="Tip" alt="Tip" id="Tip" />Tip</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>To manage access-based enumeration on a namespace by using Windows PowerShell, use the <a href="https://technet.microsoft.com/library/jj884281.aspx">Set-DfsnRoot</a>, <a href="https://technet.microsoft.com/library/jj884272.aspx">Grant-DfsnAccess</a>, and <a href="https://technet.microsoft.com/library/jj884273.aspx">Revoke-DfsnAccess</a> cmdlets. The DFSN Windows PowerShell module was introduced in Windows Server 2012.
<p></p></td>
</tr>
</tbody>
</table>

<a href="" id="BKMK_UI"></a>
#### To enable access-based enumeration by using the Windows interface

1.  In the console tree, under the **Namespaces** node, right-click the appropriate namespace and then click **Properties** .

2.  Click the **Advanced** tab and then select the **Enable access-based enumeration for this namespace** check box.

<a href="" id="BKMK_CMD"></a>
#### To enable access-based enumeration by using a command line

1.  Open a command prompt window on a server that has the **Distributed File System** role service or **Distributed File System Tools** feature installed.

2.  Type the following command, where *&lt;namespace\_root&gt;* is the root of the namespace:

    [Copy](javascript:if%20(window.epx.codeSnippet)window.epx.codeSnippet.copyCode('CodeSnippetContainerCode_4b416f08-1bb0-4e6c-8a62-28697274187e'); "Copy to clipboard.")

        dfsutil property abe enable \\
            <namespace_root>

Controlling which users and groups can view individual DFS folders
------------------------------------------------------------------

-   [Using the Windows interface](#BKMK_UI_ACL)
-   [Using a command line](#BKMK_Cmd_ACL)

<a href="" id="BKMK_UI_ACL"></a>
#### To control folder visibility by using the Windows interface

1.  In the console tree, under the **Namespaces** node, locate the folder with targets for which you want to control visibility, right-click it and then click **Properties** .

2.  Click the **Advanced** tab.

3.  Click **Set explicit view permissions on the DFS folder** and then **Configure view permissions** .

4.  Add or remove groups or users by clicking **Add** or **Remove** .

5.  To allow users to see the DFS folder, select the group or user and then select the **Allow** check box.

    To hide the folder from a group or user, select the group or user and then select the **Deny** check box.

<a href="" id="BKMK_Cmd_ACL"></a>
#### To control folder visibility by using a command line

1.  Open a command prompt window on a server that has the **Distributed File System** role service or **Distributed File System Tools** feature installed.

2.  Type the following command, where *&lt;DFSPath&gt;* is the path of the DFS folder (link), *&lt;DOMAIN\\Account&gt;* is the name of the group or user account, and *(â€¦)* is replaced with additional Access Control Entries (ACEs):

    [Copy](javascript:if%20(window.epx.codeSnippet)window.epx.codeSnippet.copyCode('CodeSnippetContainerCode_29862aaf-8e7d-4c1e-9617-1d7015eebba3'); "Copy to clipboard.")

        dfsutil property sd grant 
            <DFSPath>
           DOMAIN\Account:R 
            (â€¦)
           Protect Replace

    For example, to replace existing permissions with permissions that allows the Domain Admins and CONTOSO\\Trainers groups Read (R) access to the `\\contoso.office\public\training` folder, type the following command:

    [Copy](javascript:if%20(window.epx.codeSnippet)window.epx.codeSnippet.copyCode('CodeSnippetContainerCode_c34ccf9f-0ca2-4ae5-a851-cb34202a13e5'); "Copy to clipboard.")

        dfsutil property sd grant \\contoso.office\public\training â€CONTOSO\Domain Adminsâ€:R CONTOSO\Trainers:R Protect Replace 

3.  To perform additional tasks from the command prompt, use the following commands

    ### Â 

    <table>
    <colgroup>
    <col width="50%" />
    <col width="50%" />
    </colgroup>
    <thead>
    <tr class="header">
    <th>Command</th>
    <th>Description</th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td><p><code>Dfsutil property sd deny</code></p></td>
    <td><p>Denies a group or user the ability to view the folder.</p></td>
    </tr>
    <tr class="even">
    <td><p><code>Dfsutil property sd reset</code></p></td>
    <td><p>Removes all permissions from the folder.</p></td>
    </tr>
    <tr class="odd">
    <td><p><code>Dfsutil property sd revoke</code></p></td>
    <td><p>Removes a group or user ACE from the folder.</p></td>
    </tr>
    </tbody>
    </table>

Additional references
---------------------

-   [Create a DFS Namespace](https://technet.microsoft.com/en-us/library/cc731531(v=ws.11).aspx)
-   [Delegate Management Permissions for DFS Namespaces](https://technet.microsoft.com/en-us/library/cc754770(v=ws.11).aspx)
-   [Installing DFS](https://technet.microsoft.com/en-us/library/cc731089(v=ws.11).aspx)
-   [Using Inherited Permissions with Access-Based Enumeration](https://technet.microsoft.com/en-us/library/dd834874(v=ws.11).aspx)


