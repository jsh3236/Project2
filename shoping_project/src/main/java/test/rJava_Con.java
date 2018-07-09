package test;
import org.rosuda.REngine.REXP;
import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.REngineException;
import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;

public class rJava_Con {
	 public RConnection r = null;
	 public REXP x = null;
	 public String retStr = "";

	 public rJava_Con() throws RserveException {
	  this.r = new RConnection();

	 }

	 public byte[] returnRImg() throws REngineException, REXPMismatchException {

	  String device = "jpeg";
	  x = r.parseAndEval("try(" + device + "('test.jpg',quality=90))");
	  System.out.println("1");

	  // ok, so the device should be fine - let's plot - replace this by any plotting
	  // code you desire ...

	  r.parseAndEval("x <- mtcars$mpg ");
	  System.out.println("2");

	  r.parseAndEval("h<-hist(x, breaks=10, col=\"red\", xlab=\"Miles Per Gallon\", main=\"Histogram with Normal Curve\")");
	  System.out.println("3");

	  r.parseAndEval("xfit<-seq(min(x),max(x),length=40)");
	  System.out.println("4");

	  r.parseAndEval("yfit<-dnorm(xfit,mean=mean(x),sd=sd(x))");
	  System.out.println("5");

	  r.parseAndEval("yfit <- yfit*diff(h$mids[1:2])*length(x)");
	  System.out.println("6");

	  r.parseAndEval("lines(xfit, yfit, col=\"blue\", lwd=2)");
	  System.out.println("7");


	  // graphics off
	  r.parseAndEval("graphics.off()");
	  System.out.println("8");


	  // There is no I/O API in REngine because it's actually more efficient to use R
	  // for this
	  // we limit the file size to 1MB which should be sufficient and we delete the
	  // file as well
	  x = r.parseAndEval("r=readBin('test.jpg','raw',1024*1024); unlink('test.jpg'); r");
	  System.out.println("9");


	  return x.asBytes();// img;
	 }
	
}
