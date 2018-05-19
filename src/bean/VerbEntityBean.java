package bean;

import java.util.ArrayList;

public class VerbEntityBean {
    int id;
    String form;
    ArrayList<VerbPatternBean> patterns = new ArrayList<VerbPatternBean>();

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getForm() {
        return form;
    }

    public void setForm(String form) {
        this.form = form;
    }

    public void setPatterns(ArrayList<VerbPatternBean> patterns) {
        this.patterns = patterns;
    }

    public ArrayList<VerbPatternBean> getPatterns()
    {
        return this.patterns;
    }
}
