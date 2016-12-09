package it.uniroma1.hadoop.pagerank.job1;

import it.uniroma1.hadoop.pagerank.PageRank;

import java.io.IOException;

import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

public class PageRankJob1Reducer extends Reducer<Text, Text, Text, Text> {
    
    @Override
    public void reduce(Text key, Iterable<Text> values, Context context) throws IOException, InterruptedException {
        
        /* Job#1 reducer will scroll all the nodes pointed by the given "key" node, constructing a
         * comma separated list of values and initializing the page rank for the "key" node.
         * Output format is the following (separator is TAB):
         * 
         *     <title>    <page-rank>    <link1>,<link2>,<link3>,<link4>,...,<linkN>
         *     
         * As for the pagerank initial value, early version of the PageRank algorithm used 1.0 as default, 
         * however later versions of PageRank assume a probability distribution between 0 and 1, hence the 
         * initial valus is set to DAMPING FACTOR / TOTAL NODES for each node in the graph.   
         */
        
        boolean first = true;
        String links = (PageRank.DAMPING / PageRank.NODES.size()) + "\t";

        for (Text value : values) {
            if (!first) 
                links += ",";
            links += value.toString();
            first = false;
        }

        context.write(key, new Text(links));
    }

}
