var text: string = ""

if file_exists("/home/robert/.seve.d/seve.cos"):
  let f: File = open("/home/robert/.seve.d/seve.cos")
  text = read_all(f)
  close(f)

var opts: seq[(string, string)] = @[]

proc is_num(str: string): bool =
  for ch in str:
    if not contains("1234567890", ch):
      return false
  return true

var stack: seq[(string, string)] = @[]

var args: seq[string] = split(multi_replace(text, ("\n", " ")), ' ')

proc error(msg: string): void =
  echo "Error: " & msg
  quit(1)

proc plus(a1: (string, string), a2: (string, string)): (string, string) =
  if a1[0] != "int" or a2[0] != "int":
    error("value in addition not of type int")
  return ("int", $(parse_int(a1[1]) + parse_int(a2[1])))
proc minus(a1: (string, string), a2: (string, string)): (string, string) =
  if a1[0] != "int" or a2[0] != "int":
    error("value in addition not of type int")
  return ("int", $(parse_int(a2[1]) - parse_int(a1[1])))
proc mult(a1: (string, string), a2: (string, string)): (string, string) =
  if a1[0] != "int" or a2[0] != "int":
    error("value in addition not of type int")
  return ("int", $(parse_int(a1[1]) * parse_int(a2[1])))
 
proc seve_export(val: string, opt: string): void =
  opts &= (opt, val)

for arg in args:
  if is_num(arg):
    stack &= ("int", arg)
  elif arg[0] == ':':
    stack &= ("str", arg[1..^1])
  elif arg == "+":
    stack &= plus(stack.pop(), stack.pop())
  elif arg == "-":
    stack &= minus(stack.pop(), stack.pop())
  elif arg == "*":
    stack &= mult(stack.pop(), stack.pop())
  elif arg == "print":
    echo stack.pop()[1]
  elif arg == "show_stack":
    echo stack
  elif arg == "export":
    seve_export(stack.pop()[1], stack.pop()[1])
  else:
    error("Unrecognized option `" & arg & "` ")
