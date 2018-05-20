import FileIO.Occurrence;
import FileIO.ClassicXmlReader;
import FileIO.PatternXmlReader;
import FileIO.PatternXmlWriter;
import com.google.gson.Gson;
import utils.*;

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
    private HashMap<String, VerbEntity> patternMap = new HashMap<String, VerbEntity>();
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

        if(patternMap.containsKey(word))
        {

            VerbEntity ve = patternMap.get(word);
            if(ve != null)
            {
            return gson.toJson(ve);
            }
        }
        else
        {
            result += "The word you are searching for is not in our database!!!" + patternMap.size();
        }


        return result;
    }

    @GET
    @Path("/getImageResource")
    @Produces("image/png")
    public Response getFile(@QueryParam("graphicsInfo")String graphicsInfo) {

        File file = new File(graphicsInfo);

        ResponseBuilder response = Response.ok((Object) file);
        response.header("Content-Disposition",
                "attachment; filename=image_from_server.png");
        return response.build();
    }

    @GET
    @Path("/getPatternInfo")
    @Produces("application/json")
    public String getPatternInfo(@QueryParam("verb") String verb, @QueryParam("patternId") int patternId)
    {
        String result = "";

        if(!isInitialized)
        {
            result += initialize();
        }
        Gson gson  = new Gson();

        if(patternMap.containsKey(verb)) {

            VerbEntity ve = patternMap.get(verb);

            return gson.toJson(ve.getPatternInfo(patternId));
        }

        return result;
    }

    @GET
    @Path("/getPattern")
    @Produces("application/json")
    public String getPattern(@QueryParam("verbId") int verbId, @QueryParam("patternId") int patternId)
    {
        String result = "";
        PatternXmlReader patternReader = new PatternXmlReader();


        Gson gson  = new Gson();

        VerbPattern vp = patternReader.getPattern(verbId, patternId);

        return gson.toJson(vp);
    }


    public SearchEngine()
    {
        //initialize();
    }

    private String initialize()
    {
        String response = "";

        PatternXmlReader patternXmlReader = new PatternXmlReader();
        for(File f: new File("__PatternBank/").listFiles())
        {
            int pos = f.getName().lastIndexOf(".");
            int verbId =Integer.parseInt(f.getName().substring(1,pos));


            VerbEntity verbEntity = patternXmlReader.readXMLFile(verbId);

            patternMap.put(verbEntity.getForm().toLowerCase(), verbEntity);

        }

        isInitialized = true;
        return response;
    }

    private String initialize2()
    {
        String response = "";
        ClassicXmlReader xmlFileReader = new ClassicXmlReader();
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
