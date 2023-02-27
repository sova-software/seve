proc exec_args(args: seq[string]): void

proc error(msg: string): void =
  echo "Error: " & msg
  quit(1)

proc is_num(str: string): bool =
  for ch in str:
    if not contains("1234567890", ch):
      return false
  return true

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
 
var opts: seq[(string, string)] = @[]
proc seve_export(opt: string, val: string): void =
  opts &= (opt, val)

proc loop_args(args: seq[string], i: int): void =
  var j: int = 0
  while j < i:
    exec_args(args)
    j += 1

var stack:  seq[(string, string)] = @[]
proc exec_args(args: seq[string]): void =
  var b_args: seq[string] = @[]

  var in_block: int = 0 
  for arg in args:
    if in_block > 0:
      if arg == ")":
        in_block -= 1 
      else:
        b_args &= arg
    elif is_num(arg):
      stack &= ("int", arg)
    elif arg[0] == ':':
      stack &= ("str", arg[1..^1])
    elif arg == "+":
      stack &= plus(stack.pop(), stack.pop())
    elif arg == "-":
      stack &= minus(stack.pop(), stack.pop())
    elif arg == "*":
      stack &= mult(stack.pop(), stack.pop())
    elif arg == "dup":
      stack &= repeat(stack.pop(), 2)
    elif arg == "print":
      echo stack.pop()[1]
    elif arg == "stack":
      echo stack
    elif arg == "export":
      seve_export(stack.pop()[1], stack.pop()[1])
    elif arg == "exec":
      exec_script_command(stack.pop()[1], stack.pop()[1])
    elif arg == "sleep":
      sleep(parse_int(stack.pop()[1]))
    elif arg == "break":
      break
    elif arg == "get_key":
      stack &= ("string", $get_key())
    elif arg == "=":
      if $stack.pop()[1] == $stack.pop()[1]: stack &= ("int", "0")
      else: stack &= ("int", "1")
    elif arg == "loop":
      loop_args(bargs, parse_int(stack.pop()[1]))
      b_args = @[]
    elif arg == "if":
      if stack.pop()[1] == "0":
        exec_args(bargs)
        b_args = @[]
    elif arg == "draw":
      var dy: int = parse_int(stack.pop()[1])
      var dx: int = parse_int(stack.pop()[1])
      var dt: string = stack.pop()[1]
      tb.write(dx, dy, reset_style, bg_black, fg_white, dt)
      tb.display
    elif arg == "(":
      in_block += 1 
    elif arg == ")":
      in_block -= 1 
    elif arg[0] == '#': continue
    else:
      error("Unrecognized option `" & arg & "` ")

proc exec_script(path: string): void =
  var text: string = ""

  if file_exists(path):
    let f: File = open(path)
    text = read_all(f)
    close(f)

  var args:   seq[string] = split(multi_replace(text, ("\n", " ")), ' ')
  exec_args(args)
