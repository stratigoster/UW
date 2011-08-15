#ifndef COURIER_H
#define COURIER_H

#include <uC++.h>
#include <string>
#include "browser.h"

_Task TopicNameServer;
class Cache;
_Task Worker;

_Task Courier {
    friend _Task Worker;

    public:
        Courier( TopicNameServer &tns, Cache &cache, Browser &browser, const unsigned int id );
        void urlExists( bool exists );
        void putText( bool eof, const std::string &text );

    private:
        TopicNameServer &tns;
        Cache &cache;
        Browser &browser;
        const unsigned int id;
        bool eof;
        Browser::Job *job;
        bool fileExists;
        void main();
};

#endif
