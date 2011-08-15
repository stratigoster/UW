import java.util.*;

// All Classes represent token objects from the SL language.

public abstract class SLToken extends java_cup.runtime.Symbol {
	private final String name;

	protected abstract String printAttributes ();

	public final String toString () {
		return "<" + name + printAttributes () + ">";
	}

	public static class Keyword extends SLToken {
		protected String printAttributes () {
			return "";
		}

		protected Keyword (int code, String n, Object v) {
			super (code, n, v);
		}

		protected Keyword (int code, String n) {
			super (code, n, null);
		}
	}

	// Semicolon (;)
	public static class SEMI extends Keyword { 
		public SEMI () { 
			super (Sym.SEMI, "SEMI");
	}	}

	// Comma (,)
	public static class COMMA extends Keyword {
		public COMMA() {
			super(Sym.COMMA, "COMMA");
	}	}

	// End of file
	public static class EOF extends Keyword { 
		public EOF () { 
			super (Sym.EOF, "EOF");
	}	}

	// Parentheses ( )
	public static class OPENP extends Keyword { 
	public OPENP () { 
		super (Sym.OPENP, "OPENP");
	}	}

	public static class CLOSEP extends Keyword { 
		public CLOSEP () { 
			super (Sym.CLOSEP, "CLOSEP");
	}	}

	// Braces { }
	public static class OPENB extends Keyword { 
		public OPENB () { 
			super (Sym.OPENB, "OPENB");
	}	}

	public static class CLOSEB extends Keyword { 
		public CLOSEB () { 
			super (Sym.CLOSEB, "CLOSEB");
	}	}

	// &	
	public static class AMPERSAND extends Keyword {
		public AMPERSAND () {
			super (Sym.AMPERSAND, "AMPERSAND");
	}	}
    
	// Logical Boolean operators
	public static class NOT extends Keyword { 
		public NOT() { 
			super (Sym.NOT, "NOT");
	}	}
	
	public static class OR extends Keyword { 
		public OR() { 
			super (Sym.OR, "OR");
	}	}
    

	// Control structures
	public static class RETURN extends Keyword { 
		public RETURN() { 
			super (Sym.RETURN, "RETURN");
	}	}

	public static class IF extends Keyword { 
		public IF() { 
			super (Sym.IF, "IF");
	}	}
    
	public static class ELSEIF extends Keyword { 
		public ELSEIF() { 
			super (Sym.ELSEIF, "ELSEIF");
	}	}

	public static class ELSE extends Keyword { 
		public ELSE() { 
			super (Sym.ELSE, "ELSE");
	}	}
	
	public static class WHILE extends Keyword {
		public WHILE() {
			super(Sym.WHILE, "WHILE");
	}	}
 

	// I/O keywords
	// keyword "in"
	public static class IN extends Keyword {
		public IN() { 
			super (Sym.IN, "IN");
	}	}
    
	// >> 
	public static class INSIGN extends Keyword { 
		public INSIGN() {
			super (Sym.INSIGN, "INSIGN");
	}	}
   
	// keyword "out" 
	public static class OUT extends Keyword { 
		public OUT() { 
			super (Sym.OUT, "OUT");
	}	}

	// <<
	public static class OUTSIGN extends Keyword { 
		public OUTSIGN () { 
			super (Sym.OUTSIGN, "OUTSIGN");
	}	}

	// Assignment =
	public static class ASSIGN extends Keyword { 
		public ASSIGN () { 
			super (Sym.ASSIGN, "ASSIGN");
	}	}


	// Structures!
	public static class STRUCT extends Keyword {
		public STRUCT () {
			super (Sym.STRUCT, "STRUCT");
	}	}

	// .
	public static class PERIOD extends Keyword {
		public PERIOD() {
			super (Sym.PERIOD, "PERIOD");
	}	}


	// Basic Types (names, not literals: int, char, bool)
	public static final class Type extends SLToken {
		protected String printAttributes () {
			return " " + (String) value;
		}

		public Type (String text) {
			super (Sym.TYPE, "TYPE", text);
			if(!(text.equals("int") || text.equals("char") 
				|| text.equals("bool") ))
				throw new IllegalArgumentException ();
		}
	}

	// Multiplicative Operators (*, /, %)
	public static final class MulOp extends SLToken {
		protected String printAttributes () {
			return " " + (String) value;
		}

		public MulOp (String text) {
			super (Sym.MULOP, "MULOP", text);
			if (!(text.equals("*") || text.equals("/") 
				|| text.equals("%")))
				throw new IllegalArgumentException ();
		}
	}

	// Additive Operators (+, -)
	public static final class AddOp extends SLToken {
		protected String printAttributes () {
			return " " + (String) value;
		}

		public AddOp (String text) {
			super (Sym.ADDOP, "ADDOP", text);
			if (! (text.equals ("+") || text.equals ("-")))
				throw new IllegalArgumentException ();
		}
	}

	// Relational Operators (>, <)
	public static final class RelOp extends SLToken {
		protected String printAttributes () {
			return " " + (String) value;
		}

		public RelOp (String text) {
			super (Sym.RELOP, "RELOP", text);
			if (! (text.equals (">") || text.equals ("<") ))
				throw new IllegalArgumentException ();
		}
	}

	// Equality Operator (==)
	public static final class EqOp extends SLToken {
		protected String printAttributes () {
			return " " + (String) value;
		}

		public EqOp (String text) {
			super (Sym.EQOP, "EQOP", text);
			if ( !text.equals ("==") ) 
				throw new IllegalArgumentException ();
		}
	}

	public static final class IntLiteral extends SLToken {
		protected String printAttributes () {
			return " " + (Integer) value;
		} 

		public IntLiteral (String text) {
			this (Integer.parseInt (text));
		}

		public IntLiteral (int v) {
			super (Sym.INT, "INT", new Integer (v));
		}
	} 

	public static final class CharLiteral extends SLToken {
		protected String printAttributes () {
			return " " + value;
		}

		public CharLiteral (String text) {
			super (Sym.CHAR, "CHAR", text);
		}
	}

	public static final class BoolLiteral extends SLToken {
		protected String printAttributes () {
			return " " + (Boolean) value;
		}

		public BoolLiteral (boolean b) {
			super (Sym.BOOL, "BOOL", new Boolean (b));
		}
	}
	 
	public static final class Identifier extends SLToken {
		protected String printAttributes () {
			return " " + (String) value;
		}

		public Identifier (String n) {
			super (Sym.ID, "ID", n);
		}
	}

	protected SLToken (int code, String n, Object obj) {
		super (code, obj);
		name = n;
	}
}

