import ballerina/log;
import ballerina/test;


Client myclient = check new();

@test:Config{}
function testGetCountryPopulation() returns error? {
    var result = myclient->getPopulation(date="2000");
    if result is CountryPopulation[] {
        log:printInfo("Results: " + result.length().toString()+" records found");
    }else{
        log:printError(result.message());
        test:assertFail(result.toString());
    }
}
