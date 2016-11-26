import java.awt.datatransfer.*;
import java.awt.Toolkit;

public class init {

	public static void main(String [] args) {
		String varType = args[0];
		String varName = args[1];

		String width = "let " + varName + "Width:CGFloat = ";
		String height = "let " + varName + "Height:CGFloat = ";
		String x = "let " + varName + "X:CGFloat = ";
		String y = "let " + varName + "Y:CGFloat = ";
		
		String init = varName + " = " + varType + "(frame: CGRect(x:" + varName + "X, y:" + varName + "Y, width: " + varName + "Width, height:" + varName + "Height))";

		System.out.println(width);
		System.out.println(height);
		System.out.println(x);
		System.out.println(y);
		System.out.println(init); 

		String fullStr = width + "\n" + height + "\n" + x + "\n" + y + "\n\n" + init;

		StringSelection stringSelection = new StringSelection(fullStr);
		Clipboard clpbrd = Toolkit.getDefaultToolkit().getSystemClipboard();
		clpbrd.setContents(stringSelection, null);
	}

}
