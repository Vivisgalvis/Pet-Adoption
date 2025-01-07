public class VaccinationReminderBatch implements Database.Batchable<SObject> {
    public Database.QueryLocator start(Database.BatchableContext bc) {
        // Aquí defines los registros que procesará el batch
        return Database.getQueryLocator([
            SELECT Id, Name,Date_of_next_vaccination__c 
            FROM Pet__c 
            WHERE Date_of_next_vaccination__c < TODAY
        ]);
    }

    public void execute(Database.BatchableContext bc, List<Pet__c> scope) {
        // Aquí defines las acciones a realizar con los registros seleccionados
        List<Task> tasks = new List<Task>();
        for (Pet__c pet : scope) {
            tasks.add(new Task(
                Subject = 'Vaccination reminder',
                ActivityDate = Date.today(),
                OwnerId = UserInfo.getUserId(), // Asigna al usuario administrador
                WhatId = pet.Id, // Relaciona con la mascota
                Status = 'Not Started'
            ));
        }
        insert tasks; // Inserta las tareas
    }

    public void finish(Database.BatchableContext bc) {
        // Este bloque se ejecuta al finalizar el batch
        System.debug('Batch process completed');
    }
}
