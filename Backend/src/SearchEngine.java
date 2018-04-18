import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import java.util.ArrayList;
import java.util.HashMap;


@Path("/searchEngine")
public class SearchEngine {
    private HashMap<String, ArrayList<Occurance>> searchMap = new HashMap<String , ArrayList<Occurance>>();
    private boolean isInitialized = false;

    @GET
    @Path("/search")
    // The Java method will produce content identified by the MIME Media type "text/plain"
    @Produces("text/plain")
    public String search(@QueryParam("word") String word)
    {
        String result= "";
        if(!isInitialized)
        {
            result += initialize();
        }

        XMLReader xmlFileReader = new XMLReader();
        if(searchMap.containsKey(word))
        {
            ArrayList<Occurance> occurances = searchMap.get(word);
            for(Occurance o: occurances)
            {
                Sentence a_Sentence = xmlFileReader.getSentence(o);
                result += a_Sentence.toString() + "\n\n";
            }
        }
        else
        {
            result += "The word you are searching for is not in our database!!!" + searchMap.size();
        }

        return result;
    }

    public SearchEngine()
    {
        //initialize();
    }

    private String initialize()
    {
        String response = "";
        XMLReader xmlFileReader = new XMLReader();
        ArrayList<Sentence> sentences = xmlFileReader.readXMLFile("C:\\Users\\octak\\Dropbox\\UAIC-Ro.dep.treebank\\tools\\__TreeBank\\08_PopReg.semantic.xml");


        for(Sentence s: sentences)
        {
            ArrayList<String> verbList = getVerbList(s);

            for(String verb: verbList)
            {
                if(!searchMap.containsKey(verb))
                {
                    ArrayList<Occurance> occuranceList = new ArrayList<Occurance>();
                    occuranceList.add(new Occurance("08_PopReg.semantic", s.getID()));
                    searchMap.put(verb, occuranceList);

                }
                else
                {
                    searchMap.get(verb).add(new Occurance("08_PopReg.semantic", s.getID()));

                }
            }
        }

        isInitialized = true;
        return response;
    }

    private ArrayList<String> getVerbList(Sentence aSentence)
    {
        ArrayList<String> verbList = new ArrayList<String>();

        for(Word w: aSentence.getWordList())
        {
            if(w.getPOSTag().startsWith("V"))
            {
                verbList.add(w.getLemma());
            }
        }

        return verbList;
    }
}
