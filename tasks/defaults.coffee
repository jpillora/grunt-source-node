

path = require 'path'
fs = require 'fs'

module.exports = (grunt, src, dest) ->

  grunt.registerTask 'copy-defaults', 'C', ->

    files = fs.readdirSync(src)
    files.forEach (file) ->
      if fs.existsSync path.join dest, file
        return

      contents = fs.readFileSync path.join src, file
      unless contents
        return grunt.fail.warn "Error openning: #{file}"

      fs.writeFileSync path.join(dest, file), contents
      grunt.log.writeln "Added missing file: '#{file}'"

