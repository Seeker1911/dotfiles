from dataclasses import dataclass
from typing import List

from im import test_import

test_import()
foo


@dataclass
class myClass:
    name: str


id = myClass(name=4)


def hi() -> int:
    print("hello")
    return "x"


def none() -> List[int]:
    """here is a docstring"""
    print(not_a_variable)
    return "x"


hi: str


# TODO: fix line lenght
"aaaaaaqaaaqaaaqaaaqaaaqaaaqaaaqaaaqaaaqaaaqaaaqaaaqaaaqaaaqaaaqaaaqaaaqaaaqaaaqaaaqaaaqaaaqaaaqaaaqaaaqaaaqaaaqaaaqaaaqaaaqaaaqaaaqaaaqaaaqaaaqaaaqaaaqaaaqaaaqaaaqaaaqaaaq"


def myfunc():
    pass


if __name__ == "__main__":
    hi()
