import java.util.ArrayList;

public class VerbEntity {
    ArrayList<VerbPattern> patterns = new ArrayList<VerbPattern>();

    VerbEntity(ArrayList<Occurance> occurances)
    {
        for(Occurance o: occurances)
        {
            patterns.add(new VerbPattern(o));
        }
    }



}
