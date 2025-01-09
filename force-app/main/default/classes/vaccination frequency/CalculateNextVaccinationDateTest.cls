@isTest
public class CalculateNextVaccinationDateTest {
    @isTest
    static void testTrigger() {
        // Configurar datos de prueba
        Pet__c pet = new Pet__c(
            Name = 'Fido',
            Species__c = 'Dog',
            Date_of_last_vaccination__c = Date.today()
        );

        insert pet;

        // Verificar la fecha de próxima vacunación
        Pet__c insertedPet = [SELECT Date_of_next_vaccination__c FROM Pet__c WHERE Id = :pet.Id];
        System.assertNotEquals(null, insertedPet.Date_of_next_vaccination__c);
        System.assertEquals(Date.today().addDays(365), insertedPet.Date_of_next_vaccination__c);
    }
}