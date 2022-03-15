package nl.vs.fuse.demo.test;

import java.io.File;
import java.io.IOException;
import java.io.StringWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.Map;

import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;

import org.apache.commons.lang3.builder.ReflectionToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.junit.Assert;
import org.w3c.dom.Node;
import org.xmlunit.builder.DiffBuilder;
import org.xmlunit.builder.Input;
import org.xmlunit.builder.Input.Builder;
import org.xmlunit.diff.ComparisonResult;
import org.xmlunit.diff.Diff;
import org.xmlunit.diff.DifferenceEvaluator;
import org.xmlunit.diff.DifferenceEvaluators;
import org.xmlunit.xpath.JAXPXPathEngine;

public class TestSupport {

	public static final String WILDCARD_TOKEN = "*";

	/**
	 * Difference evaluator that supports wildcard node value.
	 * https://osmanmrzljak.blogspot.com/2016/02/compering-xml-parts-containing-dynamic.html
	 */
	public static final DifferenceEvaluator WILD_CARD = (comparison, outcome) -> {
		if (outcome == ComparisonResult.EQUAL)
			return outcome; // only evaluate differences.
		final Node controlNode = comparison.getControlDetails().getTarget();
		if (controlNode != null && WILDCARD_TOKEN.equals(controlNode.getNodeValue())) {
			return ComparisonResult.EQUAL; // will evaluate this difference as equal
		}
		return outcome;
	};

	public static Diff getDifferences(Builder expected, Builder actual) {
		return DiffBuilder.compare(expected).withTest(actual).ignoreComments().ignoreWhitespace()
				.withDifferenceEvaluator(
						DifferenceEvaluators.first(DifferenceEvaluators.Default, TestSupport.WILD_CARD))
				.build();
	}

	public static String readFile(String pathStr) throws IOException {
		Path filePath = Path.of(pathStr);
		String content = Files.readString(filePath);
		return content;
	}

	public static File getFile(String fileName) {
		return new File(TestSupport.class.getResource(fileName).getFile());

	}

	public static Node getXMLPart(String xml, String xpath, Map<String, String> prefix2Uri)
			throws TransformerException {
		return getXMLPart(Input.fromString(xml).build(), xpath, prefix2Uri);
	}

	public static Node getXMLPart(File file, String xpath, Map<String, String> prefix2Uri) throws TransformerException {
		return getXMLPart(Input.fromFile(file).build(), xpath, prefix2Uri);
	}

	public static Node getXMLPart(Source source, String xpath, Map<String, String> prefix2Uri)
			throws TransformerException {
		JAXPXPathEngine engine = new JAXPXPathEngine();
		String prefixString = "";
		if (prefix2Uri != null) {
			engine.setNamespaceContext(prefix2Uri);
			prefixString = " (" + ReflectionToStringBuilder.toString(prefix2Uri, ToStringStyle.SIMPLE_STYLE) + ")";
		}

		Node lastNode = null;
		int count = 0;
		for (Node node : engine.selectNodes(xpath, source)) {
			lastNode = node;
			count++;
		}

		Assert.assertEquals("XPath expression " + xpath + prefixString
				+ " didn't select exactly 1 XML Node (Element) from XML: " + serialize(source), 1, count);
		return lastNode;
	}

	public static String serialize(Source src) throws TransformerException {
		TransformerFactory transformerFactory = TransformerFactory.newInstance();
		Transformer transformer = transformerFactory.newTransformer();
		StringWriter writer = new StringWriter();
		Result result = new StreamResult(writer);
		transformer.transform(src, result);
		return writer.toString();
	}

	public static void assertEqualsXML(String result, String expectedResult) {
		Diff diffs = getDifferences(Input.fromString(expectedResult), Input.fromString(result));
		Assert.assertFalse(diffs.toString(), diffs.hasDifferences());
	}
}
