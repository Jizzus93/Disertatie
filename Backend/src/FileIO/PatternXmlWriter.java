package FileIO;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import utils.VerbPattern;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.File;
import java.io.FileOutputStream;

public class PatternXmlWriter {

    public void writePatternToXMLFile(VerbPattern aPattern)
    {
        try
        {
            boolean fileExisted = false;
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = null;
            File fXmlFile = new File("__PatternBank/v" + aPattern.getVerb_id() + ".xml");
            if(fXmlFile.exists())
            {
                doc = dBuilder.parse(fXmlFile);
                doc.normalizeDocument();
            }
            else
            {
                doc = dBuilder.newDocument();
            }

            NodeList nList = doc.getElementsByTagName("verb");


            Element verbRoot;
            if(nList.getLength()>=1)
            {
                verbRoot =(Element) nList.item(0);

                if (verbRoot.getNodeType() == Node.ELEMENT_NODE) {
                    Element verb = (Element) verbRoot;
                    String verbForm = verb.getAttribute("form");

                    NodeList patterns = ((Element) verbRoot).getElementsByTagName("pattern");
                    if (patterns.getLength() >= aPattern.getId()) {

                       //this means it's an update scenario
                        Node patternRoot = patterns.item(aPattern.getId()-1);
                        verbRoot.removeChild(patternRoot);
                    }
                    if( patterns.getLength() + 1 < aPattern.getId() )
                    {
                        //in case the id set for the pattern isn't in seq order, it will be set as the next one
                        aPattern.setId(patterns.getLength()+1);
                    }
                }

            }
            else
            {
                verbRoot = doc.createElement("verb");
                doc.appendChild(verbRoot);
                verbRoot.setAttribute("id", aPattern.getVerb_id() + "");
                verbRoot.setAttribute("form", aPattern.getForm_ro());
                if(aPattern.getId()!=1)
                {
                    aPattern.setId(1);
                }
            }

            verbRoot.appendChild(aPattern.toXMLElement(doc));

            Transformer tr = TransformerFactory.newInstance().newTransformer();
            tr.setOutputProperty(OutputKeys.INDENT, "yes");
            tr.setOutputProperty(OutputKeys.METHOD, "xml");
            tr.setOutputProperty(OutputKeys.ENCODING, "UTF-8");

            tr.setOutputProperty("{http://xml.apache.org/xslt}indent-amount", "4");

            // send DOM to file
            tr.transform(new DOMSource(doc),
                    new StreamResult(new FileOutputStream("__PatternBank/v" + aPattern.getVerb_id() + ".xml")));


        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }
}
