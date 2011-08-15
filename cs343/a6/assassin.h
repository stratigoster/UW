#ifndef ASSASSIN_H
#define ASSASSIN_H

#include <uC++.h>
_Task TopicNameServer;

_Task Assassin {
    public:
        Assassin( TopicNameServer &tns );

    private:
        TopicNameServer &tns;
        void main();
};

#endif
