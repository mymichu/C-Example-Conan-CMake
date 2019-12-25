#ifndef __main_sm_adapter
#define __main_sm_adapter

#ifdef __cplusplus
#define EXTERNC extern "C"
#else
#define EXTERNC
#endif

EXTERNC void buttonOn();
EXTERNC void buttonOff();
EXTERNC void run();
EXTERNC void update();

#endif
