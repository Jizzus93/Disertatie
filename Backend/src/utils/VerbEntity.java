package utils;

import FileIO.Occurrence;

import java.util.ArrayList;

public class VerbEntity {
    int id;
    String form;
    ArrayList<VerbPattern> patterns = new ArrayList<VerbPattern>();
    transient String logs;

    public VerbEntity(int id, String form){
        this.id = id;
        this.form = form;
    }

    public VerbEntity(Occurrence occurrence)
    {
        int id = 0;
        String form = "bug";
        addOccurrence(occurrence);
    }

    public VerbPatternInfo getPatternInfo(int patternId)
    {
        VerbPatternInfo verbPatternInfo = new VerbPatternInfo();
        if(patternId <= patterns.size())
        {
            verbPatternInfo = patterns.get(patternId-1).getPatternInfo();
        }

        return verbPatternInfo;
    }

    public void addPattern(VerbPattern aPattern)
    {
        this.patterns.add(aPattern);
    }

    public String getForm() {
        return form;
    }

    public void setForm(String form) {
        this.form = form;
    }

    public void addOccurrence(Occurrence occurrence)
    {
        VerbPattern newVerbPattern = new VerbPattern(occurrence);
        int indexOfPattern = patterns.indexOf(newVerbPattern);
        logs+= "" + indexOfPattern;
        if(indexOfPattern != -1)
        {
            patterns.get(indexOfPattern).addExample(occurrence);
        }
        else
        {
            patterns.add(newVerbPattern);
        }
    }

    public VerbPatternInfo getPatternExampleInfo(int patternID)
    {
        VerbPattern vp = patterns.get(patternID);
        VerbPatternInfo patternInfo = new VerbPatternInfo();
        patternInfo.setClassicArguments(vp.getArguments());
        patternInfo.setClassicAdjuncts(vp.getAdjuncts());
        patternInfo.setClassicExamplesNumber(vp.getExamplesNumber());
        return patternInfo;
    }

}
