import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class XMLReader {

    public Sentence getSentence(Occurrence a_occurrence)
    {
        Sentence result = new Sentence();

        try {

            File fXmlFile = new File("__TreeBank/" + a_occurrence.getTreebankID() + ".xml");
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(fXmlFile);

            //optional, but recommended
            //read this - http://stackoverflow.com/questions/13786607/normalization-in-dom-parsing-with-java-how-does-it-work
            doc.getDocumentElement().normalize();

            NodeList nList = doc.getElementsByTagName("sentence");


            for (int temp = 0; temp < nList.getLength(); temp++) {

                Node nNode = nList.item(temp);

                if (nNode.getNodeType() == Node.ELEMENT_NODE) {

                    Element eElement = (Element) nNode;

                    if(eElement.getAttribute("id").equals(a_occurrence.getSentenceID()))
                    {
                        String id = eElement.getAttribute("id");
                        String parser = eElement.getAttribute("parser");
                        String user = eElement.getAttribute("user");
                        String date = eElement.getAttribute("date");
                        ArrayList<Word> wordList = new ArrayList<Word>();

                        NodeList words = nNode.getChildNodes();
                        for(int i = 0; i< words.getLength(); i++)
                        {
                            Node wordNode = words.item(i);

                            if (wordNode.getNodeType() == Node.ELEMENT_NODE)
                            {
                                Element wordElement = (Element) wordNode;

                                int word_id = Integer.parseInt(wordElement.getAttribute("id"));
                                String word_form = wordElement.getAttribute("form");
                                String word_lemma = wordElement.getAttribute("lemma");
                                String word_postag = wordElement.getAttribute("postag");
                                int word_head = Integer.parseInt(wordElement.getAttribute("head"));
                                String word_chunk = wordElement.getAttribute("chunk");
                                String word_deprel = wordElement.getAttribute("deprel");

                                wordList.add(new Word(word_id, word_form, word_lemma, word_postag, word_head, word_chunk, word_deprel));
                            }
                        }

                        result = new Sentence(id, parser, user, date, wordList);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }


        return result;
    }


    public ArrayList<Sentence> readXMLFile(String path)
    {
        ArrayList<Sentence> response = new ArrayList<Sentence>();
        try {

            File fXmlFile = new File(path);
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(fXmlFile);

            //optional, but recommended
            //read this - http://stackoverflow.com/questions/13786607/normalization-in-dom-parsing-with-java-how-does-it-work
            doc.getDocumentElement().normalize();

            NodeList nList = doc.getElementsByTagName("sentence");


            for (int temp = 0; temp < nList.getLength(); temp++) {

                Node nNode = nList.item(temp);

                if (nNode.getNodeType() == Node.ELEMENT_NODE) {

                    Element eElement = (Element) nNode;

                    String id = eElement.getAttribute("id");
                    String parser = eElement.getAttribute("parser");
                    String user = eElement.getAttribute("user");
                    String date = eElement.getAttribute("date");
                    ArrayList<Word> wordList = new ArrayList<Word>();

                    NodeList words = nNode.getChildNodes();
                    for(int i = 0; i< words.getLength(); i++)
                    {
                        Node wordNode = words.item(i);

                        if (wordNode.getNodeType() == Node.ELEMENT_NODE)
                        {
                            Element wordElement = (Element) wordNode;

                            int word_id = Integer.parseInt(wordElement.getAttribute("id"));
                            String word_form = wordElement.getAttribute("form");
                            String word_lemma = wordElement.getAttribute("lemma");
                            String word_postag = wordElement.getAttribute("postag");
                            int word_head = Integer.parseInt(wordElement.getAttribute("head"));
                            String word_chunk = wordElement.getAttribute("chunk");
                            String word_deprel = wordElement.getAttribute("deprel");

                            wordList.add(new Word(word_id, word_form, word_lemma, word_postag, word_head, word_chunk, word_deprel));
                        }
                    }

                   response.add(new Sentence(id, parser, user, date, wordList));
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return response;
    }

}
