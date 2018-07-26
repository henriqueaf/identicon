# Identicon

**An command line app that generates an [Identicon](https://en.wikipedia.org/wiki/Identicon) based on the input string.**

# How to use

**IMPORTANT!** It's necessary Elixir 1.6 or above.

* Go to app's folder
```
cd /path/to/identicon/folder
```

* Install dependencies
```
mix deps.get
```

* Starts a mix command line
```
iex -S mix
```

* Run the **main** function of Identicon module with the string as paramenter.
```
Identicon.main("string_to_became_identicon")
```
It will create a *.png* file inside the app's folder with the same name as the string passed in parameter.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `identicon` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:identicon, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/identicon](https://hexdocs.pm/identicon).

