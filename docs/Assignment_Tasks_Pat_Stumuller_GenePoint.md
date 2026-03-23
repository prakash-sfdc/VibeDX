# Assignment: Create Tasks (Pat Stumuller, GenePoint) and Mark One Complete

## What was done

1. **Task on Pat Stumuller contact**
   - **Subject:** Reserve installation capacity for next quarter  
   - **Name:** Pat Stumuller (Contact)  
   - **Status:** In Progress  

2. **Task on GenePoint account**
   - **Subject:** Mail battery backup product catalog  
   - **Name:** Edna Frank (Contact, WhoId)  
   - **Account:** GenePoint (WhatId)  

3. **Mark the "Mail battery backup product catalog" task complete**  
   - The second task’s Status was set to **Completed** after creation.

## How it was built and deployed

- **Apex class:** `AssignmentTaskCreator` (in `force-app/main/default/classes/`)  
  - Creates Contact **Pat Stumuller** and **Edna Frank** and Account **GenePoint** if they don’t exist.  
  - Creates the two tasks and then updates the GenePoint task to Completed.  

- **Deployed to VibeDX:** `sf project deploy start -m ApexClass:AssignmentTaskCreator`  

- **Script run once:** `sf apex run --file scripts/run-assignment-tasks.apex`  
  - Executes `AssignmentTaskCreator.createAndCompleteAssignmentTasks();`  

The script has already been run in the VibeDX org; the tasks exist and the “Mail battery backup product catalog” task is complete.

## Run again (optional)

To create the same set of tasks again in the same or another org (after deploy):

```bash
sf apex run --file scripts/run-assignment-tasks.apex
```

Or in Developer Console: **Debug → Open Execute Anonymous Window**, paste:

```apex
AssignmentTaskCreator.createAndCompleteAssignmentTasks();
```

Then **Execute**.
