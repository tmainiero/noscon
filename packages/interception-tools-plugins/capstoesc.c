#include <stdio.h>
#include <stdlib.h>
#include <linux/input.h>

int main(void) {
    struct input_event event;

    setbuf(stdin, NULL), setbuf(stdout, NULL);

    while (fread(&event, sizeof(event), 1, stdin) == 1) {
        if (event.type == EV_KEY && event.code == KEY_CAPSLOCK)
            event.code = KEY_ESC;

        fwrite(&event, sizeof(event), 1, stdout);
    }
}
