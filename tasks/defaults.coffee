

mkdirp = require 'mkdirp'
path = require 'path'
fs = require 'fs'




copyDefaults = (grunt, src, dest) ->

  mkdirp.sync dest

  files = fs.readdirSync(src)
  files.forEach (file) ->

    srcFile = path.join src, file
    destFile = path.join dest, file

    if fs.statSync(srcFile).isDirectory()
      copyDefaults(grunt, srcFile, destFile)
      return

    if fs.existsSync destFile
      return

    contents = fs.readFileSync srcFile
    unless contents
      return grunt.fail.warn "Error openning: #{srcFile}"

    fs.writeFileSync destFile, contents
    grunt.log.writeln "Added missing file: '#{destFile}'"

module.exports = (grunt, src, dest) ->
  grunt.registerTask 'copy-defaults', 'C', ->
    copyDefaults grunt, src, dest