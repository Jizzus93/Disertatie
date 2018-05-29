package bean;


public class OccurrenceBean {
    private String mTreeBankID;
    private String mSentenceID;
    private int mWordID;
    private String occurrenceType;

    OccurrenceBean(String aTreeBankId, String aSentenceID,int aWordID, String aOccurrenceType)
    {
        this.mTreeBankID = aTreeBankId;
        this.mSentenceID = aSentenceID;
        this.mWordID = aWordID;
        occurrenceType = aOccurrenceType;
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
