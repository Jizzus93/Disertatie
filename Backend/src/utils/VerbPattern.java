package utils;

import FileIO.Occurrence;
import FileIO.ClassicXmlReader;
import org.graphstream.graph.Edge;
import org.graphstream.graph.Node;
import org.graphstream.graph.implementations.MultiGraph;
import org.graphstream.stream.file.FileSinkImages;


import java.awt.*;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import static org.graphstream.stream.file.FileSinkImages.*;

public class VerbPattern {

    transient ClassicXmlReader xmlFileReader = new ClassicXmlReader();

    int id;
    String form_ro;
    String form_en;
    String PWN;

    VerbPatternType verbPatternType;
    VerbPatternInfo patternInfo;

    ArrayList<String> implicatures = new ArrayList<String>();

    ArrayList<Occurrence> examples = new ArrayList<Occurrence>();

    int examplesNumber;
    transient String logs = "";

    public VerbPattern( int id, String form_romainian,String form_english)
    {
        this.id = id;
        this.form_ro = form_romainian;
        this.form_en = form_english;
        String PWN = "";
        verbPatternType = new VerbPatternType();
        patternInfo = new VerbPatternInfo();
        examplesNumber = 0;
    }

    public VerbPattern(Occurrence occurrence)
    {

        examplesNumber = 0;
        addExample(occurrence);
        patternInfo = new VerbPatternInfo();

    }

    public String getForm_ro() {
        return form_ro;
    }

    public void setForm_ro(String form_ro) {
        this.form_ro = form_ro;
    }

    public void addLogs(String logs)
    {
        this.logs+= logs;
    }
    public VerbPatternInfo getPatternInfo() {
        return patternInfo;
    }

    public void setPatternInfo(VerbPatternInfo patternInfo) {
        this.patternInfo = patternInfo;
    }

    public ArrayList<String> getImplicatures() {
        return implicatures;
    }

    public void addImplicature(String implicature)
    {
        this.implicatures.add(implicature);
    }

    public void setImplicatures(ArrayList<String> implicatures) {
        this.implicatures = implicatures;
    }

    public VerbPatternType getVerbPatternType() {
        return verbPatternType;
    }

    public void setVerbPatternType(VerbPatternType verbPatternType) {
        this.verbPatternType = verbPatternType;
    }

    public String getPWN() {
        return PWN;
    }

    public void setPWN(String PWN) {
        this.PWN = PWN;
    }

    public ArrayList<String> getArguments()
    {
        this.patternInfo.addClassicArgument("c.d");
        return this.patternInfo.getClassicArguments();
    }

    public ArrayList<String> getAdjuncts() {
        return this.patternInfo.getClassicAdjuncts();
    }

    public ArrayList<Occurrence> getExamples() {
        return this.examples;
    }

    public Sentence getExampleSentence(int exampleId)
    {
        return xmlFileReader.getSentence(examples.get(exampleId));
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

        for(String str: patternInfo.getClassicArguments())
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
                    patternInfo.getClassicArguments().add(w.getDepRel());
                }

                if(addAdjuncts)
                {
                    patternInfo.getClassicArguments().add(w.getDepRel());
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
