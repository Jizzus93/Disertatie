public class Occurance {
    private String mTreeBankID;
    private String mSentenceID;

    Occurance(String aTreeBankId, String aSentenceID)
    {
        this.mTreeBankID = aTreeBankId;
        this.mSentenceID = aSentenceID;
    }

    public String getTreebankID()
    {
        return this.mTreeBankID;
    }

    public String getSentenceID()
    {
        return this.mSentenceID;
    }
}
