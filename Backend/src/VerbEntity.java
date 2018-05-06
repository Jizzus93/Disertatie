import java.util.ArrayList;

public class VerbEntity {
    ArrayList<VerbPattern> patterns = new ArrayList<VerbPattern>();

    VerbEntity(ArrayList<Occurrence> occurrences)
    {
        for(Occurrence o: occurrences)
        {
            patterns.add(new VerbPattern(o));
        }
    }



}
