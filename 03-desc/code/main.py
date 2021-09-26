import rp2
from rp2 import PIO
from machine import Pin
from time import sleep

@rp2.asm_pio(out_init=[PIO.OUT_HIGH]*8)
def hello():
    pull(block)
    mov(pins, invert(osr))

sm = rp2.StateMachine(0, hello, freq=2000, out_base=Pin(0))
sm.active(1)

data = [66,56 ,43,115,142,28,238,188,18,206,123,28,188]

def display():
    while True:
        for x in data:
            sm.put(x)
            sleep(1)

display()
