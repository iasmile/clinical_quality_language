package org.cqframework.cql.cql2elm;

import jdk.nashorn.internal.ir.annotations.Ignore;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import java.io.IOException;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.is;
import static org.hamcrest.Matchers.not;

public class LibraryTests {

    ModelManager modelManager;
    LibraryManager libraryManager;
  
    @BeforeClass
    public void setup() {
        modelManager = new ModelManager();
        libraryManager = new LibraryManager(modelManager);
        libraryManager.getLibrarySourceLoader().registerProvider(new TestLibrarySourceProvider());
    }

    @AfterClass
    public void tearDown() {
        libraryManager.getLibrarySourceLoader().clearProviders();
    }

    @Test
    public void testLibraryReferences() {
        CqlTranslator translator = null;
        try {
            translator = CqlTranslator.fromStream(LibraryTests.class.getResourceAsStream("LibraryTests/ReferencingLibrary.cql"), modelManager, libraryManager);
            assertThat(translator.getErrors().size(), is(0));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Test
    public void testInvalidLibraryReferences() {
        CqlTranslator translator = null;
        try {
            translator = CqlTranslator.fromStream(LibraryTests.class.getResourceAsStream("LibraryTests/InvalidReferencingLibrary.cql"), modelManager, libraryManager);
            assertThat(translator.getErrors().size(), is(not(0)));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    //@Test
    public void testDuplicateExpressionLibrary() {
        CqlTranslator translator = null;
        try {
            translator = CqlTranslator.fromStream(LibraryTests.class.getResourceAsStream("LibraryTests/DuplicateExpressionLibrary.cql"), modelManager, libraryManager);
            assertThat(translator.getErrors().size(), is(1));
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
