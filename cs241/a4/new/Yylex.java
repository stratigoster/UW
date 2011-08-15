

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

	private void error() {
		System.out.println("\nIllegal character at line " + (yyline+1));
		System.exit(-1);	
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
		/* 29 */ YY_NO_ANCHOR,
		/* 30 */ YY_END,
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
		/* 44 */ YY_NOT_ACCEPT,
		/* 45 */ YY_NO_ANCHOR,
		/* 46 */ YY_NO_ANCHOR,
		/* 47 */ YY_END,
		/* 48 */ YY_NOT_ACCEPT,
		/* 49 */ YY_NO_ANCHOR,
		/* 50 */ YY_NOT_ACCEPT,
		/* 51 */ YY_NO_ANCHOR,
		/* 52 */ YY_NOT_ACCEPT,
		/* 53 */ YY_NO_ANCHOR,
		/* 54 */ YY_NOT_ACCEPT,
		/* 55 */ YY_NO_ANCHOR,
		/* 56 */ YY_NOT_ACCEPT,
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
		/* 85 */ YY_NO_ANCHOR
	};
	private int yy_cmap[] = unpackFromString(1,130,
"2:9,44,3,2:2,4,2:18,43,40,2:3,32,28,7,36,37,31,33,26,34,25,1,8:8,6:2,2,35,2" +
"2,30,23,2:2,41:26,2:4,42,2,14,27,24,41,12,13,41,19,20,41:2,15,41,17,21,41:2" +
",10,16,9,11,41,18,41:3,38,29,39,2:2,0,5")[0];

	private int yy_rmap[] = unpackFromString(1,86,
"0,1,2,1:2,3,4,5,6,1:4,7,1:11,8,9,1:5,8:3,10,8:2,1,8:5,11,12,13,14,15,16,17," +
"18,8,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,4" +
"2,43,44,8,45,46,47,48,49,50")[0];

	private int yy_nxt[][] = unpackFromString(51,45,
"1,2,3,4:2,1,5,45,5,6,77,79,80,81,79:2,82,79,83,79,46,63,7,8,84,9,10,85,11,1" +
"2,13,14,15,16,17,18,19,20,21,22,23,79,3,24,4,-1:46,44,-1:49,5,-1,5,-1:42,79" +
",-1,79:2,64,79:11,-1:2,79,-1:2,79,-1:13,79,52,-1:24,27,-1:45,28,-1:51,29,-1" +
":20,79,-1,79:14,-1:2,79,-1:2,79,-1:13,79,52,-1:8,79,-1,79,32,79:12,-1:2,79," +
"-1:2,79,-1:13,79,52,-1:8,79,-1,79:12,61,79,-1:2,79,-1:2,79,-1:13,79,52,-1:3" +
",44:2,30,47,30,44:39,-1,48:2,-1:3,48:2,50,48:36,-1:6,79,-1,79:5,25,79:3,26," +
"79:4,-1:2,79,-1:2,79,-1:13,79,52,-1:5,30,-1:48,31,-1:43,79,-1,79,33,79:12,-" +
"1:2,79,-1:2,79,-1:13,79,52,-1:9,31,54,-1:42,79,-1,79:4,34,79:9,-1:2,79,-1:2" +
",79,-1:13,79,52,-1:8,79,-1,79:4,35,79:9,-1:2,79,-1:2,79,-1:13,79,52,-1:10,5" +
"6,-1:42,79,-1,79:2,36,79:11,-1:2,79,-1:2,79,-1:13,79,52,-1:9,38,-1:43,79,-1" +
",79:7,37,79:6,-1:2,79,-1:2,79,-1:13,79,52,-1:8,79,-1,79:4,39,79:9,-1:2,79,-" +
"1:2,79,-1:13,79,52,-1:8,79,-1,79:4,40,79:9,-1:2,79,-1:2,79,-1:13,79,52,-1:8" +
",79,-1,79:9,41,79:4,-1:2,79,-1:2,79,-1:13,79,52,-1:8,79,-1,79:5,42,79:8,-1:" +
"2,79,-1:2,79,-1:13,79,52,-1:8,79,-1,79,43,79:12,-1:2,79,-1:2,79,-1:13,79,52" +
",-1:8,79,-1,79:3,49,79:10,-1:2,79,-1:2,79,-1:13,79,52,-1:8,79,-1,79:3,51,79" +
":10,-1:2,79,-1:2,79,-1:13,79,52,-1:8,79,-1,79,72,79:12,-1:2,79,-1:2,79,-1:1" +
"3,79,52,-1:8,79,-1,79:8,53,79:5,-1:2,79,-1:2,79,-1:13,79,52,-1:8,79,-1,79:7" +
",73,79:6,-1:2,79,-1:2,79,-1:13,79,52,-1:8,79,-1,79:2,78,79:11,-1:2,79,-1:2," +
"79,-1:13,79,52,-1:8,79,-1,79:12,74,79,-1:2,79,-1:2,79,-1:13,79,52,-1:8,79,-" +
"1,79:6,55,79:7,-1:2,79,-1:2,79,-1:13,79,52,-1:8,79,-1,79:13,57,-1:2,79,-1:2" +
",79,-1:13,79,52,-1:8,79,-1,79:3,75,79:10,-1:2,79,-1:2,79,-1:13,79,52,-1:8,7" +
"9,-1,79:8,58,79:5,-1:2,79,-1:2,79,-1:13,79,52,-1:8,79,-1,79:7,59,79:6,-1:2," +
"79,-1:2,79,-1:13,79,52,-1:8,79,-1,79:2,60,79:11,-1:2,79,-1:2,79,-1:13,79,52" +
",-1:8,79,-1,79:14,-1:2,62,-1:2,79,-1:13,79,52,-1:8,79,-1,79:4,65,79:9,-1:2," +
"79,-1:2,79,-1:13,79,52,-1:8,79,-1,79:3,76,79:10,-1:2,79,-1:2,79,-1:13,79,52" +
",-1:8,79,-1,79:7,66,79:6,-1:2,79,-1:2,79,-1:13,79,52,-1:8,79,-1,79:6,67,79:" +
"7,-1:2,79,-1:2,79,-1:13,79,52,-1:8,79,-1,79,68,79:12,-1:2,79,-1:2,79,-1:13," +
"79,52,-1:8,79,-1,79:11,69,79:2,-1:2,79,-1:2,79,-1:13,79,52,-1:8,79,-1,79:11" +
",70,79:2,-1:2,79,-1:2,79,-1:13,79,52,-1:8,79,-1,79:13,71,-1:2,79,-1:2,79,-1" +
":13,79,52,-1:2");

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

		return new SLToken.EOF();  	      
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
						{ 	return new SLToken.MulOp("/");}
					case -3:
						break;
					case 3:
						{	error();}
					case -4:
						break;
					case 4:
						{	}
					case -5:
						break;
					case 5:
						{ 	return new SLToken.IntLiteral(yytext());}
					case -6:
						break;
					case 6:
						{ 	return new SLToken.Identifier(yytext());}
					case -7:
						break;
					case 7:
						{ 	return new SLToken.RelOp("<");}
					case -8:
						break;
					case 8:
						{ 	return new SLToken.RelOp(">");}
					case -9:
						break;
					case 9:
						{	return new SLToken.PERIOD();}
					case -10:
						break;
					case 10:
						{	return new SLToken.COMMA();}
					case -11:
						break;
					case 11:
						{ 	return new SLToken.AMPERSAND();}
					case -12:
						break;
					case 12:
						{ 	return new SLToken.OR();}
					case -13:
						break;
					case 13:
						{ 	return new SLToken.ASSIGN();}
					case -14:
						break;
					case 14:
						{ 	return new SLToken.MulOp("*");}
					case -15:
						break;
					case 15:
						{ 	return new SLToken.MulOp("%");}
					case -16:
						break;
					case 16:
						{ 	return new SLToken.AddOp("+");}
					case -17:
						break;
					case 17:
						{ 	return new SLToken.AddOp("-");}
					case -18:
						break;
					case 18:
						{ 	return new SLToken.SEMI();}
					case -19:
						break;
					case 19:
						{ 	return new SLToken.OPENP();}
					case -20:
						break;
					case 20:
						{ 	return new SLToken.CLOSEP();}
					case -21:
						break;
					case 21:
						{	return new SLToken.OPENB();}
					case -22:
						break;
					case 22:
						{	return new SLToken.CLOSEB();}
					case -23:
						break;
					case 23:
						{ 	return new SLToken.NOT();}
					case -24:
						break;
					case 24:
						{	}
					case -25:
						break;
					case 25:
						{ 	return new SLToken.IF();}
					case -26:
						break;
					case 26:
						{ 	return new SLToken.IN();}
					case -27:
						break;
					case 27:
						{	return new SLToken.OUTSIGN();}
					case -28:
						break;
					case 28:
						{	return new SLToken.INSIGN();}
					case -29:
						break;
					case 29:
						{ 	return new SLToken.EqOp("==");}
					case -30:
						break;
					case 30:
						{	}
					case -31:
						break;
					case 31:
						{	return new SLToken.CharLiteral(yytext().substring(1, 2));}
					case -32:
						break;
					case 32:
						{ 	return new SLToken.Type("int");}
					case -33:
						break;
					case 33:
						{ 	return new SLToken.OUT();}
					case -34:
						break;
					case 34:
						{ 	return new SLToken.BoolLiteral(true);}
					case -35:
						break;
					case 35:
						{ 	return new SLToken.ELSE();}
					case -36:
						break;
					case 36:
						{ 	return new SLToken.Type("char");}
					case -37:
						break;
					case 37:
						{ 	return new SLToken.Type("bool");}
					case -38:
						break;
					case 38:
						{	Integer val = Integer.valueOf(yytext().substring(1,4), 8);
		return new SLToken.CharLiteral("" + ((char) val.intValue()));}
					case -39:
						break;
					case 39:
						{ 	return new SLToken.BoolLiteral(false);}
					case -40:
						break;
					case 40:
						{ 	return new SLToken.WHILE();}
					case -41:
						break;
					case 41:
						{ 	return new SLToken.RETURN();}
					case -42:
						break;
					case 42:
						{ 	return new SLToken.ELSEIF();}
					case -43:
						break;
					case 43:
						{ 	return new SLToken.STRUCT();}
					case -44:
						break;
					case 45:
						{	error();}
					case -45:
						break;
					case 46:
						{ 	return new SLToken.Identifier(yytext());}
					case -46:
						break;
					case 47:
						{	}
					case -47:
						break;
					case 49:
						{ 	return new SLToken.Identifier(yytext());}
					case -48:
						break;
					case 51:
						{ 	return new SLToken.Identifier(yytext());}
					case -49:
						break;
					case 53:
						{ 	return new SLToken.Identifier(yytext());}
					case -50:
						break;
					case 55:
						{ 	return new SLToken.Identifier(yytext());}
					case -51:
						break;
					case 57:
						{ 	return new SLToken.Identifier(yytext());}
					case -52:
						break;
					case 58:
						{ 	return new SLToken.Identifier(yytext());}
					case -53:
						break;
					case 59:
						{ 	return new SLToken.Identifier(yytext());}
					case -54:
						break;
					case 60:
						{ 	return new SLToken.Identifier(yytext());}
					case -55:
						break;
					case 61:
						{ 	return new SLToken.Identifier(yytext());}
					case -56:
						break;
					case 62:
						{ 	return new SLToken.Identifier(yytext());}
					case -57:
						break;
					case 63:
						{ 	return new SLToken.Identifier(yytext());}
					case -58:
						break;
					case 64:
						{ 	return new SLToken.Identifier(yytext());}
					case -59:
						break;
					case 65:
						{ 	return new SLToken.Identifier(yytext());}
					case -60:
						break;
					case 66:
						{ 	return new SLToken.Identifier(yytext());}
					case -61:
						break;
					case 67:
						{ 	return new SLToken.Identifier(yytext());}
					case -62:
						break;
					case 68:
						{ 	return new SLToken.Identifier(yytext());}
					case -63:
						break;
					case 69:
						{ 	return new SLToken.Identifier(yytext());}
					case -64:
						break;
					case 70:
						{ 	return new SLToken.Identifier(yytext());}
					case -65:
						break;
					case 71:
						{ 	return new SLToken.Identifier(yytext());}
					case -66:
						break;
					case 72:
						{ 	return new SLToken.Identifier(yytext());}
					case -67:
						break;
					case 73:
						{ 	return new SLToken.Identifier(yytext());}
					case -68:
						break;
					case 74:
						{ 	return new SLToken.Identifier(yytext());}
					case -69:
						break;
					case 75:
						{ 	return new SLToken.Identifier(yytext());}
					case -70:
						break;
					case 76:
						{ 	return new SLToken.Identifier(yytext());}
					case -71:
						break;
					case 77:
						{ 	return new SLToken.Identifier(yytext());}
					case -72:
						break;
					case 78:
						{ 	return new SLToken.Identifier(yytext());}
					case -73:
						break;
					case 79:
						{ 	return new SLToken.Identifier(yytext());}
					case -74:
						break;
					case 80:
						{ 	return new SLToken.Identifier(yytext());}
					case -75:
						break;
					case 81:
						{ 	return new SLToken.Identifier(yytext());}
					case -76:
						break;
					case 82:
						{ 	return new SLToken.Identifier(yytext());}
					case -77:
						break;
					case 83:
						{ 	return new SLToken.Identifier(yytext());}
					case -78:
						break;
					case 84:
						{ 	return new SLToken.Identifier(yytext());}
					case -79:
						break;
					case 85:
						{ 	return new SLToken.Identifier(yytext());}
					case -80:
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
