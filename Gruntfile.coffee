module.exports = (grunt) ->
  grunt.initConfig
    haml:
      dist:
        expand: true
        flatten: false
        cwd: 'src'
        src: ['**/*.haml']
        dest: 'build'
        ext: '.html'

    copy:
      main:
        expand: true
        cwd: 'src'
        src: ['*/*']
        dest: 'build'

    coffee:
      dist:
        expand: true
        flatten: false
        cwd: "src/js"
        src: ["**/*.coffee"]
        dest: 'build/js'
        ext: ".js"

    concurrent:
      dist:
        ['watch']

    watch:
      haml:
        files: ["src/**/*.haml"]
        tasks: ["compile:haml"]
      coffee:
        files: ["src/js/**/*.coffee"]
        tasks: ["compile:coffee"]
      static:
        files: ['src/*/*']
        tasks: ["compile:copy"]

    connect:
      server:
        options:
          port: 8000
          base: 'build'

  #Load Tasks
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-haml2html'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-concurrent'

  grunt.registerTask 'compile', ['haml', 'copy', 'coffee']
  grunt.registerTask 'server', ['connect:server', 'watch', 'compile', 'concurrent:dist']
