package bean;

import java.util.ArrayList;


public class VerbPatternExampleInfoBean {

    SentenceBean exampleSentence;
    String graphicRepresentationPath;
    ArrayList<String> arguments;
    ArrayList<String> adjuncts;
    int examplesNumber;

    VerbPatternExampleInfoBean(SentenceBean aSentence, String graphicsPath, ArrayList<String> arguments, ArrayList<String> adjuncts, int exampleNumber)
    {
        this.exampleSentence = aSentence;
        this.graphicRepresentationPath = graphicsPath;
        this.arguments = arguments;
        this.adjuncts = adjuncts;
        this.examplesNumber = exampleNumber;
    }

    public ArrayList<String> getArguments() {
        return arguments;
    }

    public void setArguments(ArrayList<String> arguments) {
        this.arguments = arguments;
    }

    public ArrayList<String> getAdjuncts() {
        return adjuncts;
    }

    public void setAdjuncts(ArrayList<String> adjuncts) {
        this.adjuncts = adjuncts;
    }

    public SentenceBean getExampleSentence() {
        return exampleSentence;
    }

    public void setExampleSentence(SentenceBean exampleSentence) {
        this.exampleSentence = exampleSentence;
    }

    public String getGraphicRepresentationPath() {
        return graphicRepresentationPath;
    }

    public int getExamplesNumber() {
        return examplesNumber;
    }
}
