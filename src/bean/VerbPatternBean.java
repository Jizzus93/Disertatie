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
    ArrayList<String> arguments = new ArrayList<String>();
    ArrayList<String> adjuncts = new ArrayList<String>();
    ArrayList<OccurrenceBean> examples = new ArrayList<OccurrenceBean>();
    int examplesNumber;
    //lista de Occurances


    public ArrayList<String> getAdjuncts() {
        return adjuncts;
    }

    public ArrayList<String> getArguments() {
        return arguments;
    }
}
