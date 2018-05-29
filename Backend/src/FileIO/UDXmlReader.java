package FileIO;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import utils.Sentence;
import utils.Word;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.ArrayList;

public class UDXmlReader {
    public Sentence getSentence(Occurrence a_occurrence)
    {
        Sentence result = new Sentence();

        try (BufferedReader br = new BufferedReader(new FileReader("__TreeBank/UD/" + a_occurrence.getTreebankID() + ".conllu"))) {
            String line;

            while ((line = br.readLine()) != null) {

                if(line.contains("newdoc"))
                {
                    String[] elements = line.split(" ");
                    if(elements.length>4)
                    {
                        String doc_id = elements[4];
                    }
                }
                if(line.contains("sent_id"))
                {
                    String[] elements = line.split(" ");
                    if(elements.length>3)
                    {
                        String sent_id = elements[3];
                        if(sent_id.equals(a_occurrence.getSentenceID()))
                        {
                            result.setID(sent_id);

                            if((line = br.readLine()) != null)
                            {
                                if(line.contains("text"))
                                {

                                }
                                ArrayList<Word> words = new ArrayList<Word>();
                                //getting words
                                while((line = br.readLine()) != null && !line.equals(""))
                                {
                                    String[] tokens = line.split("\t");
                                    if(tokens.length>7)
                                    {
                                        String id = tokens[0];
                                        String form = tokens[1];
                                        String lemma = tokens[2];
                                        String parteVb = tokens[3];
                                        String posTag = tokens[4];
                                        //
                                        String head = tokens[6];
                                        if(head.equals("amod"))
                                        {
                                            head = "0";
                                        }
                                        String depRel = tokens[7];
                                        Word word = new Word(Integer.parseInt(id), form, lemma, posTag, Integer.parseInt(head.trim()), "", depRel);
                                        words.add(word);
                                    }
                                }
                                result.setWordList(words);
                                break;
                            }
                            else
                            {
                                break;
                            }
                        }

                    }
                }

            }
        }
        catch (Exception e )
        {
            e.printStackTrace();
        }


        return result;
    }


    public ArrayList<Sentence> readXMLFile(String path)
    {
        ArrayList<Sentence> sentences = new ArrayList<Sentence>();

        try (BufferedReader br = new BufferedReader(new FileReader(path))) {
            String line;

            while ((line = br.readLine()) != null) {

                if(line.contains("newdoc"))
                {
                    String[] elements = line.split(" ");
                    if(elements.length>4)
                    {
                        String doc_id = elements[4];
                    }
                }
                if(line.contains("sent_id"))
                {
                    Sentence result = new Sentence();
                    String[] elements = line.split(" ");
                    if(elements.length>3)
                    {
                        String sent_id = elements[3];

                        result.setID(sent_id);

                        if((line = br.readLine()) != null)
                        {
                            if(line.contains("text"))
                            {

                            }
                            ArrayList<Word> words = new ArrayList<Word>();
                            //getting words
                            while((line = br.readLine()) != null && !line.equals(""))
                            {
                                String[] tokens = line.split("\t");
                                if(tokens.length>7)
                                {
                                    String id = tokens[0];
                                    String form = tokens[1];
                                    String lemma = tokens[2];
                                    String parteVb = tokens[3];
                                    String posTag = tokens[4];
                                    //
                                    String head = tokens[6];
                                    if(head.equals("amod"))
                                    {
                                        head = "0";
                                    }
                                    String depRel = tokens[7];
                                    Word word = new Word(Integer.parseInt(id), form, lemma, posTag, Integer.parseInt(head), "", depRel);
                                    words.add(word);
                                }
                            }
                            result.setWordList(words);

                        }
                        else
                        {
                            break;
                        }

                        sentences.add(result);

                    }
                }

            }
        }
        catch (Exception e )
        {
            e.printStackTrace();
        }


        return sentences;
    }

}
