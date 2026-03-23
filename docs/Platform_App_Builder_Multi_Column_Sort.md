# Platform App Builder: Sort List Views by Multiple Columns (Winter '26)

Hands-on assignment from [Sort List Views by Multiple Columns for Enhanced Insights](https://trailhead.salesforce.com/content/learn/modules/platform-app-builder-certification-maintenance-winter-26/get-hands-on-and-sort-list-views-by-multiple-columns).

## What Was Deployed

The **All Cases Sorted** list view has been created and deployed to your org:

- **List Name:** All Cases Sorted  
- **API Name:** All_Cases_Sorted  
- **Object:** Case  
- **Filter scope:** Everything  
- **Visibility:** All users can see this list view  
- **Columns:** Case Number, Contact Name (NAME), Subject, Status, Priority, Date/Time Opened (Created Date), Case Owner Alias  

Metadata path: `force-app/main/default/objects/Case/listViews/All_Cases_Sorted.listView-meta.xml`

## Apply Multi-Column Sort (in the org)

Multi-column sort is configured in the UI and is not stored in list view metadata. **Order matters:** add Status first, then Priority.

### Steps (do in this order)

1. From **App Launcher**, open the **Cases** object.
2. Select the **All Cases Sorted** list view (dropdown or List View Controls).
3. **List View Controls** (gear) → **Select Fields to Display** — ensure these columns are present (and re-add any missing):  
   Case Number, Contact Name, Subject, Status, Priority, Date/Time Opened, Case Owner Alias. Save/done.
4. Click **Column Sort** (column-sort icon in the list view header).
5. Add sort columns **in this exact order** (first = primary sort, second = secondary):
   - **1st:** **Status** → **Ascending**
   - **2nd:** **Priority** → **Descending**  
   Do not add Priority before Status.
6. Click **Apply**.

Your sort is saved for your session. To try again: **List View Controls** → **Reset Column Sorting**, then repeat from step 4.

### If the challenge says “columns weren’t sorted correctly”

- Confirm **Status** is the **first** sort column (Ascending).
- Confirm **Priority** is the **second** sort column (Descending).
- Reset Column Sorting, then re-add only those two in that order and Apply before checking the challenge again.

## Redeploy

```bash
sf project deploy start -m ListView:Case.All_Cases_Sorted
```

## Reference

- [Trailhead: Get Hands-On and Sort List Views by Multiple Columns](https://trailhead.salesforce.com/content/learn/modules/platform-app-builder-certification-maintenance-winter-26/get-hands-on-and-sort-list-views-by-multiple-columns)
- [Salesforce Help: Sort List Views by Multiple Columns](https://help.salesforce.com/)
