public class Occurance {
    private String mTreeBankID;
    private String mSentenceID;
    private int mWordID;

    Occurance(String aTreeBankId, String aSentenceID,int aWordID)
    {
        this.mTreeBankID = aTreeBankId;
        this.mSentenceID = aSentenceID;
        this.mWordID = aWordID;
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
