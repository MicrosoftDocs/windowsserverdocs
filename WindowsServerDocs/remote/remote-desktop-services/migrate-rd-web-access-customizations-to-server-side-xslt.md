---
title: Migrate RD Web Access XSLT Customizations
description: Migrate RD Web Access customizations to server-side XSLT before browser-native XSLT ends. Learn to configure, validate, and troubleshoot the migration.
author: robinharwood
ms.author: roharwoo
ms.date: 11/17/2026
ms.topic: upgrade-and-migration-article
ai-usage: ai-generated

#customer intent: As a Remote Desktop Services administrator or customization vendor, I want to migrate RD Web Access customizations to server-side XSLT so that the site continues to render in all browsers.
---

# Migrate RD Web Access customizations to server-side XSLT

Use this article to migrate Remote Desktop Web Access (RD Web Access) customizations that depend on browser-native XSLT to server-side XSLT. Chromium milestone 158 (M158) disables browser-native XSLT beginning November 17, 2026, so customizations that transform XML into HTML by using `Site.xsl` might stop rendering. Deployments that use the default RD Web Access site require no action.

Use this article to assess an existing RD Web Access customization, migrate it to server-side XSLT rendering, and validate the result. The server-side renderer uses the .NET `XslCompiledTransform` class without changing `Site.xsl`. This guidance applies to the RD Web Access Pages experience in all supported Windows Server releases. It doesn't apply to the Remote Desktop web client. Because the transformation happens on the server, the result doesn't depend on browser-native XSLT support.

## Prerequisites

- An account with administrative access to the RD Web Access server and permission to modify the RD Web Access application configuration in Internet Information Services (IIS).
- Access to the RD Web Access application configuration, pages, and stylesheets.
- A nonproduction test environment in which you can validate sign-in, published resources, and password change.
- A current backup of the RD Web Access configuration and customized files for reference.

## Understand the supported migration path

The updated `Default.aspx`, `login.aspx`, `Desktops.aspx`, and `password.aspx` files each call the server-side renderer:

```csharp
SiteXsltRenderer.RenderPage(this, writer, base.Render)
```

The renderer buffers the XML that the page normally produces and transforms it with `Site.xsl`, or with a stylesheet that you configure separately. A successful transform returns UTF-8 HTML. If the stylesheet doesn't compile or the transform fails, RD Web Access logs the error and returns the original XML.

The supported migration path is to keep the updated, shipped `.aspx` pages unchanged and put branding or other supported customization in a separate XSLT stylesheet. Select that stylesheet with the `RDWebSiteXsltPath` application setting. This approach preserves the localized markup from the stock stylesheet and avoids changes to operating system-owned files.

> [!WARNING]
> Never restore an older `Default.aspx`, `login.aspx`, `Desktops.aspx`, or `password.aspx` file over an updated page. An older page doesn't call `SiteXsltRenderer.RenderPage`, so restoring it removes server-side rendering. Don't modify the shipped `.aspx` files. `RDWebSiteXsltPath` can't compensate for a page that no longer invokes the renderer.

## Assess the existing customization

Before you migrate, complete this manual assessment on each RD Web Access application:

1. Compare `Default.aspx`, `login.aspx`, `Desktops.aspx`, and `password.aspx` with the currently shipped files. Record any page markup changes or restored older files.
1. Determine whether anyone edited `Site.xsl` directly.
1. Check whether a separate stylesheet is present and whether an `.aspx` page changes the `xml-stylesheet` `href` to point to it.
1. In IIS Manager, inspect the RD Web Access application and its parent sites for HTTP Redirect and URL Rewrite rules that target `Site.xsl` or another `.xsl` file.
1. Inspect each customized stylesheet for `msxsl:script`, network `xsl:import` or `xsl:include`, network `document()` calls, or XSLT 2.0 or 3.0 features.
1. Identify scripts, monitoring systems, and other tools that expect the original RD Web Access XML response.
1. Use the following table to select the migration action.

| Existing deployment | Server-side behavior | Migration action |
|---|---|---|
| Stock site | The shipped `Site.xsl` continues to render the site. | No action is necessary. Validate the site after the update. |
| Direct edits to `Site.xsl` | The edits continue to render, but servicing can replace this operating system-owned file. | Move the edits to a separate stylesheet and configure `RDWebSiteXsltPath`. |
| Separate stylesheet selected by an edited page `href` | The server-side renderer doesn't use the edited browser-side pointer. | Keep the updated page unchanged and select the stylesheet with `RDWebSiteXsltPath`. |
| Markup edits in an `.aspx` page | RD Web Access doesn't support changes to shipped pages, which can remove the renderer. | Remove the dependency on page edits. Keep the updated shipped pages and move supported customization into a separate stylesheet. |
| IIS HTTP Redirect or URL Rewrite rule for `Site.xsl` | The renderer doesn't invoke the rule because it reads the stylesheet from disk instead of making an HTTP request. | Remove the rule dependency and point `RDWebSiteXsltPath` at the intended local stylesheet. |
| Script or tool that consumes RD Web Access XML | The default browser response is HTML after server-side transformation. | Request the original XML with `?rdwaformat=xml`. |
| Stylesheet that uses unsupported XSLT features | Compilation or transformation fails and RD Web Access falls back to XML. | Remove or rework the unsupported features before migration. |

## Prepare for migration

1. Back up the current application configuration, `.aspx` pages, and stylesheets for comparison and reference.
1. Record the current stylesheet location and any IIS redirect or rewrite rule that affects `.xsl` requests.
1. Record every XML-consuming integration and the URL that it requests.
1. Make a working copy of customized XSLT content. Don't plan to restore backed-up `.aspx` pages over the serviced pages.
1. Refactor unsupported stylesheet features according to [Review XSLT compatibility](#review-xslt-compatibility).
1. Schedule testing of all four updated pages and representative user workflows.

## Configure `RDWebSiteXsltPath` for a separate XSLT stylesheet

Add `RDWebSiteXsltPath` to the `appSettings` section of an applicable `web.config` file. For example:

```xml
<appSettings>
  <add key="RDWebSiteXsltPath" value="~/Pages/SiteLayout.xsl" />
</appSettings>
```

ASP.NET `appSettings` values inherit from a parent `web.config` file. You can therefore store the setting outside the operating system-managed `Pages` directory while keeping the stylesheet in a supported local location.

`RDWebSiteXsltPath` accepts either of these explicit virtual path forms:

- An application-relative path that begins with `~/`, such as `~/Pages/SiteLayout.xsl`.
- A virtual path that begins with a single `/`.

The setting rejects physical paths, Universal Naming Convention (UNC) paths, and unanchored relative values. These restrictions keep stylesheet access within the application's supported local boundaries. If the value is missing or invalid, RD Web Access logs an error and falls back to the shipped `Site.xsl`.

`RDWebSiteXsltPath` is one application-wide value. It can't select a different stylesheet for each language. To preserve localized content, base customizations on the stock XSLT output rather than replacing localized markup through edited `.aspx` pages.

## Remove dependencies on IIS stylesheet rules

IIS HTTP Redirect and URL Rewrite rules for `Site.xsl` work only when the browser requests the stylesheet over HTTP. With server-side transformation, no HTTP request for `Site.xsl` occurs.

1. Identify the local stylesheet that the redirect or rewrite rule selects.
1. Set `RDWebSiteXsltPath` to the supported virtual path for that stylesheet.
1. Remove the customization's dependency on the redirect or rewrite rule.
1. Browse the RD Web Access website and confirm that it renders and works properly.

## Review XSLT compatibility

The server-side renderer uses .NET `XslCompiledTransform` and supports XSLT 1.0.

| Capability | Support |
|---|---|
| Ordinary XSLT 1.0 features | Supported |
| Local-file-system `xsl:import` and `xsl:include` | Supported |
| Local `document()` reads within allowed directories | Supported |
| `msxsl:script` | Unsupported |
| Network `xsl:import` and `xsl:include` | Unsupported |
| Network `document()` | Unsupported |
| XSLT 2.0 or XSLT 3.0 | Unsupported |

The `document()` function never fetches network content. It can use subdirectories and HTTP-shaped `$baseurl` references, but it uses only the path portion of those references. Reads must remain within the RD Web Access application directory or the configured stylesheet directory. RD Web Access rejects paths that escape these trusted directories and reads of `.config` files.

RD Web Access caches compiled stylesheets. When the stylesheet timestamp changes, RD Web Access recompiles it, so you don't need to recycle the application pool after editing a stylesheet. RD Web Access logs compile or transform failures and returns the original XML. That XML doesn't render as the RD Web Access page after Chromium removes browser-side XSLT.

## Request original RD Web Access XML with `?rdwaformat=xml`

Append `?rdwaformat=xml` to an RD Web Access page URL when a script, monitoring system, or tool must receive the original XML. This per-request option overrides content negotiation and skips server-side transformation.

Browser `Accept` headers and ambiguous `Accept` headers resolve to HTML. A client that sends an explicit XML-only `Accept` header might receive XML, but `?rdwaformat=xml` is the explicit and predictable option for an XML-consuming integration.

## Validate the RD Web Access server-side XSLT migration

Functionally validate each customized RD Web Access page and representative user workflow:

1. In a browser, open `Default.aspx`, `login.aspx`, `Desktops.aspx`, and `password.aspx` as applicable. Confirm that each page shows rendered HTML instead of raw XML.
1. Confirm that the expected branding and custom behavior appear and work on each customized page.
1. Sign in and verify that resource lists and folders appear as expected.
1. Confirm that RemoteApp icons load and that you can start published resources.
1. If the deployment supports password changes, complete a password-change test.

## Temporarily disable RD Web Access server-side XSLT with `RDWebEnableServerSideXslt=false`

`RDWebEnableServerSideXslt=false` is a sitewide diagnostic switch. Add it to `appSettings` only when you need to compare server-side behavior with the former browser-side transformation:

```xml
<appSettings>
  <add key="RDWebEnableServerSideXslt" value="false" />
</appSettings>
```

When the value is `false`, RD Web Access returns to browser transformation for the site. Remove the setting or set it to `true` after the diagnostic test. This switch isn't a durable rollback or workaround after browser XSLT becomes unavailable. Don't restore older `.aspx` pages as a rollback method.

## Troubleshoot the migration

First, view the page source to determine whether transformation ran:

- `<!DOCTYPE html` or other HTML output indicates that server-side transformation succeeded.
- `<?xml` or an `<RDWAPage` element indicates that RD Web Access returned the original XML.

### The page returns raw XML

Check these causes in order:

1. Verify that nobody restored an older or modified `Default.aspx`, `login.aspx`, `Desktops.aspx`, or `password.aspx` file. The current shipped page must invoke `SiteXsltRenderer.RenderPage`.
1. Check RD Web Access and IIS application logs for a stylesheet compile or transform error. Remove unsupported XSLT features and correct invalid local references.
1. Check `RDWebSiteXsltPath` for a missing file or an invalid value. Use a virtual path that begins with `~/` or a single `/`. If the custom path is invalid or missing, RD Web Access logs an error and falls back to the shipped `Site.xsl`; if that transform also fails, the response is XML.
1. Check whether `RDWebEnableServerSideXslt` equals `false`.
1. Check whether the request uses `?rdwaformat=xml` or sends an explicit XML-only `Accept` header.

### The page renders but custom branding is missing

The renderer is probably using the shipped `Site.xsl`.

1. Check that `RDWebSiteXsltPath` points to the intended local stylesheet and uses a supported virtual path.
1. Confirm that the stylesheet exists at the resolved location.
1. If the customization directly edited `Site.xsl`, determine whether servicing replaced the file. Move the customization to a separate stylesheet.
1. Don't add an IIS redirect or rewrite rule to compensate. The renderer doesn't make an HTTP request for the stylesheet.

### An RD Web Access customization stopped working after the server-side XSLT update

1. Check whether anyone restored or modified the shipped `.aspx` pages.
1. Check whether an edited page's `href` or an IIS rule previously selected another stylesheet. Replace that mechanism with `RDWebSiteXsltPath`.
1. Check the stylesheet for scripts, network references, or XSLT 2.0 or 3.0 features.
1. Browse the RD Web Access website and confirm that the customization renders and works properly.

## Package customizations for deployment

Customization vendors should package a durable stylesheet-based customization:

- Don't restore or modify the shipped `.aspx` pages.
- Put branding and supported custom behavior in a separate local stylesheet.
- Configure the stylesheet with `RDWebSiteXsltPath`.
- Remove dependencies on IIS redirect or rewrite rules for stylesheets.
- Validate the package by browsing the RD Web Access website and confirming that the customization renders and works.
- Include configuration and validation instructions for the customized stylesheet.
