trigger OrderEventTrigger on Order_Event__e (after insert) {
    // List to hold all cases to be created.
    List<Task> tasks = new List<Task>();
    // Get queue Id for case owner
    // Group queue = [SELECT Id FROM Group WHERE Name='Regional Dispatch' AND Type='Queue'];
    // Iterate through each notification.
    for (Order_Event__e event : Trigger.New) {
        if (event.Has_Shipped__c == true) {
            // Create
            Task t = new Task();
            t.Priority = 'Medium';
            t.Subject = 'Follow up on shipped order ' + event.Order_Number__c;
            t.OwnerId = event.CreatedById;
            // cs.Priority = 'High';
            // cs.Subject = 'News team dispatch to ' +
            //     event.Location__c;
            // cs.OwnerId = queue.Id;
            tasks.add(t);
        }
    }
    // Insert all tasks corresponding to events received.
    insert tasks;
}