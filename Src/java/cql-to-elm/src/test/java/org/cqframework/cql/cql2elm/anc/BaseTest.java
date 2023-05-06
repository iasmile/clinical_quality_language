package org.cqframework.cql.cql2elm.anc;

import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;
import org.apache.commons.lang3.time.StopWatch;
import org.cqframework.cql.cql2elm.CqlTranslator;
import org.cqframework.cql.cql2elm.CqlTranslatorOptions;
import org.cqframework.cql.cql2elm.TestUtils;
import org.cqframework.cql.gen.cqlLexer;
import org.cqframework.cql.gen.cqlParser;
import org.hl7.elm.r1.*;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

import static org.cqframework.cql.cql2elm.TestUtils.visitFile;
import static org.cqframework.cql.cql2elm.matchers.Quick2DataType.quick2DataType;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.Matchers.*;

public class BaseTest {

   @Test
   public void testAncDak() throws IOException {
      int iterations = 1000;
      int step = 10;
      long last = 0;
      var sw = new StopWatch();

      sw.start();
      for (int i = 0; i < iterations; i ++) {

         var cs = CharStreams.fromStream(BaseTest.class.getResourceAsStream("ANCContactDataElements.cql"));
         cqlLexer lexer = new cqlLexer(cs);
         CommonTokenStream tokens = new CommonTokenStream(lexer);
         cqlParser parser = new cqlParser(tokens);
         parser.setBuildParseTree(true);
         ParseTree tree = parser.library();

         if (i > 0 & i % step == 0) {
            var millis = sw.getTime(TimeUnit.MILLISECONDS);
            var time = millis - last;
            last = millis;
            System.out.printf("iteration: %s, step time: %s, step avg: %s%n", i, time, (double)time / step);
         }
      }

      sw.stop();
      var millis = sw.getTime(TimeUnit.MILLISECONDS);

      System.out.printf("iterations: %s, time: %s, avg: %s%n", iterations, millis, (double)millis / iterations);

   }
}
