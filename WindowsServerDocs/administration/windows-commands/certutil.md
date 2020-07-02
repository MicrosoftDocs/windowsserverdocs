---
title: certutil
description: Reference article for the certutil command, which is a command-line program that dumps and displays certification authority (CA) configuration information, configures Certificate Services, backup and restore CA components, and verifies certificates, key pairs, and certificate chains.
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

```
[-config Machine\CAName]
```

#### Remarks

- If the last parameter is numeric, it's taken as a **Long**.

- If the last parameter can be parsed as a date, it's taken as a **Date**.

- If the last parameter starts with `\@`, the rest of the token is taken as the filename with binary data or an ascii-text hex dump.

- If the last parameter is anything else, it's taken as a String.

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

- **certfile** is the name of the certificate file to publish.

- **NTAuthCA** publishes the certificate to the DS Enterprise store.

- **RootCA** publishes the certificate to the DS Trusted Root store.

- **SubCA** publishes the CA certificate to the DS CA object.

- **CrossCA** publishes the cross-certificate to the DS CA object.

- **KRA** publishes the certificate to the DS Key Recovery Agent object.

- **User** publishes the certificate to the User DS object.

- **Machine** publishes the certificate to the Machine DS object.

- **CRLfile** is the name of the CRL file to publish.

- **DSCDPContainer** is the DS CDP container CN, usually the CA machine name.

- **DSCDPCN** is the DS CDP object CN, usually based on the sanitized CA short name and key index.

- Use `-f` to create a new DS object.

```
[-f] [-user] [-dc DCName]
```

### -adtemplate

Displays Active Directory templates.

```
certutil [options] -adtemplate [template]
```

```
[-f] [-user] [-ut] [-mt] [-dc DCName]
```

### -template

Displays the certificate templates.

```
certutil [options] -template [template]
```

```
[-f] [-user] [-silent] [-policyserver URLorID] [-anonymous] [-kerberos] [-clientcertificate clientcertID] [-username username] [-p password]
```

### -templatecas

Displays the certification authorities (CAs) for a certificate template.

```
certutil [options] -templatecas template
```

```
[-f] [-user] [-dc DCName]
```

### -catemplates

Displays templates for the Certificate Authority.

```
certutil [options] -catemplates [template]
```

```
[-f] [-user] [-ut] [-mt] [-config Machine\CAName] [-dc DCName]
```

### -setcasites

Manages site names, including setting, verifying, and deleting Certificate Authority site names

```
certutil [options] -setcasites [set] [sitename]
certutil [options] -setcasites verify [sitename]
certutil [options] -setcasites delete
```

Where:

- **sitename** is allowed only when targeting a single Certificate Authority.

```
[-f] [-config Machine\CAName] [-dc DCName]
```

#### Remarks

- The `-config` option targets a single Certificate Authority (Default is all CAs).

- The `-f` option can be used to override validation errors for the specified **sitename** or to delete all CA sitenames.

> [!NOTE]
> For more information about configuring CAs for Active Directory Domain Services (AD DS) site awareness, see [AD DS Site Awareness for AD CS and PKI clients](https://social.technet.microsoft.com/wiki/contents/articles/14106.ad-ds-site-awareness-for-ad-cs-and-pki-clients.aspx).

### -enrollmentserverURL

Displays, adds, or deletes enrollment server URLs associated with a CA.

```
certutil [options] -enrollmentServerURL [URL authenticationtype [priority] [modifiers]]
certutil [options] -enrollmentserverURL URL delete
```

Where:

- **authenticationtype** specifies one of the following client authentication methods, while adding a URL:

  1. **kerberos** - Use Kerberos SSL credentials.

  2. **username** - Use a named account for SSL credentials.

  3. **clientcertificate**: - Use X.509 Certificate SSL credentials.

  4. **anonymous** - Use anonymous SSL credentials.

- **delete** deletes the specified URL associated with the CA.

- **priority** defaults to `1` if not specified when adding a URL.

- **modifiers** is a comma-separated list, which includes one or more of the following:

1. **allowrenewalsonly** - Only renewal requests can be submitted to this CA via this URL.

2. **allowkeybasedrenewal** - Allows use of a certificate that has no associated account in the AD. This applies only with clientcertificate and allowrenewalsonly Mode

```
[-config Machine\CAName] [-dc DCName]
```

### -adca

Displays Active Directory Certificate Authorities.

```
certutil [options] -adca [CAName]
```

```
[-f] [-split] [-dc DCName]
```

### -ca

Displays enrollment policy Certificate Authorities.

```
certutil [options] -CA [CAName | templatename]
```

```
[-f] [-user] [-silent] [-split] [-policyserver URLorID] [-anonymous] [-kerberos] [-clientcertificate clientcertID] [-username username] [-p password]
```

### -policy

Displays the enrollment policy.

```
[-f] [-user] [-silent] [-split] [-policyserver URLorID] [-anonymous] [-kerberos] [-clientcertificate clientcertID] [-username username] [-p password]
```

### -policycache

Displays or deletes enrollment policy cache entries.

```
certutil [options] -policycache [delete]
```

Where:

- **delete** deletes the policy server cache entries.

- **-f** deletes all cache entries

```
[-f] [-user] [-policyserver URLorID]
```

### -credstore

Displays, adds, or deletes Credential Store entries.

```
certutil [options] -credstore [URL]
certutil [options] -credstore URL add
certutil [options] -credstore URL delete
```

Where:

- **URL** is the target URL. You can also use `*` to match all entries or `https://machine*` to match a URL prefix.

- **add** adds a credential store entry. Using this option also requires the use of SSL credentials.

- **delete** deletes credential store entries.

- **-f** overwrites a single entry or deletes multiple entries.

```
[-f] [-user] [-silent] [-anonymous] [-kerberos] [-clientcertificate clientcertID] [-username username] [-p password]
```

### -installdefaulttemplates

Installs default certificate templates.

```
certutil [options] -installdefaulttemplates
```

```
[-dc DCName]
```

### -URLcache

Displays or deletes URL cache entries.

```
certutil [options] -URLcache [URL | CRL | * [delete]]
```

Where:

- **URL** is the cached URL.

- **CRL** runs on all cached CRL URLs only.

- **&#42;** operates on all cached URLs.

- **delete** deletes relevant URLs from the current user's local cache.

- **-f** forces fetching a specific URL and updating the cache.

```
[-f] [-split]
```

### -pulse

Pulses auto enrollment events.

```
certutil [options] -pulse
```

```
[-user]
```

### -machineinfo

Displays information about the Active Directory machine object.

```
certutil [options] -machineinfo domainname\machinename$
```

### -DCInfo

Displays information about the domain controller. The default displays DC certificates without verification.

```
certutil [options] -DCInfo [domain] [verify | deletebad | deleteall]
```

```
[-f] [-user] [-urlfetch] [-dc DCName] [-t timeout]
```

> [!TIP]
> The ability to specify an Active Directory Domain Services (AD DS) domain **[Domain]** and to specify a domain controller (**-dc**) was added in Windows Server 2012. To successfully run the command, you must use an account that is a member of **Domain Admins** or **Enterprise Admins**. The behavior modifications of this command are as follows:<ol><li>1. If a domain is not specified and a specific domain controller is not specified, this option returns a list of domain controllers to process from the default domain controller.</li><li>2. If a domain is not specified, but a domain controller is specified, a report of the certificates on the specified domain controller is generated.</li><li>3. If a domain is specified, but a domain controller is not specified, a list of domain controllers is generated along with reports on the certificates for each domain controller in the list.</li><li>4. If the domain and domain controller are specified, a list of domain controllers is generated from the targeted domain controller. A report of the certificates for each domain controller in the list is also generated.</li></ol>
>
>For example, assume there is a domain named CPANDL with a domain controller named CPANDL-DC1. You can run the following command to a retrieve a list of domain controllers and their certificates that from CPANDL-DC1: `certutil -dc cpandl-dc1 -DCInfo cpandl`

### -entinfo

Displays information about an enterprise Certificate Authority.

```
certutil [options] -entinfo domainname\machinename$
```

```
[-f] [-user]
```

### -tcainfo

Displays information about the Certificate Authority.

```
certutil [options] -tcainfo [domainDN | -]
```

```
[-f] [-enterprise] [-user] [-urlfetch] [-dc DCName] [-t timeout]
```

### -scinfo

Displays information about the smart card.

```
certutil [options] -scinfo [readername [CRYPT_DELETEKEYSET]]
```

Where:

- **CRYPT_DELETEKEYSET** deletes all keys on the smart card.

```
[-silent] [-split] [-urlfetch] [-t timeout]
```

### -scroots

Manages smart card root certificates.

```
certutil [options] -scroots update [+][inputrootfile] [readername]
certutil [options] -scroots save \@in\\outputrootfile [readername]
certutil [options] -scroots view [inputrootfile | readername]
certutil [options] -scroots delete [readername]
```

```
[-f] [-split] [-p Password]
```

### -verifykeys

Verifies a public or private key set.

```
certutil [options] -verifykeys [keycontainername cacertfile]
```

Where:

- **keycontainername** is the key container name for the key to verify. This option defaults to machine keys. To switch to user keys, use `-user`.

- **cacertfile** signs or encrypts certificate files.

```
[-f] [-user] [-silent] [-config Machine\CAName]
```

#### Remarks

- If no arguments are specified, each signing CA certificate is verified against its private key.

- This operation can only be performed against a local CA or local keys.

### -verify

Verifies a certificate, certificate revocation list (CRL), or certificate chain.

```
certutil [options] -verify certfile [applicationpolicylist | - [issuancepolicylist]]
certutil [options] -verify certfile [cacertfile [crossedcacertfile]]
certutil [options] -verify CRLfile cacertfile [issuedcertfile]
certutil [options] -verify CRLfile cacertfile [deltaCRLfile]
```

Where:

- **certfile** is the name of the certificate to verify.

- **applicationpolicylist** is the optional comma-separated list of required Application Policy ObjectIds.

- **issuancepolicylist** is the optional comma-separated list of required Issuance Policy ObjectIds.

- **cacertfile** is the optional issuing CA certificate to verify against.

- **crossedcacertfile** is the optional certificate cross-certified by **certfile**.

- **CRLfile** is the CRL file used to verify the **cacertfile**.

- **issuedcertfile** is the optional issued certificate covered by the CRLfile.

- **deltaCRLfile** is the optional delta CRL file.

```
[-f] [-enterprise] [-user] [-silent] [-split] [-urlfetch] [-t timeout]
```

#### Remarks

- Using **applicationpolicylist** restricts chain building to only chains valid for the specified Application Policies.

- Using **issuancepolicylist** restricts chain building to only chains valid for the specified Issuance Policies.

- Using **cacertfile**  verifies the fields in the file against **certfile** or **CRLfile**.

- Using **issuedcertfile** verifies the fields in the file against **CRLfile**.

- Using deltaCRLfile verifies the fields in the file against **certfile**.

- If **cacertfile** isn't specified, the full chain is built and verified against **certfile**.

- If **cacertfile** and **crossedcacertfile** are both specified, the fields in both files are verified against **certfile**.

### -verifyCTL

Verifies the AuthRoot or Disallowed Certificates CTL.

```
certutil [options] -verifyCTL CTLobject [certdir] [certfile]
```

Where:

- **CTLobject** identifies the CTL to verify, including:

  - **AuthRootWU** - Reads the AuthRoot CAB and matching certificates from the URL cache. Use `-f` to download from Windows Update instead.

  - **DisallowedWU** - Reads the Disallowed Certificates CAB and disallowed certificate store file from the URL cache. Use `-f` to download from Windows Update instead.

  - **AuthRoot** - Reads the registry-cached AuthRoot CTL. Use with `-f` and an untrusted **certfile** to force the registry cached AuthRoot and Disallowed Certificate CTLs to update.

  - **Disallowed** - Reads the registry-cached Disallowed Certificates CTL. Use with `-f` and an untrusted **certfile** to force the registry cached AuthRoot and Disallowed Certificate CTLs to update.

- **CTLfilename** specifies the file or http path to the CTL or CAB file.

- **certdir** specifies the folder containing certificates matching the CTL entries. Defaults to the same folder or website as the **CTLobject**. Using an http folder path requires a path separator at the end. If you don't specify **AuthRoot** or **Disallowed**, multiple locations will be searched for matching certificates, including local certificate stores, crypt32.dll resources and the local URL cache. Use `-f` to download from Windows Update, as needed.

- **certfile** specifies the certificate(s) to verify. Certificates are matched against CTL entries, displaying the results. This option suppresses most of the default output.

```
[-f] [-user] [-split]
```

### -sign

Re-signs a certificate revocation list (CRL) or certificate.

```
certutil [options] -sign infilelist | serialnumber | CRL outfilelist [startdate+dd:hh] [+serialnumberlist | -serialnumberlist | -objectIDlist | \@extensionfile]
certutil [options] -sign infilelist | serialnumber | CRL outfilelist [#hashalgorithm] [+alternatesignaturealgorithm | -alternatesignaturealgorithm]
```

Where:

- **infilelist** is the comma-separated list of certificate or CRL files to modify and re-sign.

- **serialnumber** is the serial number of the certificate to create. The validity period and other options can't be present.

- **CRL** creates an empty CRL. The validity period and other options can't be present.

- **outfilelist** is the comma-separated list of modified certificate or CRL output files. The number of files must match infilelist.

- **startdate+dd:hh** is the new validity period for the certificate or CRL files, including:

  - optional date plus

  - optional days and hours validity period

  If both are specified, you must use a plus sign (+) separator. Use `now[+dd:hh]` to start at the current time. Use `never` to have no expiration date (for CRLs only).

- **serialnumberlist** is the comma-separated serial number list of the files to add or remove.

- **objectIDlist** is the comma-separated extension ObjectId list of the files to remove.

- **\@extensionfile** is the INF file that contains the extensions to update or remove. For example:

  ```
  [Extensions]
      2.5.29.31 = ; Remove CRL Distribution Points extension
      2.5.29.15 = {hex} ; Update Key Usage extension
      _continue_=03 02 01 86
  ```

- **hashalgorithm** is the name of the hash algorithm. This must only be the text preceded by the `#` sign.

- **alternatesignaturealgorithm** is the alternate signature algorithm specifier.

```
[-nullsign] [-f] [-silent] [-cert certID]
```

#### Remarks

- Using the minus sign (-) removes serial numbers and extensions.

- Using the plus sign (+) adds serial numbers to a CRL.

- You can use a list to remove both serial numbers and ObjectIDs from a CRL at the same time.

- Using the minus sign before **alternatesignaturealgorithm** allows you to use the legacy signature format. Using the plus sign allows you to use the alternate signature format. If you don't specify **alternatesignaturealgorithm**, the signature format in the certificate or CRL is used.

### -vroot

Creates or deletes web virtual roots and file shares.

```
certutil [options] -vroot [delete]
```

### -vocsproot

Creates or deletes web virtual roots for an OCSP web proxy.

```
certutil [options] -vocsproot [delete]
```

### -addenrollmentserver

Add an Enrollment Server application and application pool if necessary, for the specified Certificate Authority. This command does not install binaries or packages.

```
certutil [options] -addenrollmentserver kerberos | username | clientcertificate [allowrenewalsonly] [allowkeybasedrenewal]
```

Where:

- **addenrollmentserver** requires you to use an authentication method for the client connection to the Certificate Enrollment Server, including:

  - **kerberos** uses Kerberos SSL credentials.

  - **username** uses named account for SSL credentials.

  - **clientcertificate** uses X.509 Certificate SSL credentials.

- **allowrenewalsonly** allows only renewal request submissions to the Certificate Authority through the URL.

- **allowkeybasedrenewal** allows use of a certificate with no associated account in Active Directory. This applies when used with **clientcertificate** and **allowrenewalsonly** mode.

```
[-config Machine\CAName]
```

### -deleteenrollmentserver

Deletes an Enrollment Server application and application pool if necessary, for the specified Certificate Authority. This command does not install binaries or packages.

```
certutil [options] -deleteenrollmentserver kerberos | username | clientcertificate
```

Where:

- **deleteenrollmentserver** requires you to use an authentication method for the client connection to the Certificate Enrollment Server, including:

  - **kerberos** uses Kerberos SSL credentials.

  - **username** uses named account for SSL credentials.

  - **clientcertificate** uses X.509 Certificate SSL credentials.

```
[-config Machine\CAName]
```

### -addpolicyserver

Add a Policy Server application and application pool, if necessary. This command does not install binaries or packages.

```
certutil [options] -addpolicyserver kerberos | username | clientcertificate [keybasedrenewal]
```

Where:

- **addpolicyserver** requires you to use an authentication method for the client connection to the Certificate Policy Server, including:

  - **kerberos** uses Kerberos SSL credentials.

  - **username** uses named account for SSL credentials.

  - **clientcertificate** uses X.509 Certificate SSL credentials.

- **keybasedrenewal** allows use of policies returned to the client containing keybasedrenewal templates. This option applies only for **username** and **clientcertificate** authentication.

### -deletepolicyserver

Deletes a Policy Server application and application pool, if necessary. This command does not remove binaries or packages.

certutil [options] -deletePolicyServer kerberos | username | clientcertificate [keybasedrenewal]

Where:

- **deletepolicyserver** requires you to use an authentication method for the client connection to the Certificate Policy Server, including:

  - **kerberos** uses Kerberos SSL credentials.

  - **username** uses named account for SSL credentials.

  - **clientcertificate** uses X.509 Certificate SSL credentials.

- **keybasedrenewal** allows use of a KeyBasedRenewal policy server.

### -oid

Displays the object identifier or set a display name.

```
certutil [options] -oid objectID [displayname | delete [languageID [type]]]
certutil [options] -oid groupID
certutil [options] -oid agID | algorithmname [groupID]
```

Where:

- **objectID** displays or to adds the display name.

- **groupID** is the groupID number (decimal) that objectIDs enumerate.

- **algID** is the hexadecimal ID that objectID looks up.

- **algorithmname** is the algorithm name that objectID looks up.

- **displayname** displays the name to store in DS.

- **delete** deletes the display name.

- **LanguageId** is the language ID value (defaults to current: 1033).

- **Type** is the type of DS object to create, including:

  - `1` - Template (default)

  - `2` - Issuance Policy

  - `3` - Application Policy

- `-f` creates a DS object.

### -error

Displays the message text associated with an error code.

```
certutil [options] -error errorcode
```

### -getreg

Displays a registry value.

```
certutil [options] -getreg [{ca | restore | policy | exit | template | enroll |chain | policyservers}\[progID\]][registryvaluename]
```

Where:

- **ca** uses a Certificate Authority's registry key.

- **restore** uses Certificate Authority's restore registry key.

- **policy** uses the policy module's registry key.

- **exit** uses the first exit module's registry key.

- **template** uses the template registry key (use `-user` for user templates).

- **enroll** uses the enrollment registry key (use `-user` for user context).

- **chain** uses the chain configuration registry key.

- **policyservers** uses the Policy Servers registry key.

- **progID** uses the policy or exit module's ProgID (registry subkey name).

- **registryvaluename** uses the registry value name (use `Name*` to prefix match).

- **value** uses the new numeric, string or date registry value or filename. If a numeric value starts with `+` or `-`, the bits specified in the new value are set or cleared in the existing registry value.

```
[-f] [-user] [-grouppolicy] [-config Machine\CAName]
```

#### Remarks

- If a string value starts with `+` or `-`, and the existing value is a `REG_MULTI_SZ` value, the string is added to or removed from the existing registry value. To force creation of a `REG_MULTI_SZ` value, add `\n` to the end of the string value.

- If the value starts with `\@`, the rest of the value is the name of the file containing the hexadecimal text representation of a binary value. If it doesn't refer to a valid file, it's instead parsed as `[Date][+|-][dd:hh]` - an optional date plus or minus optional days and hours. If both are specified, use a plus sign (+) or minus sign (-) separator. Use `now+dd:hh` for a date relative to the current time.

- Use `chain\chaincacheresyncfiletime \@now` to effectively flush cached CRLs.

### -setreg

Sets a registry value.

```
certutil [options] -setreg [{ca | restore | policy | exit | template | enroll |chain | policyservers}\[progID\]]registryvaluename value
```

Where:

- **ca** uses a Certificate Authority's registry key.

- **restore** uses Certificate Authority's restore registry key.

- **policy** uses the policy module's registry key.

- **exit** uses the first exit module's registry key.

- **template** uses the template registry key (use `-user` for user templates).

- **enroll** uses the enrollment registry key (use `-user` for user context).

- **chain** uses the chain configuration registry key.

- **policyservers** uses the Policy Servers registry key.

- **progID** uses the policy or exit module's ProgID (registry subkey name).

- **registryvaluename** uses the registry value name (use `Name*` to prefix match).

- **value** uses the new numeric, string or date registry value or filename. If a numeric value starts with `+` or `-`, the bits specified in the new value are set or cleared in the existing registry value.

```
[-f] [-user] [-grouppolicy] [-config Machine\CAName]
```

#### Remarks

- If a string value starts with `+` or `-`, and the existing value is a `REG_MULTI_SZ` value, the string is added to or removed from the existing registry value. To force creation of a `REG_MULTI_SZ` value, add `\n` to the end of the string value.

- If the value starts with `\@`, the rest of the value is the name of the file containing the hexadecimal text representation of a binary value. If it doesn't refer to a valid file, it's instead parsed as `[Date][+|-][dd:hh]` - an optional date plus or minus optional days and hours. If both are specified, use a plus sign (+) or minus sign (-) separator. Use `now+dd:hh` for a date relative to the current time.

- Use `chain\chaincacheresyncfiletime \@now` to effectively flush cached CRLs.

### -delreg

Deletes a registry value.

```
certutil [options] -delreg [{ca | restore | policy | exit | template | enroll |chain | policyservers}\[progID\]][registryvaluename]
```

Where:

- **ca** uses a Certificate Authority's registry key.

- **restore** uses Certificate Authority's restore registry key.

- **policy** uses the policy module's registry key.

- **exit** uses the first exit module's registry key.

- **template** uses the template registry key (use `-user` for user templates).

- **enroll** uses the enrollment registry key (use `-user` for user context).

- **chain** uses the chain configuration registry key.

- **policyservers** uses the Policy Servers registry key.

- **progID** uses the policy or exit module's ProgID (registry subkey name).

- **registryvaluename** uses the registry value name (use `Name*` to prefix match).

- **value** uses the new numeric, string or date registry value or filename. If a numeric value starts with `+` or `-`, the bits specified in the new value are set or cleared in the existing registry value.

```
[-f] [-user] [-grouppolicy] [-config Machine\CAName]
```

#### Remarks

- If a string value starts with `+` or `-`, and the existing value is a `REG_MULTI_SZ` value, the string is added to or removed from the existing registry value. To force creation of a `REG_MULTI_SZ` value, add `\n` to the end of the string value.

- If the value starts with `\@`, the rest of the value is the name of the file containing the hexadecimal text representation of a binary value. If it doesn't refer to a valid file, it's instead parsed as `[Date][+|-][dd:hh]` - an optional date plus or minus optional days and hours. If both are specified, use a plus sign (+) or minus sign (-) separator. Use `now+dd:hh` for a date relative to the current time.

- Use `chain\chaincacheresyncfiletime \@now` to effectively flush cached CRLs.

### -importKMS

Imports user keys and certificates into the server database for key archival.

```
certutil [options] -importKMS userkeyandcertfile [certID]
```

Where:

- **userkeyandcertfile** is a data file with user private keys and certificates that are to be archived. This file can be:

  - An Exchange Key Management Server (KMS) export file.

  - A PFX file.

- certID is a KMS export file decryption certificate match token. For more info, see the `-store` parameter in this article.

- `-f` imports certificates not issued by the Certificate Authority.

```
[-f] [-silent] [-split] [-config Machine\CAName] [-p password] [-symkeyalg symmetrickeyalgorithm[,keylength]]
```

### -importcert

Imports a certificate file into the database.

```
certutil [options] -importcert certfile [existingrow]
```

Where:

- **existingrow** imports the certificate in place of a pending request for the same key.

- `-f` imports certificates not issued by the Certificate Authority.

```
[-f] [-config Machine\CAName]
```

#### Remarks

The Certificate Authority may also need to be configured to support foreign certificates. To do this, type `import - certutil -setreg ca\KRAFlags +KRAF_ENABLEFOREIGN`.

### -getkey

Retrieves an archived private key recovery blob, generates a recovery script, or recovers archived keys.

```
certutil [options] -getkey searchtoken [recoverybloboutfile]
certutil [options] -getkey searchtoken script outputscriptfile
certutil [options] -getkey searchtoken retrieve | recover outputfilebasename
```

Where:

- **script** generates a script to retrieve and recover keys (default behavior if multiple matching recovery candidates are found, or if the output file is not specified).

- **retrieve** retrieves one or more Key Recovery Blobs (default behavior if exactly one matching recovery candidate is found, and if the output file is specified). Using this option truncates any extension and appends the certificate-specific string and the .rec extension for each key recovery blob.  Each file contains a certificate chain and an associated private key, still encrypted to one or more Key Recovery Agent certificates.

- **recover** retrieves and recovers private keys in one step (requires Key Recovery Agent certificates and private keys). Using this option truncates any extension and appends the .p12 extension.  Each file contains the recovered certificate chains and associated private keys, stored as a PFX file.

- **searchtoken** selects the keys and certificates to be recovered, including:

  - 1. Certificate Common Name

  - 2. Certificate Serial Number

  - 3. Certificate SHA-1 hash (thumbprint)

  - 4. Certificate KeyId SHA-1 hash (Subject Key Identifier)

  - 5. Requester Name (domain\user)

  - 6. UPN (user\@domain)

- **recoverybloboutfile** outputs a file with a certificate chain and an associated private key, still encrypted to one or more Key Recovery Agent certificates.

- **outputscriptfile** outputs a file with a batch script to retrieve and recover private keys.

- **outputfilebasename** outputs a file base name.

```
[-f] [-unicodetext] [-silent] [-config Machine\CAName] [-p password] [-protectto SAMnameandSIDlist] [-csp provider]
```

### -recoverkey

Recover an archived private key.

```
certutil [options] -recoverkey recoveryblobinfile [PFXoutfile [recipientindex]]
```

```
[-f] [-user] [-silent] [-split] [-p password] [-protectto SAMnameandSIDlist] [-csp provider] [-t timeout]
```

### -mergePFX

Merges PFX files.

```
certutil [options] -mergePFX PFXinfilelist PFXoutfile [extendedproperties]
```

Where:

- **PFXinfilelist** is a comma-separated list of PFX input files.

- **PFXoutfile** is the name of the PFX output file.

- **extendedproperties** includes any extended properties.

```
[-f] [-user] [-split] [-p password] [-protectto SAMnameAndSIDlist] [-csp provider]
```

#### Remarks

- The password specified on the command line must be a comma-separated password list.

- If more than one password is specified, the last password is used for the output file. If only one password is provided or if the last password is `*`, the user will be prompted for the output file password.

### -convertEPF

Converts a PFX file into an EPF file.

```
certutil [options] -convertEPF PFXinfilelist PFXoutfile [cast | cast-] [V3CAcertID][,salt]
```

Where:


- **PFXinfilelist** is a comma-separated list of PFX input files.

- **PFXoutfile** is the name of the PFX output file.

- **EPF** is the name of the EPF output file.

- **cast** uses CAST 64 encryption.

- **cast-** uses CAST 64 encryption (export)

- **V3CAcertID** is the V3 CA certificate match token. For more info, see the `-store` parameter in this article.

- **salt** is the EPF output file salt string.

```
[-f] [-silent] [-split] [-dc DCName] [-p password] [-csp provider]
```

#### Remarks

- The password specified on the command line must be a comma-separated password list.

- If more than one password is specified, the last password is used for the output file. If only one password is provided or if the last password is `*`, the user will be prompted for the output file password.

### -?

Displays the list of parameters.

```
certutil -?
certutil <name_of_parameter> -?
certutil -? -v
```

Where:

- **-?** displays the full list of parameters

- **-`<name_of_parameter>` -?** displays help content for the specified parameter.

- **-? -v** displays a full list of parameters and options.

## Options

This section defines all of the options you're able to specify, based on the command. Each parameter includes information about which options are valid for use.

| Options | Description |
| ------- | ----------- |
| -nullsign | Use the hash of the data as a signature. |
| -f | Force overwrite. |
| -enterprise | Use the local machine enterprise registry certificate store. |
| -user | Use the HKEY_CURRENT_USER keys or certificate store. |
| -GroupPolicy | Use the group policy certificate store. |
| -ut | Display user templates. |
| -mt | Display machine templates. |
| -Unicode | Write redirected output in Unicode. |
| -UnicodeText | Write output file in Unicode. |
| -gmt | Display times using GMT. |
| -seconds | Display times using seconds and milliseconds. |
| -silent | Use the `silent` flag to acquire crypt context. |
| -split | Split embedded ASN.1 elements, and save to files. |
| -v | Provide more detailed (verbose) information. |
| -privatekey | Display password and private key data. |
| -pin PIN | Smart card PIN. |
| -urlfetch | Retrieve and verify AIA Certs and CDP CRLs. |
| -config Machine\CAName | Certificate Authority and computer name string. |
| -policyserver URLorID | Policy Server URL or ID. For selection U/I, use `-policyserver`. For all Policy Servers, use `-policyserver *`|
| -anonymous | Use anonymous SSL credentials. |
| -kerberos | Use Kerberos SSL credentials. |
| -clientcertificate clientcertID | Use X.509 Certificate SSL credentials. For selection U/I, use `-clientcertificate`. |
| -username username | Use named account for SSL credentials. For selection U/I, use `-username`. |
| -cert certID | Signing certificate. |
| -dc DCName | Target a specific Domain Controller. |
| -restrict restrictionlist | Comma-separated Restriction List. Each restriction consists of a column name, a relational operator and a constant integer, string or date. One column name may be preceded by a plus or minus sign to indicate the sort order. For example: `requestID = 47`, `+requestername >= a, requestername`, or `-requestername > DOMAIN, Disposition = 21` |
| -out columnlist | Comma-separated column list. |
| -p password | Password |
| -protectto SAMnameandSIDlist | Comma-separated SAM name/SID list. |
| -csp provider | Provider |
| -t timeout | URL fetch timeout in milliseconds. |
| -symkeyalg symmetrickeyalgorithm[,keylength] | Name of the Symmetric Key Algorithm with optional key length. For example: `AES,128` or `3DES` |

### Additional References

For some more examples about how to use this command, see

- [Certutil Examples for Managing Active Directory Certificate Services (AD CS) from the Command Line](https://social.technet.microsoft.com/wiki/contents/articles/3063.certutil-examples-for-managing-active-directory-certificate-services-ad-cs-from-the-command-line.aspx)

- [Certutil tasks for managing certificates](https://docs.microsoft.com/previous-versions/orphan-topics/ws.10/cc772898(v=ws.10))

- [Binary Request Export Using the certutil.exe Command-Line Tool Walkthrough](https://social.technet.microsoft.com/wiki/contents/articles/7573.active-directory-certificate-services-pki-key-archival-and-management.aspx)

- [Root CA certificate renewal](https://social.technet.microsoft.com/wiki/contents/articles/2016.root-ca-certificate-renewal.aspx)

- [certutil command](certutil.md)
