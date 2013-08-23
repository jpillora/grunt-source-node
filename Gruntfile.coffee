
module.exports = (grunt) ->

  #load external tasks and change working directory
  grunt.source.loadAllTasks()

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
      files: ['src/**/*.coffee']
      tasks: ['coffee']

  #aliases
  grunt.registerTask "dev", [ "coffee", "watch" ]
  grunt.registerTask "default", [ "readme"]

