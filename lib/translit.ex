defmodule Translit do
  @moduledoc """
  Translit boundary module.
  """

  @ukr %{
    "А" => "A",
    "Б" => "B",
    "В" => "V",
    "Г" => "H",
    "Ґ" => "G",
    "Д" => "D",
    "Е" => "E",
    "Є" => "Ye",
    "Ж" => "Zh",
    "З" => "Z",
    "И" => "Y",
    "І" => "I",
    "Ї" => "Yi",
    "Й" => "Y",
    "К" => "K",
    "Л" => "L",
    "М" => "M",
    "Н" => "N",
    "О" => "O",
    "П" => "P",
    "Р" => "R",
    "С" => "S",
    "Т" => "T",
    "У" => "U",
    "Ф" => "F",
    "Х" => "Kh",
    "Ц" => "Ts",
    "Ч" => "Ch",
    "Ш" => "Sh",
    "Щ" => "Shch",
    "Ю" => "Yu",
    "Я" => "Ya",
    "а" => "a",
    "б" => "b",
    "в" => "v",
    "г" => "h",
    "ґ" => "g",
    "д" => "d",
    "е" => "e",
    "є" => "ie",
    "ж" => "zh",
    "з" => "z",
    "и" => "y",
    "і" => "i",
    "ї" => "i",
    "й" => "i",
    "к" => "k",
    "л" => "l",
    "м" => "m",
    "н" => "n",
    "о" => "o",
    "п" => "p",
    "р" => "r",
    "с" => "s",
    "т" => "t",
    "у" => "u",
    "ф" => "f",
    "х" => "kh",
    "ц" => "ts",
    "ч" => "ch",
    "ш" => "sh",
    "щ" => "shch",
    "ю" => "iu",
    "я" => "ia"
  }

  @doc """
  A cyrillic ukrainian to latin transliteration

  ## Examples
      iex> Translit.translit("Андрій Михайленко")
      "Andrii Mykhailenko"
  """
  def translit(cyrillic) when is_binary(cyrillic) do
    cyrillic
    |> String.graphemes()
    |> Enum.reduce([], &translit_letter/2)
    |> join()
  end

  # special case for "Зг", that should be mapped as "zgh"
  defp translit_letter(letter, [last_letter] = acc) when letter in ~w(Г г) and last_letter in ~w(z Z) do
    acc ++ [translit_zgh(letter)]
  end

  # special case for "зг", that should be mapped as "zgh"
  defp translit_letter(letter, acc) when letter in ~w(Г г) do
    case List.last(acc) do
      last_letter when last_letter in ~w(z Z) -> acc ++ [translit_zgh(letter)]
      _ -> acc ++ [translit_letter(letter)]
    end
  end

  defp translit_letter(letter, acc) do
    acc ++ [translit_letter(letter)]
  end

  defp translit_letter(" "), do: " "
  defp translit_letter("ь"), do: ""
  defp translit_letter("Ь"), do: ""
  defp translit_letter("'"), do: ""

  defp translit_letter(letter) do
    case Map.get(@ukr, letter) do
      nil -> letter
      latin -> latin
    end
  end

  defp translit_zgh("Г"), do: "GH"
  defp translit_zgh("г"), do: "gh"

  defp join(letters_list) when is_list(letters_list), do: Enum.join(letters_list)
end
