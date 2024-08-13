import site

list_pkg = site.getsitepackages()
str_pkg = ""
for entry in list_pkg:
    str_pkg = str_pkg + str(entry) + ":"

print(str_pkg)
