/*********************************************************
CS241 
Assignment #3
Yylex.1
A sample scanner that recognizes keywords, identifiers,
comments, and boolean operations == and |.
*********************************************************/


class Yylex implements java_cup.runtime.Scanner {
	private final int YY_BUFFER_SIZE = 512;
	private final int YY_F = -1;
	private final int YY_NO_STATE = -1;
	private final int YY_NOT_ACCEPT = 0;
	private final int YY_START = 1;
	private final int YY_END = 2;
	private final int YY_NO_ANCHOR = 4;
	private final int YY_BOL = 128;
	private final int YY_EOF = 129;

public static class Util {
	public static String s = "";
	public static void err(int n) {
		System.out.println();
		System.out.println("Illegal character at line " + (n+1));
		System.exit(-1);
	}
}
	private java.io.BufferedReader yy_reader;
	private int yy_buffer_index;
	private int yy_buffer_read;
	private int yy_buffer_start;
	private int yy_buffer_end;
	private char yy_buffer[];
	private int yyline;
	private boolean yy_at_bol;
	private int yy_lexical_state;

	Yylex (java.io.Reader reader) {
		this ();
		if (null == reader) {
			throw (new Error("Error: Bad input stream initializer."));
		}
		yy_reader = new java.io.BufferedReader(reader);
	}

	Yylex (java.io.InputStream instream) {
		this ();
		if (null == instream) {
			throw (new Error("Error: Bad input stream initializer."));
		}
		yy_reader = new java.io.BufferedReader(new java.io.InputStreamReader(instream));
	}

	private Yylex () {
		yy_buffer = new char[YY_BUFFER_SIZE];
		yy_buffer_read = 0;
		yy_buffer_index = 0;
		yy_buffer_start = 0;
		yy_buffer_end = 0;
		yyline = 0;
		yy_at_bol = true;
		yy_lexical_state = YYINITIAL;
	}

	private boolean yy_eof_done = false;
	private void yy_do_eof () {
		if (false == yy_eof_done) {

	System.out.println();
	System.exit(0);
		}
		yy_eof_done = true;
	}
	private final int C = 3;
	private final int SLASH = 7;
	private final int IDENT = 11;
	private final int PIPE = 10;
	private final int A = 5;
	private final int EQUAL2 = 9;
	private final int EQUAL1 = 8;
	private final int ERROR = 14;
	private final int R = 6;
	private final int YYINITIAL = 0;
	private final int I = 1;
	private final int H = 4;
	private final int COMMENT = 12;
	private final int F = 2;
	private final int UNDERSCORE = 13;
	private final int yy_state_dtrans[] = {
		0,
		96,
		97,
		98,
		99,
		100,
		101,
		102,
		103,
		104,
		105,
		106,
		107,
		108,
		109
	};
	private void yybegin (int state) {
		yy_lexical_state = state;
	}
	private int yy_advance ()
		throws java.io.IOException {
		int next_read;
		int i;
		int j;

		if (yy_buffer_index < yy_buffer_read) {
			return yy_buffer[yy_buffer_index++];
		}

		if (0 != yy_buffer_start) {
			i = yy_buffer_start;
			j = 0;
			while (i < yy_buffer_read) {
				yy_buffer[j] = yy_buffer[i];
				++i;
				++j;
			}
			yy_buffer_end = yy_buffer_end - yy_buffer_start;
			yy_buffer_start = 0;
			yy_buffer_read = j;
			yy_buffer_index = j;
			next_read = yy_reader.read(yy_buffer,
					yy_buffer_read,
					yy_buffer.length - yy_buffer_read);
			if (-1 == next_read) {
				return YY_EOF;
			}
			yy_buffer_read = yy_buffer_read + next_read;
		}

		while (yy_buffer_index >= yy_buffer_read) {
			if (yy_buffer_index >= yy_buffer.length) {
				yy_buffer = yy_double(yy_buffer);
			}
			next_read = yy_reader.read(yy_buffer,
					yy_buffer_read,
					yy_buffer.length - yy_buffer_read);
			if (-1 == next_read) {
				return YY_EOF;
			}
			yy_buffer_read = yy_buffer_read + next_read;
		}
		return yy_buffer[yy_buffer_index++];
	}
	private void yy_move_end () {
		if (yy_buffer_end > yy_buffer_start &&
		    '\n' == yy_buffer[yy_buffer_end-1])
			yy_buffer_end--;
		if (yy_buffer_end > yy_buffer_start &&
		    '\r' == yy_buffer[yy_buffer_end-1])
			yy_buffer_end--;
	}
	private boolean yy_last_was_cr=false;
	private void yy_mark_start () {
		int i;
		for (i = yy_buffer_start; i < yy_buffer_index; ++i) {
			if ('\n' == yy_buffer[i] && !yy_last_was_cr) {
				++yyline;
			}
			if ('\r' == yy_buffer[i]) {
				++yyline;
				yy_last_was_cr=true;
			} else yy_last_was_cr=false;
		}
		yy_buffer_start = yy_buffer_index;
	}
	private void yy_mark_end () {
		yy_buffer_end = yy_buffer_index;
	}
	private void yy_to_mark () {
		yy_buffer_index = yy_buffer_end;
		yy_at_bol = (yy_buffer_end > yy_buffer_start) &&
		            ('\r' == yy_buffer[yy_buffer_end-1] ||
		             '\n' == yy_buffer[yy_buffer_end-1] ||
		             2028/*LS*/ == yy_buffer[yy_buffer_end-1] ||
		             2029/*PS*/ == yy_buffer[yy_buffer_end-1]);
	}
	private java.lang.String yytext () {
		return (new java.lang.String(yy_buffer,
			yy_buffer_start,
			yy_buffer_end - yy_buffer_start));
	}
	private int yylength () {
		return yy_buffer_end - yy_buffer_start;
	}
	private char[] yy_double (char buf[]) {
		int i;
		char newbuf[];
		newbuf = new char[2*buf.length];
		for (i = 0; i < buf.length; ++i) {
			newbuf[i] = buf[i];
		}
		return newbuf;
	}
	private final int YY_E_INTERNAL = 0;
	private final int YY_E_MATCH = 1;
	private java.lang.String yy_error_string[] = {
		"Error: Internal error.\n",
		"Error: Unmatched input.\n"
	};
	private void yy_error (int code,boolean fatal) {
		java.lang.System.out.print(yy_error_string[code]);
		java.lang.System.out.flush();
		if (fatal) {
			throw new Error("Fatal Error.\n");
		}
	}
	private int[][] unpackFromString(int size1, int size2, String st) {
		int colonIndex = -1;
		String lengthString;
		int sequenceLength = 0;
		int sequenceInteger = 0;

		int commaIndex;
		String workString;

		int res[][] = new int[size1][size2];
		for (int i= 0; i < size1; i++) {
			for (int j= 0; j < size2; j++) {
				if (sequenceLength != 0) {
					res[i][j] = sequenceInteger;
					sequenceLength--;
					continue;
				}
				commaIndex = st.indexOf(',');
				workString = (commaIndex==-1) ? st :
					st.substring(0, commaIndex);
				st = st.substring(commaIndex+1);
				colonIndex = workString.indexOf(':');
				if (colonIndex == -1) {
					res[i][j]=Integer.parseInt(workString);
					continue;
				}
				lengthString =
					workString.substring(colonIndex+1);
				sequenceLength=Integer.parseInt(lengthString);
				workString=workString.substring(0,colonIndex);
				sequenceInteger=Integer.parseInt(workString);
				res[i][j] = sequenceInteger;
				sequenceLength--;
			}
		}
		return res;
	}
	private int yy_acpt[] = {
		/* 0 */ YY_NOT_ACCEPT,
		/* 1 */ YY_NO_ANCHOR,
		/* 2 */ YY_NO_ANCHOR,
		/* 3 */ YY_NO_ANCHOR,
		/* 4 */ YY_NO_ANCHOR,
		/* 5 */ YY_NO_ANCHOR,
		/* 6 */ YY_NO_ANCHOR,
		/* 7 */ YY_NO_ANCHOR,
		/* 8 */ YY_NO_ANCHOR,
		/* 9 */ YY_NO_ANCHOR,
		/* 10 */ YY_NO_ANCHOR,
		/* 11 */ YY_NO_ANCHOR,
		/* 12 */ YY_NO_ANCHOR,
		/* 13 */ YY_NO_ANCHOR,
		/* 14 */ YY_NO_ANCHOR,
		/* 15 */ YY_NO_ANCHOR,
		/* 16 */ YY_NO_ANCHOR,
		/* 17 */ YY_NO_ANCHOR,
		/* 18 */ YY_NO_ANCHOR,
		/* 19 */ YY_NO_ANCHOR,
		/* 20 */ YY_NO_ANCHOR,
		/* 21 */ YY_NO_ANCHOR,
		/* 22 */ YY_NO_ANCHOR,
		/* 23 */ YY_NO_ANCHOR,
		/* 24 */ YY_NO_ANCHOR,
		/* 25 */ YY_NO_ANCHOR,
		/* 26 */ YY_NO_ANCHOR,
		/* 27 */ YY_NO_ANCHOR,
		/* 28 */ YY_NO_ANCHOR,
		/* 29 */ YY_NO_ANCHOR,
		/* 30 */ YY_NO_ANCHOR,
		/* 31 */ YY_NO_ANCHOR,
		/* 32 */ YY_NO_ANCHOR,
		/* 33 */ YY_NO_ANCHOR,
		/* 34 */ YY_NO_ANCHOR,
		/* 35 */ YY_NO_ANCHOR,
		/* 36 */ YY_NO_ANCHOR,
		/* 37 */ YY_NO_ANCHOR,
		/* 38 */ YY_NO_ANCHOR,
		/* 39 */ YY_NO_ANCHOR,
		/* 40 */ YY_NO_ANCHOR,
		/* 41 */ YY_NO_ANCHOR,
		/* 42 */ YY_NO_ANCHOR,
		/* 43 */ YY_NO_ANCHOR,
		/* 44 */ YY_NO_ANCHOR,
		/* 45 */ YY_NO_ANCHOR,
		/* 46 */ YY_NO_ANCHOR,
		/* 47 */ YY_NO_ANCHOR,
		/* 48 */ YY_NO_ANCHOR,
		/* 49 */ YY_NO_ANCHOR,
		/* 50 */ YY_NO_ANCHOR,
		/* 51 */ YY_NO_ANCHOR,
		/* 52 */ YY_NO_ANCHOR,
		/* 53 */ YY_NO_ANCHOR,
		/* 54 */ YY_NO_ANCHOR,
		/* 55 */ YY_NO_ANCHOR,
		/* 56 */ YY_NO_ANCHOR,
		/* 57 */ YY_NO_ANCHOR,
		/* 58 */ YY_NO_ANCHOR,
		/* 59 */ YY_NO_ANCHOR,
		/* 60 */ YY_NO_ANCHOR,
		/* 61 */ YY_NO_ANCHOR,
		/* 62 */ YY_NO_ANCHOR,
		/* 63 */ YY_NO_ANCHOR,
		/* 64 */ YY_NO_ANCHOR,
		/* 65 */ YY_NO_ANCHOR,
		/* 66 */ YY_NO_ANCHOR,
		/* 67 */ YY_NO_ANCHOR,
		/* 68 */ YY_NO_ANCHOR,
		/* 69 */ YY_NO_ANCHOR,
		/* 70 */ YY_NO_ANCHOR,
		/* 71 */ YY_NO_ANCHOR,
		/* 72 */ YY_NO_ANCHOR,
		/* 73 */ YY_NO_ANCHOR,
		/* 74 */ YY_NO_ANCHOR,
		/* 75 */ YY_NO_ANCHOR,
		/* 76 */ YY_NO_ANCHOR,
		/* 77 */ YY_NO_ANCHOR,
		/* 78 */ YY_NO_ANCHOR,
		/* 79 */ YY_NO_ANCHOR,
		/* 80 */ YY_NO_ANCHOR,
		/* 81 */ YY_NO_ANCHOR,
		/* 82 */ YY_NO_ANCHOR,
		/* 83 */ YY_NO_ANCHOR,
		/* 84 */ YY_NO_ANCHOR,
		/* 85 */ YY_NO_ANCHOR,
		/* 86 */ YY_NO_ANCHOR,
		/* 87 */ YY_NO_ANCHOR,
		/* 88 */ YY_NO_ANCHOR,
		/* 89 */ YY_NO_ANCHOR,
		/* 90 */ YY_NO_ANCHOR,
		/* 91 */ YY_NO_ANCHOR,
		/* 92 */ YY_NO_ANCHOR,
		/* 93 */ YY_NO_ANCHOR,
		/* 94 */ YY_NO_ANCHOR,
		/* 95 */ YY_NO_ANCHOR,
		/* 96 */ YY_NOT_ACCEPT,
		/* 97 */ YY_NOT_ACCEPT,
		/* 98 */ YY_NOT_ACCEPT,
		/* 99 */ YY_NOT_ACCEPT,
		/* 100 */ YY_NOT_ACCEPT,
		/* 101 */ YY_NOT_ACCEPT,
		/* 102 */ YY_NOT_ACCEPT,
		/* 103 */ YY_NOT_ACCEPT,
		/* 104 */ YY_NOT_ACCEPT,
		/* 105 */ YY_NOT_ACCEPT,
		/* 106 */ YY_NOT_ACCEPT,
		/* 107 */ YY_NOT_ACCEPT,
		/* 108 */ YY_NOT_ACCEPT,
		/* 109 */ YY_NOT_ACCEPT
	};
	private int yy_cmap[] = unpackFromString(1,130,
"10:9,11,6,10:2,7,10:18,11,10:14,2,9:10,10:3,4,10:3,9:26,10:4,8,10,14,9,3,9:" +
"2,12,9,13,1,9:8,15,9:8,10,5,10:3,0:2")[0];

	private int yy_rmap[] = unpackFromString(1,110,
"0,1:95,2,3,4,5,6,7,8,9,10,11,12,13,14,15")[0];

	private int yy_nxt[][] = unpackFromString(16,16,
"1,2,3,4,5,6,7,8,9,10,11,8,10:4,-1:16,1,12,13,12,14,15,16:2,17,12,18,16,19,1" +
"2:3,1,20,21,20,22,23,24:2,25,20,26,24,20:4,1,27,28,27,29,30,31:2,32,27,33,3" +
"1,27,34,27:2,1,35,36,35,37,38,39:2,40,35,41,39,35:2,42,35,1,43,44,43,45,46," +
"47:2,48,43,49,47,43:3,50,1,51,52,51,53,54,55,56,57,51,58,56,51:4,1,59,60,59" +
":3,61:2,59:3,61,59:4,1,62:3,63,62,64,-1,62:8,1,65,66,67,68,69,70,71,72,73,7" +
"2,71,73:4,1,74,75,76,77,78,79:2,80,81,80,79,81:4,1,82,83,82,84,85,86:2,87,8" +
"2,83,86,82:4,1,88:5,89,90,88:3,90,88:4,1,91,92,91,93:2,94:2,95,91,93,94,91:" +
"4,1,-1:15");

	public java_cup.runtime.Symbol next_token ()
		throws java.io.IOException {
		int yy_lookahead;
		int yy_anchor = YY_NO_ANCHOR;
		int yy_state = yy_state_dtrans[yy_lexical_state];
		int yy_next_state = YY_NO_STATE;
		int yy_last_accept_state = YY_NO_STATE;
		boolean yy_initial = true;
		int yy_this_accept;

		yy_mark_start();
		yy_this_accept = yy_acpt[yy_state];
		if (YY_NOT_ACCEPT != yy_this_accept) {
			yy_last_accept_state = yy_state;
			yy_mark_end();
		}
		while (true) {
			if (yy_initial && yy_at_bol) yy_lookahead = YY_BOL;
			else yy_lookahead = yy_advance();
			yy_next_state = YY_F;
			yy_next_state = yy_nxt[yy_rmap[yy_state]][yy_cmap[yy_lookahead]];
			if (YY_EOF == yy_lookahead && true == yy_initial) {
				yy_do_eof();
				return null;
			}
			if (YY_F != yy_next_state) {
				yy_state = yy_next_state;
				yy_initial = false;
				yy_this_accept = yy_acpt[yy_state];
				if (YY_NOT_ACCEPT != yy_this_accept) {
					yy_last_accept_state = yy_state;
					yy_mark_end();
				}
			}
			else {
				if (YY_NO_STATE == yy_last_accept_state) {
					throw (new Error("Lexical Error: Unmatched Input."));
				}
				else {
					yy_anchor = yy_acpt[yy_last_accept_state];
					if (0 != (YY_END & yy_anchor)) {
						yy_move_end();
					}
					yy_to_mark();
					switch (yy_last_accept_state) {
					case 1:
						
					case -2:
						break;
					case 2:
						{ 
	yybegin (I);
	Util.s=yytext();
}
					case -3:
						break;
					case 3:
						{
	yybegin (SLASH);
}
					case -4:
						break;
					case 4:
						{
	yybegin (C);
	Util.s=yytext();
}
					case -5:
						break;
					case 5:
						{
	yybegin (EQUAL1);
}
					case -6:
						break;
					case 6:
						{
	yybegin (PIPE);
}
					case -7:
						break;
					case 7:
						{
	yybegin (YYINITIAL);
}
					case -8:
						break;
					case 8:
						{
	yybegin (YYINITIAL);
}
					case -9:
						break;
					case 9:
						{
	yybegin (ERROR);
	Util.err(yyline);
}
					case -10:
						break;
					case 10:
						{
	yybegin (IDENT);
	Util.s=yytext();
}
					case -11:
						break;
					case 11:
						{
	yybegin (ERROR);
	Util.err(yyline);
}
					case -12:
						break;
					case 12:
						{
	yybegin (IDENT);
	Util.s+=yytext();
}
					case -13:
						break;
					case 13:
						{
	yybegin (SLASH);
	return new SLToken.Identifier(Util.s);
}
					case -14:
						break;
					case 14:
						{
	yybegin (EQUAL1);
	return new SLToken.Identifier(Util.s);
}
					case -15:
						break;
					case 15:
						{
	yybegin (PIPE);
	return new SLToken.Identifier(Util.s);
}
					case -16:
						break;
					case 16:
						{
	yybegin (YYINITIAL);
	return new SLToken.Identifier(Util.s);
}
					case -17:
						break;
					case 17:
						{
	yybegin (UNDERSCORE);
	Util.s+=yytext();
}
					case -18:
						break;
					case 18:
						{
	yybegin (ERROR);
	Util.err(yyline);
}
					case -19:
						break;
					case 19:
						{
	yybegin (F);
	Util.s+=yytext();
}
					case -20:
						break;
					case 20:
						{
	yybegin (IDENT);
	Util.s+=yytext();
}
					case -21:
						break;
					case 21:
						{
	yybegin (SLASH);
	return new SLToken.IF();
}
					case -22:
						break;
					case 22:
						{
	yybegin (EQUAL1);
	return new SLToken.IF();
}
					case -23:
						break;
					case 23:
						{
	yybegin (PIPE);
	return new SLToken.IF();
}
					case -24:
						break;
					case 24:
						{
	yybegin (YYINITIAL);
	return (new SLToken.IF());
}
					case -25:
						break;
					case 25:
						{
	yybegin (UNDERSCORE);
	Util.s+=yytext();
}
					case -26:
						break;
					case 26:
						{
	yybegin (ERROR);
	Util.err(yyline);
}
					case -27:
						break;
					case 27:
						{
	yybegin (IDENT);
	Util.s+=yytext();
}
					case -28:
						break;
					case 28:
						{
	yybegin (SLASH);
}
					case -29:
						break;
					case 29:
						{
	yybegin (EQUAL1);
	return new SLToken.Identifier(Util.s);
}
					case -30:
						break;
					case 30:
						{
	yybegin (PIPE);
	return new SLToken.Identifier(Util.s);
}
					case -31:
						break;
					case 31:
						{
	yybegin (YYINITIAL);
	return new SLToken.Identifier(Util.s);
}
					case -32:
						break;
					case 32:
						{
	yybegin (UNDERSCORE);
	Util.s+=yytext();
}
					case -33:
						break;
					case 33:
						{
	yybegin (ERROR);
	Util.err(yyline);
}
					case -34:
						break;
					case 34:
						{
	yybegin (H);
	Util.s+=yytext();
}
					case -35:
						break;
					case 35:
						{
	yybegin (IDENT);
	Util.s+=yytext();
}
					case -36:
						break;
					case 36:
						{
	yybegin (SLASH);
	return new SLToken.Identifier(Util.s);
}
					case -37:
						break;
					case 37:
						{
	yybegin (EQUAL1);
	return new SLToken.Identifier(Util.s);
}
					case -38:
						break;
					case 38:
						{
	yybegin (PIPE);
	return new SLToken.Identifier(Util.s);
}
					case -39:
						break;
					case 39:
						{
	yybegin (YYINITIAL);
	return new SLToken.Identifier(Util.s);
}
					case -40:
						break;
					case 40:
						{
	yybegin (UNDERSCORE);
	Util.s+=yytext();
}
					case -41:
						break;
					case 41:
						{
	yybegin (ERROR);
	Util.err(yyline);
}
					case -42:
						break;
					case 42:
						{
	yybegin (A);
	Util.s+=yytext();
}
					case -43:
						break;
					case 43:
						{
	yybegin (IDENT);
	Util.s+=yytext();
}
					case -44:
						break;
					case 44:
						{
	yybegin (SLASH);
	return new SLToken.Identifier(Util.s);
}
					case -45:
						break;
					case 45:
						{
	yybegin (EQUAL1);
	return new SLToken.Identifier(Util.s);
}
					case -46:
						break;
					case 46:
						{
	yybegin (PIPE);
	return new SLToken.Identifier(Util.s);
}
					case -47:
						break;
					case 47:
						{
	yybegin (YYINITIAL);
	return new SLToken.Identifier(Util.s);
}
					case -48:
						break;
					case 48:
						{
	yybegin (UNDERSCORE);
	Util.s+=yytext();
}
					case -49:
						break;
					case 49:
						{
	yybegin (ERROR);
	Util.err(yyline);
}
					case -50:
						break;
					case 50:
						{
	yybegin (R);
	Util.s+=yytext();
}
					case -51:
						break;
					case 51:
						{
	yybegin (IDENT);
	Util.s+=yytext();
}
					case -52:
						break;
					case 52:
						{
	yybegin (SLASH);
	return new SLToken.Type("char");
}
					case -53:
						break;
					case 53:
						{
	yybegin (EQUAL1);
	return new SLToken.Type("char");
}
					case -54:
						break;
					case 54:
						{
	yybegin (PIPE);
	return new SLToken.Type("char");
}
					case -55:
						break;
					case 55:
						{
	yybegin (YYINITIAL);
	return new SLToken.Type("char");
}
					case -56:
						break;
					case 56:
						{
	yybegin (YYINITIAL);
	return new SLToken.Type("char");
}
					case -57:
						break;
					case 57:
						{
	yybegin (UNDERSCORE);
	Util.s+=yytext();
}
					case -58:
						break;
					case 58:
						{
	yybegin (ERROR);
	Util.err(yyline);
}
					case -59:
						break;
					case 59:
						{
	yybegin (ERROR);
	Util.err(yyline);
}
					case -60:
						break;
					case 60:
						{
	yybegin (COMMENT);
}
					case -61:
						break;
					case 61:
						{
	yybegin (ERROR);
	Util.err(yyline);
}
					case -62:
						break;
					case 62:
						{
	yybegin (ERROR);
	Util.err(yyline);
}
					case -63:
						break;
					case 63:
						{
	yybegin (EQUAL2);
}
					case -64:
						break;
					case 64:
						{
	yybegin (ERROR);
	Util.err(yyline);
}
					case -65:
						break;
					case 65:
						{
	yybegin (I);
	Util.s=yytext();
	return new SLToken.EqOp("==");
}
					case -66:
						break;
					case 66:
						{
	yybegin (SLASH);
	return new SLToken.EqOp("==");
}
					case -67:
						break;
					case 67:
						{
	yybegin (C);
	Util.s=yytext();
	return new SLToken.EqOp("==");
}
					case -68:
						break;
					case 68:
						{
	yybegin (EQUAL1);
	return new SLToken.EqOp("==");
}
					case -69:
						break;
					case 69:
						{
	yybegin (PIPE);
	return new SLToken.EqOp("==");
}
					case -70:
						break;
					case 70:
						{
	yybegin (YYINITIAL);
	return new SLToken.EqOp("==");
}
					case -71:
						break;
					case 71:
						{
	yybegin (YYINITIAL);
	return new SLToken.EqOp("==");
}
					case -72:
						break;
					case 72:
						{
	yybegin (ERROR);
	Util.err(yyline);
}
					case -73:
						break;
					case 73:
						{
	yybegin (IDENT);
	Util.s=yytext();
	return new SLToken.EqOp("==");
}
					case -74:
						break;
					case 74:
						{
	yybegin (I);
	Util.s=yytext();
	return new SLToken.OR();
}
					case -75:
						break;
					case 75:
						{
	yybegin (SLASH);
	return new SLToken.OR();
}
					case -76:
						break;
					case 76:
						{
	yybegin (C);
	Util.s=yytext();
	return new SLToken.OR();
}
					case -77:
						break;
					case 77:
						{
	yybegin (EQUAL1);
	return new SLToken.OR();
}
					case -78:
						break;
					case 78:
						{
	yybegin (PIPE);
	return new SLToken.OR();
}
					case -79:
						break;
					case 79:
						{
	yybegin (YYINITIAL);
	return new SLToken.OR();
}
					case -80:
						break;
					case 80:
						{
	yybegin (ERROR);
	Util.err(yyline);
}
					case -81:
						break;
					case 81:
						{
	yybegin (IDENT);
	Util.s=yytext();
	return new SLToken.OR();
}
					case -82:
						break;
					case 82:
						{
	yybegin (IDENT);
	Util.s+=yytext();
}
					case -83:
						break;
					case 83:
						{
	yybegin (ERROR);
	Util.err(yyline);
}
					case -84:
						break;
					case 84:
						{
	yybegin (EQUAL1);
	return new SLToken.Identifier(Util.s);
}
					case -85:
						break;
					case 85:
						{
	yybegin (PIPE);
	return new SLToken.Identifier(Util.s);
}
					case -86:
						break;
					case 86:
						{
	yybegin (YYINITIAL);
	return new SLToken.Identifier(Util.s);
}
					case -87:
						break;
					case 87:
						{
	yybegin (UNDERSCORE);
	Util.s+=yytext();
}
					case -88:
						break;
					case 88:
						{
	yybegin (COMMENT);
}
					case -89:
						break;
					case 89:
						{
	yybegin (YYINITIAL);
}
					case -90:
						break;
					case 90:
						{
	yybegin (COMMENT);
}
					case -91:
						break;
					case 91:
						{
	yybegin (IDENT);
	Util.s+=yytext();
}
					case -92:
						break;
					case 92:
						{
	yybegin (ERROR);
	Util.err(yyline);
}
					case -93:
						break;
					case 93:
						{
	yybegin (ERROR);
	Util.err(yyline);
}
					case -94:
						break;
					case 94:
						{
	yybegin (ERROR);
	Util.err(yyline);
}
					case -95:
						break;
					case 95:
						{
	yybegin (UNDERSCORE);
	Util.s+=yytext();
}
					case -96:
						break;
					default:
						yy_error(YY_E_INTERNAL,false);
					case -1:
					}
					yy_initial = true;
					yy_state = yy_state_dtrans[yy_lexical_state];
					yy_next_state = YY_NO_STATE;
					yy_last_accept_state = YY_NO_STATE;
					yy_mark_start();
					yy_this_accept = yy_acpt[yy_state];
					if (YY_NOT_ACCEPT != yy_this_accept) {
						yy_last_accept_state = yy_state;
						yy_mark_end();
					}
				}
			}
		}
	}
}
