#ifndef KEYBOARD_H
#define KEYBOARD_H

#include <uC++.h>

_Task Browser;

_Task Keyboard {
    public:
        enum Commands { FindTopic, DisplayFile, PrintCache, ClearCache, KillServer, Quit };
        Keyboard( Browser &browser );

    private:
        Browser &browser;
        void main();
};

#endif
