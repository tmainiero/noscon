#include <stdio.h>
#include <stdlib.h>
#include <linux/input.h>

/* https://github.com/torvalds/linux/blob/master/include/uapi/linux/input-event-codes.h */
/* Menu key has keycode 127, which is KEY_COMPOSE, not KEY_MENU*/
/* Run e.g. sudo libinput debug-events --show-keycodes */

int main(void) {
    struct input_event event;

    setbuf(stdin, NULL), setbuf(stdout, NULL);

    while (fread(&event, sizeof(event), 1, stdin) == 1) {
        if (event.type == EV_KEY && event.code == KEY_COMPOSE)
            event.code = KEY_RIGHTMETA;

        fwrite(&event, sizeof(event), 1, stdout);
    }
}
