# Programming Elixir - Issues

Working through the "Issues" application from "Programming Elixir" by Dave Thomas.

I created some [blog posts](https://fatschmalz.wordpress.com/) as I went through this because I changed the way some of the things were done; some of the third-party dependencies had changed and I used [poison](https://github.com/devinus/poison) rather than Erlang's jsx..

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add issues to your list of dependencies in `mix.exs`:

        def deps do
          [{:issues, "~> 0.0.1"}]
        end

  2. Ensure issues is started before your application:

        def application do
          [applications: [:issues]]
        end

