import java.util.ArrayList;

public class VerbPatternInfo {
    ArrayList<String> arguments;
    ArrayList<String> adjuncts;
    int examplesNumber;

    VerbPatternInfo(ArrayList<String> arguments, ArrayList<String> adjuncts, int examplesNumber)
    {
        this.arguments = arguments;
        this.adjuncts = adjuncts;
        this.examplesNumber = examplesNumber;
    }


}
