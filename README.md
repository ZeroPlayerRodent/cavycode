# CavyCode
Code like a Guinea Pig!

CavyCode is a lightweight programming language with a strong Guinea Pig theme.

Each function and keyword is inspired by actions and objects relating to Guinea Pigs.

CavyCode is both an interpreted and compiled language with the ability to compile to Common Lisp.

## Code Examples

Here are some simple snippets of CavyCode code.

For more programs, check out the [sample programs directory](https://github.com/ZeroPlayerRodent/cavycode/tree/main/samples).

Hello World:
```
Wheek-string "Hello, World!"
```

Infinite counter:
```
Mark-territory 1
Wheek-int Tunnel
Wheek-char 10
Eat-hay 1
Zoomies-to 1
```
Truth-machine:
```
Eat-pellet Beg-int
Poop
Mark-territory 1
Wheek-int Tunnel
Popcorn-if 0
  Zoomies-to 1
```

## Computational Class

CavyCode is [Turing-Complete](https://en.wikipedia.org/wiki/Turing_completeness) due to its ability to simulate any arbitrary [Cyclic Tag System](https://en.wikipedia.org/wiki/Tag_system#Cyclic_tag_systems).

Check out [cyclic-tag.cavy](https://github.com/ZeroPlayerRodent/cavycode/blob/main/samples/cyclic-tag.cavy) for a CavyCode program that interprets any cyclic tag system defined by the user.

See also: [BF-CavyCode](https://github.com/ZeroPlayerRodent/BF-CavyCode/tree/main), a [Brainfuck](https://en.wikipedia.org/wiki/Brainfuck) interpreter written in CavyCode.

## Get Started!

You can build/run CavyCode directly from source, or you can download a (possibly outdated) pre-compiled binary from the releases tab.

CavyCode is only confirmed to work with the [CLISP](https://clisp.sourceforge.io/) Common Lisp implementation. Any other implementation may not work or may have issues running CavyCode.

After starting CavyCode by typing `./cavycode.mem` in your terminal, you can interpret a program by typing `(cavy-i "filename.cavy")`, or you can compile a program by typing `(cavy-c "filename.cavy")`.

Now that you have CavyCode set up, learn to write programs by reading the [documentation](https://github.com/ZeroPlayerRodent/cavycode/blob/main/info.txt)!
