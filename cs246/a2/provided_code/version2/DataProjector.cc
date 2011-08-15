#include "DataProjector.h"

DataProjector::DataProjector( Room & room ) : Equipment( room ) {}

std::ostream & operator<<( std::ostream & output, const DataProjector & d ) {
    output << "data projector";
    return output;
} // operator<<

std::ostream & operator<<( std::ostream & output, const DataProjector * d ) {
    output << "data projector";
    return output;
} // operator<<
