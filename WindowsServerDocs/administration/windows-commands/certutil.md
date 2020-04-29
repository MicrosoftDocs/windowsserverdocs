---
title: certutil
description: Reference topic for the certutil command, which is a command-line program that dumps and displays certification authority (CA) configuration information, configures Certificate Services, backup and restore CA components, and verifies certificates, key pairs, and certificate chains.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: c264ccf0-ba1e-412b-9dd3-d77dd9345ad9
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# certutil

Certutil.exe is a command-line program, installed as part of Certificate Services. You can use certutil.exe to dump and display certification authority (CA) configuration information, configure Certificate Services, backup and restore CA components, and verify certificates, key pairs, and certificate chains.

If certutil is run on a certification authority without additional parameters, it displays the current certification authority configuration. If certutil is run on a non-certification authority, the command defaults to running the `certutil [-dump]` command.

> [!IMPORTANT]
> Earlier versions of certutil may not provide all of the options that are described in this document. You can see all the options that a specific version of certutil provides by running `certutil -?` or `certutil <parameter> -?`.

### Parameters


| -pingadmin | Attempt to contact the Active Directory Certificate Services Admin interface. |


| -viewdelstore | Deletes a certificate from the store. |
| -dspublish | Publishes a certificate or certificate revocation list (CRL) to Active Directory. |
| -adtemplate | Displays Active Directory templates. |
| -template | Displays certificate templates. |
| -templatecas | Displays the certification authorities (CAs) for a certificate template. |
| -catemplates | Displays templates for CA. |
| -setcasites | Manages site names for CAs. |
| -enrollmentserverURL | Displays, adds, or deletes enrollment server URLs associated with a CA. |
| -adca | Displays Active Directory CAs. |
| -ca | Displays Enrollment Policy CAs. |
| -policy | Displays Enrollment Policy. |
| -policycache | Displays or delete Enrollment Policy Cache entries. |
| -credstore | Displays, adds, or deletes Credential Store entries. |
| -installdefaulttemplates | Install default certificate templates. |
| -URLcache | Display or delete URL cache entries. |
| -pulse | Pulse auto enrollment events. |
| -machineinfo | Display information about the Active Directory machine object. |
| -dcinfo | Display information about the domain controller. |
| -entinfo | Display information about an enterprise CA. |
| -tcainfo | Display information about the CA. |
| -scinfo | Display information about the smart card. |
| -scroots | Manage smart card root certificates. |
| -verifykeys | Verify a public or private key set. |
| -verify | Verify a certificate, certificate revocation list (CRL), or certificate chain. |
| -verifyCTL | Verify AuthRoot or Disallowed Certificates CTL. |
| -sign | Re-sign a certificate revocation list (CRL) or certificate. |
| -vroot | Create or delete web virtual roots and file shares. |
| -vocsproot | Create or delete web virtual roots for an OCSP web proxy. |
| -addEnrollmentServer | Add an Enrollment Server application. |
| -deleteEnrollmentServer | Delete an Enrollment Server application. |
| -addPolicyServer | Add a Policy Server application. |
| -deletePolicyServer | Delete a Policy Server application. |
| -oid | Display the object identifier or set a display name. |
| -error | Display the message text associated with an error code. |
| -getreg | Display a registry value. |
| -setreg | Set a registry value. |
| -delreg | Delete a registry value. |
| -importKMS | Import user keys and certificates into the server database for key archival. |
| -importcert | Import a certificate file into the database. |
| -getkey | Retrieve an archived private key recovery blob. |
| -recoverkey | Recover an archived private key. |
| -mergePFX | Merge PFX files. |
| -convertEPF | Convert a PFX file into an EPF file. |
| -? | Displays the list of parameters. |
| -`<parameter>` -? | Displays help for the specified parameter. |
| -? -v | Displays a full list of parameters and options. |

## Parameters

### -dump

Dump configuration information or files.

```
certutil [options] [-dump]
certutil [options] [-dump] file
```

```
[-f] [-silent] [-split] [-p password] [-t timeout]
```

### -asn

Parse the ASN.1 file.

```
certutil [options] -asn file [type]
```

`[type]`: numeric CRYPT_STRING_* decoding type

### -decodehex

Decode a hexadecimal-encoded file.

```
certutil [options] -decodehex infile outfile [type]
```

`[type]`: numeric CRYPT_STRING_* encoding type

```
[-f]
```

### -decode

Decode a Base64-encoded file.

```
certutil [options] -decode infile outfile
```

```
[-f]
```

### -encode

Encode a file to Base64.

```
certutil [options] -encode infile outfile
```

```
[-f] [-unicodetext]
```

### -deny

Deny a pending request.

```
certutil [options] -deny requestID
```

```
[-config Machine\CAName]
```

### -resubmit

Resubmit a pending request.

```
certutil [options] -resubmit requestId
```

```
[-config Machine\CAName]
```

### -setattributes

Set attributes for a pending certificate request.

```
certutil [options] -setattributes RequestID attributestring
```

Where:

- **requestID** is the numeric Request ID for the pending request.

- **attributestring** is the request attribute name and value pairs.

```
[-config Machine\CAName]
```

#### Remarks

- Names and values must be colon separated, while multiple name, value pairs must be newline separated. For example: `CertificateTemplate:User\nEMail:User@Domain.com` where the `\n` sequence is converted to a newline separator.

### -setextension

Set an extension for a pending certificate request.

```
certutil [options] -setextension requestID extensionname flags {long | date | string | \@infile}
```

Where:

- **requestID** is the numeric Request ID for the pending request.

- **extensionname** is the ObjectId string for the extension.

- **flags** sets the priority of the extension. `0` is recommended, while `1` sets the extension to critical, `2` disables the extension, and `3` does both.

#### Remarks

- If the last parameter is numeric, it's taken as a **Long**.

- If the last parameter can be parsed as a date, it's taken as a **Date**.

- If the last parameter starts with `\@`, the rest of the token is taken as the filename with binary data or an ascii-text hex dump.

- If the last parameter is anything else, it's taken as a String.


```
[-config Machine\CAName]
```

### -revoke

Revoke a certificate.

```
certutil [options] -revoke serialnumber [reason]
```

Where:

- **serialnumber** is a comma-separated list of certificate serial numbers to revoke.

- **reason** is the numeric or symbolic representation of the revocation reason, including:

  - **0. CRL_REASON_UNSPECIFIED** -  Unspecified (default)

  - **1. CRL_REASON_KEY_COMPROMISE** - Key compromise

  - **2. CRL_REASON_CA_COMPROMISE** - Certificate Authority compromise

  - **3. CRL_REASON_AFFILIATION_CHANGED** - Affiliation changed

  - **4. CRL_REASON_SUPERSEDED** - Superseded

  - **5. CRL_REASON_CESSATION_OF_OPERATION** - Cessation of operation

  - **6. CRL_REASON_CERTIFICATE_HOLD** - Certificate hold

  - **8. CRL_REASON_REMOVE_FROM_CRL** - Remove From CRL

  - **1. Unrevoke** - Unrevoke

```
[-config Machine\CAName]
```

### -isvalid

Display the disposition of the current certificate.

```
certutil [options] -isvalid serialnumber | certhash
```

```
[-config Machine\CAName]
```

### -getconfig

Get the default configuration string.

```
certutil [options] -getconfig
```

```
[-config Machine\CAName]
```

### -ping

Attempt to contact the Active Directory Certificate Services Request interface.

```
certutil [options] -ping [maxsecondstowait | camachinelist]
```

Where:

- **camachinelist** is a comma-separated list of CA machine names. For a single machine, use a terminating comma. This option also displays the site cost for each CA machine.

```
[-config Machine\CAName]
```

### -cainfo

Display information about the certification authority.

```
certutil [options] -cainfo [infoname [index | errorcode]]
```

Where:

- **infoname** indicates the CA property to display, based on the following infoname argument syntax:

  - **file** - File version
  - **product** - Product version
  - **exitcount** - Exit module count
  - **exit `[index]`** - Exit module description
  - **policy** - Policy module description
  - **name** - CA name
  - **sanitizedname** - Sanitized CA name
  - **dsname** - Sanitized CA short name (DS name)
  - **sharedfolder** - Shared folder
  - **error1 ErrorCode** - Error message text
  - **error2 ErrorCode** - Error message text and error code
  - **type** - CA type
  - **info** - CA info
  - **parent** - Parent CA
  - **certcount** - CA cert count
  - **xchgcount** - CA exchange cert count
  - **kracount** - KRA cert count
  - **kraused** - KRA cert used count
  - **propidmax** - Maximum CA PropId
  - **certstate `[index]`** - CA cert
  - **certversion `[index]`** - CA cert version
  - **certstatuscode `[index]`** - CA cert verify status
  - **crlstate `[index]`** - CRL
  - **krastate `[index]`** - KRA cert
  - **crossstate+ `[index]`** - Forward cross cert
  - **crossstate- `[index]`** - Backward cross cert
  - **cert `[index]`** - CA cert
  - **certchain `[index]`** - CA cert chain
  - **certcrlchain `[index]`** - CA cert chain with CRLs
  - **xchg `[index]`** - CA exchange cert
  - **xchgchain `[index]`** - CA exchange cert chain
  - **xchgcrlchain `[index]`** - CA exchange cert chain with CRLs
  - **kra `[index]`** - KRA cert
  - **cross+ `[index]`** - Forward cross cert
  - **cross- `[index]`** - Backward cross cert
  - **CRL `[index]`** - Base CRL
  - **deltacrl `[index]`** - Delta CRL
  - **crlstatus `[index]`** - CRL Publish Status
  - **deltacrlstatus `[index]`** - Delta CRL Publish Status
  - **dns** - DNS Name
  - **role** - Role Separation
  - **ads** - Advanced Server
  - **templates** - Templates
  - **csp `[index]`** - OCSP URLs
  - **aia `[index]`** - AIA URLs
  - **cdp `[index]`** - CDP URLs
  - **localename** - CA locale name
  - **subjecttemplateoids** - Subject Template OIDs
  - **&#42;** - Displays all properties

- **index** is the optional zero-based property index.

- **errorcode** is the numeric error code.

```
[-f] [-split] [-config Machine\CAName]
```

### -ca.cert

Retrieve the certificate for the certification authority.

```
certutil [options] -ca.cert outcacertfile [index]
```

Where:

- **outcacertfile** is the output file.

- **index** is the CA certificate renewal index (defaults to most recent).

```
[-f] [-split] [-config Machine\CAName]
```

### -ca.chain

Retrieve the certificate chain for the certification authority.

```
certutil [options] -ca.chain outcacertchainfile [index]
```

Where:

- **outcacertchainfile** is the output file.

- **index** is the CA certificate renewal index (defaults to most recent).

```
[-f] [-split] [-config Machine\CAName]
```

### -getcrl

Gets a certificate revocation list (CRL).

certutil [options] -getcrl outfile [index] [delta]

Where:

- **index** is the CRL index or key index (defaults to CRL for most recent key).

- **delta** is the delta CRL (default is base CRL).

```
[-f] [-split] [-config Machine\CAName]
```

### -crl

Publish new certificate revocation lists (CRLs) or delta CRLs.

```
certutil [options] -crl [dd:hh | republish] [delta]
```

Where:

- **dd:hh** is the new CRL validity period in days and hours.

- **republish** republishes the most recent CRLs.

- **delta** publishes the delta CRLs only (default is base and delta CRLs).

```
[-split] [-config Machine\CAName]
```

### -shutdown

Shuts down the Active Directory Certificate Services.

```
certutil [options] -shutdown
```

```
[-config Machine\CAName]
```

### -installcert

Installs a certification authority certificate.

```
certutil [options] -installcert [cacertfile]
```

```
[-f] [-silent] [-config Machine\CAName]
```

### -renewcert

Renews a certification authority certificate.

```
certutil [options] -renewcert [reusekeys] [Machine\ParentCAName]
```

- Use `-f` to ignore an outstanding renewal request, and to generate a new request.

```
[-f] [-silent] [-config Machine\CAName]
```

### -schema

Dumps the schema for the certificate.

```
certutil [options] -schema [ext | attrib | cRL]
```
Where:

- The command defaults to the Request and Certificate table.

- **ext** is the extension table.
  
- **attribute** is the attribute table.

- **crl** is the CRL table.

```
[-split] [-config Machine\CAName]
```

### -view

Dumps the certificate view.

```
certutil [options] -view [queue | log | logfail | revoked | ext | attrib | crl] [csv]
```

Where:

- **queue** dumps a specific request queue.

- **log** dumps the issued or revoked certificates, plus any failed requests.

- **logfail** dumps the failed requests.

- **revoked** dumps the revoked certificates.

- **ext** dumps the extension table.
  
- **attribute** dumps the attribute table.

- **crl** dumps the CRL table.

- **csv** provides the output using comma-separated values.

```
[-silent] [-split] [-config Machine\CAName] [-restrict RestrictionList] [-out ColumnList]
```

#### Remarks

- To display the **StatusCode** column for all entries, type `-out StatusCode`

- To display all columns for the last entry, type: `-restrict RequestId==$`

- To display the **RequestID** and **Disposition** for three requests, type: `-restrict requestID>37,requestID<40 -out requestID,disposition`

- To display Row IDs**Row IDs** and **CRL numbers** for all Base CRLs, type: `-restrict crlminbase=0 -out crlrowID,crlnumber crl`

- To display , type: `-v -restrict crlminbase=0,crlnumber=3 -out crlrawcrl crl`

- To display the entire CRL table, type: `CRL`

- Use `Date[+|-dd:hh]` for date restrictions.

- Use `now+dd:hh` for a date relative to the current time.

### -db

Dumps the raw database.

```
certutil [options] -db
```

```
[-config Machine\CAName] [-restrict RestrictionList] [-out ColumnList]
```

### -deleterow

Deletes a row from the server database.

```
certutil [options] -deleterow rowID | date [request | cert | ext | attrib | crl]
```

Where:

- **request** deletes the failed and pending requests, based on submission date.

- **cert** deletes the expired and revoked certificates, based on expiration date.

- **ext** deletes the extension table.
  
- **attribute** deletes the attribute table.

- **crl** deletes the CRL table.

```
[-f] [-config Machine\CAName]
```

#### Examples

- To delete failed and pending requests submitted by January 22, 2001, type: `1/22/2001 request`

- To delete all certificates that expired by January 22, 2001, type: `1/22/2001 cert`

- To delete the certificate row, attributes, and extensions for RequestID 37, type: `37`

- To delete CRLs that expired by January 22, 2001, type: `1/22/2001 crl`

### -backup

Backs up the Active Directory Certificate Services.

```
certutil [options] -backup backupdirectory [incremental] [keeplog]
```

Where:

- **backupdirectory** is the directory to store the backed up data.

- **incremental** performs an incremental backup only (default is full backup).

- **keeplog** preserves the database log files (default is to truncate log files).

```
[-f] [-config Machine\CAName] [-p Password]
```

### -backupdb

Backs up the Active Directory Certificate Services database.

```
certutil [options] -backupdb backupdirectory [incremental] [keeplog]
```

Where:

- **backupdirectory** is the directory to store the backed up database files.

- **incremental** performs an incremental backup only (default is full backup).

- **keeplog** preserves the database log files (default is to truncate log files).

```
[-f] [-config Machine\CAName]
```

### -backupkey

Backs up the Active Directory Certificate Services certificate and private key.

```
certutil [options] -backupkey backupdirectory
```

Where:

- **backupdirectory** is the directory to store the backed up PFX file.

```
[-f] [-config Machine\CAName] [-p password] [-t timeout]
```

### -restore

Restores the Active Directory Certificate Services.

```
certutil [options] -restore backupdirectory
```

Where:

- **backupdirectory** is the directory containing the data to be restored.

```
[-f] [-config Machine\CAName] [-p password]
```

### -restoredb

Restores the Active Directory Certificate Services database.

```
certutil [options] -restoredb backupdirectory
```

Where:

- **backupdirectory** is the directory containing the database files to be restored.

```
[-f] [-config Machine\CAName]
```

### -restorekey

Restores the Active Directory Certificate Services certificate and private key.

```
certutil [options] -restorekey backupdirectory | pfxfile
```

Where:

- **backupdirectory** is the directory containing PFX file to be restored.

```
[-f] [-config Machine\CAName] [-p password]
```

### -importpfx

Import the certificate and private key. For more info, see the `-store` parameter in this article.

```
certutil [options] -importpfx [certificatestorename] pfxfile [modifiers]
```

Where:

- **certificatestorename** is the name of the certificate store.

- **modifiers** are the comma-separated list, which can include one or more of the following:

  1. **AT_SIGNATURE** - Changes the keyspec to signature
  
  2. **AT_KEYEXCHANGE** - Changes the keyspec to key exchange
  
  3. **NoExport** - Makes the private key non-exportable
  
  4. **NoCert** - Doesn't import the certificate
  
  5. **NoChain** - Doesn't import the certificate chain
  
  6. **NoRoot** - Doesn't import the root certificate
  
  7. **Protect** - Protects keys by using a password
  
  8. **NoProtect** - Doesn't password protect keys by using a password

```
[-f] [-user] [-p password] [-csp provider]
```

#### Remarks

- Defaults to personal machine store.

### -dynamicfilelist

Displays a dynamic file list.

```
certutil [options] -dynamicfilelist
```

```
[-config Machine\CAName]
```

### -databaselocations

Displays database locations.

```
certutil [options] -databaselocations
```

```
[-config Machine\CAName]
```

### -hashfile

Generates and displays a cryptographic hash over a file.

```
certutil [options] -hashfile infile [hashalgorithm]
```

### -store

Dumps the certificate store.

```
certutil [options] -store [certificatestorename [certID [outputfile]]]
```

Where:

- **certificatestorename** is the certificate store name. For example:

  - `My, CA (default), Root,`
  
  - `ldap:///CN=Certification Authorities,CN=Public Key Services,CN=Services,CN=Configuration,DC=cpandl,DC=com?cACertificate?one?objectClass=certificationAuthority (View Root Certificates)`
  
  - `ldap:///CN=CAName,CN=Certification Authorities,CN=Public Key Services,CN=Services,CN=Configuration,DC=cpandl,DC=com?cACertificate?base?objectClass=certificationAuthority (Modify Root Certificates)`
  
  - `ldap:///CN=CAName,CN=MachineName,CN=CDP,CN=Public Key Services,CN=Services,CN=Configuration,DC=cpandl,DC=com?certificateRevocationList?base?objectClass=cRLDistributionPoint (View CRLs)`
  
  - `ldap:///CN=NTAuthCertificates,CN=Public Key Services,CN=Services,CN=Configuration,DC=cpandl,DC=com?cACertificate?base?objectClass=certificationAuthority (Enterprise CA Certificates)`
  
  - `ldap: (AD computer object certificates)`
  
  - `-user ldap: (AD user object certificates)`

- **certID** is the certificate or CRL match token. This can be a serial number, a SHA-1 certificate, CRL, CTL or public key hash, a numeric cert index (0, 1, and so on), a numeric CRL index (.0, .1, and so on), a numeric CTL index (..0, ..1, and so on), a public key, signature or extension ObjectId, a certificate subject Common Name, an e-mail address, UPN or DNS name, a key container name or CSP name, a template name or ObjectId, an EKU or Application Policies ObjectId, or a CRL issuer Common Name. Many of these may result in multiple matches.

- **outputfile** is the file used to save the matching certificates.

```
[-f] [-user] [-enterprise] [-service] [-grouppolicy] [-silent] [-split] [-dc DCName]
```

#### Options

- The `-user` option accesses a user store instead of a machine store.

- The `-enterprise` option accesses a machine enterprise store.

- The `-service` option accesses a machine service store.

- The `-grouppolicy` option accesses a machine group policy store.

For example:

- `-enterprise NTAuth`

- `-enterprise Root 37`

- `-user My 26e0aaaf000000000004`

- `CA .11`

### -addstore

Adds a certificate to the store. For more info, see the `-store` parameter in this article.

```
certutil [options] -addstore certificatestorename infile
```

Where:

- **certificatestorename** is the certificate store name.

- **infile** is the certificate or CRL file you want to add to store.

```
[-f] [-user] [-enterprise] [-grouppolicy] [-dc DCName]
```

### -delstore

Deletes a certificate from the store. For more info, see the `-store` parameter in this article.

```
certutil [options] -delstore certificatestorename certID
```

Where:

- **certificatestorename** is the certificate store name.

- **certID** is the certificate or CRL match token.

```
[-enterprise] [-user] [-grouppolicy] [-dc DCName]
```

### -verifystore

Verifies a certificate in the store. For more info, see the `-store` parameter in this article.

```
certutil [options] -verifystore certificatestorename [certID]
```

Where:

- **certificatestorename** is the certificate store name.

- **certID** is the certificate or CRL match token.

```
[-enterprise] [-user] [-grouppolicy] [-silent] [-split] [-dc DCName] [-t timeout]
```

### -repairstore

Repairs a key association or update certificate properties or the key security descriptor. For more info, see the `-store` parameter in this article.

```
certutil [options] -repairstore certificatestorename certIDlist [propertyinffile | SDDLsecuritydescriptor]
```

Where:

- **certificatestorename** is the certificate store name.

- **certIDlist** is the comma-separated list of certificate or CRL match tokens. For more info, see the `-store certID` description in this article.

- **propertyinffile** is the INF file containing external properties, including:

  ```
  [Properties]
      19 = Empty ; Add archived property, OR:
      19 =       ; Remove archived property

      11 = {text}Friendly Name ; Add friendly name property

      127 = {hex} ; Add custom hexadecimal property
          _continue_ = 00 01 02 03 04 05 06 07 08 09 0a 0b 0c 0d 0e 0f
          _continue_ = 10 11 12 13 14 15 16 17 18 19 1a 1b 1c 1d 1e 1f

      2 = {text} ; Add Key Provider Information property
        _continue_ = Container=Container Name&
        _continue_ = Provider=Microsoft Strong Cryptographic Provider&
        _continue_ = ProviderType=1&
        _continue_ = Flags=0&
        _continue_ = KeySpec=2

      9 = {text} ; Add Enhanced Key Usage property
        _continue_ = 1.3.6.1.5.5.7.3.2,
        _continue_ = 1.3.6.1.5.5.7.3.1,
  ```

```
[-f] [-enterprise] [-user] [-grouppolicy] [-silent] [-split] [-csp provider]
```

### -viewstore

Dumps the certificates store. For more info, see the `-store` parameter in this article.

```
certutil [options] -viewstore [certificatestorename [certID [outputfile]]]
```

Where:

- **certificatestorename** is the certificate store name.

- **certID** is the certificate or CRL match token.

- **outputfile** is the file used to save the matching certificates.

```
[-f] [-user] [-enterprise] [-service] [-grouppolicy] [-dc DCName]
```

#### Options

- The `-user` option accesses a user store instead of a machine store.

- The `-enterprise` option accesses a machine enterprise store.

- The `-service` option accesses a machine service store.

- The `-grouppolicy` option accesses a machine group policy store.

For example:

- `-enterprise NTAuth`

- `-enterprise Root 37`

- `-user My 26e0aaaf000000000004`

- `CA .11`

### -viewdelstore

Deletes a certificate from the store.

```
certutil [options] -viewdelstore [certificatestorename [certID [outputfile]]]
```

Where:

- **certificatestorename** is the certificate store name.

- **certID** is the certificate or CRL match token.

- **outputfile** is the file used to save the matching certificates.

```
[-f] [-user] [-enterprise] [-service] [-grouppolicy] [-dc DCName]
```

#### Options

- The `-user` option accesses a user store instead of a machine store.

- The `-enterprise` option accesses a machine enterprise store.

- The `-service` option accesses a machine service store.

- The `-grouppolicy` option accesses a machine group policy store.

For example:

- `-enterprise NTAuth`

- `-enterprise Root 37`

- `-user My 26e0aaaf000000000004`

- `CA .11`

### -dspublish

Publishes a certificate or certificate revocation list (CRL) to Active Directory.

```
certutil [options] -dspublish certfile [NTAuthCA | RootCA | SubCA | CrossCA | KRA | User | Machine]
```

```
certutil [options] -dspublish CRLfile [DSCDPContainer [DSCDPCN]]
```

Where:

- **certfile** is the certificate file to publish.

**NTAuthCA** publishes the certificate to the DS Enterprise store.

**RootCA**: Publish cert to DS Trusted Root store

**SubCA**: Publish CA cert to DS CA object

**CrossCA**: Publish cross cert to DS CA object

**KRA**: Publish cert to DS Key Recovery Agent object

**User**: Publish cert to User DS object

**Machine**: Publish cert to Machine DS object

**CRLfile**: CRL file to publish

**DSCDPContainer**: DS CDP container CN, usually the CA machine name

**DSCDPCN**: DS CDP object CN, usually based on the sanitized CA short name and key index

Use `-f` to create DS object.

[-f] [-user] [-dc DCName]


### -ADTemplate

certutil [options] -ADTemplate [Template]

Display AD templates

[-f] [-user] [-ut] [-mt] [-dc DCName]

### -Template

certutil [options] -Template [Template]

Display Enrollment Policy templates

[-f] [-user] [-silent] [-PolicyServer URLOrId] [-Anonymous] [-Kerberos] [-ClientCertificate ClientCertId] [-UserName UserName] [-p Password]


### -TemplateCAs

certutil [options] -TemplateCAs Template

Display CAs for template

[-f] [-user] [-dc DCName]


### -CATemplates

certutil [options] -CATemplates [Template]

Display templates for CA

[-f] [-user] [-ut] [-mt] [-config Machine\CAName] [-dc DCName]


### -SetCASites

certutil [options] -SetCASites [set] [SiteName]

certutil [options] -SetCASites verify [SiteName]

certutil [options] -SetCASites delete

Set, Verify or Delete CA site names

- Use the -config option to target a single CA (Default is all CAs)
- *SiteName* is allowed only when targeting a single CA
- Use -f to override validation errors for the specified *SiteName*
- Use -f to delete all CA site names

[-f] [-config Machine\CAName] [-dc DCName]

> [!NOTE]
> For more information on configuring CAs for Active Directory Domain Services (AD DS) site awareness, see [AD DS Site Awareness for AD CS and PKI clients](https://social.technet.microsoft.com/wiki/contents/articles/14106.ad-ds-site-awareness-for-ad-cs-and-pki-clients.aspx).


### -enrollmentServerURL

certutil [options] -enrollmentServerURL [URL AuthenticationType [Priority] [Modifiers]]

certutil [options] -enrollmentServerURL URL delete

Display, add or delete enrollment server URLs associated with a CA

AuthenticationType: Specify one of the following client authentication methods while adding a URL

1. Kerberos: Use Kerberos SSL credentials
2. UserName: Use named account for SSL credentials
3. ClientCertificate: Use X.509 Certificate SSL credentials
4. Anonymous: Use anonymous SSL credentials

delete: deletes the specified URL associated with the CA

Priority: defaults to '1' if not specified when adding a URL

Modifiers -- Comma separated list of one or more of the following:

1. AllowRenewalsOnly: Only renewal requests can be submitted to this CA via this URL
2. AllowKeyBasedRenewal: Allows use of a certificate that has no associated account in the AD. This applies only with ClientCertificate and AllowRenewalsOnly Mode

[-config Machine\CAName] [-dc DCName]


### -ADCA

certutil [options] -ADCA [CAName]

Display AD CAs

[-f] [-split] [-dc DCName]


### -CA

certutil [options] -CA [CAName | TemplateName]

Display Enrollment Policy CAs

[-f] [-user] [-silent] [-split] [-PolicyServer URLOrId] [-Anonymous] [-Kerberos] [-ClientCertificate ClientCertId] [-UserName UserName] [-p Password]


### -Policy

Display Enrollment Policy

[-f] [-user] [-silent] [-split] [-PolicyServer URLOrId] [-Anonymous] [-Kerberos] [-ClientCertificate ClientCertId] [-UserName UserName] [-p Password]


### -PolicyCache

certutil [options] -PolicyCache [delete]

Display or delete Enrollment Policy Cache entries

delete: delete Policy Server cache entries

-f: use -f to delete all cache entries

[-f] [-user] [-PolicyServer URLOrId]


### -CredStore

certutil [options] -CredStore [URL]

certutil [options] -CredStore URL add

certutil [options] -CredStore URL delete

Display, add or delete Credential Store entries

URL: target URL.  Use \* to match all entries. Use https://machine\* to match a URL prefix.

add: add a Credential Store entry. SSL credentials must also be specified.

delete: delete Credential Store entries

-f: use -f to overwrite an entry or to delete multiple entries.

[-f] [-user] [-silent] [-Anonymous] [-Kerberos] [-ClientCertificate ClientCertId] [-UserName UserName] [-p Password]


### -InstallDefaultTemplates

certutil [options] -InstallDefaultTemplates

Install default certificate templates

[-dc DCName]


### -URLCache

certutil [options] -URLCache [URL | CRL | \* [delete]]

Display or delete URL cache entries

URL: cached URL

CRL: operate on all cached CRL URLs only

\*: operate on all cached URLs

delete: delete relevant URLs from the current user's local cache

Use -f to force fetching a specific URL and updating the cache.

[-f] [-split]


### -pulse

certutil [options] -pulse

Pulse autoenrollment events

[-user]


### -MachineInfo

certutil [options] -MachineInfo DomainName\MachineName$

Display Active Directory computer object information


### -DCInfo

certutil [options] -DCInfo [Domain] [Verify | DeleteBad | DeleteAll]

Display domain controller information

Default is to display DC certs without verification

[-f] [-user] [-urlfetch] [-dc DCName] [-t Timeout]

> [!TIP]
> The ability to specify an Active Directory Domain Services (AD DS) domain **[Domain]** and to specify a domain controller (**-dc**) was added in Windows Server 2012. To successfully run the command, you must use an account that is a member of **Domain Admins** or **Enterprise Admins**. The behavior modifications of this command are as follows:</br>> 1.  If a domain is not specified and a specific domain controller is not specified, this option returns a list of domain controllers to process from the default domain controller.</br>> 2.  If a domain is not specified, but a domain controller is specified, a report of the certificates on the specified domain controller is generated.</br>> 3.  If a domain is specified, but a domain controller is not specified, a list of domain controllers is generated along with reports on the certificates for each domain controller in the list.</br>> 4.  If the domain and domain controller are specified, a list of domain controllers is generated from the targeted domain controller. A report of the certificates for each domain controller in the list is also generated.

For example, assume there is a domain named CPANDL with a domain controller named CPANDL-DC1. You could run the following command to a retrieve a list of domain controllers and their certificates that from CPANDL-DC1: certutil -dc cpandl-dc1 -dcinfo cpandl


### -EntInfo

certutil [options] -EntInfo DomainName\MachineName$

[-f] [-user]


### -TCAInfo

certutil [options] -TCAInfo [DomainDN | -]

Display CA information

[-f] [-enterprise] [-user] [-urlfetch] [-dc DCName] [-t Timeout]


### -SCInfo

certutil [options] -SCInfo [ReaderName [CRYPT_DELETEKEYSET]]

Display smart card information

CRYPT_DELETEKEYSET: Delete all keys on the smart card

[-silent] [-split] [-urlfetch] [-t Timeout]


### -SCRoots

certutil [options] -SCRoots update [+][InputRootfile] [ReaderName]

certutil [options] -SCRoots save \@OutputRootfile [ReaderName]

certutil [options] -SCRoots view [InputRootfile | ReaderName]

certutil [options] -SCRoots delete [ReaderName]

Manage smart card root certificates

[-f] [-split] [-p Password]


### -verifykeys

certutil [options] -verifykeys [KeyContainerName CACertfile]

Verify public/private key set

KeyContainerName: key container name of the key to verify. Defaults to machine keys.  Use -user for user keys.

CACertfile: signing or encryption certificate file

If no arguments are specified, each signing CA cert is verified against its private key.

This operation can only be performed against a local CA or local keys.

[-f] [-user] [-silent] [-config Machine\CAName]


### -verify

certutil [options] -verify Certfile [ApplicationPolicyList | - [IssuancePolicyList]]

certutil [options] -verify Certfile [CACertfile [CrossedCACertfile]]

certutil [options] -verify CRLfile CACertfile [IssuedCertfile]

certutil [options] -verify CRLfile CACertfile [DeltaCRLfile]

Verify certificate, CRL or chain

Certfile: Certificate to verify

ApplicationPolicyList: optional comma separated list of required Application Policy ObjectIds

IssuancePolicyList: optional comma separated list of required Issuance Policy ObjectIds

CACertfile: optional issuing CA certificate to verify against

CrossedCACertfile: optional certificate cross-certified by Certfile

CRLfile: CRL to verify

IssuedCertfile: optional issued certificate covered by CRLfile

DeltaCRLfile: optional delta CRL

If ApplicationPolicyList is specified, chain building is restricted to chains valid for the specified Application Policies.

If IssuancePolicyList is specified, chain building is restricted to chains valid for the specified Issuance Policies.

If CACertfile is specified, fields in CACertfile are verified against Certfile or CRLfile.

If CACertfile is not specified, Certfile is used to build and verify a full chain.

If CACertfile and CrossedCACertfile are both specified, fields in CACertfile and CrossedCACertfile are verified against Certfile.

If IssuedCertfile is specified, fields in IssuedCertfile are verified against CRLfile.

If DeltaCRLfile is specified, fields in DeltaCRLfile are verified against CRLfile.

[-f] [-enterprise] [-user] [-silent] [-split] [-urlfetch] [-t Timeout]


### -verifyCTL

certutil [options] -verifyCTL CTLObject [CertDir] [Certfile]

Verify AuthRoot or Disallowed Certificates CTL

CTLObject: Identifies the CTL to verify:

- AuthRootWU: read AuthRoot CAB and matching certificates from the URL cache. Use -f to download from Windows Update instead.
- DisallowedWU: read Disallowed Certificates CAB and disallowed certificate store file from the URL cache.  Use -f to download from Windows Update instead.
- AuthRoot: read registry cached AuthRoot CTL.  Use with -f and a             Certfile that is not already trusted to force updating the registry cached AuthRoot and Disallowed Certificate CTLs.
- Disallowed: read registry cached Disallowed Certificates CTL. -f has the same behavior as with AuthRoot.
- CTLfileName: file or http: path to CTL or CAB

CertDir: folder containing certificates matching CTL entries. An http: folder path must end with a path separator. If a folder is not specified with AuthRoot or Disallowed, multiple locations will be searched for matching certificates: local certificate stores, crypt32.dll resources and the local URL cache. Use -f to download from Windows Update when necessary. Otherwise defaults to the same folder or web site as the CTLObject.

Certfile: file containing certificate(s) to verify. Certificates will be matched against CTL entries, and match results displayed. Suppresses most of the default output.

[-f] [-user] [-split]


### -sign

certutil [options] -sign InfileList|SerialNumber|CRL OutfileList [StartDate+dd:hh] [+SerialNumberList | -SerialNumberList | -ObjectIdList | \@Extensionfile]

certutil [options] -sign InfileList|SerialNumber|CRL OutfileList [#HashAlgorithm] [+AlternateSignatureAlgorithm | -AlternateSignatureAlgorithm]

Re-sign CRL or certificate

InfileList: comma separated list of Certificate or CRL files to modify and re-sign

SerialNumber: Serial number of certificate to create. Validity period and other options must not be present.

CRL: Create an empty CRL. Validity period and other options must not be present.

OutfileList: comma separated list of modified Certificate or CRL output files. The number of files must match InfileList.

StartDate+dd:hh: new validity period: optional date plus; optional days and hours validity period; If both are specified, use a plus sign (+) separator. Use now[+dd:hh] to start at the current time. Use never to have no expiration date (for CRLs only).

SerialNumberList: comma separated serial number list to add or remove

ObjectIdList: comma separated extension ObjectId list to remove

\@Extensionfile: INF file containing extensions to update or remove:

```
[Extensions]
     2.5.29.31 = ; Remove CRL Distribution Points extension
     2.5.29.15 = {hex} ; Update Key Usage extension
     _continue_=03 02 01 86
```

HashAlgorithm: Name of the hash algorithm preceded by a # sign

AlternateSignatureAlgorithm: alternate Signature algorithm specifier

A minus sign causes serial numbers and extensions to be removed. A plus sign causes serial numbers to be added to a CRL. When removing items from a CRL, the list may contain both serial numbers and ObjectIds. A minus sign before AlternateSignatureAlgorithm causes the legacy signature format to be used. A plus sign before AlternateSignatureAlgorithm causes the alternature signature format to be used. If AlternateSignatureAlgorithm is not specified then the signature format in the certificate or CRL is used.

[-nullsign] [-f] [-silent] [-Cert CertId]


### -vroot

certutil [options] -vroot [delete]

Create/delete web virtual roots and file shares


### -vocsproot

certutil [options] -vocsproot [delete]

Create/delete web virtual roots for OCSP web proxy


### -addEnrollmentServer

certutil [options] -addEnrollmentServer Kerberos | UserName | ClientCertificate [AllowRenewalsOnly] [AllowKeyBasedRenewal]

Add an Enrollment Server application

Add an Enrollment Server application and application pool if necessary, for the specified CA. This command does not install binaries or packages. One of the following authentication methods with which the client connects to a Certificate Enrollment Server.

- Kerberos: Use Kerberos SSL credentials
- UserName: Use named account for SSL credentials
- ClientCertificate: Use X.509 Certificate SSL credentials
- AllowRenewalsOnly: Only renewal requests can be submitted to this CA via this URL
- AllowKeyBasedRenewal -- Allows use of a certificate that has no associated account in the AD. This applies only with ClientCertificate and AllowRenewalsOnly mode.

[-config Machine\CAName]


### -deleteEnrollmentServer

certutil [options] -deleteEnrollmentServer Kerberos | UserName | ClientCertificate

Delete an Enrollment Server application

Delete an Enrollment Server application and application pool if necessary, for the specified CA. This command does not remove binaries or packages. One of the following authentication methods with which the client connects to a Certificate Enrollment Server.

1. Kerberos: Use Kerberos SSL credentials
2. UserName: Use named account for SSL credentials
3. ClientCertificate: Use X.509 Certificate SSL credentials

[-config Machine\CAName]


### -addPolicyServer

certutil [options] -addPolicyServer Kerberos | UserName | ClientCertificate [KeyBasedRenewal]

Add a Policy Server application

Add a Policy Server application and application pool if necessary. This command does not install binaries or packages. One of the following authentication methods with which the client connects to a Certificate Policy Server:

- Kerberos: Use Kerberos SSL credentials
- UserName: Use named account for SSL credentials
- ClientCertificate: Use X.509 Certificate SSL credentials
- KeyBasedRenewal: Only policies that contain KeyBasedRenewal templates are returned to the client. This flag applies only for UserName and ClientCertificate authentication.


### -deletePolicyServer

certutil [options] -deletePolicyServer Kerberos | UserName | ClientCertificate [KeyBasedRenewal]

Delete a Policy Server application

Delete a Policy Server application and application pool if necessary. This command does not remove binaries or packages. One of the following authentication methods with which the client connects to a Certificate Policy Server:

1. Kerberos: Use Kerberos SSL credentials
2. UserName: Use named account for SSL credentials
3. ClientCertificate: Use X.509 Certificate SSL credentials
4. KeyBasedRenewal: KeyBasedRenewal policy server


### -oid

certutil [options] -oid ObjectId [DisplayName | delete [LanguageId [Type]]]

certutil [options] -oid GroupId

certutil [options] -oid AlgId | AlgorithmName [GroupId]

Display ObjectId or set display name

- ObjectId -- ObjectId to display or to add display name
- GroupId -- decimal GroupId number for ObjectIds to enumerate
- AlgId -- hexadecimal AlgId for ObjectId to look up
- AlgorithmName -- Algorithm Name for ObjectId to look up
- DisplayName -- Display Name to store in DS
- delete -- delete display name
- LanguageId -- Language Id (defaults to current: 1033)
- Type -- DS object type to create: 1 for Template (default), 2 for Issuance Policy, 3 for Application Policy
- Use -f to create DS object.

[-f]


### -error

certutil [options] -error ErrorCode

Display error code message text


### -getreg

certutil [options] -getreg [{ca|restore|policy|exit|template|enroll|chain|PolicyServers}\[ProgId\]][RegistryValueName]

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

RegistryValueName: registry value name (use Name\* to prefix match)

Value: new numeric, string or date registry value or filename. If a numeric value starts with + or -, the bits specified in the new value are set or cleared in the existing registry value.

If a string value starts with + or -, and the existing value is a REG_MULTI_SZ value, the string is added to or removed from the existing registry value. To force creation of a REG_MULTI_SZ value, add a \n to the end of the string value.

If the value starts with \@, the rest of the value is the name of the file containing the hexadecimal text representation of a binary value. If it does not refer to a valid file, it is instead parsed as [Date][+|-][dd:hh] -- an optional date plus or minus optional days and hours. If both are specified, use a plus sign (+) or minus sign (-) separator. Use now+dd:hh for a date relative to the current time.

Use chain\ChainCacheResyncfiletime \@now to effectively flush cached CRLs.

[-f] [-user] [-GroupPolicy] [-config Machine\CAName]


### -setreg

certutil [options] -setreg [{ca|restore|policy|exit|template|enroll|chain|PolicyServers}\[ProgId\]]RegistryValueName Value

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

RegistryValueName: registry value name (use Name\* to prefix match)

Value: new numeric, string or date registry value or filename. If a numeric value starts with + or -, the bits specified in the new value are set or cleared in the existing registry value.

If a string value starts with + or -, and the existing value is a REG_MULTI_SZ value, the string is added to or removed from the existing registry value. To force creation of a REG_MULTI_SZ value, add a \n to the end of the string value.

If the value starts with \@, the rest of the value is the name of the file containing the hexadecimal text representation of a binary value. If it does not refer to a valid file, it is instead parsed as [Date][+|-][dd:hh] -- an optional date plus or minus optional days and hours. If both are specified, use a plus sign (+) or minus sign (-) separator. Use now+dd:hh for a date relative to the current time.

Use chain\ChainCacheResyncfiletime \@now to effectively flush cached CRLs.

[-f] [-user] [-GroupPolicy] [-config Machine\CAName]


### -delreg

certutil [options] -delreg [{ca|restore|policy|exit|template|enroll|chain|PolicyServers}\[ProgId\]][RegistryValueName]

Delete registry value

ca: Use CA's registry key

restore: Use CA's restore registry key

policy: Use policy module's registry key

exit: Use first exit module's registry key

template: Use template registry key (use -user for user templates)

enroll: Use enrollment registry key (use -user for user context)

chain: Use chain configuration registry key

PolicyServers: Use Policy Servers registry key

ProgId: Use policy or exit module's ProgId (registry subkey name)

RegistryValueName: registry value name (use Name\* to prefix match)

Value: new numeric, string or date registry value or filename. If a numeric value starts with + or -, the bits specified in the new value are set or cleared in the existing registry value.

If a string value starts with + or -, and the existing value is a REG_MULTI_SZ value, the string is added to or removed from the existing registry value. To force creation of a REG_MULTI_SZ value, add a \n to the end of the string value.

If the value starts with \@, the rest of the value is the name of the file containing the hexadecimal text representation of a binary value. If it does not refer to a valid file, it is instead parsed as [Date][+|-][dd:hh] -- an optional date plus or minus optional days and hours. If both are specified, use a plus sign (+) or minus sign (-) separator. Use now+dd:hh for a date relative to the current time.

Use chain\ChainCacheResyncfiletime \@now to effectively flush cached CRLs.

[-f] [-user] [-GroupPolicy] [-config Machine\CAName]


### -ImportKMS

certutil [options] -ImportKMS UserKeyAndCertfile [CertId]

Import user keys and certificates into server database for key archival

UserKeyAndCertfile -- Data file containing user private keys and certificates to be archived.  This can be any of the following:

- Exchange Key Management Server (KMS) export file
- PFX file

CertId: KMS export file decryption certificate match token.  See [-store](#-store).

Use -f to import certificates not issued by the CA.

[-f] [-silent] [-split] [-config Machine\CAName] [-p Password] [-symkeyalg SymmetricKeyAlgorithm[,KeyLength]]


### -ImportCert

certutil [options] -ImportCert Certfile [ExistingRow]

Import a certificate file into the database

Use ExistingRow to import the certificate in place of a pending request for the same key.

Use -f to import certificates not issued by the CA.

The CA may also need to be configured to support foreign certificate import: certutil -setreg ca\KRAFlags +KRAF_ENABLEFOREIGN

[-f] [-config Machine\CAName]


### -GetKey

certutil [options] -GetKey SearchToken [RecoveryBlobOutfile]

certutil [options] -GetKey SearchToken script OutputScriptfile

certutil [options] -GetKey SearchToken retrieve | recover OutputfileBaseName

Retrieve archived private key recovery blob, generate a recovery script, or recover archived keys

script: generate a script to retrieve and recover keys (default behavior if multiple matching recovery candidates are found, or if the output file is not specified).

retrieve: retrieve one or more Key Recovery Blobs (default behavior if exactly one matching recovery candidate is found, and if the output file is specified)

recover: retrieve and recover private keys in one step (requires Key Recovery Agent certificates and private keys)

SearchToken: Used to select the keys and certificates to be recovered.

Can be any of the following:

1. Certificate Common Name
2. Certificate Serial Number
3. Certificate SHA-1 hash (thumbprint)
4. Certificate KeyId SHA-1 hash (Subject Key Identifier)
5. Requester Name (domain\user)
6. UPN (user\@domain)

RecoveryBlobOutfile: output file containing a certificate chain and an associated private key, still encrypted to one or more Key Recovery Agent certificates.

OutputScriptfile: output file containing a batch script to retrieve and recover private keys.

OutputfileBaseName: output file base name. For retrieve, any extension is truncated and a certificate-specific string and the .rec extension are appended for each key recovery blob.  Each file contains a certificate chain and an associated private key, still encrypted to one or more Key Recovery Agent certificates. For recover, any extension is truncated and the .p12 extension is appended.  Contains the recovered certificate chains and associated private keys, stored as a PFX file.

[-f] [-UnicodeText] [-silent] [-config Machine\CAName] [-p Password] [-ProtectTo SAMNameAndSIDList] [-csp Provider]


### -RecoverKey

certutil [options] -RecoverKey RecoveryBlobInfile [PFXOutfile [RecipientIndex]]

Recover archived private key

[-f] [-user] [-silent] [-split] [-p Password] [-ProtectTo SAMNameAndSIDList] [-csp Provider] [-t Timeout]


### -MergePFX

certutil [options] -MergePFX PFXInfileList PFXOutfile [ExtendedProperties]

PFXInfileList: Comma separated PFX input file list

PFXOutfile: PFX output file

ExtendedProperties: Include extended properties

The password specified on the command line is a comma separated password list.  If more than one password is specified, the last password is used for the output file.  If only one password is provided or if the last password is \*, the user will be prompted for the output file password.

[-f] [-user] [-split] [-p Password] [-ProtectTo SAMNameAndSIDList] [-csp Provider]


### -ConvertEPF

certutil [options] -ConvertEPF PFXInfileList EPFOutfile [cast | cast-] [V3CACertId][,Salt]

Convert PFX files to EPF file

PFXInfileList: Comma separated PFX input file list

EPF: EPF output file

cast: Use CAST 64 encryption

cast-: Use CAST 64 encryption (export)

V3CACertId: V3 CA Certificate match token.  See [-store](#-store) CertId description.

Salt: EPF output file salt string

The password specified on the command line is a comma separated password list. If more than one password is specified, the last password is used for the output file.  If only one password is provided or if the last password is \*, the user will be prompted for the output file password.

[-f] [-silent] [-split] [-dc DCName] [-p Password] [-csp Provider]


### Options

This section defines the options that you can specify with the command.

|Options|Description|
|-------|-----------|
|-nullsign|Use hash of data as signature|
|-f|Force overwrite|
|-enterprise|Use local machine Enterprise registry certificate store|
|-user|Use HKEY_CURRENT_USER keys or certificate store|
|-GroupPolicy|Use Group Policy certificate store|
|-ut|Display user templates|
|-mt|Display machine templates|
|-Unicode|Write redirected output in Unicode|
|-UnicodeText|Write output file in Unicode|
|-gmt|Display times as GMT|
|-seconds|Display times with seconds and milliseconds|
|-silent|Use silent flag to acquire crypt context|
|-split|Split embedded ASN.1 elements, and save to files|
|-v|Verbose operation|
|-privatekey|Display password and private key data|
|-pin PIN|Smart Card PIN|
|-urlfetch|Retrieve and verify AIA Certs and CDP CRLs|
|-config Machine\CAName|CA and computer name string|
|-PolicyServer URLOrId|Policy Server URL or Id. For selection U/I, use -PolicyServer. For all Policy Servers, use -PolicyServer \*|
|-Anonymous|Use anonymous SSL credentials|
|-Kerberos|Use Kerberos SSL credentials|
|-ClientCertificate ClientCertId|Use X.509 Certificate SSL credentials. For selection U/I, use -clientCertificate.|
|-UserName UserName|Use named account for SSL credentials. For selection U/I, use -UserName.|
|-Cert CertId|Signing certificate|
|-dc DCName|Target a specific Domain Controller|
|-restrict RestrictionList|Comma separated Restriction List. Each restriction consists of a column name, a relational operator and a constant integer, string or date. One column name may be preceded by a plus or minus sign to indicate the sort order. Examples:</br>RequestId = 47</br>+RequesterName >= a, RequesterName < b</br>-RequesterName > DOMAIN, Disposition = 21|
|-out ColumnList|Comma separated Column List|
|-p Password|Password|
|-ProtectTo SAMNameAndSIDList|Comma separated SAM Name/SID List|
|-csp Provider|Provider|
|-t Timeout|URL fetch timeout in milliseconds|
|-symkeyalg SymmetricKeyAlgorithm[,KeyLength]|Name of Symmetric Key Algorithm with optional key length, example: AES,128 or 3DES|

### Additional certutil examples

For some examples of how to use this command, see

1. [Certutil Examples for Managing Active Directory Certificate Services (AD CS) from the Command Line](https://social.technet.microsoft.com/wiki/contents/articles/3063.certutil-examples-for-managing-active-directory-certificate-services-ad-cs-from-the-command-line.aspx)
2. [Certutil tasks for managing certificates](https://technet.microsoft.com/library/cc772898.aspx)
3. [Binary Request Export Using the certutil.exe Command-Line Tool Walkthrough](https://social.technet.microsoft.com/wiki/contents/articles/7573.active-directory-certificate-services-pki-key-archival-and-management.aspx)
4. [Root CA certificate renewal](https://social.technet.microsoft.com/wiki/contents/articles/2016.root-ca-certificate-renewal.aspx)
5. [Certutil](https://msdn.microsoft.com/subscriptions/cc773087.aspx)

