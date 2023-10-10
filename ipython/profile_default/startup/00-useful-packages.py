from importlib import import_module

packages: dict[str, str | None] = {
    "matplotlib": None,
    "matplotlib.pyplot": "plt",
    "numpy": "np",
    "pandas": "pd",
    "scipy": "sp",
    "sympy": "sym",
}

for name, rename in packages.items():
    mod = import_module(name)
    globals()[rename or name] = mod
    if rename:
        print(f"{name} -> {rename}")
    else:
        print(f"{name}")
