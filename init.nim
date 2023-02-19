import illwill
import os, strutils, sequtils

var line_numbers_show: bool = true
var line_num_bg_col: BackgroundColor = bg_black
var line_num_fg_col: ForegroundColor = fg_white
var cursor_bg_col: BackgroundColor = bg_white


include cose

proc load_conf_vars(): void =
  for opt in opts:
    if opt[0] == "line-nums":
      if   opt[1] == "false":
        line_numbers_show = false
      elif opt[1] == "true":
        line_numbers_show = true
    elif opt[0] == "line-num-bg":
      if opt[1] == "black":
        line_num_bg_col = bg_black
      elif   opt[1] == "red":
        line_num_bg_col = bg_red
      elif opt[1] == "green":
        line_num_bg_col = bg_green
      elif opt[1] == "yellow":
        line_num_bg_col = bg_yellow
      elif opt[1] == "blue":
        line_num_bg_col = bg_blue
      elif opt[1] == "magenta":
        line_num_bg_col = bg_magenta
      elif opt[1] == "cyan":
        line_num_bg_col = bg_cyan
      elif opt[1] == "white":
        line_num_bg_col = bg_white
    elif opt[0] == "line-num-fg":
      if opt[1] == "black":
        line_num_fg_col = fg_black
      elif   opt[1] == "red":
        line_num_fg_col = fg_red
      elif opt[1] == "green":
        line_num_fg_col = fg_green
      elif opt[1] == "yellow":
        line_num_fg_col = fg_yellow
      elif opt[1] == "blue":
        line_num_fg_col = fg_blue
      elif opt[1] == "magenta":
        line_num_fg_col = fg_magenta
      elif opt[1] == "cyan":
        line_num_fg_col = fg_cyan
      elif opt[1] == "white":
        line_num_fg_col = fg_white
    elif opt[0] == "cursor-bg":
      if opt[1] == "black":
        cursor_bg_col = bg_black
      elif   opt[1] == "red":
        cursor_bg_col = bg_red
      elif opt[1] == "green":
        cursor_bg_col = bg_green
      elif opt[1] == "yellow":
        cursor_bg_col = bg_yellow
      elif opt[1] == "blue":
        cursor_bg_col = bg_blue
      elif opt[1] == "magenta":
        cursor_bg_col = bg_magenta
      elif opt[1] == "cyan":
        cursor_bg_col = bg_cyan
      elif opt[1] == "white":
        cursor_bg_col = bg_white
    else: 
      discard

load_conf_vars()

include seve
main_loop()
