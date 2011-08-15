#include <iostream>
using namespace std;

int main() {
  char bytes[] = {
    '\n',                                 // empty line
    0x0b, '\n',                           // valid
    0x23, '\n',                           // valid
    0x7f, '\n',                           // valid
    0xff, '\n',                           // invalid
    0x23, 0x23, '\n',                     // valid but extra byte

    0xd7, 0x90, '\n',                     // valid
    0xd7, 0x90, 0x90, '\n',               // valid but extra byte
    0xd7, '\n',                           // invalid (missing a byte)
    0xd7, 0xe3, '\n',                     // invalid (second byte wrong)
    0xc2, 0xA3, '\n',                     // valid
    0xc0, 0x3f, '\n',                     // invalid (value encoded in wrong range)
    0xb0, '\n',                           // invalid first byte
    0xe0, 0xe3, '\n',                     // invalid (second byte wrong, + missing a byte)

    0xe9, 0x80, 0x80, '\n',               // valid
    0xe9, 0x80, 0x80, 0xff, 0xf8, '\n',   // valid, extra 2 bytes
    0xe0, 0x93, 0x90, '\n',               // invalid (value encoded in wrong range)
    0xff, 0x9A, 0x84, '\n',               // invalid first byte, extra 2 bytes 
    0xe9, 0xe3, 0x80, '\n',               // invalid (second byte wrong)

    0xf0, 0x90, 0x89, 0x80, '\n',         // valid
    0xf0, 0x90, 0x89, 0x80, 0x80, '\n',   // valid but extra byte
    0xf0, 0x90, 0x89, '\n',               // invalid (missing a byte)
    0xf0, 0xe3, 0x89, 0x80, '\n',         // invalid (second byte wrong)
    0xf0, 0x90, 0xe3, 0x80, '\n',         // invalid (third byte wrong)
    0xf0, 0x90, 0x89, 0xe3, '\n',         // invalid (fourth byte wrong)
    0xf0, 0x80, 0x80, 0xbf, '\n',         // invalid (value encoded in wrong range)
    0xf0, 0x80, 0xbf, 0xbf, '\n',         // invalid (value encoded in wrong range)
    0xf0, 0x8f, 0xbf, 0xbf, '\n',         // invalid (value encoded in wrong range)
  };
  for ( int i = 0; i < sizeof( bytes ); i += 1 ) {
    cout << bytes[i];
  }
}
