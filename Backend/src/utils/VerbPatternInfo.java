package utils;

import org.w3c.dom.Document;
import org.w3c.dom.Element;

import java.util.ArrayList;

public class VerbPatternInfo {
    ArrayList<String> classicRestrictions;
    ArrayList<String> UDRestrictions;
    ArrayList<String> semanticRestrictions;

    ArrayList<String> classicAdvancedArguments;
    ArrayList<String> classicAdvancedAdjuncts;
    ArrayList<String> UDAdvancedArguments;
    ArrayList<String> UDAdvancedAdjuncts;
    ArrayList<String> semanticAdvancedArguments;
    ArrayList<String> semanticAdvancedAdjuncts;

    ArrayList<String> classicArguments;
    ArrayList<String> classicAdjuncts;
    ArrayList<String> UDArguments;
    ArrayList<String> UDAdjuncts;
    ArrayList<String> semanticArguments;
    ArrayList<String> semanticAdjuncts;



    int classicExamplesNumber;
    int UDExamplesNumber;
    int semanticExamplesNumber;

    public VerbPatternInfo()
    {
        this.classicRestrictions = new ArrayList<String>();
        this.UDRestrictions = new ArrayList<String>();
        this.semanticRestrictions = new ArrayList<String>();

        this.classicAdvancedArguments = new ArrayList<String>();
        this.classicAdvancedAdjuncts = new ArrayList<String>();
        this.UDAdvancedArguments = new ArrayList<String>();
        this.UDAdvancedAdjuncts = new ArrayList<String>();
        this.semanticAdvancedArguments = new ArrayList<String>();
        this.semanticAdvancedAdjuncts = new ArrayList<String>();

        this.classicArguments = new ArrayList<String>();
        this.classicAdjuncts = new ArrayList<String>();
        this.UDArguments = new ArrayList<String>();
        this.UDAdjuncts = new ArrayList<String>();
        this.semanticArguments = new ArrayList<String>();
        this.semanticAdjuncts = new ArrayList<String>();

        this.classicExamplesNumber = 0;
        this.UDExamplesNumber = 0;
        this.semanticExamplesNumber = 0;
    }

    public Element toXMLElement(Document doc)
    {
        Element dependenciesRoot = doc.createElement("dependencies");



        //creating restrictions
        Element restrictions = doc.createElement("restrictions");

        for(int i=0; i<classicRestrictions.size(); i++)
        {
            restrictions.setAttribute("classic_"+ (i+1), classicRestrictions.get(i));
        }

        for(int i=0; i<UDRestrictions.size(); i++)
        {
            restrictions.setAttribute("UD_"+ (i+1), UDRestrictions.get(i));
        }

        for(int i=0; i<semanticRestrictions.size(); i++)
        {
            restrictions.setAttribute("semantic_"+ (i+1), UDRestrictions.get(i));
        }

        dependenciesRoot.appendChild(restrictions);

        //creating advanced_arguments
        Element advanced_arguments = doc.createElement("advanced_arguments");
        for(int i=0; i<classicAdvancedArguments.size(); i++)
        {
            advanced_arguments.setAttribute("type_classic_"+ (i+1), classicAdvancedArguments.get(i));
        }

        for(int i=0; i<UDAdvancedArguments.size(); i++)
        {
            advanced_arguments.setAttribute("type_UD_"+ (i+1), UDAdvancedArguments.get(i));
        }

        for(int i=0; i<semanticAdvancedArguments.size(); i++)
        {
            advanced_arguments.setAttribute("type_semantic_"+ (i+1), semanticAdvancedArguments.get(i));
        }

        dependenciesRoot.appendChild(advanced_arguments);

        //creating advanced_arguments
        Element advanced_adjuncts = doc.createElement("advanced_adjuncts");
        for(int i=0; i<classicAdvancedAdjuncts.size(); i++)
        {
            advanced_adjuncts.setAttribute("type_classic_"+ (i+1), classicAdvancedAdjuncts.get(i));
        }

        for(int i=0; i<UDAdvancedAdjuncts.size(); i++)
        {
            advanced_adjuncts.setAttribute("type_UD_"+ (i+1), UDAdvancedAdjuncts.get(i));
        }

        for(int i=0; i<semanticAdvancedAdjuncts.size(); i++)
        {
            advanced_adjuncts.setAttribute("type_semantic_"+ (i+1), semanticAdvancedAdjuncts.get(i));
        }

        dependenciesRoot.appendChild(advanced_adjuncts);


        //creating arguments
        Element arguments = doc.createElement("arguments");
        for(int i=0; i<classicArguments.size(); i++)
        {
            arguments.setAttribute("type_classic_"+ (i+1), classicArguments.get(i));
        }

        for(int i=0; i<UDArguments.size(); i++)
        {
            arguments.setAttribute("type_UD_"+ (i+1), UDArguments.get(i));
        }

        for(int i=0; i<semanticArguments.size(); i++)
        {
            arguments.setAttribute("type_semantic_"+ (i+1), semanticArguments.get(i));
        }

        dependenciesRoot.appendChild(arguments);

        //creating arguments
        Element adjuncts = doc.createElement("adjuncts");
        for(int i=0; i<classicAdjuncts.size(); i++)
        {
            adjuncts.setAttribute("type_classic_"+ (i+1), classicAdjuncts.get(i));
        }

        for(int i=0; i<UDAdjuncts.size(); i++)
        {
            adjuncts.setAttribute("type_UD_"+ (i+1), UDAdjuncts.get(i));
        }

        for(int i=0; i<semanticAdjuncts.size(); i++)
        {
            adjuncts.setAttribute("type_semantic_"+ (i+1), semanticAdjuncts.get(i));
        }

        dependenciesRoot.appendChild(adjuncts);

        return dependenciesRoot;
    }


    public ArrayList<String> getClassicRestrictions()
    {
        return classicRestrictions;
    }

    public void addClassicRestriction(String restriction)
    {
        this.classicRestrictions.add(restriction);
    }

    public void setClassicRestrictions(ArrayList<String> restrictions)
    {
        this.classicRestrictions = restrictions;
    }

    public ArrayList<String> getUDRestrictions()
    {
        return UDRestrictions;
    }

    public void addUDRestriction(String restriction)
    {
        this.UDRestrictions.add(restriction);
    }

    public void setUDRestrictions(ArrayList<String> restrictions)
    {
        this.UDRestrictions = restrictions;
    }

    public ArrayList<String> getSemanticRestrictions()
    {
        return semanticRestrictions;
    }

    public void addSemanticRestriction(String restriction)
    {
        this.semanticRestrictions.add(restriction);
    }

    public void setSemanticRestrictions(ArrayList<String> restrictions)
    {
        this.semanticRestrictions = restrictions;
    }

    public ArrayList<String> getClassicAdvancedArguments()
    {
        return classicAdvancedArguments;
    }

    public void addClassicAdvancedArgument(String argument)
    {
        this.classicAdvancedArguments.add(argument);
    }

    public void setClassicAdvancedArguments(ArrayList<String> arguments)
    {
        this.classicAdvancedArguments = arguments;
    }

    public ArrayList<String> getClassicAdvancedAdjuncts()
    {
        return classicAdvancedAdjuncts;
    }

    public void addClassicAdvancedAdjunct(String adjunct)
    {
        this.classicAdvancedAdjuncts.add(adjunct);
    }

    public void setClassicAdvancedAdjuncts(ArrayList<String> adjuncts)
    {
        this.classicAdvancedAdjuncts = adjuncts;
    }

    public ArrayList<String> getUDAdvancedArguments()
    {
        return UDAdvancedArguments;
    }

    public void addUDAdvancedArgument(String argument)
    {
        this.UDAdvancedArguments.add(argument);
    }

    public void setUDAdvancedArguments(ArrayList<String> arguments)
    {
        this.UDAdvancedArguments = arguments;
    }

    public ArrayList<String> getUDAdvancedAdjuncts()
    {
        return UDAdvancedAdjuncts;
    }

    public void addUDAdvancedAdjunct(String adjunct)
    {
        this.UDAdvancedAdjuncts.add(adjunct);
    }

    public void setUDAdvancedAdjuncts(ArrayList<String> adjuncts)
    {
        this.UDAdvancedAdjuncts = adjuncts;
    }

    public ArrayList<String> getSemanticAdvancedArguments()
    {
        return semanticAdvancedArguments;
    }

    public void addSemanticAdvancedArgument(String argument)
    {
        this.semanticAdvancedArguments.add(argument);
    }

    public void setSemanticAdvancedArguments(ArrayList<String> arguments)
    {
        this.semanticAdvancedArguments = arguments;
    }

    public ArrayList<String> getSemanticAdvancedAdjuncts()
    {
        return semanticAdvancedAdjuncts;
    }

    public void addSemanticAdvancedAdjunct(String adjunct)
    {
        this.semanticAdvancedAdjuncts.add(adjunct);
    }

    public void setSemanticAdvancedAdjunct(ArrayList<String> adjuncts)
    {
        this.semanticAdvancedAdjuncts = adjuncts;
    }

    public ArrayList<String> getClassicArguments()
    {
        return classicArguments;
    }

    public void addClassicArgument(String argument)
    {
        this.classicArguments.add(argument);
    }

    public void setClassicArguments(ArrayList<String> arguments)
    {
        this.classicArguments = arguments;
    }

    public ArrayList<String> getClassicAdjuncts()
    {
        return classicAdjuncts;
    }

    public void addClassicAdjunct(String adjunct)
    {
        this.classicAdjuncts.add(adjunct);
    }

    public void setClassicAdjuncts(ArrayList<String> adjuncts)
    {
        this.classicAdjuncts = adjuncts;
    }

    public int getClassicExamplesNumber()
    {
        return classicExamplesNumber;
    }

    public void setClassicExamplesNumber(int classicExamplesNumber)
    {
        this.classicExamplesNumber = classicExamplesNumber;
    }


    public ArrayList<String> getUDArguments()
    {
        return UDArguments;
    }

    public void addUDArgument(String argument)
    {
        this.UDArguments.add(argument);
    }

    public void setUDArguments(ArrayList<String> arguments)
    {
        this.UDArguments = arguments;
    }

    public ArrayList<String> getUDAdjuncts()
    {
        return UDAdjuncts;
    }

    public void addUDAdjunct(String adjunct)
    {
        this.UDAdjuncts.add(adjunct);
    }

    public void setUDAdjuncts(ArrayList<String> adjuncts)
    {
        this.UDAdjuncts = adjuncts;
    }

    public int getUDExamplesNumber()
    {
        return UDExamplesNumber;
    }

    public void setUDExamplesNumber(int examplesNumber)
    {
        this.UDExamplesNumber = examplesNumber;
    }


    public ArrayList<String> getSemanticArguments()
    {
        return semanticArguments;
    }

    public void setSemanticArguments(ArrayList<String> arguments)
    {
        this.semanticArguments = arguments;
    }

    public void addSemanticArgument(String argument)
    {
        this.semanticArguments.add(argument);
    }

    public ArrayList<String> getSemanticAdjuncts()
    {
        return semanticAdjuncts;
    }

    public void setSemanticAdjuncts(ArrayList<String> adjuncts)
    {
        this.semanticAdjuncts = adjuncts;
    }

    public void addSemanticAdjunct(String adjunct)
    {
        this.semanticAdjuncts.add(adjunct);
    }


    public int getSemanticExamplesNumber()
    {
        return semanticExamplesNumber;
    }

    public void setSemanticExamplesNumber(int examplesNumber)
    {
        this.semanticExamplesNumber = examplesNumber;
    }
}
