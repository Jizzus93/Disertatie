package bean;

import org.graphstream.graph.Edge;
import org.graphstream.graph.Node;
import org.graphstream.graph.implementations.MultiGraph;
import org.graphstream.stream.file.FileSinkImages;

import java.awt.*;
import java.io.IOException;
import java.util.ArrayList;

import static org.graphstream.stream.file.FileSinkImages.*;

public class VerbPatternBean {
    int id;
    String form_ro;
    String form_en;
    String PWN;

    VerbPatternTypeBean verbPatternType;
    VerbPatternInfoBean patternInfo;

    ArrayList<String> implicatures = new ArrayList<String>();


    ArrayList<OccurrenceBean> examples = new ArrayList<OccurrenceBean>();
    int examplesNumber;
    //lista de Occurances




    public ArrayList<OccurrenceBean> getExamples() {
        return examples;
    }

    public int getExamplesNumber() {
        return examplesNumber;
    }
}
