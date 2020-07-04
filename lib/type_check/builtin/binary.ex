defmodule TypeCheck.Builtin.Binary do
  defstruct []

  use TypeCheck
  type problem_tuple_type :: {:error, %__MODULE__{}, :no_match, %{}, any()}

  defimpl TypeCheck.Protocols.ToCheck do
    def to_check(s, param) do
      quote do
        case unquote(param) do
          x when is_binary(x) ->
            {:ok, []}
          _ ->
            {:error, {unquote(Macro.escape(s)), :no_match, %{}, unquote(param)}}
        end
      end
    end
  end

  # def error_response_type() do
  #   require TypeCheck.Type
  #   import TypeCheck.Builtin
  #   TypeCheck.Type.build({%__MODULE__{}, :no_match, %{}, any()})
  # end

  defimpl TypeCheck.Protocols.Inspect do
    def inspect(_, _opts) do
      "binary()"
    end
  end

  if Code.ensure_loaded?(StreamData) do
    defimpl TypeCheck.Protocols.ToStreamData do
      def to_gen(_s) do
        StreamData.binary()
      end
    end
  end
end
