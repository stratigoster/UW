/*********************************************************
CS241 
Assignment #3
Yylex.3
A sample scanner that recognizes all tokens in SL
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

	// Here is where any extra Java methods, etc. would go, if needed.
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
	private final int YYINITIAL = 0;
	private final int yy_state_dtrans[] = {
		0
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
		/* 29 */ YY_END,
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
		/* 42 */ YY_NOT_ACCEPT,
		/* 43 */ YY_NO_ANCHOR,
		/* 44 */ YY_NO_ANCHOR,
		/* 45 */ YY_END,
		/* 46 */ YY_NOT_ACCEPT,
		/* 47 */ YY_NO_ANCHOR,
		/* 48 */ YY_NOT_ACCEPT,
		/* 49 */ YY_NO_ANCHOR,
		/* 50 */ YY_NOT_ACCEPT,
		/* 51 */ YY_NO_ANCHOR,
		/* 52 */ YY_NOT_ACCEPT,
		/* 53 */ YY_NO_ANCHOR,
		/* 54 */ YY_NOT_ACCEPT,
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
		/* 84 */ YY_NO_ANCHOR
	};
	private int yy_cmap[] = unpackFromString(1,130,
"24:8,35:2,25,24:2,26,24:18,35,12,24:3,10,6,38,3,4,9,7,2,8,20,11,39:2,40:6,4" +
"2:2,24,23,19,1,18,24:2,43:26,24:4,44,24,37,36,41,43,31,34,43,29,13,43:2,30," +
"43,14,15,43:2,32,33,17,16,43,28,43:3,21,5,22,24:2,0,27")[0];

	private int yy_rmap[] = unpackFromString(1,85,
"0,1,2,1:9,3,1,4,5,6,1:6,7,1,8,9,1:3,9,1:2,10,1,9,1:2,9:3,1,11,9,12,13,9,14," +
"15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39," +
"40,41,42,43,44,45,46,47,48,49,50,51")[0];

	private int yy_nxt[][] = unpackFromString(52,45,
"1,2,3,4,5,6,7,8,9,10,11,12,13,14,43,61,43,76,15,16,17,18,19,20,21,22,-1,1,7" +
"7,43:2,69,82,83,84,22,78,43,44,23:2,43,23,43,21,-1:46,24,-1:54,42,-1:46,43," +
"25,43:3,-1:10,43:6,26,-1,43:2,-1,43:5,46,-1:18,27,-1:45,28,-1:64,23:2,-1,23" +
",-1:15,43:4,49,-1:10,43:7,-1,43:2,-1,43:5,46,-1:13,43:5,-1:10,43:7,-1,43:2," +
"-1,43:5,46,-1:13,57,43:4,-1:10,43:7,-1,43:2,-1,43:5,46,-1,42:24,29,45,29,42" +
":17,-1,48:24,-1:3,48:11,50,48:5,-1:25,29,-1:32,43:4,30,-1:10,43:7,-1,43:2,-" +
"1,43:5,46,-1:38,31,-1:19,43:5,-1:7,32,-1:2,43:7,32,43:2,-1,43:5,46,-1:38,31" +
",52:2,-1:17,43:5,-1:10,43:3,33,43:3,-1,43:2,-1,43:5,46,-1:39,54:2,-1:17,43:" +
"5,-1:7,34,-1:2,43:7,34,43:2,-1,43:5,46,-1:38,37,-1:19,43:5,-1:10,43:3,35,43" +
":3,-1,43:2,-1,43:5,46,-1:13,43:5,-1:7,36,-1:2,43:7,36,43:2,-1,43:5,46,-1:13" +
",43:5,-1:10,43:6,38,-1,43:2,-1,43:5,46,-1:13,43,39,43:3,-1:10,43:7,-1,43:2," +
"-1,43:5,46,-1:13,43:4,40,-1:10,43:7,-1,43:2,-1,43:5,46,-1:13,43:5,-1:7,41,-" +
"1:2,43:7,41,43:2,-1,43:5,46,-1:13,43:3,47,43,-1:10,43:7,-1,43:2,-1,43:5,46," +
"-1:13,43:5,-1:10,43:5,51,43,-1,43:2,-1,43:5,46,-1:13,43:5,-1:10,43:3,53,43:" +
"3,-1,43:2,-1,43:5,46,-1:13,43:5,-1:10,43:2,55,43:4,-1,43:2,-1,43:5,46,-1:13" +
",43:5,-1:10,43:2,56,43:4,-1,43:2,-1,43:5,46,-1:13,43:5,-1:10,43:4,58,43:2,-" +
"1,43:2,-1,43:5,46,-1:13,43:5,-1:10,43:7,-1,43:2,-1,43:2,59,43:2,46,-1:13,43" +
":5,-1:10,43:3,60,43:3,-1,43:2,-1,43:5,46,-1:13,43:5,-1:10,43:2,62,43:4,-1,4" +
"3:2,-1,43:5,46,-1:13,43:3,63,43,-1:10,43:7,-1,43:2,-1,43:5,46,-1:13,64,43:4" +
",-1:10,43:7,-1,43:2,-1,43:5,46,-1:13,43:2,65,43:2,-1:10,43:7,-1,43:2,-1,43:" +
"5,46,-1:13,43:3,66,43,-1:10,43:7,-1,43:2,-1,43:5,46,-1:13,43:3,67,43,-1:10," +
"43:7,-1,43:2,-1,43:5,46,-1:13,43:5,-1:10,43:5,68,43,-1,43:2,-1,43:5,46,-1:1" +
"3,43:5,-1:10,43:4,70,43:2,-1,43:2,-1,43:5,46,-1:13,43:5,-1:10,43,71,43:5,-1" +
",43:2,-1,43:5,46,-1:13,43:2,72,43:2,-1:10,43:7,-1,43:2,-1,43:5,46,-1:13,43:" +
"4,73,-1:10,43:7,-1,43:2,-1,43:5,46,-1:13,43:5,-1:10,43:4,74,43:2,-1,43:2,-1" +
",43:5,46,-1:13,43:5,-1:10,43:2,75,43:4,-1,43:2,-1,43:5,46,-1:13,43:5,-1:10," +
"43:3,79,43:3,-1,43:2,-1,43:5,46,-1:13,43:4,80,-1:10,43:7,-1,43:2,-1,43:5,46" +
",-1:13,43:5,-1:10,43:7,-1,43,81,-1,43:5,46");

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
						{ return new SLToken.ASSIGN(); }
					case -3:
						break;
					case 3:
						{ return new SLToken.COMMA(); }
					case -4:
						break;
					case 4:
						{ return new SLToken.OPENP(); }
					case -5:
						break;
					case 5:
						{ return new SLToken.CLOSEP(); }
					case -6:
						break;
					case 6:
						{	return new SLToken.OR(); }
					case -7:
						break;
					case 7:
						{ return new SLToken.AMPERSAND(); }
					case -8:
						break;
					case 8:
						{ return new SLToken.AddOp("+"); }
					case -9:
						break;
					case 9:
						{ return new SLToken.AddOp("-"); }
					case -10:
						break;
					case 10:
						{ return new SLToken.MulOp("*"); }
					case -11:
						break;
					case 11:
						{	return new SLToken.MulOp("%"); }
					case -12:
						break;
					case 12:
						{	return new SLToken.MulOp("/"); }
					case -13:
						break;
					case 13:
						{	return new SLToken.NOT(); }
					case -14:
						break;
					case 14:
						{ return new SLToken.Identifier(yytext()); }
					case -15:
						break;
					case 15:
						{ return new SLToken.RelOp(">"); }
					case -16:
						break;
					case 16:
						{	return new SLToken.RelOp("<"); }
					case -17:
						break;
					case 17:
						{	return new SLToken.PERIOD(); }
					case -18:
						break;
					case 18:
						{	return new SLToken.OPENB(); }
					case -19:
						break;
					case 19:
						{	return new SLToken.CLOSEB(); }
					case -20:
						break;
					case 20:
						{	return new SLToken.SEMI(); }
					case -21:
						break;
					case 21:
						{
	System.out.println();
	System.out.println("Illegal character at line " + (yyline + 1));
	System.exit(0);
}
					case -22:
						break;
					case 22:
						{ }
					case -23:
						break;
					case 23:
						{ return new SLToken.IntLiteral(yytext()); }
					case -24:
						break;
					case 24:
						{ return new SLToken.EqOp("=="); }
					case -25:
						break;
					case 25:
						{ return new SLToken.IN(); }
					case -26:
						break;
					case 26:
						{ return new SLToken.IF(); }
					case -27:
						break;
					case 27:
						{ return new SLToken.INSIGN(); }
					case -28:
						break;
					case 28:
						{ return new SLToken.OUTSIGN(); }
					case -29:
						break;
					case 29:
						{ }
					case -30:
						break;
					case 30:
						{ return new SLToken.OUT(); }
					case -31:
						break;
					case 31:
						{ return new SLToken.CharLiteral(yytext().substring(1,yytext().length()-1)); }
					case -32:
						break;
					case 32:
						{ return new SLToken.Type("int"); }
					case -33:
						break;
					case 33:
						{ return new SLToken.ELSE(); }
					case -34:
						break;
					case 34:
						{ return new SLToken.BoolLiteral(true); }
					case -35:
						break;
					case 35:
						{ return new SLToken.WHILE(); }
					case -36:
						break;
					case 36:
						{ return new SLToken.Type("bool"); }
					case -37:
						break;
					case 37:
						{
	int x = Integer.parseInt(yytext().substring(1,yytext().length()-1), 8);
	char c = (char)x;
	return new SLToken.CharLiteral(c+"");
}
					case -38:
						break;
					case 38:
						{ return new SLToken.ELSEIF(); }
					case -39:
						break;
					case 39:
						{ return new SLToken.RETURN(); }
					case -40:
						break;
					case 40:
						{ return new SLToken.STRUCT(); }
					case -41:
						break;
					case 41:
						{ return new SLToken.BoolLiteral(false); }
					case -42:
						break;
					case 43:
						{ return new SLToken.Identifier(yytext()); }
					case -43:
						break;
					case 44:
						{
	System.out.println();
	System.out.println("Illegal character at line " + (yyline + 1));
	System.exit(0);
}
					case -44:
						break;
					case 45:
						{ }
					case -45:
						break;
					case 47:
						{ return new SLToken.Identifier(yytext()); }
					case -46:
						break;
					case 49:
						{ return new SLToken.Identifier(yytext()); }
					case -47:
						break;
					case 51:
						{ return new SLToken.Identifier(yytext()); }
					case -48:
						break;
					case 53:
						{ return new SLToken.Identifier(yytext()); }
					case -49:
						break;
					case 55:
						{ return new SLToken.Identifier(yytext()); }
					case -50:
						break;
					case 56:
						{ return new SLToken.Identifier(yytext()); }
					case -51:
						break;
					case 57:
						{ return new SLToken.Identifier(yytext()); }
					case -52:
						break;
					case 58:
						{ return new SLToken.Identifier(yytext()); }
					case -53:
						break;
					case 59:
						{ return new SLToken.Identifier(yytext()); }
					case -54:
						break;
					case 60:
						{ return new SLToken.Identifier(yytext()); }
					case -55:
						break;
					case 61:
						{ return new SLToken.Identifier(yytext()); }
					case -56:
						break;
					case 62:
						{ return new SLToken.Identifier(yytext()); }
					case -57:
						break;
					case 63:
						{ return new SLToken.Identifier(yytext()); }
					case -58:
						break;
					case 64:
						{ return new SLToken.Identifier(yytext()); }
					case -59:
						break;
					case 65:
						{ return new SLToken.Identifier(yytext()); }
					case -60:
						break;
					case 66:
						{ return new SLToken.Identifier(yytext()); }
					case -61:
						break;
					case 67:
						{ return new SLToken.Identifier(yytext()); }
					case -62:
						break;
					case 68:
						{ return new SLToken.Identifier(yytext()); }
					case -63:
						break;
					case 69:
						{ return new SLToken.Identifier(yytext()); }
					case -64:
						break;
					case 70:
						{ return new SLToken.Identifier(yytext()); }
					case -65:
						break;
					case 71:
						{ return new SLToken.Identifier(yytext()); }
					case -66:
						break;
					case 72:
						{ return new SLToken.Identifier(yytext()); }
					case -67:
						break;
					case 73:
						{ return new SLToken.Identifier(yytext()); }
					case -68:
						break;
					case 74:
						{ return new SLToken.Identifier(yytext()); }
					case -69:
						break;
					case 75:
						{ return new SLToken.Identifier(yytext()); }
					case -70:
						break;
					case 76:
						{ return new SLToken.Identifier(yytext()); }
					case -71:
						break;
					case 77:
						{ return new SLToken.Identifier(yytext()); }
					case -72:
						break;
					case 78:
						{ return new SLToken.Identifier(yytext()); }
					case -73:
						break;
					case 79:
						{ return new SLToken.Identifier(yytext()); }
					case -74:
						break;
					case 80:
						{ return new SLToken.Identifier(yytext()); }
					case -75:
						break;
					case 81:
						{ return new SLToken.Identifier(yytext()); }
					case -76:
						break;
					case 82:
						{ return new SLToken.Identifier(yytext()); }
					case -77:
						break;
					case 83:
						{ return new SLToken.Identifier(yytext()); }
					case -78:
						break;
					case 84:
						{ return new SLToken.Identifier(yytext()); }
					case -79:
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
