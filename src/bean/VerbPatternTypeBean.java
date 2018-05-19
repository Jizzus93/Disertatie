package bean;

public class VerbPatternTypeBean {
    int id;

    String syntacticType;
    String patternType;
    String head;

    public VerbPatternTypeBean()
    {
        this.id = -1;
        this.syntacticType = "";
        this.patternType = "";
        this.head = "";
    }

    public VerbPatternTypeBean(int id, String syntacticType, String patternType, String head) {
        this.id = id;
        this.syntacticType = syntacticType;
        this.patternType = patternType;
        this.head = head;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSyntacticType() {
        return syntacticType;
    }

    public void setSyntacticType(String syntacticType) {
        this.syntacticType = syntacticType;
    }

    public String getPatternType() {
        return patternType;
    }

    public void setPatternType(String patternType) {
        this.patternType = patternType;
    }

    public String getHead() {
        return head;
    }

    public void setHead(String head) {
        this.head = head;
    }

}

