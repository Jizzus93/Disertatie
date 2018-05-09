import java.util.ArrayList;

public class VerbPatternExampleInfo {

    Sentence exampleSentence;
    String graphicRepresentationPath;
    ArrayList<String> arguments;
    ArrayList<String> adjuncts;
    int examplesNumber;

    VerbPatternExampleInfo(Sentence aSentence, String graphicsPath, ArrayList<String> arguments, ArrayList<String> adjuncts, int examplesNumber)
    {
        this.exampleSentence = aSentence;
        this.graphicRepresentationPath = graphicsPath;
        this.arguments = arguments;
        this.adjuncts = adjuncts;
        this.examplesNumber = examplesNumber;
    }


}
