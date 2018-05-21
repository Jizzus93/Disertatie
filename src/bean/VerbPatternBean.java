package bean;

import org.graphstream.graph.Edge;
import org.graphstream.graph.Node;
import org.graphstream.graph.implementations.MultiGraph;
import org.graphstream.stream.file.FileSinkImages;

import java.awt.*;
import java.io.IOException;
import java.util.ArrayList;

import static org.graphstream.stream.file.FileSinkImages.*;

public class VerbPatternBean {
    int verb_id;
    int id;
    String form_ro;
    String form_en;
    String PWN;

    VerbPatternTypeBean verbPatternType;
    VerbPatternInfoBean patternInfo;


    ArrayList<String> implicatures = new ArrayList<String>();

    ArrayList<OccurrenceBean> examples = new ArrayList<OccurrenceBean>();


    public VerbPatternBean(int verb_id, int id, String form_romainian, String form_english)
    {
        this.verb_id = verb_id;
        this.id = id;
        this.form_ro = form_romainian;
        this.form_en = form_english;
        String PWN = "";
        verbPatternType = new VerbPatternTypeBean();
        patternInfo = new VerbPatternInfoBean();
        examplesNumber = 0;
    }

    int examplesNumber;

    public int getVerb_id() {
        return verb_id;
    }

    public void setVerb_id(int verb_id) {
        this.verb_id = verb_id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getForm_ro() {
        return form_ro;
    }

    public void setForm_ro(String form_ro) {
        this.form_ro = form_ro;
    }

    public String getForm_en() {
        return form_en;
    }

    public void setForm_en(String form_en) {
        this.form_en = form_en;
    }

    public String getPWN() {
        return PWN;
    }

    public void setPWN(String PWN) {
        this.PWN = PWN;
    }

    public VerbPatternTypeBean getVerbPatternType() {
        return verbPatternType;
    }

    public void setVerbPatternType(VerbPatternTypeBean verbPatternType) {
        this.verbPatternType = verbPatternType;
    }

    public VerbPatternInfoBean getPatternInfo() {
        return patternInfo;
    }

    public void setPatternInfo(VerbPatternInfoBean patternInfo) {
        this.patternInfo = patternInfo;
    }

    public ArrayList<String> getImplicatures() {
        return implicatures;
    }

    public void setImplicatures(ArrayList<String> implicatures) {
        this.implicatures = implicatures;
    }

    public void setExamples(ArrayList<OccurrenceBean> examples) {
        this.examples = examples;
    }

    public void setExamplesNumber(int examplesNumber) {
        this.examplesNumber = examplesNumber;
    }

    public ArrayList<OccurrenceBean> getExamples() {
        return examples;
    }

    public int getExamplesNumber() {
        return examplesNumber;
    }
}
