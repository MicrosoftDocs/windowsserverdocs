---
title: Angular 20 Upgrade for Windows Admin Center
description: Upgrade your Windows Admin Center extensions to Angular 20 for the latest framework features, security patches, and faster builds. Follow this guide to get started.
ms.topic: upgrade-and-migration-article
author: pmiddha
ms.author: pmiddha
ms.date: 08/18/2026
---

# Upgrade Windows Admin Center extensions to Angular 20

This guide walks you through upgrading a Windows Admin Center extension from Angular 15 to Angular 20. New fixes and updates to the Windows Admin Center shell and SDK reach only extensions built on Angular 20, so upgrading keeps your extension current and supported.

By the end of this guide, your extension runs on Angular 20. The steps assume your extension is on an Angular 15 baseline. If your extension is still on Angular 11 or earlier, [upgrade to Angular 15](upgrade-to-angular-15.md) first.

If you run into problems during the upgrade, reach out to your Microsoft contact and they'll route the request.

## Prerequisites

Before you upgrade to Angular 20, make sure that your environment meets the following requirements:

- Your extension is on Angular 15. If your extension is still on Angular 11 or earlier, [upgrade to Angular 15](upgrade-to-angular-15.md) first.
- Node.js 20.19.0, Angular CLI 20.3.18, TypeScript 5.9.2, and the latest Windows Admin Center shell and development tools.

> [!NOTE]
> This guide assumes an Angular 15 baseline. The `wac angular20Upgrade` command handles the intermediate Angular versions (16, 17, 18, 19), so you don't run separate commands for each one.

### Confirm your Angular 15 baseline

Open your extension's `package.json` at the root of the project. You should see entries similar to the following (package names vary by your public-facing SDK):

```json
{
  "dependencies": {
    "@angular/core": "15.2.9",
    "rxjs": "~7.5.0",
    "zone.js": "0.13.1"
  }
}
```

If your `@angular/core` is `11.x.x`, finish the [Angular 15 upgrade](upgrade-to-angular-15.md) before continuing.

### Configuring your environment for upgrade

Before you begin the upgrade to Angular 20, configure your developer environment with the latest Windows Admin Center shell and development tools, including upgrading your version of Node.

To manage your versions of Node, use [Node Version Manager](https://github.com/coreybutler/nvm-windows). Follow the instructions to install nvm-windows on your machine. Use version 1.1.11 or later, as older versions might not support the Node.js versions required for this upgrade.

After you install it, prepare your environment by running these commands:

```cmd
nvm install 20.19.0
nvm use 20.19.0
npm i -g gulp-cli
npm i -g @angular/cli@20.3.18
npm i -g vsts-npm-auth
npm i -g typescript@5.9.2
```

> [!TIP]
> The upgrade tool also adds a `.nvmrc` file to your project root pinning Node `20.19.0`, and sets `"engines": { "node": ">=20" }` in your `package.json`. This change makes the required Node version self-documenting for new contributors. If you use a different Node manager (fnm, asdf), it honors the `.nvmrc` file automatically.

If you want to continue to make changes in Angular 15, use Node 16.14.0. These versions are incompatible for simultaneous use, so you must toggle your global Node version to run build commands in each environment.

To switch back to the Angular 15 configuration, run:

```cmd
nvm install 16.14.0
nvm use 16.14.0
npm i -g gulp-cli
npm i -g @angular/cli@15.2.9
npm i -g vsts-npm-auth
npm i -g typescript@4.8.2
```

When you toggle Node versions, you might lose all global Node settings, including your VSTS authentication. To restore VSTS authentication, run `vsts-npm-auth -config .npmrc` at the root of your repository.

### Browser support

Angular 20 raises the minimum supported browser version. Confirm your extension still targets a supported matrix:

| Browser                  | Minimum supported          |
| ------------------------ | -------------------------- |
| Chrome / Edge (Chromium) | Current and previous major |
| Firefox                  | Current, previous, and ESR |
| Safari                   | 16+                        |

Angular 20 doesn't support Internet Explorer. If you previously included IE polyfills, remove them. The upgrade tool also strips them automatically.

## Automated upgrade process

To ease the upgrade from Angular 15 to Angular 20, the SDK includes a CLI command that automates most of the work - dependency updates, build-configuration changes, code-level fixups (for example, adding `standalone: false` to legacy components), and known-pattern audit fixes.

Before running the automated upgrade:

- Ensure your environment meets the requirements in the [Prerequisites](#prerequisites) section (Node 20, Angular CLI 20).
- Commit or shelve any work-in-progress changes. The tool modifies many files.
- Ensure your branch builds cleanly on Angular 15 (`gulp build --prod` succeeds).

When you're ready, follow these steps:

1. Make sure you have the latest version of the Windows Admin Center CLI by running:

   ```cmd
   npm install -g @microsoft/windows-admin-center-sdk@latest
   ```

1. From the root of your extension, run:

   ```cmd
   wac angular20Upgrade
   ```

### Understanding upgrade stages

By default, `wac angular20Upgrade` runs all upgrade stages in sequence. For diagnostics or to re-run a specific portion, pass `--stage <n>`:

| Stage       | Purpose                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| ----------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 0 (default) | Run all stages in sequence                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| 1           | Update non-Angular configuration and tooling dependencies. This stage doesn't touch Angular packages — Stage 2 handles those. |
| 2           | Step incrementally through Angular 16 → 17 → 18 → 19 → 20 by using `ng update`. This stage is the slowest (~5–8 minutes total).                                                                 |
| 3           | Apply the standalone-component scan — adds `standalone: false` to every `@Component`, `@Directive`, and `@Pipe` decorator in your project.                                                                                                                                                                                                                                                                                                                                        |
| 4           | Apply code-level fixups — `.toPromise()` → `lastValueFrom`, `moment` default import, `zone.js` polyfill path, template `this.` stripping.                                                                                                                                                                                                                                                                                                                                         |
| 5           | Run ESLint auto-fix (`npx eslint . --fix` and `npx ng lint --fix`).                                                                                                                                                                                                                                                                                                                                                                                                               |

Stage 1 and Stage 2 do most of the work. Here's what each one changes in detail:

- **Stage 1** bumps tooling dependencies that `ng update` doesn't manage (jasmine, karma, `@types/*`, `@typescript-eslint`, eslint, ng-mocks, `@testing-library`, tslib) and updates configuration files: `angular.json` (builder switch, `browserTarget`→`buildTarget`, custom-webpack removal), tsconfig cleanup, `ci-build.yml`, `.nvmrc`, `engines`, `.gitignore`, and `version.json`. This stage doesn't touch Angular packages — Stage 2 handles those by using `ng update`.
- **Stage 2** runs `ng update @angular/core@N @angular/cli@N`, then `ng update @angular-eslint/schematics@N`, then parses `log.txt` for known patterns, for each version in the sequence. After the loop completes, Stage 2 bumps the SDK packages to their Angular-20-compatible release line, and `npm install --force` reconciles the tree.

#### Why incremental and not single-jump?

Angular ships many breaking changes as official `ng update` schematics, not just documentation:

- v15 → v16: `TestBed.get()` → `TestBed.inject()`
- v17 → v18: two-way binding syntax fix
- v18 → v19: the standalone-component default flip (Stage 3 mops up what the schematic misses)
- v19 → v20: minor cleanup

A naive single-jump regex bump of `@angular/*` would skip every one of those schematics. This CLI uses Angular's official upgrade path one major version at a time.

To demonstrate this approach, re-run only the standalone scan and code-level fixups without redoing dependency installs:

```cmd
wac angular20Upgrade --stage 3
wac angular20Upgrade --stage 4
```

### Optional flags

| Flag          | Default | Purpose                                             |
| ------------- | ------- | --------------------------------------------------- |
| `--stage <n>` | `0`     | Run a specific stage (see the preceding stage table)                    |
| `--debug`     | `false` | Write verbose logs to `log.txt` at the project root |

## Post-upgrade actions

After the upgrade command finishes:

1. The command generates a `log.txt` file at the root of your project. Review it for any actions the tool flagged for manual follow-up.
1. Stage your changes (`git add` / `git status`). The command is idempotent, so you can re-run it if needed.
1. Build and serve locally.

   ```cmd
   gulp build --prod
   gulp serve
   ```
1. Run your unit tests, if applicable.

   ```cmd
   gulp test
   ```

Now test your extension in Windows Admin Center as normal.

## Troubleshooting scenarios

Most upgrade errors fall into one of the categories described in this section. The upgrade command attempts to fix each error automatically. If any error reaches the build, the guidance in this section explains how to mitigate the error manually.

## NG6008: Component XYZ is standalone, and can't be declared in an NgModule

```output
error NG6008: Component MyDialogComponent is standalone, and cannot be declared
in an NgModule. Did you mean to import it instead?
```

**Cause:** Angular 19 reversed the default - every component is now standalone unless you explicitly mark otherwise. `wac angular20Upgrade --stage 3` scans your `*.component.ts`, `*.directive.ts`, and `*.pipe.ts` files and adds `standalone: false`.

**Mitigation:** If the command misses a few components (typically those with complex `providers: [{ provide: X, useExisting: forwardRef(...) }]` arrays), add the property manually.

```typescript
@Component({
  selector: "my-dialog",
  templateUrl: "./my-dialog.component.html",
  providers: [
    { provide: TOKEN, useExisting: forwardRef(() => MyDialogComponent) },
  ],
  standalone: false, // <-- add this
})
export class MyDialogComponent {}
```

After fixing the error, re-run `wac angular20Upgrade --stage 3` to confirm no remaining decorators are missing the flag.

## `.toPromise()` is deprecated and removed

```output
error TS2339: Property 'toPromise' does not exist on type 'Observable<...>'
```

**Cause:** RxJS 7 deprecated `.toPromise()`, and Angular 20's strict mode flags it as removed.

**Mitigation:** Replace it with `lastValueFrom`:

```typescript
// Before
const result = await someObservable$.toPromise();

// After
import { lastValueFrom } from "rxjs";
const result = await lastValueFrom(someObservable$, {
  defaultValue: undefined,
});
```

`wac angular20Upgrade --stage 4` handles this change for common patterns; complex chains might need manual edits.

## Cannot find module 'zone.js/dist/zone'

**Cause:** zone.js 0.14+ flattened its package layout. The path `zone.js/dist/zone` no longer exists.

**Mitigation:** Update your `polyfills.ts`:

```typescript
// Before
import "zone.js/dist/zone";

// After
import "zone.js";
```

Also remove `"zone.js/dist/zone"` from the `polyfills` array in `angular.json`. The upgrade tool handles both changes automatically.

## Configuration property 'browserTarget' is not allowed

```output
Schema validation failed with the following errors:
  Data path "/projects/my-app/architect/serve/options" must NOT have additional properties (browserTarget).
```

**Cause:** Angular 17 renamed `browserTarget` to `buildTarget` in `angular.json` for `serve`, `extract-i18n`, and related architects.

**Mitigation:** The upgrade tool replaces every occurrence. If your `angular.json` still has `browserTarget` after the upgrade, replace `browserTarget` with `buildTarget` project-wide.

## Custom webpack configuration isn't loaded

**Cause:** The upgrade switches your `build` builder from `@angular-builders/custom-webpack:browser` to `@angular-devkit/build-angular:browser-esbuild`. The esbuild-based builder doesn't use `customWebpackConfig`.

**Mitigation:** Most extensions don't need custom webpack configuration once on esbuild - tree-shaking, vendor chunk splitting, and asset handling are built in. If your extension relied on a specific webpack plugin:

- For asset transforms (for example, copying static files), use the `assets` array in `angular.json`.
- For CommonJS dependency warnings, add the entries to `allowedCommonJsDependencies` (see the [Dependency warnings (CommonJS)](#dependency-warnings-commonjs) scenario).
- For complex cases, file an issue with your Microsoft contact describing the webpack feature you depended on.

## `moment` has no default export

```output
error TS2613: Module '"moment"' has no default export. Did you mean to use
'import moment = require("moment")' instead?
```

**Cause:** TypeScript 5 with `esModuleInterop: true` requires the default-import form for moment.

**Mitigation:** Update your imports:

```typescript
// Before
import * as moment from "moment";

// After
import moment from "moment";
```

The upgrade tool applies this fix project-wide.

## Build optimizer warning / "buildOptimizer" isn't recognized

**Cause:** `buildOptimizer` was a webpack-specific flag. The esbuild builder has equivalent optimizations enabled by default.

**Mitigation:** Remove the `buildOptimizer` keys from your `angular.json` (the upgrade tool does this). You don't need a replacement.

## File encoding errors or mojibake after upgrade

If you see garbled characters in component templates (`â€™` instead of `'`, and similar errors) after running `ng update`:

**Cause:** The Angular CLI's migration scripts can corrupt UTF-8 BOMs on Windows.

**Mitigation:** The upgrade tool restores UTF-8 encoding for known-affected file types. If a file is still affected, open it in VS Code, change the encoding to **UTF-8** (status bar, lower right), and save.

## Dependency warnings (CommonJS)

```output
Warning: C:\path\to\extension\node_modules\some-dep depends on
'some-commonjs-module'. CommonJS or AMD dependencies can cause optimization
bailouts.
```

**Mitigation:** Add the dependency to `allowedCommonJsDependencies` in `angular.json`:

```json
"architect": {
  "build": {
    "options": {
      "allowedCommonJsDependencies": [
        "base64-arraybuffer",
        "file-saver",
        "xterm",
        "xterm-addon-fit"
      ]
    }
  }
}
```

The upgrade tool seeds known dependencies. Add others as the build flags them.

## ngTemplateOutlet context type error

```output
error TS2322: Type '{ $implicit: ...; index: number; }' is not assignable to type ...
```

**Cause:** Angular 16+ enables strict template checking by default and now type-checks inline context objects passed to `*ngTemplateOutlet`.

**Mitigation:** Wrap the context object in `$any()`:

```html
<!-- Before -->
<ng-container
  *ngTemplateOutlet="getTemplate(item); context: { $implicit: item, index: i }"
></ng-container>

<!-- After -->
<ng-container
  *ngTemplateOutlet="getTemplate(item); context: $any({ $implicit: item, index: i })"
></ng-container>
```

## Tests fail with TestBed.get is not a function

**Cause:** Angular 16 removed `TestBed.get()`.

**Mitigation:** Replace it with `TestBed.inject()`:

```typescript
// Before
const service = TestBed.get(MyService);

// After
const service = TestBed.inject(MyService);
```

## ESLint rule not found errors

```output
Definition for rule '@angular-eslint/template/accessibility-alt-text' was not found.
```

**Cause:** `@angular-eslint` v16+ **renamed** several accessibility rules (it didn't remove them). It dropped the `accessibility-` prefix.

**Mitigation:** The upgrade tool renames them automatically in stage 5. If your ESLint config still uses the old names, update them:

| Old name                                                  | New name                                                |
| --------------------------------------------------------- | ------------------------------------------------------- |
| `@angular-eslint/template/accessibility-alt-text`         | `@angular-eslint/template/alt-text`                     |
| `@angular-eslint/template/accessibility-elements-content` | `@angular-eslint/template/elements-content`             |
| `@angular-eslint/template/accessibility-label-for`        | `@angular-eslint/template/label-has-associated-control` |
| `@angular-eslint/template/accessibility-table-scope`      | `@angular-eslint/template/table-scope`                  |
| `@angular-eslint/template/accessibility-valid-aria`       | `@angular-eslint/template/valid-aria`                   |

The upgrade tool also adds new accessibility rules introduced in `@angular-eslint` 18+: `click-events-have-key-events`, `mouse-events-have-key-events`, `no-autofocus`, and `no-distracting-elements`. These rules flag patterns you should make keyboard-accessible; if a flagged element is intentionally pointer-only (for example, a drag handle), suppress with `// eslint-disable-next-line @angular-eslint/template/click-events-have-key-events` rather than disabling the rule globally.

## Angular 20 lint rule conflicts with NgModule architecture

```output
warning: Components, directives, and pipes should be marked as standalone
  (@angular-eslint/prefer-standalone)
warning: Prefer using inject() function over constructor injection
  (@angular-eslint/prefer-inject)
```

**Cause:** `@angular-eslint` 18+ ships two rules that nudge codebases toward the modern Angular style: standalone components and the `inject()` function. These rules conflict with this upgrade's intentional choice to preserve the existing `NgModule` + constructor-injection architecture.

**Mitigation:** The upgrade tool disables both rules in your ESLint config:

```javascript
// .eslintrc.json (or eslint.config.mjs)
{
  "rules": {
    "@angular-eslint/prefer-standalone": "off",
    "@angular-eslint/prefer-inject": "off"
  }
}
```

If you later migrate your extension to standalone components and want to adopt `inject()`, re-enable these rules.

## Template error: "this" is no longer valid in template expressions

```output
error NG5002: Parser Error: Unexpected token '.' at column N in [this.dropDown.isOpen]
```

**Cause:** Angular 20 enforces a stricter template parser. Component-property references in templates must use the bare property name (`dropDown.isOpen`); the parser rejects the `this.` prefix.

**Mitigation:** Remove `this.` from template expressions:

```html
<!-- Before -->
<sme-icon *ngIf="!this.dropDown.isOpen"></sme-icon>

<!-- After -->
<sme-icon *ngIf="!dropDown.isOpen"></sme-icon>
```

The upgrade tool scans your templates for this pattern and fixes simple occurrences. Complex expressions (with chained `this.` references) might need manual edits.

## Spec tests failing after upgrade — flaky DOM queries

Angular 20's change-detection scheduling is stricter than v15. Tests that previously queried the DOM directly might now race against pending change-detection cycles.

**Recommended pattern:**

```typescript
// Before — flaky in Angular 20
it("shows tooltip", () => {
  fixture.detectChanges();
  const tooltip = fixture.nativeElement.querySelector("[ng-reflect-title]");
  expect(tooltip.getAttribute("ng-reflect-title")).toBe("Expected");
});

// After — stable, uses component API
it("shows tooltip", async () => {
  fixture.detectChanges();
  await fixture.whenStable();
  expect(component.getColumnTooltipText(column)).toBe("Expected");
});
```

If your tests use virtualization-aware components (data grids, virtual scrollers), consider disabling virtualization in tests:

```html
<sme-data-table [disableUIVirtualization]="true" ...></sme-data-table>
```

The upgrade tool flags spec files that match brittle patterns and writes guidance into `log.txt`, but doesn't rewrite the tests automatically.

## Other considerations when upgrading extensions to Angular 20

- **Shell version pairing.** Angular 20 extensions pair with the Windows Admin Center **5.x** shell and **5.x.y** `@microsoft/windows-admin-center-sdk` libraries. Continue using **4.x.y** SDK packages and the **4.x** shell branch if your extension is still on Angular 15. To check, look at `@microsoft/windows-admin-center-sdk` in your `package.json`.
- **Sideloading.** The Angular 20 upgrade doesn't affect sideloading. Two shell branches (4.x for Angular 15 extensions, 5.x for Angular 20 extensions) can coexist on your development machine.
- **copyTarget.** When you use `copyTarget`, ensure you're copying to the correct shell branch — only use the 5.x branch if the extension you're copying is on Angular 20.
- **Karma and Jasmine.** Angular officially deprecated Karma as of v18, but it continues to work in Angular 20. You don't need to migrate away from Karma as part of this upgrade.
- **Standalone components (optional modernization).** This upgrade preserves your existing `NgModule`-based architecture by adding `standalone: false`. If you later want to modernize to standalone components, you can do so incrementally — remove `standalone: false`, add `imports: [...]` to the component, and remove the corresponding `NgModule` declaration. This modernization isn't required for Angular 20 compatibility.
- **Build performance.** The new esbuild-based builder is significantly faster than webpack — expect 2-5× faster cold builds and ~10× faster incremental builds. The output bundle's functionality doesn't change.
- **Polyfills.** You no longer need to import `zone.js/dist/zone` explicitly. If you have custom polyfills, ensure they're still listed in the `polyfills` array of `angular.json`.

## Releasing your upgraded extension

After you test your extension in Windows Admin Center desktop and service mode, send an email to [wacextensionrequest@microsoft.com](mailto:wacextensionrequest@microsoft.com?subject=Windows%20Admin%20Center%20Extension%20Package%20Review) to coordinate the release of your upgraded extension.

## Appendix: What the upgrade tool changes

For reference, the following list summarizes the changes `wac angular20Upgrade` applies. You don't need to make these changes by hand — the CLI handles them — but the list is useful when reviewing the resulting diff:

### `package.json`

- `@angular/*` packages bumped to `20.3.18`
- `@angular-devkit/build-angular` bumped to `20.3.18`
- `@angular/cli` bumped to `20.3.18` (devDependencies)
- `@angular/compiler-cli` bumped to `20.3.18`
- `typescript` bumped to `5.9.2`
- `rxjs` bumped to `~7.8.1`
- `zone.js` bumped to `~0.15.1`
- `ng-packagr` bumped to `~20.2.0`
- `@angular-eslint/*` bumped to `20.3.0`
- `@typescript-eslint/*` bumped to `7.18.0`
- `ng-mocks` bumped to `~14.13.1`
- `@testing-library/angular` bumped to `^17.2.0`
- SDK packages bumped to their Angular-20-compatible release line
- `@angular-builders/custom-webpack` removed
- `protractor` removed (no longer maintained)
- `@types/node` bumped to `^20.19.0`

### `angular.json`

- Builder switched from `@angular-builders/custom-webpack:browser` to `@angular-devkit/build-angular:browser-esbuild`
- `customWebpackConfig` and `indexTransform` blocks removed
- `buildOptimizer` flag removed (no-op under esbuild)
- `browserTarget` renamed to `buildTarget` in `serve` and `extract-i18n` architects
- `zone.js/dist/zone` removed from `polyfills` arrays
- `maximumWarning` budget raised where needed

### `tsconfig.base.json` / `tsconfig.json`

- `target` set to `ES2022`
- `module` set to `esnext`
- `skipLibCheck: true` added
- Deprecated `emitDecoratorMetadata`, `fullTemplateTypeCheck`, `skipTemplateCodegen`, `strictMetadataEmit` removed
- `lib` array updated to include `ES2022`

### Source code (`*.ts`, `*.html`)

- `standalone: false` added to every existing `@Component`, `@Directive`, and `@Pipe` decorator (preserves NgModule-based architecture). For reference: the Windows Admin Center monorepo applied this change to ~1,800 decorators across 45 packages.
- `.toPromise()` calls replaced with `lastValueFrom(observable, { defaultValue: undefined })`
- `import 'zone.js/dist/zone'` replaced with `import 'zone.js'`
- `import * as moment from 'moment'` replaced with `import moment from 'moment'`
- `TestBed.get(X)` replaced with `TestBed.inject(X)`
- `*ngTemplateOutlet`-context type errors patched with `$any()` wrappers
- Template expressions with `this.` prefix stripped (`this.foo.bar` → `foo.bar`)
- Encoding restored to UTF-8 (no BOM) for files corrupted by `ng update` on Windows

### ESLint configuration

- Accessibility rules renamed (drop `accessibility-` prefix; see troubleshooting section for the full table)
- New rules added: `click-events-have-key-events`, `mouse-events-have-key-events`, `no-autofocus`, `no-distracting-elements`
- Angular 20 modernization rules disabled to preserve NgModule architecture: `@angular-eslint/prefer-standalone: off`, `@angular-eslint/prefer-inject: off`
- `createDefaultProgram: true` removed (no longer recognized in `@angular-eslint` 18+)

### Node environment

- `.nvmrc` file created at project root pinning Node `20.19.0`
- `"engines": { "node": ">=20" }` added to `package.json`

## Related content

- [Upgrade Windows Admin Center extensions to Angular 15](upgrade-to-angular-15.md) — prerequisite if you're still on Angular 11
- [Angular update guide](https://angular.dev/update-guide) — Angular's official version-to-version migration reference
