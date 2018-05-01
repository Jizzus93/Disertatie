import org.graphstream.graph.Node;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import java.util.List;

// The Java class will be hosted at the URI path "/word"
@Path("/word")
public class Word{
    private int mID;
    private String mForm;
    private String mLemma;
    private String mPOSTag; //TODO: Figure out how to decode this
    private int mHead;
    private String mChunk; //Unused
    private String mDepRel;


    public Word(int a_ID,String a_Form, String a_Lemma, String a_POSTag, int a_Head, String a_Chunk, String a_DepRel)
    {
        this.mID = a_ID;
        this.mForm = a_Form;
        this.mLemma = a_Lemma;
        this.mPOSTag = a_POSTag;
        this.mHead = a_Head;
        this.mChunk = a_Chunk;
        this.mDepRel = a_DepRel;
    }

    public Word()
    {}

    //GETTERS

    public int getId()
    {
        return this.mID;
    }

    public String getForm()
    {
        return this.mForm;
    }

    public String getLemma()
    {
        return this.mLemma;
    }

    public String getPOSTag()
    {
        return this.mPOSTag;
    }

    public int getHead()
    {
        return this.mHead;
    }

    public String getChunk()
    {
        return this.mChunk;
    }

    public String getDepRel()
    {
        return this.mDepRel;
    }


    //SETTERS
    public void setID(int a_ID)
    {
        this.mID = a_ID;
    }

    public void setForm(String a_Form)
    {
        this.mForm = a_Form;
    }

    public void setLemma(String a_Lemma)
    {
        this.mLemma = a_Lemma;
    }

    public void setPOSTag(String a_POSTag)
    {
        this.mPOSTag = a_POSTag;
    }

    public void setHead(int a_Head)
    {
        this.mHead = a_Head;
    }

    public void setChunk(String a_Chunk)
    {
        this.mChunk = a_Chunk;
    }

    public void setDepRel(String a_DepRel)
    {
        this.mDepRel = a_DepRel;
    }

    public String toString()
    {
        return "Word ID: " + mID + " Form: " + mForm + " Lemma: " + mLemma + " POSTag: " + mPOSTag + " Head: " + mHead + " Chunk: " + mChunk + " DepRel: " + mDepRel;
    }

    // The Java method will process HTTP GET requests
    @GET
    @Path("/query")
    // The Java method will produce content identified by the MIME Media type "text/plain"
    @Produces("text/plain")
    public String bullshit(@QueryParam("word") String word) {
        String result = "Cautare dupa: " + word + "\n\n";

        XMLReader xmlFileReader = new XMLReader();
        //List<String> response = xmlFileReader.readXMLFile("C:\\Users\\octak\\Dropbox\\UAIC-Ro.dep.treebank\\tools\\__TreeBank\\08_PopReg.semantic.xml");

        /*Occurance a_occurance = new Occurance("08_PopReg", "08_PopReg_8_");
        Sentence a_Sentence = xmlFileReader.getSentence(a_occurance);
        result += a_Sentence.toString() + "\n\n";

        a_occurance = new Occurance("08_PopReg", "08_PopReg_9_");
        a_Sentence = xmlFileReader.getSentence(a_occurance);
        result += a_Sentence.toString() + "\n\n";

        a_occurance = new Occurance("08_PopReg", "08_PopReg_12_");
        a_Sentence = xmlFileReader.getSentence(a_occurance);
        result += a_Sentence.toString() + "\n\n";
        */

        return result;
    }
}