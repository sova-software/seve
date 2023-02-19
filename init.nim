import illwill
import os, strutils, sequtils

var debug_msg: string = ""

var line_numbers_show: bool = true
var line_num_bg_col: BackgroundColor = bg_black
var line_num_fg_col: ForegroundColor = fg_white
var cursor_bg_col: BackgroundColor = bg_white
var text_fg_col: ForegroundColor = fg_white
var text_bg_col: BackgroundColor = bg_black

proc load_conf_vars(): void
proc exec_script_command(val: string, cmd: string): void

include cose
include seve

exec_script("/home/robert/.seve.d/seve.cos")
get_external_commands()

proc exec_script_command(val: string, cmd: string): void =
  case cmd
  of "goto-line": line_goto(parse_int(val))
  of "set-cursor-pos": posx = parse_int(val)
  of "msg": panel_msg(0, ">> " & val, width, height)
  of "reload-conf": load_conf_vars()
  else:
    discard
  render_text(buffer, posx, posy)
  tb.display()


proc load_conf_vars(): void =
  for opt in opts:
    case opt[0]
    of "line-nums":
      if   opt[1] == "false":
        line_numbers_show = false
      elif opt[1] == "true":
        line_numbers_show = true
    of "line-num-bg":
      case opt[1]
      of "black":   line_num_bg_col = bg_black
      of "red":     line_num_bg_col = bg_red
      of "green":   line_num_bg_col = bg_green
      of "yellow":  line_num_bg_col = bg_yellow
      of "blue":    line_num_bg_col = bg_blue
      of "magenta": line_num_bg_col = bg_magenta
      of "cyan":    line_num_bg_col = bg_cyan
      of "white":   line_num_bg_col = bg_white
      else:         line_num_bg_col = bg_black
    of "line-num-fg":
      case opt[1]
      of "black":   line_num_fg_col = fg_black
      of "red":     line_num_fg_col = fg_red
      of "green":   line_num_fg_col = fg_green
      of "yellow":  line_num_fg_col = fg_yellow
      of "blue":    line_num_fg_col = fg_blue
      of "magenta": line_num_fg_col = fg_magenta
      of "cyan":    line_num_fg_col = fg_cyan
      of "white":   line_num_fg_col = fg_white
      else:         line_num_fg_col = fg_white
    of "cursor-bg":
      case opt[1]
      of "black":   cursor_bg_col = bg_black
      of "red":     cursor_bg_col = bg_red
      of "green":   cursor_bg_col = bg_green
      of "yellow":  cursor_bg_col = bg_yellow
      of "blue":    cursor_bg_col = bg_blue
      of "magenta": cursor_bg_col = bg_magenta
      of "cyan":    cursor_bg_col = bg_cyan
      of "white":   cursor_bg_col = bg_white
      else:         cursor_bg_col = bg_white
    of "text-col-fg":
      case opt[1]
      of "black":   text_fg_col = fg_black
      of "red":     text_fg_col = fg_red
      of "green":   text_fg_col = fg_green
      of "yellow":  text_fg_col = fg_yellow
      of "blue":    text_fg_col = fg_blue
      of "magenta": text_fg_col = fg_magenta
      of "cyan":    text_fg_col = fg_cyan
      of "white":   text_fg_col = fg_white
      else:         text_fg_col = fg_white
    of "text-col-bg":
      case opt[1]
      of "black":   text_bg_col = bg_black
      of "red":     text_bg_col = bg_red
      of "green":   text_bg_col = bg_green
      of "yellow":  text_bg_col = bg_yellow
      of "blue":    text_bg_col = bg_blue
      of "magenta": text_bg_col = bg_magenta
      of "cyan":    text_bg_col = bg_cyan
      of "white":   text_bg_col = bg_white
      else:         text_bg_col = bg_white
    else: 
      discard

load_conf_vars()

main_loop()
