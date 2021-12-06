#from importlib import import_module
#
## module name: Optional[what to rename it]
#packages = {
#    "matplotlib": None,
#    "matplotlib.pyplot": "plt",
#    "numpy": "np",
#    "pandas": "pd",
#    "scipy": "sp",
#    "sympy": "sym",
#}
#
# print("Loading:", end="")
#for name, rename in packages.items():
#    if not rename:
#        rename = name
#    rename = import_module(package)
#    print(f" {name} -> {rename},", end="")

import matplotlib
import matplotlib.pyplot as plt
import numpy as np

try:
    pass
    import pandas as pd
except NameError:
    pass
try:
    pass
    import scipy as sp
except NameError:
    pass

try:
    import sympy as sym
    sympy.init_printing()
except NameError:
    pass

# Setup
