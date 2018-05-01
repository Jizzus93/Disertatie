import org.graphstream.graph.Node;
import org.graphstream.graph.implementations.DefaultGraph;

public class VerbPattern {
    //graph
    DefaultGraph mPattern;
    XMLReader xmlFileReader = new XMLReader();
    //lista de Occurances

    VerbPattern(Occurance o)
    {
        mPattern = new DefaultGraph("" + o.getTreebankID() + "_" + o.getSentenceID() + "_" + o.getWordID());
        Sentence a_Sentence = xmlFileReader.getSentence(o);

        //adding the verb as the root node
        mPattern.addNode(a_Sentence.getWord(o.getWordID()).getForm());

        Node root = mPattern.getNode(a_Sentence.getWord(o.getWordID()).getForm());

        

    }


}
