package it.uniroma1.hadoop.pagerank.job1;

import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

import it.uniroma1.hadoop.pagerank.PageRank;

import java.io.IOException;

public class PageRankJob1Mapper extends Mapper<LongWritable, Text, Text, Text> {
    
    @Override
    public void map(LongWritable key, Text value, Context context) throws IOException, InterruptedException {
        
        /* Job#1 mapper will simply parse a line of the input graph creating a map with key-value(s) pairs.
         * Input format is the following (separator is TAB):
         * 
         *     <nodeA>    <nodeB>
         * 
         * which denotes an edge going from <nodeA> to <nodeB>.
         * We would need to skip comment lines (denoted by the # characters at the beginning of the line).
         * We will also collect all the distinct nodes in our graph: this is needed to compute the initial 
         * pagerank value in Job #1 reducer and also in later jobs.
         */
        
        if (value.charAt(0) != '#') {
            
            int tabIndex = value.find("\t");
            String nodeA = Text.decode(value.getBytes(), 0, tabIndex);
            String nodeB = Text.decode(value.getBytes(), tabIndex + 1, value.getLength() - (tabIndex + 1));
            context.write(new Text(nodeA), new Text(nodeB));
            
            // add the current source node to the node list so we can 
            // compute the total amount of nodes of our graph in Job#2
            PageRank.NODES.add(nodeA);
            // also add the target node to the same list: we may have a target node 
            // with no outlinks (so it will never be parsed as source)
            PageRank.NODES.add(nodeB);
            
        }
 
    }
    
}
