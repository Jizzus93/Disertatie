import java.util.ArrayList;

public class Sentence {
    private String mID;
    private String mParser;
    private String mUser;
    private String mDate;
    private ArrayList<Word> mWordList = new ArrayList<Word>();

    Sentence()
    {}

    Sentence(String a_ID, String a_Parser, String a_User, String a_Date, ArrayList<Word> a_List)
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

    public String getUser()
    {
        return this.mUser;
    }

    public String getDate()
    {
        return this.mDate;
    }

    public ArrayList<Word> getWordList()
    {
        return  this.mWordList;
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

    public void setWordList(ArrayList<Word> a_WordList)
    {
        this.mWordList = a_WordList;
    }


    public String toString()
    {
        String response = "Sentence: \n" + "Id= " + this.mID + " Parser: " + mParser + " User: " + mUser + " Date: " + mDate + "\nWordList: \n";
        for(Word w: mWordList)
        {
            response += w.toString() + "\n";
        }

        return response;
    }
}
