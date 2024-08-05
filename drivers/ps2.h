#pragma once
#include "../libs/common.h"

void ps2_init(void);
void ps2_handler(struct InterruptRegisters* regs);
