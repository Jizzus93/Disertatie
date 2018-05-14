package bean;

import java.util.ArrayList;


public class VerbPatternInfoBean {
    ArrayList<String> arguments;
    ArrayList<String> adjuncts;
    int examplesNumber;

    VerbPatternInfoBean(ArrayList<String> arguments, ArrayList<String> adjuncts, int exampleNumber)
    {
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

    public int getExamplesNumber() {
        return examplesNumber;
    }
}
