package bean;


import java.util.ArrayList;

public class SentenceBean {
    private String mID;
    private String mParser;
    private String mUser;
    private String mDate;
    private ArrayList<WordBean> mWordList = new ArrayList<WordBean>();

    SentenceBean()
    {}

    SentenceBean(String a_ID, String a_Parser, String a_User, String a_Date, ArrayList<WordBean> a_List)
    {
        this.mID = a_ID;
        this.mParser = a_Parser;
        this.mUser = a_User;
        this.mDate = a_Date;
        this.mWordList = a_List;
    }

    //GETTER

    public String getID()
    {
        return this.mID;
    }

    public String getParser() {
        return mParser;
    }

    public String getUser()
    {
        return this.mUser;
    }

    public String getDate()
    {
        return this.mDate;
    }

    public ArrayList<WordBean> getWordList()
    {
        return  this.mWordList;
    }

    //WARNING: wordId counter starts from 1
    public WordBean getWord(int wordId)
    {
        return this.mWordList.get(wordId - 1);
    }


    //SETTERS

    public void setID(String a_ID)
    {
        this.mID = a_ID;
    }

    public void setUser(String a_User)
    {
        this.mUser = a_User;
    }

    public void setDate(String a_Date)
    {
        this.mDate = a_Date;
    }

    public void setWordList(ArrayList<WordBean> a_WordList)
    {
        this.mWordList = a_WordList;
    }


    public String toString()
    {
        String response = "utils.Sentence: \n" + "Id= " + this.mID + " Parser: " + mParser + " User: " + mUser + " Date: " + mDate + "\nWordList: \n";
        for(WordBean w: mWordList)
        {
            response += w.toString() + "\n";
        }

        return response;
    }
}
