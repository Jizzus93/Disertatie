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

    VerbPatternInfo()
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


    public ArrayList<String> getClassicRestrictions()
    {
        return classicRestrictions;
    }

    public void setClassicRestrictions(ArrayList<String> restrictions)
    {
        this.classicRestrictions = restrictions;
    }

    public ArrayList<String> getUDRestrictions()
    {
        return UDRestrictions;
    }

    public void setUDRestrictions(ArrayList<String> restrictions)
    {
        this.UDRestrictions = restrictions;
    }

    public ArrayList<String> getSemanticRestrictions()
    {
        return semanticRestrictions;
    }

    public void setSemanticRestrictions(ArrayList<String> restrictions)
    {
        this.semanticRestrictions = restrictions;
    }

    public ArrayList<String> getClassicAdvancedArguments()
    {
        return classicAdvancedArguments;
    }

    public void setClassicAdvancedArguments(ArrayList<String> arguments)
    {
        this.classicAdvancedArguments = arguments;
    }

    public ArrayList<String> getClassicAdvancedAdjuncts()
    {
        return classicAdvancedAdjuncts;
    }

    public void setClassicAdvancedAdjuncts(ArrayList<String> adjuncts)
    {
        this.classicAdvancedAdjuncts = adjuncts;
    }

    public ArrayList<String> getUDAdvancedArguments()
    {
        return UDAdvancedArguments;
    }

    public void setUDAdvancedArguments(ArrayList<String> arguments)
    {
        this.UDAdvancedArguments = arguments;
    }

    public ArrayList<String> getUDAdvancedAdjuncts()
    {
        return UDAdvancedAdjuncts;
    }

    public void setUDAdvancedAdjuncts(ArrayList<String> adjuncts)
    {
        this.UDAdvancedAdjuncts = adjuncts;
    }

    public ArrayList<String> getSemanticAdvancedArguments()
    {
        return semanticAdvancedArguments;
    }

    public void setSemanticAdvancedArguments(ArrayList<String> arguments)
    {
        this.semanticAdvancedArguments = arguments;
    }

    public ArrayList<String> getSemanticAdvancedAdjuncts()
    {
        return semanticAdvancedAdjuncts;
    }

    public void setSemanticAdvancedAdjuncts(ArrayList<String> adjuncts)
    {
        this.semanticAdvancedAdjuncts = adjuncts;
    }

    public ArrayList<String> getClassicArguments()
    {
        return classicArguments;
    }

    public void setClassicArguments(ArrayList<String> arguments)
    {
        this.classicArguments = arguments;
    }

    public ArrayList<String> getClassicAdjuncts()
    {
        return classicAdjuncts;
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

    public void setUDArguments(ArrayList<String> arguments)
    {
        this.UDArguments = arguments;
    }

    public ArrayList<String> getUDAdjuncts()
    {
        return UDAdjuncts;
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

    public ArrayList<String> getSemanticAdjuncts()
    {
        return semanticAdjuncts;
    }

    public void setSemanticAdjuncts(ArrayList<String> adjuncts)
    {
        this.semanticAdjuncts = adjuncts;
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
