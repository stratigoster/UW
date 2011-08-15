#include "DataProjector.h"

DataProjector::DataProjector( Room & room ) : Equipment( room ) {}

std::string DataProjector::print() {
    return "data projector";
} // DataProjector::print
