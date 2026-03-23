/**
 * Creates assignment tasks per requirements:
 * 1. Task on Pat Stumuller contact: Subject "Reserve installation capacity for next quarter", Status In Progress
 * 2. Task on GenePoint account: Subject "Mail battery backup product catalog", Name: Edna Frank (WhoId), Account: GenePoint (WhatId)
 * 3. Mark the "Mail battery backup product catalog" task complete
 *
 * If Contact (Pat Stumuller), Account (GenePoint), or Contact (Edna Frank) do not exist, they are created
 * using a default Account for contacts (required).
 */
public with sharing class AssignmentTaskCreator {
    public static void createAndCompleteAssignmentTasks() {
        List<Task> toInsert = new List<Task>();
        Task genePointTask = null;

        // Ensure Pat Stumuller contact exists
        Id patStumullerId = getOrCreateContact('Pat', 'Stumuller', null);

        // Task 1: On Pat Stumuller contact
        toInsert.add(new Task(
            Subject = 'Reserve installation capacity for next quarter',
            WhoId = patStumullerId,
            Status = 'In Progress'
        ));

        // Ensure GenePoint account exists
        Id genePointId = getOrCreateAccount('GenePoint');
        // Ensure Edna Frank contact exists (prefer linked to GenePoint)
        Id ednaFrankId = getOrCreateContact('Edna', 'Frank', genePointId);

        // Task 2: On GenePoint account, WhoId = Edna Frank
        genePointTask = new Task(
            Subject = 'Mail battery backup product catalog',
            WhatId = genePointId,
            WhoId = ednaFrankId,
            Status = 'Not Started'
        );
        toInsert.add(genePointTask);

        insert toInsert;

        // Mark "Mail battery backup product catalog" task complete
        genePointTask.Status = 'Completed';
        update genePointTask;
    }

    private static Id getOrCreateAccount(String name) {
        List<Account> accounts = [SELECT Id FROM Account WHERE Name = :name LIMIT 1];
        if (!accounts.isEmpty()) {
            return accounts[0].Id;
        }
        Account a = new Account(Name = name);
        insert a;
        return a.Id;
    }

    private static Id getOrCreateContact(String firstName, String lastName, Id accountId) {
        List<Contact> contacts = [
            SELECT Id FROM Contact
            WHERE FirstName = :firstName AND LastName = :lastName
            LIMIT 1
        ];
        if (!contacts.isEmpty()) {
            return contacts[0].Id;
        }
        if (accountId == null) {
            List<Account> defaultAccounts = [SELECT Id FROM Account LIMIT 1];
            accountId = defaultAccounts.isEmpty() ? null : defaultAccounts[0].Id;
        }
        Contact c = new Contact(FirstName = firstName, LastName = lastName, AccountId = accountId);
        insert c;
        return c.Id;
    }

    public class AssignmentTaskException extends Exception {}
}
