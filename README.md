# VibeDX

Salesforce DX source for the **VibeDX** project: metadata under `force-app`, manifests, and tooling (ESLint, Prettier, Jest for LWC).

## Prerequisites

- [Salesforce CLI](https://developer.salesforce.com/tools/salesforcecli)
- Node.js (for `npm` scripts in `package.json`)

## Quick start

```bash
npm install
sf org login web --alias vibe-dx
sf project deploy start --source-dir force-app
```

## Project layout

| Path | Purpose |
|------|---------|
| `force-app/main/default` | Apex, LWC, Visualforce, settings, etc. |
| `manifest-w2l.xml` / `package.xml` | Deployment manifests |
| `scripts/` | Helper scripts |
| `docs/` | Project notes |

For general Salesforce DX workflow, see the [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_intro.htm).
