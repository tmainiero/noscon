cmake_minimum_required(VERSION 3.0)

project(enter+rightctrl)
project(rightctrltosuper)
project(menutosuper)
project(capstoesc)

add_executable(enter+rightctrl enter+rightctrl.c)
add_executable(rightctrltosuper rightctrltosuper.c)
add_executable(menutosuper menutosuper.c)
add_executable(capstoesc capstoesc.c)

target_compile_options(enter+rightctrl PRIVATE -Wall -Wextra)
target_compile_options(rightctrltosuper PRIVATE -Wall -Wextra)
target_compile_options(menutosuper PRIVATE -Wall -Wextra)
target_compile_options(capstoesc PRIVATE -Wall -Wextra)

install(TARGETS enter+rightctrl RUNTIME DESTINATION bin)
install(TARGETS rightctrltosuper RUNTIME DESTINATION bin)
install(TARGETS menutosuper RUNTIME DESTINATION bin)
install(TARGETS capstoesc RUNTIME DESTINATION bin)


