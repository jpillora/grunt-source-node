
path = require 'path'
fs = require 'fs'
require "coffee-script"
_ = require "lodash"

module.exports = (grunt) ->

  readmeTask = require "./tasks/readme"
  copyDefaultsTask = require "./tasks/defaults"

  defaultsFolder = path.join process.cwd(), 'defaults'
  #above here the working directory is the grunt directory
  gruntdir = process.cwd()
  base = grunt.option "basedir"
  throw "Missing 'basedir' option" unless base
  grunt.file.setBase base
  #below here the working directory is the project directory
  currentFolder = path.join process.cwd()

  pkg = grunt.file.readJSON 'package.json'

  #create readme task with some data
  readmeTask grunt, pkg

  #create 
  copyDefaultsTask grunt, defaultsFolder, currentFolder


  grunt.registerTask "default", [ "readme", "copy-defaults"]

