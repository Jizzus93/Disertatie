package utils;

import java.util.ArrayList;

public class BundleInfo {
    int verbId;
    int patternId;
    ArrayList<String> arguments = new ArrayList<String>();

    public BundleInfo(int verbId, int patternId, ArrayList<String> arguments) {
        this.verbId = verbId;
        this.patternId = patternId;
        this.arguments = arguments;
    }

    public int getVerbId() {
        return verbId;
    }

    public void setVerbId(int verbId) {
        this.verbId = verbId;
    }

    public int getPatternId() {
        return patternId;
    }

    public void setPatternId(int patternId) {
        this.patternId = patternId;
    }

    public ArrayList<String> getArguments() {
        return arguments;
    }

    public void setArguments(ArrayList<String> arguments) {
        this.arguments = arguments;
    }
}
