defmodule Username do

  def sanitize([]), do: []
  def sanitize([head | tail]) do
    sanitized = 
    case head do
     ?ä -> 'ae'
     ?ö -> 'oe'
     ?ü -> 'ue'
     ?ß -> 'ss'
     x when (x >= ?a and x <= ?z) or x == ?_ -> [x]
     _ -> []
    end

    sanitized ++ sanitize(tail)
  end
end
