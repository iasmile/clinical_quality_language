package org.cqframework.cql.cql2elm.anc;

import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.atn.ATN;
import org.antlr.v4.runtime.atn.DecisionInfo;
import org.antlr.v4.runtime.atn.DecisionState;
import org.antlr.v4.runtime.atn.ParseInfo;
import org.antlr.v4.runtime.atn.PredictionMode;
import org.antlr.v4.runtime.misc.Interval;
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
   public void testAncDakErrorListener() throws IOException {
      var cs = CharStreams.fromStream(BaseTest.class.getResourceAsStream("ANCContactDataElementsAmbig.cql"));
      cqlLexer lexer = new cqlLexer(cs);
      CommonTokenStream tokens = new CommonTokenStream(lexer);
      cqlParser parser = new cqlParser(tokens);
      var listener = new org.antlr.v4.runtime.DiagnosticErrorListener();
      parser.addErrorListener(listener); // add ours
      parser.getInterpreter().setPredictionMode(PredictionMode.LL_EXACT_AMBIG_DETECTION);
      parser.library();
   }


   @Test
   public void testAncDakProfile() throws IOException {
      var cs = CharStreams.fromStream(BaseTest.class.getResourceAsStream("ANCContactDataElementsExtreme.cql"));
      cqlLexer lexer = new cqlLexer(cs);
      CommonTokenStream tokens = new CommonTokenStream(lexer);
      cqlParser parser = new cqlParser(tokens);
      var listener = new org.antlr.v4.runtime.DiagnosticErrorListener();
      parser.addErrorListener(listener); // add ours
      parser.getInterpreter().setPredictionMode(PredictionMode.LL_EXACT_AMBIG_DETECTION);
      parser.setProfile(true);
      parser.library();

      ParseInfo parseInfo = parser.getParseInfo();
      ATN atn = parser.getATN();
      for (DecisionInfo di : parseInfo.getDecisionInfo()) {
         DecisionState ds = atn.decisionToState.get(di.decision);
         String ruleName = cqlParser.ruleNames[ds.ruleIndex];

         System.out.println(ruleName +" -> " + di.toString());

         if (di.ambiguities.size() > 0) {
            System.out.println("ambiguities");
            for (var a : di.ambiguities) {

               String text = a.input.getText(Interval.of(a.startIndex, a.stopIndex));
               System.out.printf("alts: %s, decision: %s, range: %s-%s, text: %n%s%n", a.ambigAlts.size(), a.decision,
                     a.startIndex, a.stopIndex, text);
            }
         }
      }
   }



   @Test
   public void testAncDakStepped() throws IOException {

      int iterations = 100;
      int step = 10;
      long time = 0;

      var sw = new StopWatch();
      sw.start();
      for (int i = 0; i < iterations; i++) {
         var cs = CharStreams.fromStream(BaseTest.class.getResourceAsStream("ANCContactDataElementsExtreme.cql"));
         cqlLexer lexer = new cqlLexer(cs);
         CommonTokenStream tokens = new CommonTokenStream(lexer);
         cqlParser parser = new cqlParser(tokens);
         parser.library();

         if (i > 0 && i % step == 0) {
            var mills = sw.getTime(TimeUnit.MILLISECONDS);
            var diff = mills - time;
            time = mills;

            System.out.printf("iteration: %s, avg ms %s%n", i, (double) diff / step);

         }
      }

   }
}
