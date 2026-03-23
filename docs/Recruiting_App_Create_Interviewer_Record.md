# Build an Automation for Creating Interviewer Records

Step-by-step implementation for [Streamline Interviewer Record Creation & Approval](https://trailhead.salesforce.com/content/learn/projects/automate-business-processes-recruiting-app/build-process-interview-records) from the **Automate Business Processes for a Recruiting App** Trailhead project.

## Summary

- **Flow:** Record-triggered on **Position** (when a record is **created** and **Hiring Manager** is not null).
- **Action:** Create one **Interviewer** record with **Employee** = Position’s Hiring Manager and **Position** = the new Position’s ID.
- **Pre-step:** Deactivate the validation rule **Every_Position_Must_Have_a_Hiring_Mgr** on Position.
- **VibeDX:** The flow cannot be deployed to VibeDX until the **Position** and **Interviewer** custom objects (and required fields) exist there. Use this guide to build the flow in an org that has the [Recruiting App data model](https://trailhead.salesforce.com/content/learn/projects/build-a-data-model-for-a-recruiting-app), then retrieve and deploy to VibeDX if desired.

---

## Prerequisites in VibeDX (or your org)

This project builds on the **Recruiting App** data model. You need:

- **Position** object (custom object, e.g. `Position__c`) with at least:
  - **Hiring Manager** (lookup to User)
  - Record type(s) if your app uses them (e.g. Nontechnical Position)
- **Interviewer** object (e.g. `Interviewer__c`) with at least:
  - **Employee** (lookup to User)
  - **Position** (lookup to Position)
- **Validation rule** on Position: `Every_Position_Must_Have_a_Hiring_Mgr` (you will **deactivate** it in Step 1)

If you haven’t built the data model yet, complete the [Build a Data Model for a Recruiting App](https://trailhead.salesforce.com/content/learn/projects/build-a-data-model-for-a-recruiting-app) project in the same org (or in a Trailhead playground, then retrieve those objects and deploy to VibeDX).

---

## Step 1: Deactivate the validation rule

1. **Setup** → **Object Manager** → **Position** → **Validation Rules**.
2. Open **Every_Position_Must_Have_a_Hiring_Mgr**.
3. **Edit** → clear **Active** → **Save**.

This allows the flow to create a Position first; the flow will then create the Interviewer with the Hiring Manager set.

---

## Step 2: Create the record-triggered flow

1. **App Launcher** → search **Automation** → open **Flows**.
2. **New Flow** → under **Frequently Used** choose **Record-Triggered Flow** → **Create**.
3. **Configure Start**:
   - **Object:** Position (or Position__c).
   - **Trigger:** When a record is **created**.
   - **Condition Requirements:** **All Conditions Are Met (AND)**.
   - Condition:
     - **Field:** Hiring Manager  
     - **Operator:** Is Null  
     - **Value:** **False** (i.e. Hiring Manager is not null).
   - **Run the flow for:** **Actions and Related Records** (after the record is saved).
   - **Done**.

4. **Add element** → search **create** → **Create Records**.
5. **Create Records** configuration:
   - **Label:** `Create Interviewer Record`
   - **How to set record field values:** **Manually** (assign each field).
   - **Object:** **Interviewer** (or Interviewer__c).
   - **Set Field Values:**
     - **Field 1:** Employee  
       **Value 1:** From **Triggering Position** (or **Position__c**) → **Hiring Manager**  
       (Choose the option that is the Hiring Manager field, not “Record ID”.)
     - **Field 2:** Position  
       **Value 2:** From **Triggering Position** (or **Position__c**) → **Record ID**
   - **Done**.

6. **Save** the flow:
   - **Flow Label:** `Create Interviewer Record`
   - **Save** (API name will be e.g. `Create_Interviewer_Record`).
7. **Activate** the flow.
8. Use the back button to leave Flow Builder.

---

## Step 3: Test the flow

### 3a. Create a test user (if needed)

1. **Setup** → Quick Find **Users** → **New User**.
2. Example:
   - First Name: `Kathy`  
   - Last Name: `Cooper`  
   - Email: your email  
   - Username: e.g. `kcooper@<your-initials><favorite-color>.com`  
   - Nickname: `kcoop`  
   - Title: `Customer Support Manager`  
   - Role: **Customer Support, North America** (or equivalent in your org)  
   - User License: **Salesforce Platform**  
   - Profile: **Standard Platform User**
3. Deselect **Generate new password and notify user immediately** → **Save**.

### 3b. Create a Position and check the Interviewer

1. Open the **Recruiting** app (or the app that has **Positions**).
2. **Positions** tab → **New**.
3. Choose record type if prompted (e.g. **Nontechnical Position**) → **Next**.
4. Fill in, for example:
   - **Title:** `Super Support Supervisor`  
   - **Status:** New  
   - **Department:** Support  
   - **Location:** US  
   - **Hiring Manager:** **Kathy Cooper**  
   - **Job Description:** `Manage a team that fields inquiries and cases from customers`  
   - **Pay Grade:** S-200 (if present)
5. **Save**.
6. On the Position record, open the **Related** tab.
7. In **Interviewers**, open an Interviewer record and confirm:
   - **Employee** = Kathy Cooper (the Hiring Manager).
   - **Position** = this Position.

---

## Deploying this to VibeDX

- **If the Recruiting App data model already exists in VibeDX:**  
  Follow Steps 1–3 above in your VibeDX org (Setup and Flow Builder). Then retrieve the flow (and the validation rule if you want it in source control) and deploy via your normal process.

- **If the data model is only in a Trailhead Recruiting App playground:**  
  1. Complete this project in that playground (Steps 1–3).  
  2. In your project, set the default org to that playground and retrieve:
     - Flow: `Create_Interviewer_Record`
     - Custom objects: `Position__c`, `Interviewer__c` (and any other Recruiting objects you use)
     - Validation rule: Position → `Every_Position_Must_Have_a_Hiring_Mgr`
  3. Set default org to VibeDX and deploy the retrieved metadata.

Example retrieve (from project root, default org = Trailhead playground):

```bash
sf project retrieve start -m "Flow:Create_Interviewer_Record"
# If you also need objects and validation rule:
# sf project retrieve start -m "CustomObject:Position__c,CustomObject:Interviewer__c"
# sf project retrieve start -m "ValidationRule:Position__c.Every_Position_Must_Have_a_Hiring_Mgr"
```

Deploy to VibeDX (default org = VibeDX):

```bash
sf project deploy start -m "Flow:Create_Interviewer_Record"
```

---

## References

- [Trailhead: Build an Automation for Creating Interviewer Records](https://trailhead.salesforce.com/content/learn/projects/automate-business-processes-recruiting-app/build-process-interview-records)
- [Trailhead: Build a Data Model for a Recruiting App](https://trailhead.salesforce.com/content/learn/projects/build-a-data-model-for-a-recruiting-app)
