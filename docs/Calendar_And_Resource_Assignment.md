# Assignment: Public Calendar and Resource with Sales Reps Sharing

## What to create

1. **Public calendar**
   - **Name:** Quarterly Kickoffs  
   - **Active:** Checked  
   - **Sharing:** Group: Sales Reps  

2. **Resource**
   - **Name:** Demonstration Org  
   - **Active:** Checked  
   - **Sharing:** Group: Sales Reps  

Salesforce does not allow creating Public Calendars or Resources via the Metadata API or Apex. The **Sales Reps** group is created by script; the calendar and resource must be created in the UI.

---

## Step 1: Create the Sales Reps group (deployed and run)

The Apex class `CalendarAndResourceCreator` creates the public group **Sales Reps** if it doesn’t exist. It has been **deployed to VibeDX** and **run once** (the Sales Reps group now exists in the org).

To run again in another org or if you need to recreate the group:

```bash
sf apex run --file scripts/run-calendar-resource-setup.apex
```

Or in Developer Console → **Execute Anonymous**:

```apex
CalendarAndResourceCreator.createSalesRepsGroup();
```

---

## Step 2: Create the public calendar in Setup

1. **Setup** → Quick Find: **Public Calendars and Resources** → open it.  
2. Under **Public Calendars**, click **New**.  
3. Set:
   - **Name:** `Quarterly Kickoffs`  
   - **Active:** checked  
4. **Save**.  
5. Click **Sharing** next to **Quarterly Kickoffs**.  
6. **Add** → choose **Sales Reps** (public group) → set access (e.g. **Read/Write**) → **Save**.

---

## Step 3: Create the resource in Setup

1. On the same **Public Calendars and Resources** page, under **Resources**, click **New**.  
2. Set:
   - **Name:** `Demonstration Org`  
   - **Active:** checked  
3. **Save**.  
4. Click **Sharing** next to **Demonstration Org**.  
5. **Add** → choose **Sales Reps** → set access → **Save**.

---

## Summary

| Item           | Name               | Active | Sharing   |
|----------------|--------------------|--------|-----------|
| Public calendar| Quarterly Kickoffs | Yes    | Sales Reps |
| Resource       | Demonstration Org  | Yes    | Sales Reps |

**In repo:** `CalendarAndResourceCreator.cls` (creates Sales Reps group), `scripts/run-calendar-resource-setup.apex`, this guide.
