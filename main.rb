require 'gtk3'

glade_file = __dir__+'/tasmo.glade'

builder = Gtk::Builder.new(file: glade_file)

@font = Pango::FontDescription.new("Serif bold 12")

win = builder.get_object('win')
win.set_title('tasmo')
win.set_resizable(false)

left_button = builder.get_object('left_button')
right_button = builder.get_object('right_button')
$check = builder.get_object('check')
$entry = builder.get_object('entry')

$text_arr = Array.new(10, '')
$check_arr = Array.new(10, false)

def entry_init
  $entry.text = ''
  $entry.override_font(@font)
end

def on_win_destroy
  Gtk.main_quit
end

@page = 1
@counter = 0
def on_left_button_clicked
  $text_arr[@counter] = $entry.text
  if @counter > 0 then
    @counter -= 1
    @page = @counter+1
    $entry.text = $text_arr[@counter]
    $check.active = $check_arr[@counter]
  end
  #puts "hello, you are in the page #{@page}!"
end

def on_right_button_clicked
  $text_arr[@counter] = $entry.text
  if @counter < 9 then
    @counter += 1
    @page = @counter+1
    $entry.text = $text_arr[@counter]
    $check.active = $check_arr[@counter]
  end
  #puts "hello, you are in the page #{@page}!"
end

def on_check_toggled
  $check_arr[@counter] = $check.active?
  #puts "on_check_toggled"
end

builder.connect_signals { |handler| method(handler) }

entry_init
win.show_all
Gtk.main

