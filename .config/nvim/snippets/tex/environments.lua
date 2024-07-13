local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local line_begin = require("luasnip.extras.expand_conditions").line_begin

function line_begin_or_non_letter(line_to_cursor, matched_trigger)
  local line_begin = line_to_cursor:sub(1, -(#matched_trigger + 1)):match("^%s*$")
  local non_letter = line_to_cursor:sub(-(#matched_trigger + 1), -(#matched_trigger + 1)):match("[^%a]")
  return line_begin or non_letter
end

local get_visual = function(args, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else  -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

local date_input = function(args, snip, old_state, fmt)
  local fmt = fmt or "%Y-%m-%d"
  return sn(nil, i(1, os.date(fmt)))
end

local buffer_is_empty = function()
  -- Technically doens't verify that the buffer is empty, just that
  -- there is a single line in the buffer and that the snippet trigger
  -- is the first set of characters in the line
  local last_line = vim.fn.line('$')
  if last_line == 1 and line_begin then
    return true
  else
    return false
  end
end

return {
  s( -- env -> Generic Environment )
    {
      trig = "env",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        \begin{<>}
          <>
        \end{<>}
      ]],
      {
        i(1),
        i(0),
        rep(1),
      }
    ),
    {
      condition = line_begin
    }
  ),
  s( -- tbl -> Longtable Environment )
    {
      trig = "tbl",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        \begin{longtable}[c]{<>}
          \caption{<>}
          \label{table:<>}\\
          \toprule
          <>
          \midrule
          \endfirsthead
          \toprule
          <>
          \midrule
          \endhead
          <>
          \bottomrule
        \end{longtable}
      ]],
      {
        i(1, "Define Columns"),
        i(2, "Caption"),
        i(3),
        i(4, "Table Heading"),
        rep(4),
        i(5, "Contents"),
      }
    ),
    {
      condition = line_begin
    }
  ),
  s( -- eq -> Equation Environment )
    {
      trig = "eq",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        \begin{equation}
          <>
        \end{equation}
      ]],
      {
        i(0),
      }
    ),
    {
      condition = line_begin
    }
  ),
  s( -- al -> Align Environment )
    {
      trig = "al",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        \begin{align}
          <>
        \end{align}
      ]],
      {
        i(0),
      }
    ),
    {
      condition = line_begin
    }
  ),
  s( -- fig -> Figure Environment )
    -- TODO: Create options to cycle through for location [p], [b], etc.
    {
      trig = "fig",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        \begin{figure}[h!]
          \includegraphics[width=<>]{<>}
          \caption{<>}
          \label{figure:<>}
        \end{figure}
      ]],
      {
        i(1, "\\linewidth"),
        i(2, "path"),
        i(3, "caption"),
        i(4, "label")
      }
    ),
    {
      condition = line_begin
    }
  ),
  s( -- sfig -> Subfigure Environment )
    {
      trig = "sfig",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        \begin{subfigure}[b]{<>}
          \includegraphics[width=<>]{<>}
          \caption{<>}
        \end{subfigure}
      ]],
      {
        i(1, "width"),
        i(2, "\\linewidth"),
        i(3, "path"),
        i(4, "caption")
      }
    ),
    {
      condition = line_begin
    }
  ),
  s( -- tk -> TikZ Environment )
    {
      trig = "tk",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        \begin{tikzpicture}
          <>
        \end{tikzpicture}
      ]],
      {
        i(1)
      }
    ),
    {
      condition = line_begin
    }
  ),
}
