---
title: Customize HTTP security response headers with AD FS
description: Learn how to customize security headers to protect against security vulnerabilities with AD FS 2019.
author: billmath
ms.author: wscontent
manager: amycolannino
ms.reviewer: akgoel23
ms.date: 06/14/2023
ms.topic: article
---

# Customize HTTP security response headers with AD FS 2019

Active Directory Federation Services (AD FS) 2019 adds the functionality to customize the HTTP security response headers sent by AD FS. These tools help administrators protect against common security vulnerabilities and allow them to take advantage of the latest advancements in browser-based protection mechanisms. This feature comes from the introduction of two new cmdlets: `Get-AdfsResponseHeaders` and `Set-AdfsResponseHeaders`.

> [!NOTE]
> The functionality to customize the HTTP security response headers (except CORS Headers) by using cmdlets: `Get-AdfsResponseHeaders` and `Set-AdfsResponseHeaders` was backported to AD FS 2016. You can add the functionality to your AD FS 2016 by installing [KB4493473](https://support.microsoft.com/help/4493473/windows-10-update-kb4493473) and [KB4507459](https://support.microsoft.com/help/4507459/windows-10-update-kb4507459).

This article discusses commonly used security response headers to demonstrate how to customize headers sent by AD FS 2019.

> [!NOTE]
> The article assumes that you installed AD FS 2019.

## Scenarios

The following scenarios demonstrate the need admins might have to customize security headers.

- An administrator enabled [HTTP Strict-Transport-Security (HSTS)](#http-strict-transport-security-hsts) to protect the users who might access the web app by using HTTP from a public wifi access point that might be hacked. HSTS forces all connections over HTTPS encryption. They would like to further strengthen security by enabling HSTS for subdomains.
- An administrator configured the [X-Frame-Options](#x-frame-options) response header to protect the web pages from being clickjacked. X-Frame-Options prevents rendering any web page in an iFrame. However, they need to customize the header value due to a new business requirement to display data (in iFrame) from an application with a different origin (domain).
- An administrator enabled [X-XSS-Protection](#x-xss-protection) to sanitize and block the page if browser detects cross scripting attacks. X-XSS-Protection prevents cross scripting attacks. However, they need to customize header to allow the page to load after it's sanitized.
- An administrator needs to enable [Cross Origin Resource Sharing (CORS)](#cross-origin-resource-sharing-cors-headers), and they need to set the origin (domain) on AD FS to allow a single page application to access a web API with another domain.
- An Administrator enabled the [Content Security Policy (CSP)](#content-security-policy-csp) header to prevent cross site scripting and data injection attacks by disallowing any cross-domain requests. However, due to a new business requirement they need to customize the header to allow web page to load images from any origin and restrict media to trusted providers.

## HTTP security response headers

AD FS includes the response headers in the outgoing HTTP response sent a web browser. You can list the headers by using the `Get-AdfsResponseHeaders` cmdlet as shown in the following screenshot.

:::image type="content" source="media/customize-http-security-headers-ad-fs/header1.png" alt-text="Screenshot that shows the PowerShell output from Get-AdfsResponseHeaders." lightbox="media/customize-http-security-headers-ad-fs/header1.png":::

The **ResponseHeaders** attribute in the screenshot identifies the security headers included by AD FS in every HTTP response. AD FS sends the response headers only if **ResponseHeadersEnabled** is set to `True` (default value). The value can be set to `False` to prevent AD FS including any of the security headers in the HTTP response. However, this setting isn't recommended. You can set **ResponseHeaders** to `False` with the following command:

```powershell
Set-AdfsResponseHeaders -EnableResponseHeaders $false
```

### HTTP Strict-Transport-Security (HSTS)

HTTP Strict-Transport-Security (HSTS) is a web security policy mechanism, which helps mitigate protocol downgrade attacks and cookie hijacking for services that have both HTTP and HTTPS endpoints. It allows web servers to declare that web browsers, or other complying user agents, should only interact with it by using HTTPS and never via the HTTP protocol.

All AD FS endpoints for web authentication traffic are opened exclusively over HTTPS. As a result, AD FS effectively mitigates the threats that HTTP Strict Transport Security policy mechanism provides. By default, there's no downgrade to HTTP since there are no listeners in HTTP. The header can be customized by setting the following parameters:

- **max-age=&lt;expire-time&gt;**. The expiry time (in seconds) specifies how long the site should only be accessed using HTTPS. The default and recommended value is 31536000 seconds (one year).
- **includeSubDomains**. This parameter is optional. If specified, the HSTS rule applies to all subdomains as well.

#### HSTS customization

By default, the header is enabled and `max-age` is set to one year; however, administrators can modify the `max-age` (lowering max-age value isn't recommended) or enable HSTS for subdomains through the **Set-AdfsResponseHeaders** cmdlet.

```powershell
Set-AdfsResponseHeaders -SetHeaderName "Strict-Transport-Security" -SetHeaderValue "max-age=<seconds>; includeSubDomains"
```

Example:

```powershell
Set-AdfsResponseHeaders -SetHeaderName "Strict-Transport-Security" -SetHeaderValue "max-age=31536000; includeSubDomains"
 ```

By default, the header is included in the **ResponseHeaders** attribute; however, administrators can remove the header through the `Set-AdfsResponseHeaders` cmdlet.

```powershell
Set-AdfsResponseHeaders -RemoveHeaders "Strict-Transport-Security"
```

### X-Frame-Options

AD FS by default doesn't allow external applications to use iFrames when performing interactive sign in. This configuration prevents certain style of phishing attacks. Non-interactive sign-in can be performed via iFrame due to prior session level security that has been established.

However, in certain rare cases you might trust a specific application that requires an iFrame capable interactive AD FS sign-in page. The `X-Frame-Options` header is used for this purpose.

This HTTP security response header is used to communicate to the browser whether it can render a page in a &lt;frame&gt;/&lt;iframe&gt;. The header can be set to one of the following values:

- **deny**. The page in a frame isn't displayed. This configuration is the default and recommended setting.
- **sameorigin**. The page is only displayed in the frame if the origin is the same as the origin of the web page. The option isn't useful unless all ancestors are also in the same origin.
- **allow-from \<specified origin>**. The page is only displayed in the frame if the origin (for example, `https://www.".com`) matches the specific origin in the header. Some browsers might not support this option.

#### X-Frame-Options customization

By default, the header is set to deny; however, admins can modify the value through the `Set-AdfsResponseHeaders` cmdlet.

```powershell
Set-AdfsResponseHeaders -SetHeaderName "X-Frame-Options" -SetHeaderValue "<deny/sameorigin/allow-from<specified origin>>"
 ```

Example:

```powershell
Set-AdfsResponseHeaders -SetHeaderName "X-Frame-Options" -SetHeaderValue "allow-from https://www.example.com"
 ```

By default, the header is included in the **ResponseHeaders** attribute; however, administrators can remove the header through the `Set-AdfsResponseHeaders` cmdlet.

```powershell
Set-AdfsResponseHeaders -RemoveHeaders "X-Frame-Options"
```

### X-XSS-Protection

This HTTP security response header is used to stop web pages from loading when browsers detect cross-site scripting (XSS) attacks. This approach is referred to as XSS filtering. The header can be set to one of the following values:

- **0** disables XSS filtering. Not recommended.
- **1** enables XSS filtering. If an XSS attack is detected, the browser sanitizes the page.
- **1; mode=block** enables XSS filtering. If an XSS attack is detected, the browser prevents rendering of the page. This setting is the default and recommended setting.

#### X-XSS-Protection customization

By default, the header is set to **1; mode=block;**. However, administrators can modify the value through the `Set-AdfsResponseHeaders` cmdlet.

```powershell
Set-AdfsResponseHeaders -SetHeaderName "X-XSS-Protection" -SetHeaderValue "<0/1/1; mode=block/1; report=<reporting-uri>>"
```

Example:

```powershell
Set-AdfsResponseHeaders -SetHeaderName "X-XSS-Protection" -SetHeaderValue "1"
 ```

By default, the header is included in the **ResponseHeaders** attribute; however, admins can remove the header through the `Set-AdfsResponseHeaders` cmdlet.

```powershell
Set-AdfsResponseHeaders -RemoveHeaders "X-XSS-Protection"
```

### Cross Origin Resource Sharing (CORS) headers

Web browser security prevents a web page from making cross-origin requests initiated from within scripts. However, you might want to access resources in other origins (domains). Cross Origin Resource Sharing (CORS) is a W3C standard that allows a server to relax the same-origin policy. By using CORS, a server can explicitly allow some cross-origin requests while rejecting others.

To better understand a CORS request, the following scenario walks through an instance where a single page application (SPA) needs to call a web API with a different domain. Further, consider that both SPA and API are configured on AD FS 2019 and AD FS has CORS enabled. AD FS can identify CORS headers in the HTTP request, validate header values, and include appropriate CORS headers in the response. For details on how to enable and configure CORS on AD FS 2019, see [CORS Customization section](#cors-customization). The following sample flow walks you through the scenario:

1. A user accesses SPA through the client browser and is redirected to AD FS auth endpoint for authentication. Since SPA is configured for implicit grant flow, the request returns an Access + ID token to the browser after successful authentication.
1. After user authentication, the front-end JavaScript included in SPA makes a request to access the web API. The request is redirected to AD FS with following headers:
    - Options - describes the communication options for the target resource.
    - Origin - includes the origin of the web API.
    - Access-Control-Request-Method - identifies the HTTP method (for example, DELETE) to be used when an actual request is made.
    - Access-Control-Request-Headers - identifies the HTTP headers to be used when an actual request is made.

   > [!NOTE]
   > A CORS request resembles a standard HTTP request. However, the presence of an origin header signals the incoming request is CORS related.
1. AD FS verifies that the web API origin included in the header is listed in the trusted origins configured in AD FS. For more information on how to modify trusted origins, see [CORS Customization](#cors-customization). AD FS then responds with the following headers:
    - Access-Control-Allow-Origin - value same as in the Origin header.
    - Access-Control-Allow-Method - value same as in the Access-Control-Request-Method header.
    - Access-Control-Allow-Headers - value same as in the Access-Control-Request-Headers header.
1. The browser sends the actual request including the following headers:
    - HTTP method (for example, DELETE).
    - Origin – includes the origin of the web API.
    - All headers included in the Access-Control-Allow-Headers response header.
1. After it's verified, AD FS approves the request by including the web API domain (origin) in the Access-Control-Allow-Origin response header.
1. The inclusion of the Access-Control-Allow-Origin header allows the browser to call the requested API.

#### CORS customization

By default, CORS functionality isn't enabled; however, admins can enable the functionality through the `Set-AdfsResponseHeaders` cmdlet.

```powershell
Set-AdfsResponseHeaders -EnableCORS $true
 ```

After it's enabled, admins can enumerate a list of trusted origins by using the same cmdlet. For instance, the following command would allow CORS requests from the origins `https&#58;//example1.com` and `https&#58;//example1.com`.

```powershell
Set-AdfsResponseHeaders -CORSTrustedOrigins https://example1.com,https://example2.com
 ```

> [!NOTE]
> Admins can allow CORS requests from any origin by including "*" in the list of trusted origins, although this approach isn't recommended due to security vulnerabilities and a warning message is provided if they choose to.

### Content Security Policy (CSP)

This HTTP security response header is used to prevent cross-site scripting, clickjacking, and other data injection attacks by preventing browsers from inadvertently executing malicious content. Browsers that don't support Content Security Policy (CSP) ignore the CSP response headers.

#### CSP customization

Customization of the CSP header involves modifying the security policy that defines the resources that the browser is allowed to load for the web page. The default security policy is:

`Content-Security-Policy: default-src 'self' 'unsafe-inline' 'unsafe-eval'; img-src 'self' data:;`

The **default-src** directive is used to modify [-src directives](https://developer.mozilla.org/docs/Web/HTTP/Headers/Content-Security-Policy/default-src) without listing each directive explicitly. For instance, in the following example, the policy 1 is same as policy 2.

Policy 1

```powershell
Set-AdfsResponseHeaders -SetHeaderName "Content-Security-Policy" -SetHeaderValue "default-src 'self'"
```

Policy 2

```powershell
Set-AdfsResponseHeaders -SetHeaderName "Content-Security-Policy" -SetHeaderValue "script-src 'self'; img-src 'self'; font-src 'self';
frame-src 'self'; manifest-src 'self'; media-src 'self';"
```

If a directive is explicitly listed, the specified value overrides the value given for default-src. In the following example, the img-src takes the value as '*' (allowing images to be loaded from any origin) while other -src directives take the value as 'self' (restricting to same origin as the web page).

```powershell
Set-AdfsResponseHeaders -SetHeaderName "Content-Security-Policy" -SetHeaderValue "default-src 'self'; img-src *"
```

The following sources can be defined for the default-src policy:

- 'self' - specifying this source restricts the origin of the content to load to the origin of the web page.
- 'unsafe-inline' - specifying this source in the policy allows the use of inline JavaScript and CSS.
- 'unsafe-eval' - specifying this source in the policy allows the use of text to JavaScript mechanisms like eval.
- 'none' - specifying this source restricts the content from any origin to load.
- data: - specifying data: URIs allow content creators to embed small files inline in documents. Usage not recommended.

> [!NOTE]
> AD FS uses JavaScript in the authentication process and therefore enables JavaScript by including 'unsafe-inline' and 'unsafe-eval' sources in default policy.

### Custom headers

In addition to the previously listed security response headers (HSTS, CSP, X-Frame-Options, X-XSS-Protection and CORS), AD FS 2019 enables you to set new headers.

As an example, you could set a new header "TestHeader" and "TestHeaderValue" as the value.

```powershell
Set-AdfsResponseHeaders -SetHeaderName "TestHeader" -SetHeaderValue "TestHeaderValue"
 ```

After it's set, the new header is sent in the AD FS response, as shown in the following Fiddler snippet:

:::image type="content" source="media/customize-http-security-headers-ad-fs/header2.png" alt-text="Screenshot of Fiddler on the headers tab that highlights TestHeader: TestHeaderValue under Miscellaneous.":::

## Web browser compatibility

Use the following table and links to determine which web browsers are compatible with each of the security response headers.

|HTTP Security Response Headers|Browser Compatibility|
|-----|-----|
|HTTP Strict-Transport-Security (HSTS)|[HSTS browser compatibility](https://developer.mozilla.org/docs/Web/HTTP/Headers/Strict-Transport-Security#Browser_compatibility)|
|X-Frame-Options|[X-Frame-Options browser compatibility](https://developer.mozilla.org/docs/Web/HTTP/Headers/X-Frame-Options#Browser_compatibility)|
|X-XSS-Protection|[X-XSS-Protection browser compatibility](https://developer.mozilla.org/docs/Web/HTTP/Headers/X-XSS-Protection#Browser_compatibility)|
|Cross Origin Resource Sharing (CORS)|[CORS browser compatibility](https://developer.mozilla.org/docs/Web/HTTP/CORS#Browser_compatibility)
|Content Security Policy (CSP)|[CSP browser compatibility](https://developer.mozilla.org/docs/Web/HTTP/CSP#Browser_compatibility)

## Next

- [Use AD FS Help troubleshooting guides](https://aka.ms/adfshelp/troubleshooting )
- [AD FS Troubleshooting](../../ad-fs/troubleshooting/ad-fs-tshoot-overview.md)
