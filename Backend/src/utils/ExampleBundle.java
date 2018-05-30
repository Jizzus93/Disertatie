package utils;

import FileIO.Occurrence;

import java.util.ArrayList;

public class ExampleBundle {
    private ArrayList<String> arguments = new ArrayList<String>();
    private ArrayList<Occurrence> occurrences = new ArrayList<Occurrence>();

    public ExampleBundle(ArrayList<String> arguments ,Occurrence o)
    {
        this.arguments = arguments;
        occurrences.add(o);
    }

    public void addExample(Occurrence o)
    {
        occurrences.add(o);
    }

    public ArrayList<String> getArguments() {
        return arguments;
    }

    public void setArguments(ArrayList<String> arguments) {
        this.arguments = arguments;
    }

    public ArrayList<Occurrence> getOccurrences() {
        return occurrences;
    }

    public void setOccurrences(ArrayList<Occurrence> occurrences) {
        this.occurrences = occurrences;
    }
}
