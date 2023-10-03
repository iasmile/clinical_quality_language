package org.opencds.cqf.cql.engine.fhir.data;
import org.testng.annotations.Test;
import static org.testng.Assert.assertEquals;
import java.util.Collections;
import java.util.Map;
import org.hl7.fhir.r4.model.HumanName;
import org.hl7.fhir.r4.model.Patient;
import org.opencds.cqf.cql.engine.data.CompositeDataProvider;
import org.opencds.cqf.cql.engine.data.DataProvider;
import org.opencds.cqf.cql.engine.execution.Environment;
import org.opencds.cqf.cql.engine.retrieve.RetrieveProvider;
import org.opencds.cqf.cql.engine.runtime.Code;
import org.opencds.cqf.cql.engine.runtime.Interval;
public class Issue1223 extends FhirExecutionTestBase {
    @Override
    public Environment getEnvironment() {
        var retriever = new RetrieveProvider() {
            @Override
            public Iterable<Object> retrieve(String context, String contextPath, Object contextValue, String dataType,
                    String templateId, String codePath, Iterable<Code> codes, String valueSet, String datePath,
                    String dateLowPath, String dateHighPath, Interval dateRange) {
                if (dataType == null || !dataType.equals("Patient"))  {
                    return Collections.emptyList();
                }
                else {
                    return Collections.singletonList(
                        new Patient().setName(
                            Collections.singletonList(
                                new HumanName().addGiven("John"))));
                }
                /*
                 * {
                 *   "resourceType": "Patient",
                 *   "name": [
                 *      {
                 *        "given": [ "John" ]
                 *      }
                 *    ]
                 * }
                 */
            }
        };
        var provider = new CompositeDataProvider(r4ModelResolver, retriever);
        return new Environment(getLibraryManager(), Map.<String, DataProvider>of("http://hl7.org/fhir", provider), null) ;
    }
    @Test
    public void testPatientResource() {
        var engine = getEngine();
        var evaluationResult = engine.evaluate(toElmIdentifier("Issue1223"));
        Object result = evaluationResult.expressionResults.get("Name").value();
        assertEquals(result, "John");
    }
}