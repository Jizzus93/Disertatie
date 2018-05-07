import java.util.ArrayList;

public class VerbEntity {
    ArrayList<VerbPattern> patterns = new ArrayList<VerbPattern>();
    transient String logs;

    VerbEntity(Occurrence occurrence)
    {
        addOccurrence(occurrence);
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


}
