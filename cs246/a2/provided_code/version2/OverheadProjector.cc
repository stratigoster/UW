#include "OverheadProjector.h"

OverheadProjector::OverheadProjector( Room & room ) : Equipment( room ) {}

std::ostream & operator<<( std::ostream & output, const OverheadProjector & o ) {
    output << "overhead projector";
    return output;
} // operator<<

std::ostream & operator<<( std::ostream & output, const OverheadProjector * o ) {
    output << "overhead projector";
    return output;
} // operator<<
