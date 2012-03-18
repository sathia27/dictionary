#!/usr/bin/env ruby
=begin
Program name: Enlish to tamil dictionary
Date Written: 18/03/2012
Date Modified: 18/03/2012
Author : Sathianarayanan.S
License: GPL2.0
Version: 1.0
=end

require_relative "word"
require 'gtk2'

window = Gtk::Window.new
window.border_width = 10
window.set_size_request(700, -1)
window.resizable = false
window.opacity = 0.9
window.set_title "Dictionary"
window.set_window_position "center"
window.modify_bg Gtk::STATE_NORMAL, 	Gdk::Color.parse("#cccccc")
@textview = Gtk::TextView.new
@textview.set_editable false
@textview.set_size_request(450, 100)

vboxmain = Gtk::VBox.new( false, 10 )
hbox1 = Gtk::HBox.new( false, 10 )
vbox1 = Gtk::VBox.new( false, 5 )
vbox2 = Gtk::VBox.new( false, 5 )
hbox2 = Gtk::HBox.new( false, 10 )

image = Gtk::Image.new("logo.png")
@text1 = Gtk::Entry.new
@text1.set_size_request(200, 30)
completion = Gtk::EntryCompletion.new
@text1.completion = completion

model = Gtk::ListStore.new(String)
Word.all.each do |v|
  iter = model.append
  iter[0] = v.name
end

completion.model = model
completion.text_column = 0

label1 = Gtk::Label.new("Enter a Word", true)
label1.set_alignment(0,1)

vboxmain.pack_start(image, false, false, 0)
image.show
vboxmain.pack_start(hbox2, false, false, 0)
hbox2.show

vbox1.pack_start(label1, false, false, 0)
label1.show
vbox1.pack_start(@text1, false, false, 0)
@text1.show
vbox2.pack_start(@textview, false, false, 0)
@textview.show


hbox2.pack_start(vbox1, false, false, 0)
vbox1.show
hbox2.pack_start(vbox2, false, false, 0)
vbox2.show

window.signal_connect('delete_event') { Gtk.main_quit }

@text1.signal_connect("activate") {
	apply_text
}

def apply_text
	@textview.buffer.text = Word.where("name LIKE ?",@text1.text).any? ? @text1.text+"\n"+Word.where("name LIKE ?",@text1.text).first.meaning : "No results for '"+@text1.text+"'"
end
window.add(vboxmain)
window.show_all

Gtk.main
