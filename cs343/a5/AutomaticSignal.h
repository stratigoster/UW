#ifndef AUTOMATIC_SIGNAL_H
#define AUTOMATIC_SIGNAL_H

#define AUTOMATIC_SIGNAL uCondition IS;

#define WAITUNTIL(pred, before, after) \
    if ( ! (pred) ) {\
        (before);\
        while ( ! IS.empty() ) IS.signal();\
        do {\
            IS.wait();\
        } while ( ! (pred) );\
        (after);\
    }

#define RETURN(expr) \
    while ( ! IS.empty() ) IS.signal();\
    return (expr);

#endif
