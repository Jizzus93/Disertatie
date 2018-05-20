package FileIO;

import org.w3c.dom.Document;
import org.w3c.dom.Element;


public class Occurrence {
    private String mTreeBankID;
    private String mSentenceID;
    private int mWordID;

    public Occurrence(String aTreeBankId, String aSentenceID,int aWordID)
    {
        this.mTreeBankID = aTreeBankId;
        this.mSentenceID = aSentenceID;
        this.mWordID = aWordID;
    }

    public Element toXMLElement(Document doc, int exampleId)
    {
        Element rootExample = doc.createElement("example");

        rootExample.setAttribute("id", exampleId+"");
        rootExample.setAttribute("corpus", mTreeBankID);
        rootExample.setAttribute("sentence_id", mSentenceID);
        rootExample.setAttribute("word_id", mWordID+"");

        return rootExample;
    }

    public String getTreebankID()
    {
        return this.mTreeBankID;
    }

    public String getSentenceID()
    {
        return this.mSentenceID;
    }

    public int getWordID() { return this.mWordID; }
}
