package org.opencds.cqf.cql.engine.execution;

import org.testng.annotations.Test;

import static org.testng.Assert.assertEquals;


public class Issue1223 extends CqlTestBase {

    @Test
    public void testPatientResource() {

        EvaluationResult evaluationResult;

        evaluationResult = engine.evaluate(toElmIdentifier("Issue1223"));
        Object result = evaluationResult.expressionResults.get("Patient").value();
        assertEquals(result, "Patient");
    }
}
