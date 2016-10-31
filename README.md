# cppize

Crystal-to-C++ transpiler [WIP]

Generated code can be compiled with c++14 compiler (tested with g++ 6.2.0)

## Usage

1. Compile `src/compiler_test.cr`
2. Launch the executable like `my_executable my_file.cr`, (`my_file.cr` is the name of the Crystal source)
3. C++ output will be printed to stdout


## Development

#### Implementing nodes

See [src/cppize/nodes/expressions.cr](src/cppize/nodes/expressions.cr) for example

#### Adding transpile-time macros

See [src/cppize/macros/\_\_cpp\_\_.cr](src/cppize/macros/__cpp__.cr) for example

## Contributing

1. Fork it ( https://github.com/unn4m3d/cppize/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [unn4m3d](https://github.com/unn4m3d) unn4m3d - creator, maintainer