defmodule TranslitTest do
  use ExUnit.Case
  doctest Translit

  test "sucess translitaration" do
    data = file_to_list("test/data/ukr-latin.txt")

    Enum.each(data, fn words ->
      err_msg = "Invalid input for tests. Expected two words separated by dash, got: #{words}"

      assert [ukr, latin] = String.split(words, " - "), err_msg
      assert latin == Translit.translit(ukr)
    end)
  end

  defp file_to_list(file) do
    file
    |> File.read!()
    |> String.split("\n")
  end
end
