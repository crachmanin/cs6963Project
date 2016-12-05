/* SimpleApp.scala */
import org.apache.spark.SparkContext
import org.apache.spark.SparkContext._
import org.apache.spark.SparkConf
import org.apache.log4j.{Level, Logger}
import org.apache.spark.mllib.regression.LabeledPoint
import org.apache.spark.mllib.util.MLUtils
import breeze.linalg._
import breeze.numerics._
//import org.apache.spark.mllib.linalg.BLAS.{dot}
import java.io._

object SimpleApp {

  def main(args: Array[String]) {
    //case class DLabeledPoint(var label: Double, var features:DenseVector)
    val conf = new SparkConf().setAppName("Logistic Regression")
    val sc = new SparkContext(conf)
    val data = MLUtils.loadLabeledPoints(sc, "test2")
      .map(p => (p.label, new DenseVector(p.features.toArray)))

    var a:Array[Double] = new Array[Double](28)
    for( i <- 0 to 27 ){
      a(i) = 1.0
    }
    var w = new DenseVector(a)
    for (i <- 1 to 10) {
      val gradient = data.map(p =>
          p._2 * (1/(1+exp(-p._1*(w dot p._2)))-1)*p._1
      ).reduce((a,b) => a+b)
      for( i <- 0 to 27 ){
        w(i) -= gradient(i)
      }
    }
    val pw = new PrintWriter(new File("hello.txt" ))
    pw.write(w.toString())
    pw.close()

    sc.stop()
  }
}
