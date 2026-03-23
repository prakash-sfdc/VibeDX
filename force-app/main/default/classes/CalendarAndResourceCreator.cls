/**
 * Creates the public group "Sales Reps" so it can be used for sharing
 * Public Calendars and Resources. Public calendars and resources cannot be
 * created via Apex (Calendar is not insertable); create them in Setup and
 * share with this group. Run createSalesRepsGroup() then follow the guide
 * in docs/Calendar_And_Resource_Assignment.md.
 */
public with sharing class CalendarAndResourceCreator {
    private static final String GROUP_NAME = 'Sales Reps';

    /** Creates the public group "Sales Reps" if it does not exist. */
    public static void createSalesRepsGroup() {
        getOrCreateSalesRepsGroup();
    }

    public static Id getOrCreateSalesRepsGroup() {
        List<Group> groups = [
            SELECT Id FROM Group
            WHERE Name = :GROUP_NAME
            AND Type = 'Regular'
            LIMIT 1
        ];
        if (!groups.isEmpty()) {
            return groups[0].Id;
        }
        Group g = new Group(
            Name = GROUP_NAME,
            Type = 'Regular'
        );
        insert g;
        return g.Id;
    }
}
