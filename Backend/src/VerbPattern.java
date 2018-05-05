import org.graphstream.graph.Edge;
import org.graphstream.graph.Node;
import org.graphstream.graph.implementations.DefaultGraph;
import org.graphstream.graph.implementations.MultiGraph;
import org.graphstream.stream.file.FileSinkImages;
import org.graphstream.ui.swingViewer.Viewer;


import java.awt.*;
import java.io.File;
import java.io.IOException;

import static org.graphstream.stream.file.FileSinkImages.*;

public class VerbPattern {
    //graph
    MultiGraph mPattern;
    XMLReader xmlFileReader = new XMLReader();
    //lista de Occurances

    VerbPattern(Occurance o)
    {
        mPattern = new MultiGraph("" + o.getTreebankID() + "_" + o.getSentenceID() + "_" + o.getWordID());
        Sentence a_Sentence = xmlFileReader.getSentence(o);

        //adding the verb as the root node
        mPattern.addNode("Id" + o.getWordID());

        //make the root verb blue, so it stands out
        Node root = mPattern.getNode("Id" + o.getWordID());
        root.setAttribute("ui.color", Color.BLUE);
        root.setAttribute("ui.size", "2gu");
        root.addAttribute("ui.label", a_Sentence.getWord(o.getWordID()).getForm());

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

                currentNode.addAttribute("ui.label", w.getForm());
                mPattern.addEdge("Edge"+nodeId, "Id" + rootId, nodeId);

                Edge currentEdge = mPattern.getEdge("Edge"+nodeId);
                currentEdge.addAttribute("ui.label", w.getDepRel());

                //we should add all the children until there are node left
                createGraphFromRoot(w.getId(), aSentence);
            }
        }
    }


    public String getImageResource()
    {

        System.setProperty("gs.ui.renderer", "org.graphstream.ui.j2dviewer.J2DGraphRenderer");
        System.setProperty("java.awt.headless","false");


        FileSinkImages pic = new FileSinkImages("graphics/" + mPattern.getId(), OutputType.PNG, Resolutions.HD720, OutputPolicy.ByAttributeEventOutput);
        pic.setLayoutPolicy(LayoutPolicy.ComputedInLayoutRunner);


        mPattern.clearSinks();
        mPattern.addSink(pic);


        try {
            pic.writeAll(mPattern, "sample2.png");
        } catch (IOException e) {
            e.printStackTrace();
        }


        //BUG IN LIB, this works with older versions
        //TODO: If no fix comes for this bug, an older version of the lib should be used.
        //mPattern.addAttribute("ui.screenshot", "sample2.png");
        //Viewer v = mPattern.display();
        return "sample.png";
    }


}
