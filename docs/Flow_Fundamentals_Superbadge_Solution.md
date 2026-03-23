# Flow Fundamentals Superbadge – Solution Guide

Step-by-step implementation for the [Flow Fundamentals Superbadge](https://trailhead.salesforce.com/content/learn/superbadges/superbadge_flow_basics_sbu), based on the [Avenoir solution](https://www.avenoir.ai/post/flow-fundamentals-superbadge-solution) and official Trailhead requirements.

---

## Important: Where to Build This

This superbadge is designed to be completed in the **Trailhead-provisioned Developer Edition org** (special configuration), not in your production or VibeDX org.

- **Sign up:** [Developer Edition org with special configuration](https://trailhead.salesforce.com/en/promo/orgs/earn-the-flow-elements-and-resources-specialist-superbadge)
- **Connect** that org to Trailhead and run **Check Challenge** from the superbadge page.
- **VibeDX / other orgs:** The Book Order, Recommendation Email, and Birthday Loyalty flows plus custom objects (e.g. Book Order, Contact custom fields) exist only in the Trailhead org. To have the same solution in VibeDX, complete the steps below in the Trailhead org, then **retrieve** the three flows (and any custom objects) from that org into your project and **deploy** to VibeDX. The challenge verification will still only pass in the connected Trailhead org.

---

## Challenge 1: Create Tasks According to Specific Criteria

**Goal:** Update the **Book Order** flow so that tasks are created when the order has 3, 4, or 5+ books (bookmark for 3–4, bookmark and sticker for 5+).

### 1. Decision element

- **API name:** `How Many Books in the Order?`
- **Outcomes:**
  - **Three/Four Orders** – condition: `varBooksAdded` **Equals** 3 **OR** `varBooksAdded` **Equals** 4 (or “Equals 3 or 4” if available).
  - **Five or more Orders** – condition: `varBooksAdded` **Greater Than or Equal to** 5.
- Use the existing **varBooksAdded** variable.

### 2. Formula resource

- **API name:** `DueDate`
- **Formula:** `{!$Flow.CurrentDate}+1`

### 3. Create Records – task for 3 or 4 books

- **Object:** Task  
- **Subject:** `Add Bookmark`  
- **WhatId:** `{!Create_Book_Order}` (record ID from the Create Book Order element)  
- **OwnerId:** `{!Get_Records_for_Queue.Id}` (queue from “Get Records for Queue”)  
- **ActivityDate:** `{!DueDate}`  

Connect this Create Records element to the **Three/Four Orders** outcome.

### 4. Create Records – task for 5+ books

- **Object:** Task  
- **Subject:** `Add Bookmark and Sticker`  
- **WhatId:** `{!Create_Book_Order}`  
- **OwnerId:** `{!Get_Records_for_Queue.Id}`  
- **ActivityDate:** `{!DueDate}`  

Connect this Create Records element to the **Five or more Orders** outcome.

### 5. Default outcome

- Connect the **default** outcome of the Decision to the existing **Create Book Order Line Items** Create Records element (so orders that don’t match 3–4 or 5+ still continue the flow).

### 6. Verify

- Save the flow. Run **Book Order** from a Contact record (create a Book Order with 3, 4, or 5+ books) and confirm the right tasks are created. Then run **Check Challenge** on the superbadge page.

---

## Challenge 2: Add More Details to the Email and Update the Customer Record

**Goal:** Update the **Recommendation Email** flow so the email body includes book and contact details, the Contact’s **Last Outreach** is set, and a **Confirmation Screen** is the last screen.

### 1. Email body (Text Template)

Update the **EmailBody** text template so it includes the reader’s first name and the current recommendation (title, author, summary). Example:

```text
Dear {!Get_Customer_Info.FirstName},

Thanks for being a customer of Dreamscape Bookshop! We also like the books you bought recently, and we've got another one like it that we think you'll love! Check it out!

Name: {!Get_Customer_Info.Current_Recommendation__r.Name}
Author: {!Get_Customer_Info.Current_Recommendation__r.Author__c}
Summary: {!Get_Customer_Info.Current_Recommendation__r.Book_Summary__c}
```

(Adjust merge field API names to match your org’s Contact and Book/Recommendation fields if different.)

### 2. Assignment – Last Outreach

- **New Assignment** element.
- Set **Last Outreach** on the contact to the current date/time:  
  `{!Get_Customer_Info.Last_Outreach__c}` **Equals** `{!$Flow.CurrentDateTime}`

### 3. Update contact

- **New Update Records** element.
- Update the **Contact** using the record variable **Get_Customer_Info** (so the assigned Last Outreach value is saved).

### 4. Confirmation screen

- **New Screen** element.
- **API name:** `Confirmation_Screen`
- **Display text:** `Your email has been sent`
- **Footer:** Hide **Previous** and **Pause** so this is the final screen.
- Place this screen **after** the send-email and update-contact steps so it is the **last** element in the flow.

### 5. Confirmation Screen error

If the challenge says: *“We can't find the new screen element called Confirmation Screen setup correctly on the Recommendation Email flow”*:

- Confirm the **API name** is exactly `Confirmation_Screen` (underscore, no spaces).
- Confirm the screen is the **last** element (no elements after it).
- Save, run the flow once from a Contact, then run **Check Challenge** again.

---

## Challenge 3: Update the Birthday Loyalty Points Update Flow

**Goal:** In the **Birthday Loyalty Points Update** flow, add bonus points by loyalty level (Bronze +100, Silver +250, Gold +500).

### 1. Formula resource

- **Name:** `AssignLoyaltyPoints` (or as required; spelling may be “Loyality” in some instructions)
- **Formula:**

```text
Case(
  {!Loop_Through_Contacts.Loyalty_Status__c},
  'Bronze', {!Loop_Through_Contacts.Loyalty_Points__c} + 100,
  'Silver', {!Loop_Through_Contacts.Loyalty_Points__c} + 250,
  'Gold', {!Loop_Through_Contacts.Loyalty_Points__c} + 500,
  {!Loop_Through_Contacts.Loyalty_Points__c}
)
```

### 2. Assignment

- **New Assignment** element.
- Set **Loyalty Points** on the contact:  
  `{!Loop_Through_Contacts.Loyalty_Points__c}` **Equals** `{!AssignLoyaltyPoints}`

### 3. Update record

- **New Update Records** element.
- Update the Contact using the record variable **Customercontactforemail** (or the variable that holds the contact record in the loop).

### 4. Verify

- Save the flow. Run **Check Challenge** for Challenge 3.

---

## Optional: Retrieve from Trailhead Org and Deploy to VibeDX

If you want the same flows in your VibeDX source org:

1. **Complete** all three challenges in the Trailhead-connected Developer Edition org (using this guide).
2. In your project (with default org set to that Trailhead org), retrieve the flows and any custom objects:

   ```bash
   sf project retrieve start -m "Flow:Book_Order,Flow:Recommendation_Email,Flow:Birthday_Loyalty_Points_Update"
   # If custom objects are needed:
   # sf project retrieve start -m "CustomObject:Book_Order__c,CustomObject:Contact"  # etc.
   ```

3. Set the default org to VibeDX and deploy:

   ```bash
   sf config set target-org <vibedx-alias>
   sf project deploy start -m "Flow:Book_Order,Flow:Recommendation_Email,Flow:Birthday_Loyalty_Points_Update"
   ```

Note: Challenge verification only runs in the Trailhead-connected org. Deploying to VibeDX is for reuse/copy of the solution, not for passing the superbadge.

---

## References

- [Superbadge: Flow Fundamentals](https://trailhead.salesforce.com/content/learn/superbadges/superbadge_flow_basics_sbu)
- [Flow Elements and Resources Specialist Superbadge – Challenge Help](https://trailhead.salesforce.com/en/help?article=Flow-Elements-and-Resources-Specialist-Superbadge-Trailhead-Challenge-Help)
- [Avenoir: Flow Fundamentals Superbadge Solution](https://www.avenoir.ai/post/flow-fundamentals-superbadge-solution)
