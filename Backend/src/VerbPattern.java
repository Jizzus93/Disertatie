import org.graphstream.graph.Edge;
import org.graphstream.graph.Node;
import org.graphstream.graph.implementations.DefaultGraph;
import org.graphstream.graph.implementations.MultiGraph;
import org.graphstream.stream.file.FileSinkImages;
import org.graphstream.ui.swingViewer.Viewer;


import java.awt.*;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import static org.graphstream.stream.file.FileSinkImages.*;

public class VerbPattern {
    //graph
    transient MultiGraph mPattern;
    transient XMLReader xmlFileReader = new XMLReader();
    ArrayList<String> arguments = new ArrayList<String>();
    ArrayList<String> adjuncts = new ArrayList<String>();
    ArrayList<Occurrence> examples = new ArrayList<Occurrence>();
    int examplesNumber;


    VerbPattern(Occurrence o)
    {
        mPattern = new MultiGraph("" + o.getTreebankID() + "_" + o.getSentenceID() + "_" + o.getWordID());
        examplesNumber = 0;
        addExample(o);

        createGraph(o);

    }

    public void addExample(Occurrence occurrence)
    {
        examples.add(occurrence);
        examplesNumber++;
    }

    public int getExamplesNumber()
    {
        return examplesNumber;
    }


    private void createGraph(Occurrence occurrence)
    {
        Sentence a_Sentence = xmlFileReader.getSentence(occurrence);

        //adding the verb as the root node
        mPattern.addNode("Id" + occurrence.getWordID());

        //make the root verb blue, so it stands out
        Node root = mPattern.getNode("Id" + occurrence.getWordID());
        root.setAttribute("ui.color", Color.BLUE);
        root.setAttribute("ui.size", "2gu");
        root.addAttribute("ui.label", a_Sentence.getWord(occurrence.getWordID()).getForm());

        createGraphFromRoot(occurrence.getWordID(), a_Sentence, true, true);
    }


    private void createGraphFromRoot(int rootId, Sentence aSentence, boolean addArguments, boolean addAdjuncts)
    {
        for(Word w: aSentence.getWordList())
        {
            if(w.getHead() == rootId)
            {
                String nodeId = "Id" + w.getId();
                mPattern.addNode(nodeId);

                Node currentNode = mPattern.getNode(nodeId);
                if(addArguments)
                {
                    arguments.add(w.getDepRel());
                }

                if(addAdjuncts)
                {
                    adjuncts.add(w.getDepRel());
                }

                Node rootNode = mPattern.getNode("Id" + rootId);

                currentNode.addAttribute("ui.label", w.getForm());
                mPattern.addEdge("Edge"+nodeId, "Id" + rootId, nodeId);

                Edge currentEdge = mPattern.getEdge("Edge"+nodeId);
                currentEdge.addAttribute("ui.label", w.getDepRel());

                //we should add all the children until there are node left
                createGraphFromRoot(w.getId(), aSentence, false, false);
            }
        }
    }


    public String getImageResource()
    {

        System.setProperty("gs.ui.renderer", "org.graphstream.ui.j2dviewer.J2DGraphRenderer");
        System.setProperty("java.awt.headless","false");


        FileSinkImages pic = new FileSinkImages("graphics/" + mPattern.getId() + "/img", OutputType.PNG, Resolutions.HD720, OutputPolicy.ByAttributeEventOutput);
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
