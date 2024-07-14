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

function non_letter(line_to_cursor, matched_trigger)
  local non_letter = line_to_cursor:sub(-(#matched_trigger + 1), -(#matched_trigger + 1)):match("[^%a]")
  return non_letter
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
    {}
  ),
  s( -- Tb -> Longtable Environment )
    {
      trig = "Tb",
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
    {}
  ),
  s( -- tb -> Tabular Environment )
    {
      trig = "tb",
    },
    fmta(
      [[
        \begin{tabular}{<>}                                                                                                  
          \toprule                                                                                                              
          <> \\
          \midrule                                                                                                              
          <>
          \bottomrule                                                                                                           
        \end{tabular}
      ]],
      {
        i(1, "Define Columns"),
        i(2, "Name Columns"),
        i(3, "Contents"),
      }
    ),
    {}
  ),
  s( -- eq -> Equation Environment )
    {
      trig = "eq",
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
    {}
  ),
  s( -- al -> Align Environment )
    {
      trig = "al",
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
    {}
  ),
  s( -- fg -> Figure Environment )
    -- TODO: Create options to cycle through for location [p], [b], etc.
    {
      trig = "fg",
    },
    fmta(
      [[
        \begin{figure}[h!]
          <>
        \end{figure}
      ]],
      {
        i(0),
      }
    ),
    {}
  ),
  s( -- sfg -> Subfigure Environment )
    {
      trig = "sfg",
    },
    fmta(
      [[
        \begin{subfigure}[b]{<>}
          <>
        \end{subfigure}
      ]],
      {
        i(1, "width"),
        i(0),
      }
    ),
    {}
  ),
  s( -- wfg -> Wrapfigure Environment )
    {
      trig = "wfg",
    },
    fmta(
      [[
        \begin{wrapfigure}{<>}{<>}
          <>
        \end{wrapfigure}
      ]],
      {
        i(1, "alignment"),
        i(2, "width"),
        i(0),
      }
    ),
    {}
  ),
  s( -- tk -> TikZ Environment )
    {
      trig = "tk",
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
    {}
  ),
}
