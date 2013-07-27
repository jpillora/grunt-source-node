
path = require 'path'
fs = require 'fs'
require "coffee-script"
_ = require "lodash"

module.exports = (grunt) ->

  grunt.loadNpmTasks "grunt-contrib-coffee"
  grunt.loadNpmTasks "grunt-jpillora-watch"

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

  #config
  grunt.initConfig
    coffee:
      compile:
        expand: true
        bare: true
        join: false
        cwd: 'src/'
        src: ['**/*.coffee']
        dest: 'out/'
        ext: '.js'
    watch:
      options:
        gruntCwd: gruntdir
      files: ['src/**/*.coffee']
      tasks: ['coffee']

  #aliases
  grunt.registerTask "init", [ "copy-defaults" ]
  grunt.registerTask "dev", [ "coffee", "watch" ]
  grunt.registerTask "default", [ "readme"]








