import org.graphstream.graph.Edge;
import org.graphstream.graph.Node;
import org.graphstream.graph.implementations.DefaultGraph;
import org.graphstream.stream.file.FileSinkImages;

import java.awt.*;
import java.io.File;
import java.io.IOException;

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

        //make the root verb blue, so it stands out
        Node root = mPattern.getNode(a_Sentence.getWord(o.getWordID()).getForm());
        root.setAttribute("ui.color", Color.BLUE);
        root.setAttribute("ui.size", "2gu");
        root.addAttribute("ui.label", a_Sentence.getWord(o.getWordID()).getForm());

        for(Word w: a_Sentence.getWordList())
        {
            if(w.getHead() == o.getWordID())
            {
                String nodeId = "Id" + w.getId();
                mPattern.addNode(nodeId);
                Node currentNode = mPattern.getNode(nodeId);
                currentNode.addAttribute("ui.label", w.getForm());
                mPattern.addEdge("Edge"+nodeId, root, currentNode);
                Edge currentEdge = mPattern.getEdge("Edge"+nodeId);
                currentNode.addAttribute("ui.label", w.getDepRel());
            }
        }

        

    }


    public String getImageResource()
    {
        System.setProperty("org.graphstream.ui.renderer", "org.graphstream.ui.j2dviewer.J2DGraphRenderer");
        FileSinkImages pic = new FileSinkImages(FileSinkImages.OutputType.PNG, FileSinkImages.Resolutions.VGA);

        //pic.setLayoutPolicy(FileSinkImages.LayoutPolicy.COMPUTED_FULLY_AT_NEW_IMAGE);


        try {
            pic.writeAll(mPattern, "sample.png");
        } catch (IOException e) {
            e.printStackTrace();
        }
        File f = new File("sample.png");
        //mPattern.addAttribute("ui.screenshot", "sample2.png");
        return "sample.png";
    }


}
