PIN_FSM/lustre
===============

This directory contains a Lustre model of the rflx transition system and posed invariants.
Properties in the model can be proved using `kind2`.


# Background #

## Lustre ##

Lustre is a functional programming language with formal semantics that was originally designed to specify the cyclic execution of synchronous computations.
For an introduction to Lustre, consult the tutorial here: http://www-verimag.imag.fr/~halbwach/lustre-tutorial.html.
We use Lustre for this model because Lustre is the input language for a class of interesting tools, including modern infinite-state model checkers like `kind2`.

Lustre is syntactically poor, compared to many other languages, and is therefore not difficult to learn.
Two key differences between Lustre and typical programming languages are worth highlighting:

1. Lustre programs operate on _streams_ that represent sequences of values over time.
   This feature of the language is presented in the introductory paragraph of the above tutorial.

2. The Lustre _arrow_ operator (`->`) is *not* implication.
   The operator allows the programmer to designate the value to be used when an expression would otherwise be `nil`.
   The arrow operator is used in conjunction with `pre` to designate the value to be used when there is no prior value for an expression.

### VS Code Extension ###

There is a [VS Code](#https://code.visualstudio.com/) extension for Lustre: https://github.com/MercierCorentin/vscode-lustre that offers syntax highlighting and comment/uncomment functionality.
The support for `kind2`'s Lustre is incomplete but generally adequate.

## kind2 ##

`kind2` is an open-source model checker developed at the University of Iowa: https://kind2-mc.github.io/kind2/

### Installing Kind2 ###

The easiest way to install `kind2` is via `opam`, the OCaml package manager.
Follow these steps:

    $ sh <(curl -sL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh)
    $ opam init
    $ opam install opam-depext
    $ opam depext kind2
    $ opam install z3
    $ opam install kind2

## Running kind2 ##

To run `kind2`, you first need to export the `opam`-provided environment:

    $ eval "$( opam env )"

Then, you can run `kind2` to reprove all properties on all nodes of the model, like this:

    PIN_FSM/lustre$ kind2 pin_nodes.lus


# Model #

There are five files:

- `pin.lus`: the top-level model
- `pin_automaton.lus`: reencoding of the model using the hierarchical-automaton syntax
- `types.lus`: type definitions, drawn from the rflx
- `pltl.lus`: observers implementing pltl operators

- `pin_nodes.lus`

Of these, the most interesting is the last: `pin_nodes.lus`.
This model attempts to illustrate how an automatic translation from RecordFlux to Lustre might be structured.
All types are declared in the file.
The naming of types and the state enumerations has been improved to reduce changes of confusing during parsing.
The variables are packed into a record, which makes the resulting model more compact and also makes it easier to identify which variables are drawn from the RecordFlux and which are introduced to control the model.
Protocol states are implemented as Lustre nodes.
This allows a more direct comparison to be made with the original RecordFlux as compared to the giant if expression in `pin.lus`.

Analysis time is nearly identical to that of `pin.lus`.
The model also appears to be more accurate, possibly because it was partly retranslated by hand.
