#ifndef SMOKERS_H
#define SMOKERS_H

#define NoOfKinds 3
template<unsigned int> class Table;
_Cormonitor Printer;

_Task Smoker {
    public:
        enum states { needs, blocking, smoking };
        Smoker( Table<NoOfKinds> &table,
                const unsigned int id,
                Printer &printer
              ) : table(table), id(id), printer(printer) {}

    private:
        unsigned int kind;
        unsigned int ncigs;
        Table<NoOfKinds> &table;
        const unsigned int id;
        Printer &printer;
        void main();
};

#endif
