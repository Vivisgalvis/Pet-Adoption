@isTest
public class CalculateNextVaccinationDateTest {
    @isTest
    static void testCalculateNextVaccination() {
        // Simula los metadatos personalizados como un mapa
        Map<String, Decimal> simulatedMetadata = new Map<String, Decimal>();
        simulatedMetadata.put('Dog', 365);
        simulatedMetadata.put('Cat', 180);

        // Crea un registro de prueba para Mascota
        Pet__c pet = new Pet__c(
            Name = 'Fido',
            Species__c = 'Dog',
            Date_of_last_vaccination__c = Date.today()
        );

        // Simula el comportamiento del disparador
        Test.startTest();
        CalculateNextVaccinationHelper.calculateNextVaccination(new List<Pet__c>{pet});
        Test.stopTest();

        // Verifica el resultado
        System.assertEquals(Date.today().addDays(365), pet.Date_of_next_vaccination__c);
    }
}