package utils;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

public class VerbPatternType {
    int id;

    String syntacticType;
    String patternType;
    String head;

    public VerbPatternType()
    {
        this.id = -1;
        this.syntacticType = "";
        this.patternType = "";
        this.head = "";
    }

    public VerbPatternType(int id, String syntacticType, String patternType, String head) {
        this.id = id;
        this.syntacticType = syntacticType;
        this.patternType = patternType;
        this.head = head;
    }

    public Element toXMLElement(Document doc)
    {
        Element rootType = doc.createElement("type");

        rootType.setAttribute("id", id+"");
        rootType.setAttribute("syntactic_type", syntacticType);
        rootType.setAttribute("pattern_type", patternType);
        rootType.setAttribute("head", head);

        return rootType;
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
