#include <uC++.h>

template<typename T> _Coroutine Binsertsort {
    public:
        Binsertsort( T EndOfSet ) : EndOfSet(EndOfSet) {}

        void sort( T value ) {
            Binsertsort::value = value;
            resume();
        }

        T retrieve() {
            resume();
            return value;
        }

    private:
        const T EndOfSet;
        T value;
        T pivot;

        void main() {
            Binsertsort<T> left( EndOfSet );
            Binsertsort<T> right( EndOfSet );

            // initialize this node's value
            pivot = value;

            if (pivot == EndOfSet) {
                suspend();
                value = EndOfSet;
                return;
            }

            for (;;) {
                suspend();
                if (value == EndOfSet) {

                    // process left branch
                    left.sort( EndOfSet );
                    for (;;) {
                        suspend();
                        if ( (value = left.retrieve()) == EndOfSet ) break;
                    }

                    // pass up pivot
                    value = pivot;

                    // process right branch
                    right.sort( EndOfSet );
                    for (;;) {
                        suspend();
                        if ( (value = right.retrieve()) == EndOfSet ) break;
                    }
                    break;
                }
                (value <= pivot ? left : right).sort( value );
            }
        }
};
