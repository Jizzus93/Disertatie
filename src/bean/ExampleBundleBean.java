package bean;

import java.util.ArrayList;

public class ExampleBundleBean {
    private ArrayList<String> arguments = new ArrayList<String>();
    private ArrayList<OccurrenceBean> occurrences = new ArrayList<OccurrenceBean>();

    public ExampleBundleBean(ArrayList<String> arguments ,OccurrenceBean o)
    {
        this.arguments = arguments;
        occurrences.add(o);
    }

    public void addExample(OccurrenceBean o)
    {
        occurrences.add(o);
    }

    public ArrayList<String> getArguments() {
        return arguments;
    }

    public void setArguments(ArrayList<String> arguments) {
        this.arguments = arguments;
    }

    public ArrayList<OccurrenceBean> getOccurrences() {
        return occurrences;
    }

    public void setOccurrences(ArrayList<OccurrenceBean> occurrences) {
        this.occurrences = occurrences;
    }
}

