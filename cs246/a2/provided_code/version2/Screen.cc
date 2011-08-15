#include "Screen.h"

Screen::Screen( Room & room ) : Equipment( room ) {}

std::ostream & operator<<( std::ostream & output, const Screen & s ) {
    output << "screen";
    return output;
} // operator<<

std::ostream & operator<<( std::ostream & output, const Screen * s ) {
    output << "screen";
    return output;
} // operator<<
