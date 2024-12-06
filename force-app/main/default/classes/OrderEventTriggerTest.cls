/**
 * This class contains unit tests for validating the behavior of
 *  trigger related to the Platform Event OrderEvent
 */
@isTest
private class OrderEventTriggerTest {

    @isTest
    static void testOrderEvent() {
        // Create Order Event
        Order_Event__e orderEvent = new Order_Event__e(
            Has_Shipped__c = true,
            Order_Number__c = '555444');
        Test.startTest();
        // Call method to publish order event
        Database.SaveResult sr = EventBus.publish(orderEvent);
        Test.stopTest();
        // Perform validation here
        // Validate that the publish was successful
        System.assert(sr.isSuccess(), String.valueOf(sr.getErrors()));
        // Check that the task that the trigger created is present.
        List<Task> tasks = [SELECT Subject, Priority FROM Task];
        // Validate that this task was found
        System.assertEquals(1, tasks.size(), 'A task must exist');
        // Validate that the task matches the event
        System.assert(tasks[0].Subject.contains(orderEvent.Order_Number__c), 'Task subject must contain the order number.');
        // Validate that the task's priority is set to 'Medium'
        System.assertEquals('Medium', tasks[0].Priority, 'Task priority must be "Medium"');
    }
}