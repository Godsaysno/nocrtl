set mylist [list]
lappend mylist "testbench.clk"
lappend mylist "testbench.reset"
lappend mylist "testbench.router0.flit_counter"
lappend mylist "testbench.router1.flit_counter"
lappend mylist "testbench.router2.flit_counter"
lappend mylist "testbench.router3.flit_counter"
lappend mylist "testbench.router4.flit_counter"
lappend mylist "testbench.router5.flit_counter"
lappend mylist "testbench.router6.flit_counter"
lappend mylist "testbench.router7.flit_counter"
lappend mylist "testbench.router8.flit_counter"
lappend mylist "testbench.router9.flit_counter"
lappend mylist "testbench.router10.flit_counter"
lappend mylist "testbench.router11.flit_counter"
lappend mylist "testbench.router12.flit_counter"
lappend mylist "testbench.router13.flit_counter"
lappend mylist "testbench.router14.flit_counter"
lappend mylist "testbench.router15.flit_counter"

# set num_added [ gtkwave::addSignalsFromList $mylist ]

# set mylist2 [list]
lappend mylist "testbench.sink0.s1.register"
lappend mylist "testbench.sink1.s1.register"
lappend mylist "testbench.sink2.s1.register"
lappend mylist "testbench.sink3.s1.register"
lappend mylist "testbench.sink4.s1.register"
lappend mylist "testbench.sink5.s1.register"
lappend mylist "testbench.sink6.s1.register"
lappend mylist "testbench.sink7.s1.register"
lappend mylist "testbench.sink8.s1.register"
lappend mylist "testbench.sink9.s1.register"
lappend mylist "testbench.sink10.s1.register"
lappend mylist "testbench.sink11.s1.register"
lappend mylist "testbench.sink12.s1.register"
lappend mylist "testbench.sink13.s1.register"
lappend mylist "testbench.sink14.s1.register"
lappend mylist "testbench.sink15.s1.register"

set num_added [ gtkwave::addSignalsFromList $mylist ]
