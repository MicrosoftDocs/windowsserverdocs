---
title: certutil
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c264ccf0-ba1e-412b-9dd3-d77dd9345ad9
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# certutil

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

certutil.exe is a command-line program that is installed as part of Certificate Services. You can use certutil.exe to dump and display certification authority (CA) configuration information, configure Certificate Services, backup and restore CA components, and verify certificates, key pairs, and certificate chains.
When certutil is run on a certification authority without additional parameters, it displays the current certification authority configuration. When cerutil is run on a non-certification authority, the command defaults to running the certutil [-dump](certutil.md#BKMK_dump) verb.
> [!WARNING]
> Earlier versions of certutil may not provide all of the options that are described in this document. You can see all the options that a specific version of certutil provides by running the commands shown in the [Syntax notations](certutil.md#BKMK_notations) section.
## <a name="BKMK_menu"></a>Menu
The major sections in this document are:
-   [verbs](certutil.md#BKMK_verbs)
-   [Syntax notations](certutil.md#BKMK_notations)
-   [Options](certutil.md#BKMK_Options)
-   [additional certutil examples](certutil.md#BKMK_addedExamples)
## <a name="BKMK_verbs"></a>verbs
The following table describes the verbs that can be used with the certutil command.
|verbs|Description|
|-----|--------|
|[-dump](certutil.md#BKMK_dump)|Dump configuration information or files|
|[-asn](certutil.md#BKMK_asn)|Parse ASN.1 file|
|[-decodehex](certutil.md#BKMK_decodehex)-decodehex|Decode hexadecimal-encoded file|
|[-decode](certutil.md#BKMK_decode)|Decode a Base64-encoded file|
|[-encode](certutil.md#BKMK_encode)|Encode a file to Base64|
|[-deny](certutil.md#BKMK_deny)|Deny a pending certificate request|
|[-resubmit](certutil.md#BKMK_resubmit)|Resubmit a pending certificate request|
|[-setattributes](certutil.md#BKMK_setattributes)|Set attributes for a pending certificate request|
|[-setextension](certutil.md#BKMK_setextension)|Set an extension for a pending certificate request|
|[-revoke](certutil.md#BKMK_revoke)|Revoke a certificate|
|[-isvalid](certutil.md#BKMK_isvalid)|Display the disposition of the current certificate|
|[-getconfig](certutil.md#BKMK_getconfig)|Get the default configuration string|
|[-ping](certutil.md#BKMK_ping)|attempt to contact the active directory Certificate Services Request interface|
|-pingadmin|attempt to contact the active directory Certificate Services Admin interface|
|[-CAInfo](certutil.md#BKMK_CAInfo)|Display information about the certification authority|
|[-ca.cert](certutil.md#BKMK_ca.cert)|Retrieve the certificate for the certification authority|
|[-ca.chain](certutil.md#BKMK_ca.chain)|Retrieve the certificate chain for the certification authority|
|[-GetCRL](certutil.md#BKMK_GetCRL)|Get a certificate revocation list (CRL)|
|[-CRL](certutil.md#BKMK_CRL)|Publish new certificate revocation lists (CRLs) [or only delta CRLs]|
|[-shutdown](certutil.md#BKMK_shutdown)|shutdown active directory Certificate Services|
|[-installCert](certutil.md#BKMK_installcert)|Install a certification authority certificate|
|[-renewCert](certutil.md#BKMK_renewcert)|renew a certification authority certificate|
|[-schema](certutil.md#BKMK_schema)|Dump the schema for the certificate|
|[-view](certutil.md#BKMK_view)|Dump the certificate view|
|[-db](certutil.md#BKMK_db)|Dump the raw database|
|[-deleterow](certutil.md#BKMK_deleterow)|delete a row from the server database|
|[-backup](certutil.md#BKMK_backup)|Backup active directory Certificate Services|
|[-backupDB](certutil.md#BKMK_backupDB)|Backup the active directory Certificate Services database|
|[-backupKey](certutil.md#BKMK_backupKey)|Backup the active directory Certificate Services certificate and private key|
|[-restore](certutil.md#BKMK_restore)|Restore active directory Certificate Services|
|[-restoreDB](certutil.md#BKMK_restoreDB)|Restore the active directory Certificate Services database|
|[-restoreKey](certutil.md#BKMK_restorekey)|Restore the active directory Certificate Services certificate and private key|
|[-importPFX](certutil.md#BKMK_importPFX)|import certificate and private key|
|[-dynamicfilelist](certutil.md#BKMK_dynamicfilelist)|Display a dynamic file list|
|[-databaselocations](certutil.md#BKMK_databaselocations)|Display database locations|
|[-hashfile](certutil.md#BKMK_hashfile)|Generate and display a cryptographic hash over a file|
|[-store](certutil.md#BKMK_Store)|Dump the certificate store|
|[-addstore](certutil.md#BKMK_addstore)|add a certificate to the store|
|[-delstore](certutil.md#BKMK_delstore)|delete a certificate from the store|
|[-verifystore](certutil.md#BKMK_verifystore)|verify a certificate in the store|
|[-repairstore](certutil.md#BKMK_repairstore)|repair a key association or update certificate properties or the key security descriptor|
|[-viewstore](certutil.md#BKMK_viewstore)|Dump the certificates store|
|[-viewdelstore](certutil.md#BKMK_viewdelstore)|delete a certificate from the store|
|[-dsPublish](certutil.md#BKMK_dsPublish)|Publish a certificate or certificate revocation list (CRL) to active directory|
|[-ADTemplate](certutil.md#BKMK_ADTemplate)|Display AD templates|
|[-Template](certutil.md#BKMK_template)|Display certificate templates|
|[-TemplateCAs](certutil.md#BKMK_TemplateCAs)|Display the certification authorities (CAs) for a certificate template|
|[-Catemplates](certutil.md#BKMK_Catemplates)|Display templates for CA|
|[-SetCASites](certutil.md#BKMK_SetCASites)|Manage Site Names for CAs|
|[-enrollmentServerURL](certutil.md#BKMK_enrollmentServerURL)|Display, add or delete enrollment server URLs associated with a CA|
|[-ADCA](certutil.md#BKMK_ADCA)|Display AD CAs|
|[-CA](certutil.md#BKMK_CA)|Display Enrollment Policy CAs|
|[-Policy](certutil.md#BKMK_Policy)|Display Enrollment Policy|
|[-PolicyCache](certutil.md#BKMK_PolicyCache)|Display or delete Enrollment Policy Cache entries|
|[-CredStore](certutil.md#BKMK_Credstore)|Display, add or delete Credential Store entries|
|[-InstallDefaultTemplates](certutil.md#BKMK_InstallDefaultTemplates)|Install default certificate templates|
|[-URLCache](certutil.md#BKMK_URLCache)|Display or delete URL cache entries|
|[-pulse](certutil.md#BKMK_pulse)|Pulse auto enrollment events|
|[-MachineInfo](certutil.md#BKMK_MachineInfo)|Display information about the active directory machine object|
|[-DCInfo](certutil.md#BKMK_DCInfo)|Display information about the domain controller|
|[-EntInfo](certutil.md#BKMK_EntInfo)|Display information about an enterprise CA|
|[-TCAInfo](certutil.md#BKMK_TCAInfo)|Display information about the CA|
|[-SCInfo](certutil.md#BKMK_SCInfo)|Display information about the smart card|
|[-SCRoots](certutil.md#BKMK_SCRoots)|Manage smart card root certificates|
|[-verifykeys](certutil.md#BKMK_verifykeys)|verify a public or private key set|
|[-verify](certutil.md#BKMK_verify)|verify a certificate, certificate revocation list (CRL), or certificate chain|
|[-verifyCTL](certutil.md#BKMK_verifyCTL)|verify AuthRoot or Disallowed Certificates CTL|
|[-sign](certutil.md#BKMK_sign)|Re-sign a certificate revocation list (CRL) or certificate|
|[-vroot](certutil.md#BKMK_vroot)|create or delete web virtual roots and file shares|
|[-vocsproot](certutil.md#BKMK_vocsproot)|create or delete web virtual roots for an OCSP web proxy|
|[-addEnrollmentServer](certutil.md#BKMK_addEnrollmentServer)|add an Enrollment Server application|
|[-deleteEnrollmentServer](certutil.md#BKMK_deleteEnrollmentServer)|delete an Enrollment Server application|
|[-addPolicyServer](certutil.md#BKMK_addPolicyServer)|add a Policy Server application|
|[-deletePolicyServer](certutil.md#BKMK_deletePolicyServer)|delete a Policy Server application|
|[-oid](certutil.md#BKMK_oid)|Display the object identifier or set a display name|
|[-error](certutil.md#BKMK_error)|Display the message text associated with an error code|
|[-getreg](certutil.md#BKMK_getreg)|Display a registry value|
|[-setreg](certutil.md#BKMK_setreg)|Set a registry value|
|[-delreg](certutil.md#BKMK_delreg)|delete a registry value|
|[-importKMS](certutil.md#BKMK_importKMS)|import user keys and certificates into the server database for key archival|
|[-importCert](certutil.md#BKMK_importCert)|import a certificate file into the database|
|[-GetKey](certutil.md#BKMK_GetKey)|Retrieve an archived private key recovery blob|
|[-recoverKey](certutil.md#BKMK_recoverKey)|recover an archived private key|
|[-MergePFX](certutil.md#BKMK_MergePFX)|Merge PFX files|
|[-convertEPF](certutil.md#BKMK_convertEPF)|convert a PFX file into an EPF file|
|-?|Displays the list of verbs|
|-*<verb>* -?|Displays help for the verb specified.|
|-? -v|Displays a full list of verbs and|
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_notations"></a>Syntax notations
-   for basic command line syntax, run `certutil -?`
-   for the syntax on using certutil with a specific verb, run **certutil** *<verb>* **-?**
-   To send all of the certutil syntax into a text file, run the following commands:
    -   `certutil -v -? > certutilhelp.txt`
    -   `notepad certutilhelp.txt`
The following table describes the notation used to indicate command-line syntax.
|Notation|Description|
|------|--------|
|Text without brackets or braces|Items you must type as shown|
|<Text inside angle brackets>|Placeholder for which you must supply a value|
|[Text inside square brackets]|Optional items|
|{Text inside braces}|Set of required items; choose one|
|vertical bar (&#124;)|Separator for mutually exclusive items; choose one|
|Ellipsis ( )|Items that can be repeated|
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_dump"></a>-dump
certutil [Options] [-dump]
certutil [Options] [-dump] File
Dump configuration information or files
[-f] [-silent] [-split] [-p Password] [-t timeout]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_asn"></a>-asn
certutil [Options] -asn File [type]
Parse ASN.1 file
type: numeric CRYPT_STRING_* decoding type
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_decodehex"></a>-decodehex
certutil [Options] -decodehex InFile OutFile [type]
type: numeric CRYPT_STRING_* encoding type
[-f]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_decode"></a>-decode
certutil [Options] -decode InFile OutFile
Decode Base64-encoded file
[-f]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_encode"></a>-encode
certutil [Options] -encode InFile OutFile
Encode file to Base64
[-f] [-UnicodeText]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_deny"></a>-deny
certutil [Options] -deny RequestId
Deny pending request
[-config Machine\CAName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_resubmit"></a>-resubmit
certutil [Options] -resubmit RequestId
Resubmit pending request
[-config Machine\CAName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_setattributes"></a>-setattributes
certutil [Options] -setattributes RequestId attributestring
Set attributes for pending request
RequestId - numeric Request Id of pending request
attributestring - Request attribute name and value pairs
-   Names and values are colon separated.
-   Multiple name, value pairs are newline separated.
-   Example: "CertificateTemplate:User\nEMail:User@Domain.com"
-   Each "\n" sequence is converted to a newline separator.
[-config Machine\CAName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_setextension"></a>-setextension
certutil [Options] -setextension RequestId ExtensionName Flags {Long | date | String | @InFile}
Set extension for pending request
RequestId - numeric Request Id of a pending request
ExtensionName - ObjectId string of the extension
Flags - 0 is recommended.  1 makes the extension critical, 2 disables it, 3 does both.
if the last parameter is numeric, it is taken as a Long.
if it can be parsed as a date, it is taken as a date.
if it starts with '@', the rest of the token is the filename containing binary data or an ascii-text hex dump.
Anything else is taken as a String.
[-config Machine\CAName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_revoke"></a>-revoke
certutil [Options] -revoke SerialNumber [Reason]
Revoke Certificate
SerialNumber: Comma separated list of certificate serial numbers to revoke
Reason: numeric or symbolic revocation reason
-   0: CRL_REASON_UNSPECifIED: Unspecified (default)
-   1: CRL_REASON_KEY_compROMISE: Key compromise
-   2: CRL_REASON_CA_compROMISE: CA compromise
-   3: CRL_REASON_AFFILIatION_changeD: Affiliation changed
-   4: CRL_REASON_SUPERSEDED: Superseded
-   5: CRL_REASON_CESSatION_OF_OPERatION: Cessation of Operation
-   6: CRL_REASON_CERTifICatE_HOLD: Certificate Hold
-   8: CRL_REASON_remove_FROM_CRL: remove From CRL
-   -1: Unrevoke: Unrevoke
[-config Machine\CAName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_isvalid"></a>-isvalid
certutil [Options] -isvalid SerialNumber | CertHash
Display current certificate disposition
[-config Machine\CAName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_getconfig"></a>-getconfig
certutil [Options] -getconfig
Get default configuration string
[-config Machine\CAName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_ping"></a>-ping
certutil [Options] -ping [MaxSecondsToWait | CAMachinelist]
ping active directory Certificate Services Request interface
CAMachinelist - Comma-separated CA machine name list
1.  for a single machine, use a terminating comma
2.  Displays the site cost for each CA machine
[-config Machine\CAName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_CAInfo"></a>-CAInfo
certutil [Options] -CAInfo [InfoName [Index | ErrorCode]]
Display CA Information
InfoName - indicates the CA property to display (see below). Use "*" for all properties.
Index - optional zero-based property index
ErrorCode - numeric error code
[-f] [-split] [-config Machine\CAName]
InfoName argument syntax:
-   file: File version
-   product: Product version
-   exitcount: exit module count
-   exit [Index]: exit module description
-   policy: Policy module description
-   name: CA name
-   sanitizedname: sanitized CA name
-   dsname: sanitized CA short name (DS name)
-   sharedfolder: Shared folder
-   error1 ErrorCode: Error message text
-   error2 ErrorCode: Error message text and error code
-   type: CA type
-   info: CA info
-   parent: Parent CA
-   certcount: CA cert count
-   xchgcount: CA exchange cert count
-   kracount: KRA cert count
-   kraused: KRA cert used count
-   propidmax: Maximum CA PropId
-   certstate [Index]: CA cert
-   certversion [Index]: CA cert version
-   certstatuscode [Index]: CA cert verify status
-   crlstate [Index]: CRL
-   krastate [Index]: KRA cert
-   crossstate+ [Index]: forward cross cert
-   crossstate- [Index]: Backward cross cert
-   cert [Index]: CA cert
-   certchain [Index]: CA cert chain
-   certcrlchain [Index]: CA cert chain with CRLs
-   xchg [Index]: CA exchange cert
-   xchgchain [Index]: CA exchange cert chain
-   xchgcrlchain [Index]: CA exchange cert chain with CRLs
-   kra [Index]: KRA cert
-   cross+ [Index]: forward cross cert
-   cross- [Index]: Backward cross cert
-   CRL [Index]: Base CRL
-   deltacrl [Index]: delta CRL
-   crlstatus [Index]: CRL Publish Status
-   deltacrlstatus [Index]: delta CRL Publish Status
-   dns: DNS Name
-   role: Role Separation
-   ads: Advanced Server
-   templates: Templates
-   ocsp [Index]: OCSP URLs
-   aia [Index]: AIA URLs
-   cdp [Index]: cdP URLs
-   localename: CA locale name
-   subjecttemplateoids: Subject Template OIDs
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_ca.cert"></a>-ca.cert
certutil [Options] -ca.cert OutCACertFile [Index]
Retrieve the CA's certificate
OutCACertFile: output file
Index: CA certificate renewal index (defaults to most recent)
[-f] [-split] [-config Machine\CAName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_ca.chain"></a>-ca.chain
certutil [Options] -ca.chain OutCACertChainFile [Index]
Retrieve the CA's certificate chain
OutCACertChainFile: output file
Index: CA certificate renewal index (defaults to most recent)
[-f] [-split] [-config Machine\CAName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_GetCRL"></a>-GetCRL
certutil [Options] -GetCRL OutFile [Index] [delta]
Get CRL
Index: CRL index or key index (defaults to CRL for newest key)
delta: delta CRL (default is base CRL)
[-f] [-split] [-config Machine\CAName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_CRL"></a>-CRL
certutil [Options] -CRL [dd:hh | republish] [delta]
Publish new CRLs [or delta CRLs only]
dd:hh - new CRL validity period in days and hours
republish - republish most recent CRLs
delta - delta CRLs only (default is base and delta CRLs)
[-split] [-config Machine\CAName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_shutdown"></a>-shutdown
certutil [Options] -shutdown
shutdown active directory Certificate Services
[-config Machine\CAName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_installcert"></a>-installCert
certutil [Options] -installCert [CACertFile]
Install Certification Authority certificate
[-f] [-silent] [-config Machine\CAName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_renewcert"></a>-renewCert
certutil [Options] -renewCert [ReuseKeys] [Machine\ParentCAName]
renew Certification Authority certificate
Use -f to ignore an outstanding renewal request, and generate a new request.
[-f] [-silent] [-config Machine\CAName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_schema"></a>-schema
certutil [Options] -schema [Ext | attrib | CRL]
Dump Certificate Schema
Defaults to Request and Certificate table
Ext: Extension table
attrib: attribute table
CRL: CRL table
[-split] [-config Machine\CAName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_view"></a>-view
certutil [Options] -view [Queue | Log | LogFail | Revoked | Ext | attrib | CRL] [csv]
Dump Certificate View
Queue: Request queue
Log: Issued or revoked certificates, plus failed requests
LogFail: Failed requests
Revoked: Revoked certificates
Ext: Extension table
attrib: attribute table
CRL: CRL table
csv: Output as Comma Separated Values
To display the StatusCode column for all entries: -out StatusCode
To display all columns for the last entry: -restrict "RequestId==$"
To display RequestId and Disposition for three requests: -restrict "RequestId>=37,RequestId<40" -out "RequestId,Disposition"
To display Row Ids and CRL Numbers for all Base CRLs: -restrict "CRLMinBase=0" -out "CRLRowId,CRLNumber" CRL
To display Base CRL Number 3: -v -restrict "CRLMinBase=0,CRLNumber=3" -out "CRLRawCRL" CRL
To display the entire CRL table: CRL
Use "date[+|-dd:hh]" for date restrictions
Use "now+dd:hh" for a date relative to the current time
[-silent] [-split] [-config Machine\CAName] [-restrict Restrictionlist] [-out Columnlist]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_db"></a>-db
certutil [Options] -db
Dump Raw Database
[-config Machine\CAName] [-restrict Restrictionlist] [-out Columnlist]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_deleterow"></a>-deleterow
certutil [Options] -deleterow RowId | date [Request | Cert | Ext | attrib | CRL]
delete server database row
Request: Failed and pending requests (submission date)
Cert: Expired and revoked certificates (expiration date)
Ext: Extension table
attrib: attribute table
CRL: CRL table (expiration date)
To delete failed and pending requests submitted by January 22, 2001: 1/22/2001 Request
To delete all certificates that expired by January 22, 2001: 1/22/2001 Cert
To delete the certificate row, attributes and extensions for RequestId 37: 37
To delete CRLs that expired by January 22, 2001: 1/22/2001 CRL
[-f] [-config Machine\CAName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_backup"></a>-backup
certutil [Options] -backup Backupdirectory [Incremental] [KeepLog]
Backup active directory Certificate Services
Backupdirectory: directory to store backed up data
Incremental: perform incremental backup only (default is full backup)
KeepLog: preserve database log files (default is to truncate log files)
[-f] [-config Machine\CAName] [-p Password]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_backupDB"></a>-backupDB
certutil [Options] -backupDB Backupdirectory [Incremental] [KeepLog]
Backup active directory Certificate Services database
Backupdirectory: directory to store backed up database files
Incremental: perform incremental backup only (default is full backup)
KeepLog: preserve database log files (default is to truncate log files)
[-f] [-config Machine\CAName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_backupKey"></a>-backupKey
certutil [Options] -backupKey Backupdirectory
Backup active directory Certificate Services certificate and private key
Backupdirectory: directory to store backed up PFX file
[-f] [-config Machine\CAName] [-p Password] [-t timeout]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_restore"></a>-restore
certutil [Options] -restore Backupdirectory
Restore active directory Certificate Services
Backupdirectory: directory containing data to be restored
[-f] [-config Machine\CAName] [-p Password]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_restoreDB"></a>-restoreDB
certutil [Options] -restoreDB Backupdirectory
Restore active directory Certificate Services database
Backupdirectory: directory containing database files to be restored
[-f] [-config Machine\CAName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_restorekey"></a>-restoreKey
certutil [Options] -restoreKey Backupdirectory | PFXFile
Restore active directory Certificate Services certificate and private key
Backupdirectory: directory containing PFX file to be restored
PFXFile: PFX file to be restored
[-f] [-config Machine\CAName] [-p Password]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_importPFX"></a>-importPFX
certutil [Options] -importPFX [CertificateStorename] PFXFile [Modifiers]
import certificate and private key
CertificateStorename: Certificate store name.  See [-store](certutil.md#BKMK_Store).
PFXFile: PFX file to be imported
Modifiers: Comma separated list of one or more of the following:
1.  at_SIGNatURE: change the KeySpec to Signature
2.  at_KEYEXchange: change the KeySpec to Key Exchange
3.  NoExport: Make the private key non-exportable
4.  NoCert: Do not import the certificate
5.  NoChain: Do not import the certificate chain
6.  NoRoot: Do not import the root certificate
7.  Protect: Protect keys with password
8.  NoProtect: Do not password protect keys
Defaults to personal machine store.
[-f] [-user] [-p Password] [-csp Provider]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_dynamicfilelist"></a>-dynamicfilelist
certutil [Options] -dynamicfilelist
Display dynamic file list
[-config Machine\CAName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_databaselocations"></a>-databaselocations
certutil [Options] -databaselocations
Display database locations
[-config Machine\CAName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_hashfile"></a>-hashfile
certutil [Options] -hashfile InFile [HashAlgorithm]
Generate and display cryptographic hash over a file
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_Store"></a>-store
certutil [Options] -store [CertificateStorename [CertId [OutputFile]]]
Dump certificate store
CertificateStorename: Certificate store name. Examples:
-   "My", "CA" (default), "Root",
-   "ldap:///CN=Certification Authorities,CN=Public Key Services,CN=Services,CN=Configuration,DC=cpandl,DC=com?cACertificate?one?objectClass=certificationAuthority" (View Root Certificates)
-   "ldap:///CN=CAName,CN=Certification Authorities,CN=Public Key Services,CN=Services,CN=Configuration,DC=cpandl,DC=com?cACertificate?base?objectClass=certificationAuthority" (Modify Root Certificates)
-   "ldap:///CN=CAName,CN=MachineName,CN=cdP,CN=Public Key Services,CN=Services,CN=Configuration,DC=cpandl,DC=com?certificateRevocationlist?base?objectClass=cRLDistributionPoint" (View CRLs)
-   "ldap:///CN=NTAuthCertificates,CN=Public Key Services,CN=Services,CN=Configuration,DC=cpandl,DC=com?cACertificate?base?objectClass=certificationAuthority" (Enterprise CA Certificates)
-   ldap: (AD computer object certificates)
-   -user ldap: (AD user object certificates)
CertId: Certificate or CRL match token.  This can be a serial number, an SHA-1 certificate, CRL, CTL or public key hash, a numeric cert index (0, 1, and so on), a numeric CRL index (.0, .1, and so on), a numeric CTL index (..0, ..1, and so on), a public key, signature or extension ObjectId, a certificate subject Common Name, an e-mail address, UPN or DNS name, a key container name or CSP name, a template name or ObjectId, an EKU or Application Policies ObjectId, or a CRL issuer Common Name. Many of these may result in multiple matches.
OutputFile: file to save matching cert
Use -user to access a user store instead of a machine store.
Use -enterprise to access a machine enterprise store.
Use -service to access a machine service store.
Use -grouppolicy to access a machine group policy store.
Examples:
-   -enterprise NTAuth
-   -enterprise Root 37
-   -user My 26e0aaaf000000000004
-   CA .11
[-f] [-enterprise] [-user] [-GroupPolicy] [-silent] [-split] [-dc DCName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_addstore"></a>-addstore
certutil [Options] -addstore CertificateStorename InFile
add certificate to store
CertificateStorename: Certificate store name.  See [-store](certutil.md#BKMK_Store).
InFile: Certificate or CRL file to add to store.
[-f] [-enterprise] [-user] [-GroupPolicy] [-dc DCName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_delstore"></a>-delstore
certutil [Options] -delstore CertificateStorename CertId
delete certificate from store
CertificateStorename: Certificate store name.  See [-store](certutil.md#BKMK_Store).
CertId: Certificate or CRL match token.  See [-store](certutil.md#BKMK_Store).
[-enterprise] [-user] [-GroupPolicy] [-dc DCName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_verifystore"></a>-verifystore
certutil [Options] -verifystore CertificateStorename [CertId]
verify certificate in store
CertificateStorename: Certificate store name.  See [-store](certutil.md#BKMK_Store).
CertId: Certificate or CRL match token.  See [-store](certutil.md#BKMK_Store).
[-enterprise] [-user] [-GroupPolicy] [-silent] [-split] [-dc DCName] [-t timeout]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_repairstore"></a>-repairstore
certutil [Options] -repairstore CertificateStorename CertIdlist [PropertyInfFile | SDDLSecurityDescriptor]
repair key association or update certificate properties or key security descriptor
CertificateStorename: Certificate store name.  See [-store](certutil.md#BKMK_Store).
CertIdlist: comma separated list of Certificate or CRL match tokens. See [-store](certutil.md#BKMK_Store) CertId description.
PropertyInfFile - INF file containing external properties:
```
[Properties]
     19 = Empty ; add archived property, OR:
     19 =       ; remove archived property
     11 = "{text}Friendly Name" ; add friendly name property
     127 = "{hex}" ; add custom hexadecimal property
         _continue_ = "00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f"
         _continue_ = "10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f"
     2 = "{text}" ; add Key Provider Information property
       _continue_ = "Container=Container Name&"
       _continue_ = "Provider=Microsoft Strong Cryptographic Provider&"
       _continue_ = "Providertype=1&"
       _continue_ = "Flags=0&"
       _continue_ = "KeySpec=2"
     9 = "{text}" ; add Enhanced Key Usage property
       _continue_ = "1.3.6.1.5.5.7.3.2,"
       _continue_ = "1.3.6.1.5.5.7.3.1,"
```
[-f] [-enterprise] [-user] [-GroupPolicy] [-silent] [-split] [-csp Provider]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_viewstore"></a>-viewstore
certutil [Options] -viewdelstore [CertificateStorename [CertId [OutputFile]]]
Dump certificate store
CertificateStorename: Certificate store name.  Examples:
-   "My", "CA" (default), "Root",
-   "ldap:///CN=Certification Authorities,CN=Public Key Services,CN=Services,CN=Configuration,DC=cpandl,DC=com?cACertificate?one?objectClass=certificationAuthority" (View Root Certificates)
-   "ldap:///CN=CAName,CN=Certification Authorities,CN=Public Key Services,CN=Services,CN=Configuration,DC=cpandl,DC=com?cACertificate?base?objectClass=certificationAuthority" (Modify Root Certificates)
-   "ldap:///CN=CAName,CN=MachineName,CN=cdP,CN=Public Key Services,CN=Services,CN=Configuration,DC=cpandl,DC=com?certificateRevocationlist?base?objectClass=cRLDistributionPoint" (View CRLs)
-   "ldap:///CN=NTAuthCertificates,CN=Public Key Services,CN=Services,CN=Configuration,DC=cpandl,DC=com?cACertificate?base?objectClass=certificationAuthority" (Enterprise CA Certificates)
-   ldap: (AD machine object certificates)
-   -user ldap: (AD user object certificates)
CertId: Certificate or CRL match token. This can be a serial number, an SHA-1 certificate, CRL, CTL or public key hash, a numeric cert index (0, 1, and so on), a numeric CRL index (.0, .1, and so on), a numeric CTL index (..0, ..1, and so on), a public key, signature or extension ObjectId, a certificate subject Common Name, an e-mail address, UPN or DNS name, a key container name or CSP name, a template name or ObjectId, an EKU or Application Policies ObjectId, or a CRL issuer Common Name. Many of these may result in multiple matches.
OutputFile: file to save matching cert
Use -user to access a user store instead of a machine store.
Use -enterprise to access a machine enterprise store.
Use -service to access a machine service store.
Use -grouppolicy to access a machine group policy store.
Examples:
1.  -enterprise NTAuth
2.  -enterprise Root 37
3.  -user My 26e0aaaf000000000004
4.  CA .11
[-f] [-enterprise] [-user] [-GroupPolicy] [-dc DCName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_viewdelstore"></a>-viewdelstore
certutil [Options] -viewdelstore [CertificateStorename [CertId [OutputFile]]]
delete certificate from store
CertificateStorename: Certificate store name.  Examples:
-   "My", "CA" (default), "Root",
-   "ldap:///CN=Certification Authorities,CN=Public Key Services,CN=Services,CN=Configuration,DC=cpandl,DC=com?cACertificate?one?objectClass=certificationAuthority" (View Root Certificates)
-   "ldap:///CN=CAName,CN=Certification Authorities,CN=Public Key Services,CN=Services,CN=Configuration,DC=cpandl,DC=com?cACertificate?base?objectClass=certificationAuthority" (Modify Root Certificates)
-   "ldap:///CN=CAName,CN=MachineName,CN=cdP,CN=Public Key Services,CN=Services,CN=Configuration,DC=cpandl,DC=com?certificateRevocationlist?base?objectClass=cRLDistributionPoint" (View CRLs)
-   "ldap:///CN=NTAuthCertificates,CN=Public Key Services,CN=Services,CN=Configuration,DC=cpandl,DC=com?cACertificate?base?objectClass=certificationAuthority" (Enterprise CA Certificates)
-   ldap: (AD machine object certificates)
-   -user ldap: (AD user object certificates)
CertId: Certificate or CRL match token. This can be a serial number, an SHA-1 certificate, CRL, CTL or public key hash, a numeric cert index (0, 1, and so on), a numeric CRL index (.0, .1, and so on), a numeric CTL index (..0, ..1, and so on), a public key, signature or extension ObjectId, a certificate subject Common Name, an e-mail address, UPN or DNS name, a key container name or CSP name, a template name or ObjectId, an EKU or Application Policies ObjectId, or a CRL issuer Common Name. Many of these may result in multiple matches.
OutputFile: file to save matching cert
Use -user to access a user store instead of a machine store.
Use -enterprise to access a machine enterprise store.
Use -service to access a machine service store.
Use -grouppolicy to access a machine group policy store.
Examples:
1.  -enterprise NTAuth
2.  -enterprise Root 37
3.  -user My 26e0aaaf000000000004
4.  CA .11
[-f] [-enterprise] [-user] [-GroupPolicy] [-dc DCName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_dsPublish"></a>-dsPublish
certutil [Options] -dsPublish CertFile [NTAuthCA | RootCA | SubCA | CrossCA | KRA | User | Machine]
certutil [Options] -dsPublish CRLFile [DScdPContainer [DScdPCN]]
Publish certificate or CRL to active directory
CertFile: certificate file to publish
NTAuthCA: Publish cert to DS Enterprise store
RootCA: Publish cert to DS Trusted Root store
SubCA: Publish CA cert to DS CA object
CrossCA: Publish cross cert to DS CA object
KRA: Publish cert to DS Key recovery Agent object
User: Publish cert to User DS object
Machine: Publish cert to Machine DS object
CRLFile: CRL file to publish
DScdPContainer: DS cdP container CN, usually the CA machine name
DScdPCN: DS cdP object CN, usually based on the sanitized CA short name and key index
Use -f to create DS object.
[-f] [-user] [-dc DCName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_ADTemplate"></a>-ADTemplate
certutil [Options] -ADTemplate [Template]
Display AD templates
[-f] [-user] [-ut] [-mt] [-dc DCName]
## <a name="BKMK_template"></a>-Template
certutil [Options] -Template [Template]
Display Enrollment Policy templates
[-f] [-user] [-silent] [-PolicyServer URLOrId] [-Anonymous] [-Kerberos] [-ClientCertificate ClientCertId] [-UserName UserName] [-p Password]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_TemplateCAs"></a>-TemplateCAs
certutil [Options] -TemplateCAs Template
Display CAs for template
[-f] [-user] [-dc DCName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_Catemplates"></a>-Catemplates
certutil [Options] -Catemplates [Template]
Display templates for CA
[-f] [-user] [-ut] [-mt] [-config Machine\CAName] [-dc DCName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_SetCASites"></a>-SetCASites
certutil [Options] -SetCASites [set] [SiteName]
certutil [Options] -SetCASites verify [SiteName]
certutil [Options] -SetCASites delete
Set, verify or delete CA site names
-   Use the -config option to target a single CA (Default is all CAs)
-   *SiteName* is allowed only when targeting a single CA
-   Use -f to override validation errors for the specified *SiteName*
-   Use -f to delete all CA site names
[-f] [-config Machine\CAName] [-dc DCName]
> [!NOTE]
> for more information on configuring CAs for active directory Domain Services (AD DS) site awareness, see [AD DS Site Awareness for AD CS and PKI clients](http://social.technet.microsoft.com/wiki/contents/articles/14106.ad-ds-site-awareness-for-ad-cs-and-pki-clients.aspx).
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_enrollmentServerURL"></a>-enrollmentServerURL
certutil [Options] -enrollmentServerURL [URL Authenticationtype [Priority] [Modifiers]]
certutil [Options] -enrollmentServerURL URL delete
Display, add or delete enrollment server URLs associated with a CA
Authenticationtype: Specify one of the following client authentication methods while adding a URL
1.  Kerberos: Use Kerberos SSL credentials
2.  UserName: Use named account for SSL credentials
3.  ClientCertificate: Use X.509 Certificate SSL credentials
4.  Anonymous: Use anonymous SSL credentials
delete: deletes the specified URL associated with the CA
Priority: defaults to '1' if not specified when adding a URL
Modifiers - Comma separated list of one or more of the following:
1.  AllowrenewalsOnly: Only renewal requests can be submitted to this CA via this URL
2.  AllowKeyBasedrenewal: Allows use of a certificate that has no associated account in the AD. This applies only with ClientCertificate and AllowrenewalsOnly mode
[-config Machine\CAName] [-dc DCName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_ADCA"></a>-ADCA
certutil [Options] -ADCA [CAName]
Display AD CAs
[-f] [-split] [-dc DCName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_CA"></a>-CA
certutil [Options] -CA [CAName | TemplateName]
Display Enrollment Policy CAs
[-f] [-user] [-silent] [-split] [-PolicyServer URLOrId] [-Anonymous] [-Kerberos] [-ClientCertificate ClientCertId] [-UserName UserName] [-p Password]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_Policy"></a>-Policy
Display Enrollment Policy
[-f] [-user] [-silent] [-split] [-PolicyServer URLOrId] [-Anonymous] [-Kerberos] [-ClientCertificate ClientCertId] [-UserName UserName] [-p Password]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_PolicyCache"></a>-PolicyCache
certutil [Options] -PolicyCache [delete]
Display or delete Enrollment Policy Cache entries
delete: delete Policy Server cache entries
-f: use -f to delete all cache entries
[-f] [-user] [-PolicyServer URLOrId]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_Credstore"></a>-CredStore
certutil [Options] -CredStore [URL]
certutil [Options] -CredStore URL add
certutil [Options] -CredStore URL delete
Display, add or delete Credential Store entries
URL: target URL.  Use * to match all entries. Use https://machine\* to match a URL prefix.
add: add a Credential Store entry. SSL credentials must also be specified.
delete: delete Credential Store entries
-f: use -f to overwrite an entry or to delete multiple entries.
[-f] [-user] [-silent] [-Anonymous] [-Kerberos] [-ClientCertificate ClientCertId] [-UserName UserName] [-p Password]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_InstallDefaultTemplates"></a>-InstallDefaultTemplates
certutil [Options] -InstallDefaultTemplates
Install default certificate templates
[-dc DCName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_URLCache"></a>-URLCache
certutil [Options] -URLCache [URL | CRL | * [delete]]
Display or delete URL cache entries
URL: cached URL
CRL: operate on all cached CRL URLs only
*: operate on all cached URLs
delete: delete relevant URLs from the current user's local cache
Use -f to force fetching a specific URL and updating the cache.
[-f] [-split]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_pulse"></a>-pulse
certutil [Options] -pulse
Pulse autoenrollment events
[-user]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_MachineInfo"></a>-MachineInfo
certutil [Options] -MachineInfo DomainName\MachineName$
Display active directory computer object information
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_DCInfo"></a>-DCInfo
certutil [Options] -DCInfo [Domain] [verify | deleteBad | deleteAll]
Display domain controller information
Default is to display DC certs without verification
[-f] [-user] [-urlfetch] [-dc DCName] [-t timeout]
> [!TIP]
> The ability to specify an active directory Domain Services (AD DS) domain **[Domain]** and to specify a domain controller (**-dc**) was added in  Windows Server 2012 . To successfully run the command, you must use an account that is a member of **Domain Admins** or **Enterprise Admins**. The behavior modifications of this command are as follows:
> 
> 1.  if a domain is not specified and a specific domain controller is not specified, this option returns a list of domain controllers to process from the default domain controller.
> 2.  if a domain is not specified, but a domain controller is specified, a report of the certificates on the specified domain controller is generated.
> 3.  if a domain is specified, but a domain controller is not specified, a list of domain controllers is generated along with reports on the certificates for each domain controller in the list.
> 4.  if the domain and domain controller are specified, a list of domain controllers is generated from the targeted domain controller. A report of the certificates for each domain controller in the list is also generated.
for example, assume there is a domain named CPANDL with a domain controller named CPANDL-DC1. You could run the following command to a retrieve a list of domain controllers and their certificates that from CPANDL-DC1: certutil -dc cpandl-dc1 -dcinfo cpandl
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_EntInfo"></a>-EntInfo
certutil [Options] -EntInfo DomainName\MachineName$
[-f] [-user]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_TCAInfo"></a>-TCAInfo
certutil [Options] -TCAInfo [DomainDN | -]
Display CA information
[-f] [-enterprise] [-user] [-urlfetch] [-dc DCName] [-t timeout]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_SCInfo"></a>-SCInfo
certutil [Options] -SCInfo [ReaderName [CRYPT_deleteKEYSET]]
Display smart card information
CRYPT_deleteKEYSET: delete all keys on the smart card
[-silent] [-split] [-urlfetch] [-t timeout]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_SCRoots"></a>-SCRoots
certutil [Options] -SCRoots update [+][InputRootFile] [ReaderName]
certutil [Options] -SCRoots save @OutputRootFile [ReaderName]
certutil [Options] -SCRoots view [InputRootFile | ReaderName]
certutil [Options] -SCRoots delete [ReaderName]
Manage smart card root certificates
[-f] [-split] [-p Password]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_verifykeys"></a>-verifykeys
certutil [Options] -verifykeys [KeyContainerName CACertFile]
verify public/private key set
KeyContainerName: key container name of the key to verify. Defaults to machine keys.  Use -user for user keys.
CACertFile: signing or encryption certificate file
if no arguments are specified, each signing CA cert is verified against its private key.
This operation can only be performed against a local CA or local keys.
[-f] [-user] [-silent] [-config Machine\CAName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_verify"></a>-verify
certutil [Options] -verify CertFile [ApplicationPolicylist | - [IssuancePolicylist]]
certutil [Options] -verify CertFile [CACertFile [CrossedCACertFile]]
certutil [Options] -verify CRLFile CACertFile [IssuedCertFile]
certutil [Options] -verify CRLFile CACertFile [deltaCRLFile]
verify certificate, CRL or chain
CertFile: Certificate to verify
ApplicationPolicylist: optional comma separated list of required Application Policy ObjectIds
IssuancePolicylist: optional comma separated list of required Issuance Policy ObjectIds
CACertFile: optional issuing CA certificate to verify against
CrossedCACertFile: optional certificate cross-certified by CertFile
CRLFile: CRL to verify
IssuedCertFile: optional issued certificate covered by CRLFile
deltaCRLFile: optional delta CRL
if ApplicationPolicylist is specified, chain building is restricted to chains valid for the specified Application Policies.
if IssuancePolicylist is specified, chain building is restricted to chains valid for the specified Issuance Policies.
if CACertFile is specified, fields in CACertFile are verified against CertFile or CRLFile.
if CACertFile is not specified, CertFile is used to build and verify a full chain.
if CACertFile and CrossedCACertFile are both specified, fields in CACertFile and CrossedCACertFile are verified against CertFile.
if IssuedCertFile is specified, fields in IssuedCertFile are verified against CRLFile.
if deltaCRLFile is specified, fields in deltaCRLFile are verified against CRLFile.
[-f] [-enterprise] [-user] [-silent] [-split] [-urlfetch] [-t timeout]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_verifyCTL"></a>-verifyCTL
certutil [Options] -verifyCTL CTLObject [Certdir] [CertFile]
verify AuthRoot or Disallowed Certificates CTL
CTLObject: Identifies the CTL to verify:
-   AuthRootWU: read AuthRoot CAB and matching certificates from the URL cache. Use -f to download from Windows Update instead.
-   DisallowedWU: read Disallowed Certificates CAB and disallowed certificate store file from the URL cache.  Use -f to download from Windows Update instead.
-   AuthRoot: read registry cached AuthRoot CTL.  Use with -f and a             CertFile that is not already trusted to force updating the registry cached AuthRoot and Disallowed Certificate CTLs.
-   Disallowed: read registry cached Disallowed Certificates CTL. -f has the same behavior as with AuthRoot.
-   CTLFileName: file or http: path to CTL or CAB
Certdir: folder containing certificates matching CTL entries. An http: folder path must end with a path separator. If a folder is not specified with AuthRoot or Disallowed, multiple locations will be searched for matching certificates: local certificate stores, crypt32.dll resources and the local URL cache. Use -f to download from Windows Update when necessary. Otherwise defaults to the same folder or web site as the CTLObject.
CertFile: file containing certificate(s) to verify. Certificates will be matched against CTL entries, and match results displayed. Suppresses most of the default output.
[-f] [-user] [-split]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_sign"></a>-sign
certutil [Options] -sign InFilelist|SerialNumber|CRL OutFilelist [startdate+dd:hh] [+SerialNumberlist | -SerialNumberlist | -ObjectIdlist | @ExtensionFile]
certutil [Options] -sign InFilelist|SerialNumber|CRL OutFilelist [#HashAlgorithm] [+AlternateSignatureAlgorithm | -AlternateSignatureAlgorithm]
Re-sign CRL or certificate
InFilelist: comma separated list of Certificate or CRL files to modify and re-sign
SerialNumber: Serial number of certificate to create. Validity period and other options must not be present.
CRL: create an empty CRL. Validity period and other options must not be present.
OutFilelist: comma separated list of modified Certificate or CRL output files. The number of files must match InFilelist.
startdate+dd:hh: new validity period: optional date plus; optional days and hours validity period; if both are specified, use a plus sign (+) separator. Use "now[+dd:hh]" to start at the current time. Use "never" to have no expiration date (for CRLs only).
SerialNumberlist: comma separated serial number list to add or remove
ObjectIdlist: comma separated extension ObjectId list to remove
@ExtensionFile: INF file containing extensions to update or remove:
```
[Extensions]
     2.5.29.31 = ; remove CRL Distribution Points extension
     2.5.29.15 = "{hex}" ; Update Key Usage extension
     _continue_="03 02 01 86"
```
HashAlgorithm: Name of the hash algorithm preceded by a # sign
AlternateSignatureAlgorithm: alternate Signature algorithm specifier
A minus sign causes serial numbers and extensions to be removed. A plus sign causes serial numbers to be added to a CRL. When removing items from a CRL, the list may contain both serial numbers and ObjectIds. A minus sign before AlternateSignatureAlgorithm causes the legacy signature format to be used. A plus sign before AlternateSignatureAlgorithm causes the alternature signature format to be used. If AlternateSignatureAlgorithm is not specified then the signature format in the certificate or CRL is used.
[-nullsign] [-f] [-silent] [-Cert CertId]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_vroot"></a>-vroot
certutil [Options] -vroot [delete]
create/delete web virtual roots and file shares
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_vocsproot"></a>-vocsproot
certutil [Options] -vocsproot [delete]
create/delete web virtual roots for OCSP web proxy
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_addEnrollmentServer"></a>-addEnrollmentServer
certutil [Options] -addEnrollmentServer Kerberos | UserName | ClientCertificate [AllowrenewalsOnly] [AllowKeyBasedrenewal]
add an Enrollment Server application
add an Enrollment Server application and application pool if necessary, for the specified CA. This command does not install binaries or packages. One of the following authentication methods with which the client connects to a Certificate Enrollment Server.
-   Kerberos: Use Kerberos SSL credentials
-   UserName: Use named account for SSL credentials
-   ClientCertificate: Use X.509 Certificate SSL credentials
-   AllowrenewalsOnly: Only renewal requests can be submitted to this CA via this URL
-   AllowKeyBasedrenewal - Allows use of a certificate that has no associated account in the AD. This applies only with ClientCertificate and AllowrenewalsOnly mode.
[-config Machine\CAName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_deleteEnrollmentServer"></a>-deleteEnrollmentServer
certutil [Options] -deleteEnrollmentServer Kerberos | UserName | ClientCertificate
delete an Enrollment Server application
delete an Enrollment Server application and application pool if necessary, for the specified CA. This command does not remove binaries or packages. One of the following authentication methods with which the client connects to a Certificate Enrollment Server.
1.  Kerberos: Use Kerberos SSL credentials
2.  UserName: Use named account for SSL credentials
3.  ClientCertificate: Use X.509 Certificate SSL credentials
[-config Machine\CAName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_addPolicyServer"></a>-addPolicyServer
certutil [Options] -addPolicyServer Kerberos | UserName | ClientCertificate [KeyBasedrenewal]
add a Policy Server application
add a Policy Server application and application pool if necessary. This command does not install binaries or packages. One of the following authentication methods with which the client connects to a Certificate Policy Server:
-   Kerberos: Use Kerberos SSL credentials
-   UserName: Use named account for SSL credentials
-   ClientCertificate: Use X.509 Certificate SSL credentials
-   KeyBasedrenewal: Only policies that contain KeyBasedrenewal templates are returned to the client. This flag applies only for UserName and ClientCertificate authentication.
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_deletePolicyServer"></a>-deletePolicyServer
certutil [Options] -deletePolicyServer Kerberos | UserName | ClientCertificate [KeyBasedrenewal]
delete a Policy Server application
delete a Policy Server application and application pool if necessary. This command does not remove binaries or packages. One of the following authentication methods with which the client connects to a Certificate Policy Server:
1.  Kerberos: Use Kerberos SSL credentials
2.  UserName: Use named account for SSL credentials
3.  ClientCertificate: Use X.509 Certificate SSL credentials
4.  KeyBasedrenewal: KeyBasedrenewal policy server
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_oid"></a>-oid
certutil [Options] -oid ObjectId [DisplayName | delete [LanguageId [type]]]
certutil [Options] -oid GroupId
certutil [Options] -oid AlgId | AlgorithmName [GroupId]
Display ObjectId or set display name
-   ObjectId - ObjectId to display or to add display name
-   GroupId - decimal GroupId number for ObjectIds to enumerate
-   AlgId - hexadecimal AlgId for ObjectId to look up
-   AlgorithmName - Algorithm Name for ObjectId to look up
-   DisplayName - Display Name to store in DS
-   delete - delete display name
-   LanguageId - Language Id (defaults to current: 1033)
-   type - DS object type to create: 1 for Template (default), 2 for Issuance Policy, 3 for Application Policy
-   Use -f to create DS object.
[-f]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_error"></a>-error
certutil [Options] -error ErrorCode
Display error code message text
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_getreg"></a>-getreg
certutil [Options] -getreg [{ca|restore|policy|exit|template|enroll|chain|PolicyServers}\\[ProgId\\]][registryValueName]
Display registry value
ca: Use CA's registry key
restore: Use CA's restore registry key
policy: Use policy module's registry key
exit: Use first exit module's registry key
template: Use template registry key (use -user for user templates)
enroll: Use enrollment registry key (use -user for user context)
chain: Use chain configuration registry key
PolicyServers: Use Policy Servers registry key
ProgId: Use policy or exit module's ProgId (registry subkey name)
registryValueName: registry value name (use "Name*" to prefix match)
Value: new numeric, string or date registry value or filename. If a numeric value starts with "+" or "-", the bits specified in the new value are set or cleared in the existing registry value.
if a string value starts with "+" or "-", and the existing value is a reg_MULTI_SZ value, the string is added to or removed from the existing registry value. To force creation of a reg_MULTI_SZ value, add a "\n" to the end of the string value.
if the value starts with "@", the rest of the value is the name of the file containing the hexadecimal text representation of a binary value. If it does not refer to a valid file, it is instead parsed as [date][+|-][dd:hh] - an optional date plus or minus optional days and hours. If both are specified, use a plus sign (+) or minus sign (-) separator. Use "now+dd:hh" for a date relative to the current time.
Use "chain\ChainCacheResyncFiletime @now" to effectively flush cached CRLs.
[-f] [-user] [-GroupPolicy] [-config Machine\CAName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_setreg"></a>-setreg
certutil [Options] -setreg [{ca|restore|policy|exit|template|enroll|chain|PolicyServers}\\[ProgId\\]]registryValueName Value
Set registry value
ca: Use CA's registry key
restore: Use CA's restore registry key
policy: Use policy module's registry key
exit: Use first exit module's registry key
template: Use template registry key (use -user for user templates)
enroll: Use enrollment registry key (use -user for user context)
chain: Use chain configuration registry key
PolicyServers: Use Policy Servers registry key
ProgId: Use policy or exit module's ProgId (registry subkey name)
registryValueName: registry value name (use "Name*" to prefix match)
Value: new numeric, string or date registry value or filename. If a numeric value starts with "+" or "-", the bits specified in the new value are set or cleared in the existing registry value.
if a string value starts with "+" or "-", and the existing value is a reg_MULTI_SZ value, the string is added to or removed from the existing registry value. To force creation of a reg_MULTI_SZ value, add a "\n" to the end of the string value.
if the value starts with "@", the rest of the value is the name of the file containing the hexadecimal text representation of a binary value. If it does not refer to a valid file, it is instead parsed as [date][+|-][dd:hh] - an optional date plus or minus optional days and hours. If both are specified, use a plus sign (+) or minus sign (-) separator. Use "now+dd:hh" for a date relative to the current time.
Use "chain\ChainCacheResyncFiletime @now" to effectively flush cached CRLs.
[-f] [-user] [-GroupPolicy] [-config Machine\CAName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_delreg"></a>-delreg
certutil [Options] -delreg [{ca|restore|policy|exit|template|enroll|chain|PolicyServers}\\[ProgId\\]][registryValueName]
delete registry value
ca: Use CA's registry key
restore: Use CA's restore registry key
policy: Use policy module's registry key
exit: Use first exit module's registry key
template: Use template registry key (use -user for user templates)
enroll: Use enrollment registry key (use -user for user context)
chain: Use chain configuration registry key
PolicyServers: Use Policy Servers registry key
ProgId: Use policy or exit module's ProgId (registry subkey name)
registryValueName: registry value name (use "Name*" to prefix match)
Value: new numeric, string or date registry value or filename. If a numeric value starts with "+" or "-", the bits specified in the new value are set or cleared in the existing registry value.
if a string value starts with "+" or "-", and the existing value is a reg_MULTI_SZ value, the string is added to or removed from the existing registry value. To force creation of a reg_MULTI_SZ value, add a "\n" to the end of the string value.
if the value starts with "@", the rest of the value is the name of the file containing the hexadecimal text representation of a binary value. If it does not refer to a valid file, it is instead parsed as [date][+|-][dd:hh] - an optional date plus or minus optional days and hours. If both are specified, use a plus sign (+) or minus sign (-) separator. Use "now+dd:hh" for a date relative to the current time.
Use "chain\ChainCacheResyncFiletime @now" to effectively flush cached CRLs.
[-f] [-user] [-GroupPolicy] [-config Machine\CAName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_importKMS"></a>-importKMS
certutil [Options] -importKMS UserKeyAndCertFile [CertId]
import user keys and certificates into server database for key archival
UserKeyAndCertFile - Data file containing user private keys and certificates to be archived.  This can be any of the following:
-   Exchange Key Management Server (KMS) export file
-   PFX file
CertId: KMS export file decryption certificate match token.  See [-store](certutil.md#BKMK_Store).
Use -f to import certificates not issued by the CA.
[-f] [-silent] [-split] [-config Machine\CAName] [-p Password] [-symkeyalg SymmetricKeyAlgorithm[,KeyLength]]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_importCert"></a>-importCert
certutil [Options] -importCert Certfile [ExistingRow]
import a certificate file into the database
Use ExistingRow to import the certificate in place of a pending request for the same key.
Use -f to import certificates not issued by the CA.
The CA may also need to be configured to support foreign certificate import: certutil -setreg ca\KRAFlags +KRAF_ENABLEforEIGN
[-f] [-config Machine\CAName]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_GetKey"></a>-GetKey
certutil [Options] -GetKey SearchToken [recoveryBlobOutFile]
certutil [Options] -GetKey SearchToken script OutputScriptFile
certutil [Options] -GetKey SearchToken retrieve | recover OutputFileBaseName
Retrieve archived private key recovery blob, generate a recovery script, or recover archived keys
script: generate a script to retrieve and recover keys (default behavior if multiple matching recovery candidates are found, or if the output file is not specified).
retrieve: retrieve one or more Key recovery Blobs (default behavior if exactly one matching recovery candidate is found, and if the output file is specified)
recover: retrieve and recover private keys in one step (requires Key recovery Agent certificates and private keys)
SearchToken: Used to select the keys and certificates to be recovered.
Can be any of the following:
1.  Certificate Common Name
2.  Certificate Serial Number
3.  Certificate SHA-1 hash (thumbprint)
4.  Certificate KeyId SHA-1 hash (Subject Key Identifier)
5.  Requester Name (domain\user)
6.  UPN (user@domain)
recoveryBlobOutFile: output file containing a certificate chain and an associated private key, still encrypted to one or more Key recovery Agent certificates.
OutputScriptFile: output file containing a batch script to retrieve and recover private keys.
OutputFileBaseName: output file base name. For retrieve, any extension is truncated and a certificate-specific string and the .rec extension are appended for each key recovery blob.  Each file contains a certificate chain and an associated private key, still encrypted to one or more Key recovery Agent certificates. For recover, any extension is truncated and the .p12 extension is appended.  Contains the recovered certificate chains and associated private keys, stored as a PFX file.
[-f] [-UnicodeText] [-silent] [-config Machine\CAName] [-p Password] [-ProtectTo SAMNameAndSIDlist] [-csp Provider]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_recoverKey"></a>-recoverKey
certutil [Options] -recoverKey recoveryBlobInFile [PFXOutFile [RecipientIndex]]
recover archived private key
[-f] [-user] [-silent] [-split] [-p Password] [-ProtectTo SAMNameAndSIDlist] [-csp Provider] [-t timeout]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_MergePFX"></a>-MergePFX
certutil [Options] -MergePFX PFXInFilelist PFXOutFile [extendedProperties]
PFXInFilelist: Comma separated PFX input file list
PFXOutFile: PFX output file
extendedProperties: Include extended properties
The password specified on the command line is a comma separated password list.  if more than one password is specified, the last password is used for the output file.  if only one password is provided or if the last password is "*", the user will be prompted for the output file password.
[-f] [-user] [-split] [-p Password] [-ProtectTo SAMNameAndSIDlist] [-csp Provider]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_convertEPF"></a>-convertEPF
certutil [Options] -convertEPF PFXInFilelist EPFOutFile [cast | cast-] [V3CACertId][,Salt]
convert PFX files to EPF file
PFXInFilelist: Comma separated PFX input file list
EPF: EPF output file
cast: Use CAST 64 encryption
cast-: Use CAST 64 encryption (export)
V3CACertId: V3 CA Certificate match token.  See [-store](certutil.md#BKMK_Store) CertId description.
Salt: EPF output file salt string
The password specified on the command line is a comma separated password list. If more than one password is specified, the last password is used for the output file.  if only one password is provided or if the last password is "*", the user will be prompted for the output file password.
[-f] [-silent] [-split] [-dc DCName] [-p Password] [-csp Provider]
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_Options"></a>Options
This section defines the options that you can specify with the command.
|Options|Description|
|------|--------|
|-nullsign|Use hash of data as signature|
|-f|force overwrite|
|-enterprise|Use local machine Enterprise registry certificate store|
|-user|Use HKEY_CURrenT_USER keys or certificate store|
|-GroupPolicy|Use Group Policy certificate store|
|-ut|Display user templates|
|-mt|Display machine templates|
|-Unicode|Write redirected output in Unicode|
|-UnicodeText|Write output file in Unicode|
|-gmt|Display times as GMT|
|-seconds|Display times with seconds and milliseconds|
|-silent|Use silent flag to acquire crypt context|
|-split|Split embedded ASN.1 elements, and save to files|
|-v|verbose operation|
|-privatekey|Display password and private key data|
|-pin PIN|Smart Card PIN|
|-urlfetch|Retrieve and verify AIA Certs and cdP CRLs|
|-config Machine\CAName|CA and computer name string|
|-PolicyServer URLOrId|Policy Server URL or Id. For selection U/I, use -PolicyServer. For all Policy Servers, use -PolicyServer *|
|-Anonymous|Use anonymous SSL credentials|
|-Kerberos|Use Kerberos SSL credentials|
|-ClientCertificate ClientCertId|Use X.509 Certificate SSL credentials. For selection U/I, use -clientCertificate.|
|-UserName UserName|Use named account for SSL credentials. For selection U/I, use -UserName.|
|-Cert CertId|Signing certificate|
|-dc DCName|Target a specific Domain Controller|
|-restrict Restrictionlist|Comma separated Restriction list. Each restriction consists of a column name, a relational operator and a constant integer, string or date. One column name may be preceded by a plus or minus sign to indicate the sort order. Examples:<br /><br />"RequestId = 47"<br /><br />"+RequesterName >= a, RequesterName < b"<br /><br />"-RequesterName > DOMAIN, Disposition = 21"|
|-out Columnlist|Comma separated Column list|
|-p Password|Password|
|-ProtectTo SAMNameAndSIDlist|Comma separated SAM Name/SID list|
|-csp Provider|Provider|
|-t timeout|URL fetch timeout in milliseconds|
|-symkeyalg SymmetricKeyAlgorithm[,KeyLength]|Name of Symmetric Key Algorithm with optional key length, example: AES,128 or 3DES|
Return to [Menu](certutil.md#BKMK_menu)
## <a name="BKMK_addedExamples"></a>additional certutil examples
for some examples of how to use this command, see
1.  [certutil Examples for Managing active directory Certificate Services (AD CS) from the Command Line](http://social.technet.microsoft.com/wiki/contents/articles/3063.certutil-examples-for-managing-active-directory-certificate-services-ad-cs-from-the-command-line.aspx)
2.  [certutil tasks for managing certificates](http://technet.microsoft.com/library/cc772898.aspx)
3.  [Binary Request Export Using the certutil.exe Command-Line Tool Walkthrough](http://social.technet.microsoft.com/wiki/contents/articles/7573.active-directory-certificate-services-pki-key-archival-and-management.aspx)
4.  [Root CA certificate renewal](http://social.technet.microsoft.com/wiki/contents/articles/2016.root-ca-certificate-renewal.aspx)
5.  [certutil](http://msdn.microsoft.com/subscriptions/cc773087.aspx)
Return to [Menu](certutil.md#BKMK_menu)
