#include "OverheadProjector.h"

OverheadProjector::OverheadProjector( Room & room ) : Equipment( room ) {}

std::string OverheadProjector::print() {
    return "overhead projector";
} // OverheadProjector::print
