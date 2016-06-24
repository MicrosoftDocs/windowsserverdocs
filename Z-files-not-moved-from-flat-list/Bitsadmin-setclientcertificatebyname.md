---
title: Bitsadmin setclientcertificatebyname
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f308a6d9-d0da-48be-ae41-eced14b3cccb
author: britw
---
# Bitsadmin setclientcertificatebyname
Specifies the subject name of the client certificate to use for client authentication in an HTTPS (SSL) request.  
  
## Syntax  
  
```  
bitsadmin /SetClientCertificateByID <Job> <store_location> <store_name> <subject_name>  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------------|---------------|  
|Job|The job's display name or GUID|  
|Store_location|Identifies the location of a system store to use for looking up the certificate. Possible values include:<br /><br />1 (CURRENT_USER)<br /><br />2 (LOCAL_MACHINE)<br /><br />3 (CURRENT_SERVICE)<br /><br />4 (SERVICES)<br /><br />5 (USERS)<br /><br />6 (CURRENT_USER_GROUP_POLICY)<br /><br />7 (LOCAL_MACHINE_GROUP_POLICY)<br /><br />8 (LOCAL_MACHINE_ENTERPRISE)|  
|Store_name|The name of the certificate store. Possible values include:<br /><br />CA (Certification Authority certificates)<br /><br />MY (Personal certificates)<br /><br />ROOT (Root certificates)<br /><br />SPC (Software Publisher Certificate)|  
|Subject_name|Name of the certificate|  
  
## <a name="BKMK_examples"></a>Examples  
The following example specifies the name of the client certificate *myCertificate* to use for client authentication in an HTTPS (SSL) request for the job named *myJob*.  
  
```  
C:\>bitsadmin Bitsadmin /SetClientCertificateByName myJob 1 MY myCertificate   
```  
  
## Additional references  
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)  
  

