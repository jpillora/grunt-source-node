grunt-source-web
====================

A premade Grunt environment to manage Node projects,
utilizing [Grunt Source](https://github.com/jpillora/grunt-source).

## Features

* A `readme` task, to add templating to your `README.md` using your `package.json` and more, see [this](https://raw.github.com/jpillora/grunt-source-node/master/defaults/README.md) and [this](https://raw.github.com/jpillora/flatify/master/README.md)
* Initialise Node projects 
  * Pre-templated `README.md`
  * Node `.travis.yml`
  * Git ignore `.gitignore`
  * Initial example `example/basic.js`
  * Initial test `example/basic-test.coffee`

## Usage

* Install Grunt Source

  http://github.com/jpillora/grunt-source

* Add the `gruntSource` field to your `package.json`

  ``` json
  {
      "gruntSource": {
        "source": "~/.grunt-sources/node",
        "repo": "https://github.com/jpillora/grunt-source-node.git"
      }
  }
  ```

* Run it

  ```
  grunt-source
  ```

#### MIT License

Copyright &copy; 2013 Jaime Pillora &lt;dev@jpillora.com&gt;

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
