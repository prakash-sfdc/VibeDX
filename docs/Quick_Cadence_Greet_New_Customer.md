# Create a Quick Cadence: Greet New Customer (Make a Call)

Step-by-step guide to complete the [Create a Quick Cadence](https://trailhead.salesforce.com/content/learn/modules/quick-cadences-for-sales-teams/create-a-quick-cadence) assignment. Quick cadences **cannot be created or deployed via Metadata API or Apex**; they must be created in the Salesforce UI.

---

## Prerequisites in your org

- **Sales Engagement** (or Quick Cadences) must be enabled:  
  **Setup** → **Sales Engagement Settings** (or search **Sales Engagement**) → enable as needed.
- A **Call Script** named **Greet New Customer** must exist. If it doesn’t, create it first under the appropriate Call Script / Sales Engagement setup.

---

## Steps (in the org)

1. **Open Cadences**
   - With **Sales Engagement**: **App Launcher** → **Cadences** (or open the **Sales** app and use the Cadences tab if your org uses that).
   - Click **New Cadence**.

2. **Choose the action**
   - Select **Make a Call**.

3. **Configure the quick cadence**
   - **Name:** `Greet New Customer`
   - **Description:** `Make a call to greet a new customer and thank them for placing their first order.`  
     (Exact text is not checked; you can use this or similar.)
   - **Choose a Call Script:** **Greet New Customer**

4. **Start and due date**
   - **Start this quick cadence:** **Immediately After Assignment**
   - **Select a Due Date:** **Date Cadence Is Assigned**

5. **Repeat**
   - **Repeat:** **Don’t Repeat**

6. **Save**
   - Click **Save** (or **Create** / **Finish**, depending on the flow).

---

## Summary

| Setting              | Value                        |
|----------------------|------------------------------|
| Cadence Action       | Make a Call                  |
| Name                 | Greet New Customer           |
| Description          | Make a call to greet a new customer and thank them for placing their first order. |
| Call Script          | Greet New Customer           |
| Start                | Immediately After Assignment |
| Due Date             | Date Cadence Is Assigned     |
| Repeat               | Don’t Repeat                 |

---

## If “Cadences” or “Make a Call” is not available

- Confirm **Sales Engagement** (or **Quick Cadences**) is enabled in Setup.
- Use a **Developer Edition** org with Quick Cadences enabled, or ask your admin to enable it in VibeDX.
- The **Greet New Customer** call script may need to be created first in your org (Setup or Sales Engagement settings, depending on your edition).

---

## Reference

- [Trailhead: Create a Quick Cadence](https://trailhead.salesforce.com/content/learn/modules/quick-cadences-for-sales-teams/create-a-quick-cadence)
