package FileIO;

import com.google.gson.Gson;
import utils.VerbPattern;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;

@Path("/verbPatternWriter")
public class VerbPatternWriter {

    @POST
    @Path("/writePattern")
    @Consumes("application/json")
    public void writePatter(InputStream inputStream)
    {
        StringBuilder inputBuilder = new StringBuilder();
        try {
            BufferedReader in = new BufferedReader(new InputStreamReader(inputStream));
            String line = null;
            while((line = in.readLine()) != null)
            {
                inputBuilder.append(line);
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        String input = inputBuilder.toString();

        Gson gson = new Gson();

        VerbPattern inputPattern = gson.fromJson(input, VerbPattern.class);
        PatternXmlWriter xmlWriter = new PatternXmlWriter();
        xmlWriter.writePatternToXMLFile(inputPattern,inputPattern.getVerb_id());
    }
}
