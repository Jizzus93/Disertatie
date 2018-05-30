import FileIO.*;
import com.google.gson.Gson;
import org.util.set.Array;
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
    private HashMap<String, ArrayList<ExampleBundle>> searchMap = new HashMap<String , ArrayList<ExampleBundle>>();
    private HashMap<String, VerbEntity> patternMap = new HashMap<String, VerbEntity>();
    private boolean isInitialized = false;
    private boolean isExampleSearchInitialized = false;


    @GET
    @Path("/search")
    // The Java method will produce content identified by the MIME Media type "text/plain"
    @Produces("application/json")
    public String search(@QueryParam("word") String word)
    {
        String result= "";
        VerbEntity ve = null;
        if(!isInitialized)
        {
            result += initialize();
        }
        Gson gson  = new Gson();

        if(patternMap.containsKey(word))
        {

            ve = patternMap.get(word);

        }
        else
        {
            ve = new VerbEntity(getNextVerbId(), word);
            patternMap.put(word,ve);
        }


        return gson.toJson(ve);
    }

    @GET
    @Path("/getVerbOccurrences")
    // The Java method will produce content identified by the MIME Media type "text/plain"
    @Produces("application/json")
    public String getVerbOccurrences(@QueryParam("verb") String verb)
    {
        String result= "";
        if(!isExampleSearchInitialized)
        {
            result += initializeExampleSearch();
        }
        Gson gson  = new Gson();

        if(searchMap.containsKey(verb))
        {

            ArrayList<ExampleBundle> exampleBundles = searchMap.get(verb);
            if(exampleBundles != null)
            {
                return gson.toJson(exampleBundles);
            }
        }
        else
        {
            result += "The word you are searching for is not in our database!!!" + searchMap.size();
        }


        return result;
    }

    @GET
    @Path("/getVerbOccurrences")
    // The Java method will produce content identified by the MIME Media type "text/plain"
    @Produces("application/json")
    public String getExampleBundle(@QueryParam("verb") String verb, @QueryParam("patternId") int patternId, @QueryParam("bundleId") int bundleId)
    {
        String result= "";
        if(!isExampleSearchInitialized)
        {
            result += initializeExampleSearch();
        }
        Gson gson  = new Gson();

        if(searchMap.containsKey(verb))
        {
            if(searchMap.get(verb).size()> bundleId)
            {
                ExampleBundle exampleBundle = searchMap.get(verb).get(bundleId);
                VerbPattern vp = null;
                if(patternMap.containsKey(verb))
                {
                    if(patternMap.get(verb).getPatterns().size() > patternId)
                    {
                        for(Occurrence o : exampleBundle.getOccurrences())
                        {
                            vp = patternMap.get(verb).getPatterns().get(patternId);
                            vp.addExample(o);
                        }

                    }


                }
                else
                {
                    
                }

                if(vp!=null)
                {
                    PatternXmlWriter xmlWriter = new PatternXmlWriter();
                    xmlWriter.writePatternToXMLFile(vp);
                }
            }
        }
        else
        {
            result += "The word you are searching for is not in our database!!!" + searchMap.size();
        }


        return result;
    }

    @GET
    @Path("/getRoPAASVerbs")
    // The Java method will produce content identified by the MIME Media type "text/plain"
    @Produces("application/json")
    public String getRoPAASVerbs()
    {
        String result= "";

        if(!isInitialized)
        {
            initialize();
        }

        ArrayList<String> RoPAASVerbs = new ArrayList<String>();
        for(String s: patternMap.keySet())
        {
            RoPAASVerbs.add(s);
        }

        Gson gson = new Gson();


        return gson.toJson(RoPAASVerbs);
    }


    @GET
    @Path("/getDeltaTreebankVerbs")
    // The Java method will produce content identified by the MIME Media type "text/plain"
    @Produces("application/json")
    public String getDeltaTreebankVerbs()
    {
        String result= "";

        if(!isExampleSearchInitialized)
        {
            initializeExampleSearch();
        }



        ArrayList<String> treebankDeltaVerbs = new ArrayList<String>();

        for(String s: searchMap.keySet())
        {
            if(!patternMap.containsKey(s))
            {
                treebankDeltaVerbs.add(s);
            }
        }

        Gson gson = new Gson();


        return gson.toJson(treebankDeltaVerbs);
    }

    @GET
    @Path("/getExample")
    // The Java method will produce content identified by the MIME Media type "text/plain"
    @Produces("application/json")
    public String getExample(@QueryParam("treebankId") String treeBankId, @QueryParam("sentenceId") String sentenceId, @QueryParam("wordId") String wordId, @QueryParam("type") String type)
    {
        String log= "";
        log+= treeBankId + " | " + sentenceId + " | " + wordId + " | " + type;


        Sentence sentence = null;
        Gson gson = new Gson();

        switch(type)
        {
            case "classic":
            {
                ClassicXmlReader xmlFileReader = new ClassicXmlReader();
                sentence = xmlFileReader.getSentence(new Occurrence(treeBankId,sentenceId,Integer.parseInt(wordId),type));

                break;
            }
            case "semantic":
            {
                SemanticXmlReader xmlFileReader = new SemanticXmlReader();
                sentence = xmlFileReader.getSentence(new Occurrence(treeBankId,sentenceId,Integer.parseInt(wordId),type));

                break;
            }
            case "UD": //remove this after UD reader is implemented
            {
                UDXmlReader xmlFileReader = new UDXmlReader();
                sentence = xmlFileReader.getSentence(new Occurrence(treeBankId,sentenceId,Integer.parseInt(wordId),type));


                break;
            }
            default:
            {
                log += "SearchEngine::getExample -> UnknownExampleType" + type;
                break;
            }
        }

        //return log;
        return gson.toJson(sentence);
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


        VerbPattern vp = null;
        if(verbId != 0)
        {
            vp =  patternReader.getPattern(verbId, patternId);
        }

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

    private String initializeExampleSearch()
    {
        String response = "";

        response += loadExampleFiles("__TreeBank/Classic/");
        response += loadExampleFiles("__TreeBank/Semantic/");
        response += loadExampleFiles("__TreeBank/UD/");

        isExampleSearchInitialized = true;
        return response;
    }

    private String loadExampleFiles(String fileType)
    {
        String log = "";
        switch (fileType)
        {
            case "__TreeBank/Classic/":
                {
                    ClassicXmlReader xmlFileReader = new ClassicXmlReader();

                    for (File f : new File(fileType).listFiles())
                    {
                        int pos = f.getName().lastIndexOf(".");
                        String treebankId = f.getName().substring(0, pos);
                        ArrayList<Sentence> sentences = xmlFileReader.readXMLFile(fileType + f.getName());

                        for (Sentence s : sentences)
                        {
                            ArrayList<Word> verbList = s.getVerbList();

                            for (Word verb : verbList) {
                                Occurrence currentOccurrence = new Occurrence(treebankId, s.getID(), verb.getId(),"classic");
                                if (!searchMap.containsKey(verb.getLemma()))
                                {

                                    ArrayList<ExampleBundle> exampleBundles = new ArrayList<ExampleBundle>();
                                    ExampleBundle exampleBundle = new ExampleBundle(s.getWordArguments(verb.getId()), currentOccurrence);
                                    exampleBundles.add(exampleBundle);

                                    searchMap.put(verb.getLemma(), exampleBundles);

                                }
                                else
                                {
                                    boolean added = false;

                                    for(ExampleBundle bundle :searchMap.get(verb.getLemma()))
                                    {
                                        if(areEqual(bundle.getArguments(), s.getWordArguments(verb.getId())))
                                        {
                                            bundle.addExample(currentOccurrence);
                                            added = true;
                                            break;
                                        }
                                    }

                                    if(!added)
                                    {
                                        ExampleBundle exampleBundle = new ExampleBundle(s.getWordArguments(verb.getId()), currentOccurrence);
                                        searchMap.get(verb.getLemma()).add(exampleBundle);
                                    }

                                }
                            }
                        }

                    }
                    break;
                }
            case "__TreeBank/UD/":
            {
                UDXmlReader xmlFileReader = new UDXmlReader();

                for (File f : new File(fileType).listFiles())
                {
                    int pos = f.getName().lastIndexOf(".");
                    String treebankId = f.getName().substring(0, pos);
                    ArrayList<Sentence> sentences = xmlFileReader.readXMLFile(fileType + f.getName());

                    for (Sentence s : sentences)
                    {
                        ArrayList<Word> verbList = s.getVerbList();

                        for (Word verb : verbList) {
                            Occurrence currentOccurrence = new Occurrence(treebankId, s.getID(), verb.getId(), "UD");
                            if (!searchMap.containsKey(verb.getLemma()))
                            {

                                ArrayList<ExampleBundle> exampleBundles = new ArrayList<ExampleBundle>();
                                ExampleBundle exampleBundle = new ExampleBundle(s.getWordArguments(verb.getId()), currentOccurrence);
                                exampleBundles.add(exampleBundle);

                                searchMap.put(verb.getLemma(), exampleBundles);

                            }
                            else
                            {
                                boolean added = false;

                                for(ExampleBundle bundle :searchMap.get(verb.getLemma()))
                                {
                                    if(areEqual(bundle.getArguments(), s.getWordArguments(verb.getId())))
                                    {
                                        bundle.addExample(currentOccurrence);
                                        added = true;
                                        break;
                                    }
                                }

                                if(!added)
                                {
                                    ExampleBundle exampleBundle = new ExampleBundle(s.getWordArguments(verb.getId()), currentOccurrence);
                                    searchMap.get(verb.getLemma()).add(exampleBundle);
                                }

                            }
                        }
                    }

                }
                break;
            }
            case "__TreeBank/Semantic/":
            {
                ClassicXmlReader xmlFileReader = new ClassicXmlReader();

                for (File f : new File(fileType).listFiles())
                {
                    int pos = f.getName().lastIndexOf(".");
                    String treebankId = f.getName().substring(0, pos);
                    ArrayList<Sentence> sentences = xmlFileReader.readXMLFile(fileType + f.getName());

                    for (Sentence s : sentences)
                    {
                        ArrayList<Word> verbList = s.getVerbList();

                        for (Word verb : verbList) {
                            Occurrence currentOccurrence = new Occurrence(treebankId, s.getID(), verb.getId(), "semantic");
                            if (!searchMap.containsKey(verb.getLemma()))
                            {

                                ArrayList<ExampleBundle> exampleBundles = new ArrayList<ExampleBundle>();
                                ExampleBundle exampleBundle = new ExampleBundle(s.getWordArguments(verb.getId()), currentOccurrence);
                                exampleBundles.add(exampleBundle);

                                searchMap.put(verb.getLemma(), exampleBundles);

                            }
                            else
                            {
                                boolean added = false;

                                for(ExampleBundle bundle :searchMap.get(verb.getLemma()))
                                {
                                    if(areEqual(bundle.getArguments(), s.getWordArguments(verb.getId())))
                                    {
                                        bundle.addExample(currentOccurrence);
                                        added = true;
                                        break;
                                    }
                                }

                                if(!added)
                                {
                                    ExampleBundle exampleBundle = new ExampleBundle(s.getWordArguments(verb.getId()), currentOccurrence);
                                    searchMap.get(verb.getLemma()).add(exampleBundle);
                                }

                            }
                        }
                    }

                }
                break;
            }
            default:
            {
                log += "SearchEngine::loadExampleFiles -> Unknown file type" + fileType;
                break;
            }
        }

        return log;
    }


    private boolean areEqual(ArrayList<String> first , ArrayList<String> second)
    {
        if(first.size() != second.size())
        {
            return false;
        }
        for(String s: first)
        {
            if(!second.contains(s))
            {
                return false;
            }
        }
        return true;
    }

    private int getNextVerbId()
    {
        return new File("__PatternBank/").listFiles().length + 1;
    }
}
