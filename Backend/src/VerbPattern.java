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

    transient XMLReader xmlFileReader = new XMLReader();
    ArrayList<String> arguments = new ArrayList<String>();
    ArrayList<String> adjuncts = new ArrayList<String>();
    ArrayList<Occurrence> examples = new ArrayList<Occurrence>();
    int examplesNumber;
    transient String logs = "";


    VerbPattern(Occurrence occurrence)
    {

        examplesNumber = 0;
        addExample(occurrence);
        arguments = computeArguments(occurrence);
        adjuncts = computeAdjuncts(occurrence);

    }

    public ArrayList<String> getArguments()
    {
        return this.arguments;
    }

    public ArrayList<String> getAdjuncts() {
        return this.adjuncts;
    }

    public ArrayList<Occurrence> getExamples() {
        return this.examples;
    }

    @Override
    public boolean equals(Object obj) {
        if(obj == this)
        {
            return true;
        }

        if(!(obj instanceof VerbPattern))
        {
            return false;
        }

        VerbPattern vp = (VerbPattern) obj;

        for(String str: arguments)
        {
            //logs += "Looking for " + str + "\n";
            if(!vp.getArguments().contains(str))
            {
                return false;
            }
        }

        return true;

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

    public String generateImageResource(int exampleIndex)
    {
        String pathToPNGFile = "graphics/";
        if(exampleIndex<examplesNumber)
        {
            Occurrence occurrence = examples.get(exampleIndex);
            MultiGraph graphRepresentation = new MultiGraph("" + occurrence.getTreebankID() + "_" + occurrence.getSentenceID() + "_" + occurrence.getWordID());
            createGraph(occurrence, graphRepresentation);
            String graphPath = getImageResource(graphRepresentation);
            if(graphPath.equals("invalidPath"))
            {
                pathToPNGFile = "invalidPath";
            }
            else
            {
                pathToPNGFile += graphPath;
            }
        }
        else
        {
            //this is an error case, should not happen unless class is misused
            pathToPNGFile = "invalidPath";
        }


        return pathToPNGFile;
    }

    private ArrayList<String> computeArguments(Occurrence occurrence)
    {
        ArrayList<String> tmp_arguments = new ArrayList<String>();
        Sentence aSentence = xmlFileReader.getSentence(occurrence);

        for(Word w: aSentence.getWordList())
        {
            if(w.getHead() == occurrence.getWordID())
            {
                tmp_arguments.add(w.getDepRel());
            }
        }

        return tmp_arguments;
    }

    private ArrayList<String> computeAdjuncts(Occurrence occurrence)
    {
        ArrayList<String> tmp_adjuncts = new ArrayList<String>();
        Sentence aSentence = xmlFileReader.getSentence(occurrence);

        for(Word w: aSentence.getWordList())
        {
            if(w.getHead() == occurrence.getWordID())
            {
                tmp_adjuncts.add(w.getDepRel());
            }
        }

        return tmp_adjuncts;
    }

    private void createGraph(Occurrence occurrence, MultiGraph graphRepresentation)
    {
        Sentence a_Sentence = xmlFileReader.getSentence(occurrence);

        //adding the verb as the root node
        graphRepresentation.addNode("Id" + occurrence.getWordID());

        //make the root verb blue, so it stands out
        Node root = graphRepresentation.getNode("Id" + occurrence.getWordID());
        root.setAttribute("ui.color", Color.BLUE);
        root.setAttribute("ui.size", "2gu");
        root.addAttribute("ui.label", a_Sentence.getWord(occurrence.getWordID()).getForm());

        createGraphFromRoot(occurrence.getWordID(), a_Sentence, true, true, graphRepresentation);
    }


    private void createGraphFromRoot(int rootId, Sentence aSentence, boolean addArguments, boolean addAdjuncts, MultiGraph graphRepresentation)
    {
        for(Word w: aSentence.getWordList())
        {
            if(w.getHead() == rootId)
            {
                String nodeId = "Id" + w.getId();
                graphRepresentation.addNode(nodeId);

                Node currentNode = graphRepresentation.getNode(nodeId);
                if(addArguments)
                {
                    arguments.add(w.getDepRel());
                }

                if(addAdjuncts)
                {
                    adjuncts.add(w.getDepRel());
                }

                Node rootNode = graphRepresentation.getNode("Id" + rootId);

                currentNode.addAttribute("ui.label", w.getForm());
                graphRepresentation.addEdge("Edge"+nodeId, "Id" + rootId, nodeId);

                Edge currentEdge = graphRepresentation.getEdge("Edge"+nodeId);
                currentEdge.addAttribute("ui.label", w.getDepRel());

                //we should add all the children until there are node left
                createGraphFromRoot(w.getId(), aSentence, false, false, graphRepresentation);
            }
        }
    }


    private String getImageResource(MultiGraph graphRepresentation)
    {

        System.setProperty("gs.ui.renderer", "org.graphstream.ui.j2dviewer.J2DGraphRenderer");
        System.setProperty("java.awt.headless","false");

        String graphPathPrefix = "" + graphRepresentation.getId();
        FileSinkImages pic = new FileSinkImages("graphics/" + graphRepresentation.getId() + "/img", OutputType.PNG, Resolutions.HD720, OutputPolicy.ByAttributeEventOutput);
        pic.setLayoutPolicy(LayoutPolicy.ComputedInLayoutRunner);


        graphRepresentation.clearSinks();
        graphRepresentation.addSink(pic);


        try {
            pic.writeAll(graphRepresentation, "sample2.png");
        } catch (IOException e) {
            e.printStackTrace();
        }

        File[] files = new File("graphics/"+graphPathPrefix).listFiles();
        if(files.length != 0)
        {
            graphPathPrefix += "/" + files[files.length-1].getName();
        }
        else
        {
            //lets hope this doesn't happen
            graphPathPrefix = "invalidPath";
        }

        return graphPathPrefix;
    }


}
