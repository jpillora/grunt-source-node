
vm = require 'vm'
_ = require 'lodash'
{fork} = require 'child_process'
path = require 'path'
fs = require 'fs'

blurbs =
  MIT: """
    Permission is hereby granted, free of charge, to any person obtaining
    a copy of this software and associated documentation files (the
    'Software'), to deal in the Software without restriction, including
    without limitation the rights to use, copy, modify, merge, publish,
    distribute, sublicense, and/or sell copies of the Software, and to
    permit persons to whom the Software is furnished to do so, subject to
    the following conditions:

    The above copyright notice and this permission notice shall be
    included in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
    EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
    MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
    IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
    CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
    TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
    """

module.exports = (grunt, data) ->

  DO_ASYNC = {} 
  # usable methods
  context = _.extend {}, data,
    DO_ASYNC: DO_ASYNC
    #set per exec
    callback: null
    runFile: (file, args = []) ->
      async = true
      proc = fork file, args, {silent:true}
      out = ''
      err = ''
      proc.stdout.on 'data', (buff) -> out += buff.toString()
      proc.stderr.on 'data', (buff) -> err += buff.toString()
      proc.on 'close', (code) ->
        context.callback err, "\n```\n#{out}\n```\n"
      return DO_ASYNC

    #
    showFile: (file) ->
      async = true
      language = ''
      if /\.js$/.test file
        language = ' javascript'
      fs.readFile file, (err, result) ->
        return context.callback(err) if err
        result = result.toString().replace /require\(["']\.\.\/\["']\)/, "require('#{data.name}')"
        context.callback null, "\n```#{language}\n#{result}\n```\n"
      return DO_ASYNC

    codeBlock: (str)->
      "\n```\n#{str}\n```\n"

    license: ->
      unless data.license
        return null
      """\n#### #{data.license} License

      Copyright &copy; #{new Date().getFullYear()} #{data.author}

      #{blurbs[data.license]}\n
      """

  #README templates
  grunt.registerTask 'readme', 'Allow templating in your README.md', ->
    
    done = @async()

    md = newmd = grunt.file.read 'README.md'

    process = ->

      m = newmd.match /<\s*([^>]+?)\s*>([\S\s]*?)<\/end>/

      unless m
        return processed() 

      code = m[1]
      # grunt.log.writeln "execute: #{code}"

      ran = (err, str) ->
        if err
          grunt.fail.warn "Error executing: '#{code}'\n#{err}"
          return
        unless str
          grunt.fail.warn "Error executing: '#{code}'\nResult is: '#{str}'"
          return
        str = str.toString()
        str = str.replace(/>/g,'&gt;').replace(/</g,'&lt;')
        newmd = newmd.replace m[0], "⦓#{code}⦔#{str}⦓/end⦔"
        process()

      try
        context.callback = ran
        vm.runInNewContext """
          var result = #{code};
          if(result !== DO_ASYNC)
            callback(null,result);
        """, context
      catch e
        grunt.fail.warn "Error executing '#{code}'\n#{e.stack}"
        

    processed = ->
      newmd = newmd.replace(/⦔/g,'>').replace(/⦓/g,'<')
      if md isnt newmd
        grunt.file.write 'README.md', newmd
      else
        grunt.log.writeln "No changes to README.md"
      done()

    process()
