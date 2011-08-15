#include "Screen.h"

Screen::Screen( Room & room ) : Equipment( room ) {}

std::string Screen::print() {
    return "screen";
} // Screen::print
