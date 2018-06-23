package FileIO;

import org.w3c.dom.Document;
import org.w3c.dom.Element;


public class Occurrence {
    private String mTreeBankID;
    private String mSentenceID;
    private int mWordID;
    private String occurrenceType;

    public Occurrence(String aTreeBankId, String aSentenceID,int aWordID, String aOccurrenceType)
    {
        this.mTreeBankID = aTreeBankId;
        this.mSentenceID = aSentenceID;
        this.mWordID = aWordID;
        this.occurrenceType = aOccurrenceType;
    }

    public Element toXMLElement(Document doc, int exampleId)
    {
        Element rootExample = doc.createElement("example");

        rootExample.setAttribute("id", exampleId+"");
        rootExample.setAttribute("corpus", mTreeBankID);
        rootExample.setAttribute("sentence_id", mSentenceID);
        rootExample.setAttribute("word_id", mWordID+"");
        rootExample.setAttribute("type", occurrenceType);

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

    public String getOccurrenceType() {
        return occurrenceType;
    }

    public void setOccurrenceType(String occurrenceType) {
        this.occurrenceType = occurrenceType;
    }
}
