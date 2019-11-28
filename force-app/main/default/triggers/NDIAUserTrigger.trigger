/*This trigger is written to handle all the scenarios on User object
----------------------------------Mukul Mishra--------------------------
----------------------------------18/11/2019----------------------------
------------------------------User story -0006 ------------------------- */
trigger NDIAUserTrigger on User (after insert) {
  NDIAUserTriggerHandler objNDIAAddToPublicGroup= new NDIAUserTriggerHandler();
    if(trigger.isAfter && trigger.isInsert)
    {
      objNDIAAddToPublicGroup.addMembertoNDIAGroup(trigger.new);

     
    }
}