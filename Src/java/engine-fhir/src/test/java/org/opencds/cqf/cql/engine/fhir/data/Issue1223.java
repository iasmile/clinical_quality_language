package org.opencds.cqf.cql.engine.fhir.data;

import org.testng.annotations.Test;

import static org.testng.Assert.assertEquals;


public class Issue1223 extends FhirExecutionTestBase {

    @Test
    public void testPatientResource() {

        var engine = getEngine();
        var evaluationResult = engine.evaluate(toElmIdentifier("Issue1223"));
        Object result = evaluationResult.expressionResults.get("Patient").value();
        assertEquals(result, "Patient");
    }
}
