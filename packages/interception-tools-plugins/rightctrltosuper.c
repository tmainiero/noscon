#include <stdio.h>
#include <stdlib.h>
#include <linux/input.h>

/* KEY_RIGHTMETA is event code for the right super key*/

int main(void) {
    struct input_event event;

    setbuf(stdin, NULL), setbuf(stdout, NULL);

    while (fread(&event, sizeof(event), 1, stdin) == 1) {
        if (event.type == EV_KEY && event.code == KEY_RIGHTCTRL)
            event.code = KEY_RIGHTMETA;

        fwrite(&event, sizeof(event), 1, stdout);
    }
}
