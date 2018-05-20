package FileIO;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import utils.*;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.File;
import java.util.ArrayList;

public class PatternXmlReader {


    public VerbEntity readXMLFile(int verbId) {
        VerbEntity verbEntity = null;
        try {

            File fXmlFile = new File("__PatternBank/v" + verbId + ".xml");
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(fXmlFile);

            //optional, but recommended
            //read this - http://stackoverflow.com/questions/13786607/normalization-in-dom-parsing-with-java-how-does-it-work
            doc.getDocumentElement().normalize();

            NodeList nList = doc.getElementsByTagName("verb");
            Node verbRoot = nList.item(0);

            if(verbRoot.getNodeType() == Node.ELEMENT_NODE)
            {
                Element verb = (Element) verbRoot;
                String verbForm = verb.getAttribute("form");

                verbEntity = new VerbEntity(verbId,verbForm);

                NodeList patterns = ((Element) verbRoot).getElementsByTagName("pattern");
                for(int patternId = 1; patternId <= patterns.getLength(); patternId++)
                {
                    Node patternRoot = patterns.item(patternId-1);

                    if(patternRoot.getNodeType() == Node.ELEMENT_NODE)
                    {
                        Element pattern = (Element) patternRoot;
                        String formRo = pattern.getAttribute("form_ro");
                        String formEn = pattern.getAttribute("form_en");

                        VerbPattern returnPattern =  new VerbPattern(verbId,patternId, formRo, formEn);

                        if(pattern.hasAttribute("PWN"))
                        {
                            String pwn = pattern.getAttribute("PWN");
                            returnPattern.setPWN(pwn);
                        }

                        NodeList patternElements = patternRoot.getChildNodes();
                        for(int i = 0; i < patternElements.getLength(); i++)
                        {
                            Node nNode = patternElements.item(i);
                            if(nNode.getNodeType() == Node.ELEMENT_NODE)
                            {
                                Element element = (Element) nNode;
                                switch (element.getTagName())
                                {
                                    case "type":
                                    {

                                        int typeId = Integer.parseInt(element.getAttribute("id"));
                                        String syntacticType = element.getAttribute("syntactic_type");
                                        String patternType = element.getAttribute("pattern_type");
                                        String head = element.getAttribute("head");

                                        VerbPatternType verbPatternType = new VerbPatternType(typeId, syntacticType, patternType, head);
                                        returnPattern.setVerbPatternType(verbPatternType);
                                        break;
                                    }
                                    case "dependencies":
                                    {

                                        NodeList dependenciesRoot = nNode.getChildNodes();
                                        returnPattern.setPatternInfo(parseDependencies(dependenciesRoot));

                                        break;
                                    }
                                    case "implicature":
                                    {
                                        String implicatureText = element.getTextContent();
                                        returnPattern.addImplicature(implicatureText);
                                        break;
                                    }
                                    case "example":
                                    {
                                        String treebankId = element.getAttribute("corpus");
                                        String sentenceId = element.getAttribute("sentence_id");
                                        int wordId = Integer.parseInt(element.getAttribute("word_id"));
                                        returnPattern.addExample(new Occurrence(treebankId, sentenceId, wordId));
                                        break;
                                    }
                                }
                            }
                        }
                        verbEntity.addPattern(returnPattern);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return verbEntity;
    }

    public VerbPattern getPattern(int verbId, int patternId)
    {
        VerbPattern returnPattern = null;
        try {

            File fXmlFile = new File("__PatternBank/v" + verbId + ".xml");
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(fXmlFile);

            //optional, but recommended
            //read this - http://stackoverflow.com/questions/13786607/normalization-in-dom-parsing-with-java-how-does-it-work
            doc.getDocumentElement().normalize();

            NodeList nList = doc.getElementsByTagName("verb");
            Node verbRoot = nList.item(0);

            if(verbRoot.getNodeType() == Node.ELEMENT_NODE)
            {
                Element verb = (Element) verbRoot;
                String verbForm = verb.getAttribute("form");

                NodeList patterns = ((Element) verbRoot).getElementsByTagName("pattern");
                if(patterns.getLength() >= patternId)
                {
                    Node patternRoot = patterns.item(patternId-1);

                    if(patternRoot.getNodeType() == Node.ELEMENT_NODE )
                    {
                        Element pattern = (Element) patternRoot;
                        String formRo = pattern.getAttribute("form_ro");
                        String formEn = pattern.getAttribute("form_en");

                        returnPattern =  new VerbPattern(verbId, patternId, formRo, formEn);

                        if(pattern.hasAttribute("PWN"))
                        {
                            String pwn = pattern.getAttribute("PWN");
                            returnPattern.setPWN(pwn);
                        }

                        NodeList patternElements = patternRoot.getChildNodes();

                        for(int i = 0; i < patternElements.getLength(); i++)
                        {
                            Node nNode = patternElements.item(i);

                            if(nNode.getNodeType() == Node.ELEMENT_NODE )
                            {

                                Element element = (Element) nNode;


                                switch (element.getTagName())
                                {
                                    case "type":
                                    {

                                        int typeId = Integer.parseInt(element.getAttribute("id"));
                                        String syntacticType = element.getAttribute("syntactic_type");
                                        String patternType = element.getAttribute("pattern_type");
                                        String head = element.getAttribute("head");

                                        VerbPatternType verbPatternType = new VerbPatternType(typeId, syntacticType, patternType, head);
                                        returnPattern.setVerbPatternType(verbPatternType);
                                        break;
                                    }
                                    case "dependencies":
                                    {

                                        NodeList dependenciesRoot = nNode.getChildNodes();
                                        returnPattern.setPatternInfo(parseDependencies(dependenciesRoot));

                                        break;
                                    }
                                    case "implicature":
                                    {
                                        String implicatureText = nNode.getTextContent();
                                        returnPattern.addImplicature(implicatureText);
                                        break;
                                    }

                                    case "example":
                                    {
                                        String treebankId = element.getAttribute("corpus");
                                        String sentenceId = element.getAttribute("sentence_id");
                                        int wordId = Integer.parseInt(element.getAttribute("word_id"));
                                        returnPattern.addExample(new Occurrence(treebankId, sentenceId, wordId));
                                        break;
                                    }
                                    default:
                                    {
                                        break;
                                    }
                                }
                            }

                        }

                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return returnPattern;
    }

    private VerbPatternInfo parseDependencies (NodeList dependenciesRoot)
    {
        VerbPatternInfo verbPatternInfo = new VerbPatternInfo();
        //Parsing restrictions
        for(int i=0;i<dependenciesRoot.getLength();i++)
        {
            if(dependenciesRoot.item(i).getNodeType() == Node.ELEMENT_NODE)
            {
                Element element = (Element) dependenciesRoot.item(i);
                int index = 1;
                switch (element.getTagName())
                {
                    case "restrictions":
                    {
                        while( element.hasAttribute("classic_" + index))
                        {
                            verbPatternInfo.addClassicRestriction(element.getAttribute("classic_"+index));

                            index++;
                        }

                        index = 1;

                        while( element.hasAttribute("UD_" + index))
                        {
                            verbPatternInfo.addUDRestriction(element.getAttribute("UD_"+index));

                            index++;
                        }

                        index = 1;

                        while( element.hasAttribute("semantic_" + index))
                        {
                            verbPatternInfo.addSemanticRestriction(element.getAttribute("semantic_"+index));

                            index++;
                        }
                        break;
                    }
                    case "advanced_arguments":
                    {
                        while( element.hasAttribute("type_classic_" + index))
                        {
                            verbPatternInfo.addClassicAdvancedArgument(element.getAttribute("type_classic_"+index));

                            index++;
                        }

                        index = 1;

                        while( element.hasAttribute("type_UD_" + index))
                        {
                            verbPatternInfo.addUDAdvancedArgument(element.getAttribute("type_UD_"+index));

                            index++;
                        }

                        index = 1;

                        while( element.hasAttribute("type_semantic_" + index))
                        {
                            verbPatternInfo.addSemanticAdvancedArgument(element.getAttribute("semantic_"+index));

                            index++;
                        }

                        break;
                    }
                    case "advanced_adjuncts":
                    {
                        while( element.hasAttribute("type_classic_" + index))
                        {
                            verbPatternInfo.addClassicAdvancedAdjunct(element.getAttribute("type_classic_"+index));

                            index++;
                        }

                        index = 1;

                        while( element.hasAttribute("type_UD_" + index))
                        {
                            verbPatternInfo.addUDAdvancedAdjunct(element.getAttribute("type_UD_"+index));

                            index++;
                        }

                        index = 1;

                        while( element.hasAttribute("type_semantic_" + index))
                        {
                            verbPatternInfo.addSemanticAdvancedAdjunct(element.getAttribute("semantic_"+index));

                            index++;
                        }

                        break;
                    }
                    case "arguments":
                    {
                        while( element.hasAttribute("type_classic_" + index))
                        {
                            verbPatternInfo.addClassicArgument(element.getAttribute("type_classic_"+index));

                            index++;
                        }

                        index = 1;

                        while( element.hasAttribute("type_UD_" + index))
                        {
                            verbPatternInfo.addUDArgument(element.getAttribute("type_UD_"+index));

                            index++;
                        }

                        index = 1;

                        while( element.hasAttribute("type_semantic_" + index))
                        {
                            verbPatternInfo.addSemanticArgument(element.getAttribute("semantic_"+index));

                            index++;
                        }

                        break;
                    }
                    case "adjuncts":
                    {
                        while( element.hasAttribute("type_classic_" + index))
                        {
                            verbPatternInfo.addClassicAdjunct(element.getAttribute("type_classic_"+index));

                            index++;
                        }

                        index = 1;

                        while( element.hasAttribute("type_UD_" + index))
                        {
                            verbPatternInfo.addUDAdjunct(element.getAttribute("type_UD_"+index));

                            index++;
                        }

                        index = 1;

                        while( element.hasAttribute("type_semantic_" + index))
                        {
                            verbPatternInfo.addSemanticAdjunct(element.getAttribute("semantic_"+index));

                            index++;
                        }

                        break;
                    }
                }
            }

        }

        return verbPatternInfo;
    }

}
