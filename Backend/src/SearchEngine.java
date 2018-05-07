import com.google.gson.Gson;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.ResponseBuilder;
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;


@Path("/searchEngine")
public class SearchEngine {
    private HashMap<String, VerbEntity> searchMap = new HashMap<String , VerbEntity>();
    private boolean isInitialized = false;

    @GET
    @Path("/search")
    // The Java method will produce content identified by the MIME Media type "text/plain"
    @Produces("application/json")
    public String search(@QueryParam("word") String word)
    {
        String result= "";
        if(!isInitialized)
        {
            result += initialize();
        }
        Gson gson  = new Gson();
        XMLReader xmlFileReader = new XMLReader();
        if(searchMap.containsKey(word))
        {

            VerbEntity ve = searchMap.get(word);
            return gson.toJson(ve);

            /*
            for(Occurence o: occurences)
            {
                Sentence a_Sentence = xmlFileReader.getSentence(o);

                result += a_Sentence.toString() + "\nWordId: " + o.getWordID() + "\n";
            }
            */
            //currentVerbPattern.getImageResource();
        }
        else
        {
            result += "The word you are searching for is not in our database!!!" + searchMap.size();
        }


        return result;
    }

    @GET
    @Path("/get")
    @Produces("image/png")
    public Response getFile() {

        File file = new File("sample.png");

        ResponseBuilder response = Response.ok((Object) file);
        response.header("Content-Disposition",
                "attachment; filename=image_from_server.png");
        return response.build();
    }

    public SearchEngine()
    {
        //initialize();
    }

    private String initialize()
    {
        String response = "";
        XMLReader xmlFileReader = new XMLReader();
        ArrayList<Sentence> sentences = xmlFileReader.readXMLFile("__TreeBank/08_PopReg.xml");


        for(Sentence s: sentences)
        {
            ArrayList<Word> verbList = getVerbList(s);

            for(Word verb: verbList)
            {
                Occurrence currentOccurrence = new Occurrence("08_PopReg", s.getID(), verb.getId());
                if(!searchMap.containsKey(verb.getLemma()))
                {

                    VerbEntity verbEntity = new VerbEntity(currentOccurrence);
                    searchMap.put(verb.getLemma(), verbEntity);

                }
                else
                {
                    searchMap.get(verb.getLemma()).addOccurrence(currentOccurrence);
                }
            }
        }

        isInitialized = true;
        return response;
    }

    private ArrayList<Word> getVerbList(Sentence aSentence)
    {
        ArrayList<Word> verbList = new ArrayList<Word>();

        for(Word w: aSentence.getWordList())
        {
            if(w.getPOSTag().startsWith("V"))
            {
                verbList.add(w);
            }
        }

        return verbList;
    }
}
