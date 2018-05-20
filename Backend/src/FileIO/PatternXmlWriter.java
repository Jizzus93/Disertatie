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

    public void writePatternToXMLFile(VerbPattern aPattern, int verbId)
    {
        try
        {
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = null;
            File fXmlFile = new File("__PatternBank/v" + verbId + ".xml");
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
            }
            else
            {
                verbRoot = doc.createElement("verb");
                doc.appendChild(verbRoot);
                verbRoot.setAttribute("id", verbId + "");
                verbRoot.setAttribute("form", aPattern.getForm_ro());
            }

            verbRoot.appendChild(aPattern.toXMLElement(doc));

            Transformer tr = TransformerFactory.newInstance().newTransformer();
            tr.setOutputProperty(OutputKeys.INDENT, "yes");
            tr.setOutputProperty(OutputKeys.METHOD, "xml");
            tr.setOutputProperty(OutputKeys.ENCODING, "UTF-8");

            tr.setOutputProperty("{http://xml.apache.org/xslt}indent-amount", "4");

            // send DOM to file
            tr.transform(new DOMSource(doc),
                    new StreamResult(new FileOutputStream("__PatternBank/v" + verbId + ".xml")));


        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }
}
