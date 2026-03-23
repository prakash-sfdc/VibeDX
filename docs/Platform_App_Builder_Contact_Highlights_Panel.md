# Platform App Builder: Dynamic Highlights Panel (Contact Record Page)

Hands-on steps to maintain your **Platform App Builder** certification using the **Dynamic Highlights Panel** on a Contact record page, then deploy to the VibeDX source org.

## Option A: Configure in Lightning App Builder (recommended)

Do the following in your Salesforce org, then retrieve and deploy.

### 1. Open the page in the Sales App

1. Log in to your **VibeDX source org**.
2. Open the **Sales** app (App Launcher → Sales).
3. Go to the **Contacts** tab and open any **Contact** record.
4. Leave the default record page as is (we will edit this page).

### 2. Edit the page and create a copy

1. Click the **gear** (Setup) icon → **Edit Page**.
2. In Lightning App Builder, use **Save As** (or create a new record page) with:
   - **Name:** `Contact Record PageCopy`
   - **API Name:** `Contact_Record_PageCopy`

### 3. Replace the standard Highlights Panel with Dynamic Highlights Panel

1. In the **header** region, **remove** the standard **Highlights Panel** (select it → Delete or Remove).
2. From the **Fields** tab (not Components), drag **Dynamic Highlights Panel** onto the header.
3. Select the Dynamic Highlights Panel and set **Primary Field** to **Name**.

### 4. Add action buttons

On the Dynamic Highlights Panel component, add these **action buttons**:

- **Edit**
- **Delete**

### 5. Add fields to the panel

Drag these fields into the Dynamic Highlights Panel (from the Fields tab or component properties):

- **Title**
- **Account Name**
- **Phone**
- **Email**
- **Contact Owner**
- **Level** (use **Level** if standard, or **Level__c** if custom)

### 6. Save and set as org default

1. Click **Save**.
2. Click **Activate** and set as **Org Default**.
3. Click **Back** to leave the builder.

### 7. Retrieve into the VibeDX project

From the VibeDX project root:

```bash
# Default org (VibeDX source org)
sf project retrieve start -m FlexiPage:Contact_Record_PageCopy
```

This writes/updates:

`force-app/main/default/flexiPages/Contact_Record_PageCopy.flexipage-meta.xml`

### 8. Deploy to the VibeDX source org

To deploy the FlexiPage from the project to the org:

```bash
# Deploy FlexiPage to default org
sf project deploy start -m FlexiPage:Contact_Record_PageCopy

# Or deploy the whole project
sf project deploy start --source-dir force-app
```

---

## Option B: Deploy the included FlexiPage from source

This repo includes a **Contact_Record_PageCopy** FlexiPage that:

- Uses the **Dynamic Highlights Panel** in the header (no standard Highlights Panel).
- Sets **Name** as the primary field.
- Configures **Edit** and **Delete** action buttons.
- Includes fields: **Title**, **Account Name**, **Phone**, **Email**, **Contact Owner**, **Level** (Level__c in metadata; use **Level** in the UI if your org has a standard Level field).

**Deploy to your VibeDX source org:**

```bash
# Set default org to your VibeDX source org (if needed)
sf config set target-org <your-vibedx-org-alias>

# Deploy the Contact record page
sf project deploy start -m FlexiPage:Contact_Record_PageCopy
```

**If deployment fails** (e.g. invalid component or property names for your API version), use **Option A**: configure the page in App Builder, activate as org default, then run the retrieve command above. The retrieved metadata will match your org and can be committed and redeployed.

**Note:** If your org does not have a **Level** field, remove it from the panel in App Builder or adjust the retrieved metadata (e.g. remove `Level__c` from the panel configuration).

---

## Summary

| Item | Value |
|------|--------|
| Page name | Contact Record PageCopy |
| API name | Contact_Record_PageCopy |
| App | Sales |
| Object | Contact |
| Header | Dynamic Highlights Panel (standard Highlights Panel removed) |
| Primary field | Name |
| Actions | Edit, Delete |
| Fields | Title, Account Name, Phone, Email, Contact Owner, Level |
| Assignment | Org Default (after activation) |

After deployment or retrieval, the page is in `force-app/main/default/flexiPages/Contact_Record_PageCopy.flexipage-meta.xml` and can be deployed to the VibeDX source org with the commands above.
