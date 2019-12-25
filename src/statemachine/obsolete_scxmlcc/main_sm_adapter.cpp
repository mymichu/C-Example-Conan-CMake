#include "generated/main_sm.h"
#include <iostream>
#include "main_sm_adapter.h"
typedef sc_main_state_machine sc;

template<> void sc::state_actions<sc::state_Off>::enter(sc::data_model &m)
{
        std::cout << "Enter OFF" << std::endl;
}

template<> void sc::state_actions<sc::state_Off>::exit(sc::data_model &m)
{
        std::cout << "EXIT OFF" << std::endl;
}

template<> void sc::state_actions<sc::state_On>::enter(sc::data_model &m)
{
        std::cout << "Enter ON" << std::endl;
}

template<> void sc::state_actions<sc::state_On>::exit(sc::data_model &m)
{
        std::cout << "Exit ON" << std::endl;
}

sc sc0;
sc::event e;

EXTERNC void buttonOn(){
    e = &sc::state::event_trButtonOn;
}

EXTERNC void buttonOff(){
    e = &sc::state::event_trButtonOff;
}

EXTERNC void update(){
   sc0.dispatch(e);
}

EXTERNC void run()
{
   sc0.init();
}
