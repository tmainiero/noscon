#include <stdio.h>
#include <stdlib.h>

#include <linux/input.h>

/* #include "event.h" */

// clang-format off
const struct input_event
enter_up         = {.type = EV_KEY, .code = KEY_ENTER,     .value = 0},
rightctrl_up     = {.type = EV_KEY, .code = KEY_RIGHTCTRL, .value = 0},
enter_down       = {.type = EV_KEY, .code = KEY_ENTER,     .value = 1},
rightctrl_down   = {.type = EV_KEY, .code = KEY_RIGHTCTRL, .value = 1},
enter_repeat     = {.type = EV_KEY, .code = KEY_ENTER,     .value = 2},
rightctrl_repeat = {.type = EV_KEY, .code = KEY_RIGHTCTRL, .value = 2};
// clang-format on

// Event related functions begin
int equal(const struct input_event *first, const struct input_event *second) {
    return first->type == second->type && first->code == second->code &&
           first->value == second->value;
}

int read_event(struct input_event *event) {
    return fread(event, sizeof(struct input_event), 1, stdin) == 1;
}

void write_event(const struct input_event *event) {
    if (fwrite(event, sizeof(struct input_event), 1, stdout) != 1)
        exit(EXIT_FAILURE);
}
// Event related functions end

int main(void) {
    int enter_is_down = 0, rightctrl_give_up = 0;
    struct input_event input;

    setbuf(stdin, NULL), setbuf(stdout, NULL);

    while (read_event(&input)) {
        if (input.type != EV_KEY) {
            write_event(&input);
            continue;
        }

        if (enter_is_down) {
            if (equal(&input, &enter_down) ||
                equal(&input, &enter_repeat)) {
                continue;
            }

            if (equal(&input, &enter_up)) {
                enter_is_down = 0;

                if (rightctrl_give_up) {
                    rightctrl_give_up = 0;
                    write_event(&rightctrl_up);
                    continue;
                }

                write_event(&enter_down);
                write_event(&enter_up);
                continue;
            }

            if (!rightctrl_give_up && input.value) {
                rightctrl_give_up = 1;
                write_event(&rightctrl_down);
            }
        } else {
            if (equal(&input, &enter_down)) {
                enter_is_down = 1;
                continue;
            }
        }

        write_event(&input);
    }
}
