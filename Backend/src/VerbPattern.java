import org.graphstream.graph.Edge;
import org.graphstream.graph.Node;
import org.graphstream.graph.implementations.DefaultGraph;
import org.graphstream.stream.file.FileSinkImages;
import org.graphstream.ui.j2dviewer.J2DGraphRenderer;


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
        mPattern.addNode("Id" + o.getWordID());

        //make the root verb blue, so it stands out
        Node root = mPattern.getNode("Id" + o.getWordID());
        //root.setAttribute("ui.color", Color.BLUE);
        //root.setAttribute("ui.size", "2gu");
        //root.addAttribute("ui.label", a_Sentence.getWord(o.getWordID()).getForm());

        createGraphFromRoot(o.getWordID(), a_Sentence);
        

    }

    private void createGraphFromRoot(int rootId, Sentence aSentence)
    {
        for(Word w: aSentence.getWordList())
        {
            if(w.getHead() == rootId)
            {
                String nodeId = "Id" + w.getId();
                mPattern.addNode(nodeId);

                Node currentNode = mPattern.getNode(nodeId);
                Node rootNode = mPattern.getNode("Id" + rootId);

                //currentNode.addAttribute("ui.label", w.getForm());
                mPattern.addEdge("Edge"+nodeId, rootNode, currentNode);

                Edge currentEdge = mPattern.getEdge("Edge"+nodeId);
                //currentEdge.addAttribute("ui.label", w.getDepRel());

                //we should add all the children until there are node left
                createGraphFromRoot(w.getId(), aSentence);
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
