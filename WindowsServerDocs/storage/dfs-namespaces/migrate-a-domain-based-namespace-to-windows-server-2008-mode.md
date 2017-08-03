Published: October 22, 2009

Updated: October 16, 2013

Applies To: Windows Server 2008 R2, Windows Server 2012, Windows Server 2012 R2

The Windows ServerÂ 2008 mode for domain-based namespaces includes support for access-based enumeration and increased scalability.

To migrate a domain-based namespace from WindowsÂ 2000Â Server mode to Windows ServerÂ 2008 mode, you must export the namespace to a file, delete the namespace, recreate it in Windows ServerÂ 2008 mode, and then import the namespace settings. To do so, use the following procedure.

#### To migrate a domain-based namespace to Windows ServerÂ 2008 mode

1.  Open a Command Prompt window and type the following command to export the namespace to a file, where \\\\ *domain* \\ *namespace* is the name of the appropriate domain and namespace and *path\\filename* is the path and file name of the export file:

    [Copy](javascript:if%20(window.epx.codeSnippet)window.epx.codeSnippet.copyCode('CodeSnippetContainerCode_d9a5de92-42cc-4975-9753-eb9b6ec44654'); "Copy to clipboard.")

        Dfsutil root export 
            \\domain\namespace path\filename
          .xml 

2.  Write down the path (\\\\ *server* \\ *share* ) for each namespace server. You must manually add namespace servers to the recreated namespace because Dfsutil cannot import namespace servers.

3.  In DFS Management, right-click the namespace and then click **Delete** , or type the following command at a command prompt, where \\\\ *domain* \\ *namespace* is the name of the appropriate domain and namespace:

    [Copy](javascript:if%20(window.epx.codeSnippet)window.epx.codeSnippet.copyCode('CodeSnippetContainerCode_65771de1-06fd-477a-9e5d-61e801f4995d'); "Copy to clipboard.")

        Dfsutil root remove 
            \\domain\namespace

4.  In DFS Management, recreate the namespace with the same name, but use the Windows ServerÂ 2008 mode, or type the following command at a command prompt, where \\\\ *server* \\ *namespace* is the name of the appropriate server and share for the namespace root:

    [Copy](javascript:if%20(window.epx.codeSnippet)window.epx.codeSnippet.copyCode('CodeSnippetContainerCode_891d2f68-dba5-4c59-8823-57d56fe59201'); "Copy to clipboard.")

        Dfsutil root adddom 
            \\server\namespace 
          v2

5.  To import the namespace from the export file, type the following command at a command prompt, where \\\\ *domain* \\ *namespace* is the name of the appropriate domain and namespace and *path\\filename* is the path and file name of the file to import:

    [Copy](javascript:if%20(window.epx.codeSnippet)window.epx.codeSnippet.copyCode('CodeSnippetContainerCode_833c712d-f4eb-492d-9133-7608542fe5d6'); "Copy to clipboard.")

        Dfsutil root import merge 
            path\filename
          .xml
             \\domain\namespace

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
    <td>To minimize the time that is required to import a large namespace, run the <strong>Dfsutil</strong> root import command locally on a namespace server.
    <p></p></td>
    </tr>
    </tbody>
    </table>

6.  Add any remaining namespace servers to the recreated namespace by right-clicking the namespace in DFS Management and then clicking **Add Namespace Server** , or by typing the following command at a command prompt, where \\\\ *server* \\ *share* is the name of the appropriate server and share for the namespace root:

    [Copy](javascript:if%20(window.epx.codeSnippet)window.epx.codeSnippet.copyCode('CodeSnippetContainerCode_5fdcbbe1-9568-4eca-9a57-a074e3215840'); "Copy to clipboard.")

        Dfsutil target add 
            \\server\share 

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
    <td>You can add namespace servers before importing the namespace, but doing so causes the namespace servers to incrementally download the metadata for the namespace instead of immediately downloading the entire namespace after being added as a namespace server.
    <p></p></td>
    </tr>
    </tbody>
    </table>

#### Additional references

-   [Deploying DFS Namespaces](https://technet.microsoft.com/en-us/library/cc771424(v=ws.11).aspx)
-   [Choose a Namespace Type](https://technet.microsoft.com/en-us/library/cc770287(v=ws.11).aspx)


