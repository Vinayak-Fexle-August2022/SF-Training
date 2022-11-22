@isTest
public class Test_Addition
{
	@istest 
    private Static Void testDoSum()
    {
        Integer Num1 = 10;
        Integer Num2 = 5;
        Addition ad = new Addition();
        Integer resultForAddition = ad.doSum(Num1, Num2);
        Decimal resultForDivision = ad.doDivision(Num1, Num2);
        Integer resultForMultiplication = ad.doMultiplication(Num1, Num2);
        
        //assert for addition of the given values
        System.assertEquals(15, resultForAddition);
        
        //assert for multiplication of the given values
        System.assertEquals(50, resultForMultiplication);
        
        //assert for multiplication of the given values
        System.assertEquals(2, resultForDivision);
    } 
}