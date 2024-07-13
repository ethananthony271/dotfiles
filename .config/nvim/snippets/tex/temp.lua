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
  s( -- bl -> LaTeX Document Boilerplate )
    {
      trig = "bl",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        \documentclass{<>}

        \usepackage{tikz}
        \usepackage{fullpage}
        \usepackage{graphicx}
        \usepackage{subcaption}
        % Table Formatting
        \usepackage{multirow}
        \usepackage{booktabs}
        \usepackage{longtable}
        \usepackage{siunitx}

        \sisetup{
          round-mode          = places, % Rounds numbers
          round-precision     = 2, % to 2 places
        }

        \title{<>}
        \date{<>}
        \author{<>}

        \begin{document}
        \pagenumbering{arabic}
        \maketitle
        \tableofcontents
        \newpage

          <>

        \end{document}
      ]],
      {
        i(1, "article"),
        i(2, "title"),
        d(3, date_input, {}, { user_args = { "%B %d, %Y" } }),
        i(4, "Ethan Anthony"),
        i(0)
      }
    ),
    {
      condition = buffer_is_empty
    }
  ),
  s( -- pkg -> Usepackage )
    {
      trig = "pkg",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        \usepackage{<>}
          <>
      ]],
      {
        i(1),
        i(0),
      }
    ),
    {
      condition = line_begin
    }
  ),
  s( -- p1 -> Paragraph )
    {
      trig = "p1",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        \paragraph{<>}
          <>
      ]],
      {
        i(1),
        i(0),
      }
    ),
    {
      condition = line_begin
    }
  ),
  s( -- p2 -> Subparagraph )
    {
      trig = "p2",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        \subparagraph{<>}
          <>
      ]],
      {
        i(1),
        i(0),
      }
    ),
    {
      condition = line_begin
    }
  ),
  s( -- s1 -> Section )
    {
      trig = "s1",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        \section{<>}
          <>
      ]],
      {
        i(1),
        i(0),
      }
    ),
    {
      condition = line_begin
    }
  ),
  s( -- s2 -> Subsection )
    {
      trig = "s2",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        \subsection{<>}
          <>
      ]],
      {
        i(1),
        i(0),
      }
    ),
    {
      condition = line_begin
    }
  ),
  s( -- s3 -> Subsubsection )
    {
      trig = "s3",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        \subsubsection{<>}
          <>
      ]],
      {
        i(1),
        i(0),
      }
    ),
    {
      condition = line_begin
    }
  ),
  s( -- mm -> Inline Math )
    {
      trig = "mm",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        <>$<>$
      ]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    ),
    {
      condition = line_begin_or_non_letter
    }
  ),
  s( -- ff -> Fraction )
    {
      trig = "ff",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        <>\frac{<>}{<>}
      ]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
        i(2),
      }
    ),
    {
      condition = line_begin_or_non_letter
    }
  ),
  s( -- fF -> Fraction (Denominator) )
    {
      trig = "fF",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        <>\frac{<>}{<>}
      ]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        i(2),
        d(1, get_visual),
      }
    ),
    {
      condition = line_begin_or_non_letter
    }
  ),
  s( -- sq -> Square Root )
    {
      trig = "sq",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        <>\sqrt{<>}
      ]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    ),
    {
      condition = line_begin_or_non_letter
    }
  ),
  s( -- sc -> Scale Brackets )
    {
      trig = "sc",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        <>\left<><>\right<>
      ]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        i(1),
        d(0, get_visual),
        i(2),
      }
    ),
    {
      condition = line_begin_or_non_letter
    }
  ),
  s( -- fn -> Footnote )
    {
      trig = "fn",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        <>\footnote{\label{<>}<>}
      ]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        i(1),
        d(2, get_visual),
      }
    ),
    {
      condition = line_begin_or_non_letter
    }
  ),
}
