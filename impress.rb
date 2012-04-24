#!/usr/bin/env ruby

require "rubygems"
require "haml"
require "yaml"

require 'choice'

Choice.options do
  header 'Application options:'

  separator 'Required:'

  option :slide_settings, :required => true do
	short '-s'
	long '--slide-settings=SETTINGS_YAML'
	desc 'The YAML file containing the slide settings.'
  end

  option :slides_folder, :required => true do
	short '-f'
	long '--slides-folder=FOLDER'
	desc 'The path to folder containing individual slides.'
  end

  separator 'Optional:'

  option :layout_template do
	short '-l'
	long '--layout-template=LAYOUT_FILE'
	desc 'The file to use as the layout template'
	default 'templates/layout.html.haml'
  end

  option :slide_template do
	short '-t'
	long '--slide-template=SLIDE_FILE'
	desc 'The file to use as the slide template'
	default 'templates/slide.html.haml'
  end

  separator 'Common:'

  option :help do
	short '-h'
	long '--help'
	desc 'Show this message.'
  end

  option :version do
	short '-v'
	long '--version'
	desc 'Show version.'
	action do
	  puts 'impress.js renderer version 1.0'
	  exit
	end
  end
end

slides = YAML::load( File.read(Choice.choices.slide_settings) )

haml = Haml::Engine.new(File.read(Choice.choices.layout_template)).render do
  slides_html = slides.each_with_index.map do |slide, index|

    slide = {:name => "", :cls => [], :data => {}, :slide_partial => "#{ index + 1 }.html.haml"}.merge(slide)
    
    slide_partial = File.join(Choice.choices.slides_folder, slide.delete(:slide_partial))

    slide = Haml::Engine.new(File.read(Choice.choices.slide_template)).render(Object.new, slide) do
      Haml::Engine.new(File.read(slide_partial)).render
    end
    slide
  end
  slides_html.join("")
end

puts haml
