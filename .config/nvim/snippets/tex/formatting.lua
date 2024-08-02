local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local c = ls.choice_node
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
  s( -- p1 -> Paragraph )
    {
      trig = "p1",
    },
    fmta(
      [[
        \paragraph{<>}
      ]],
      {
        i(0),
      }
    ),
    {
      -- condition = line_begin
    }
  ),
  s( -- p2 -> Subparagraph )
    {
      trig = "p2",
    },
    fmta(
      [[
        \subparagraph{<>}
      ]],
      {
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
    },
    fmta(
      [[
        \section{<>}
      ]],
      {
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
    },
    fmta(
      [[
        \subsection{<>}
      ]],
      {
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
    },
    fmta(
      [[
        \subsubsection{<>}
      ]],
      {
        i(0),
      }
    ),
    {
      condition = line_begin
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
  s( -- `r -> Upright Text )
    {
      trig = "`r",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        <>\textup{<>}
      ]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    ),
    {}
  ),
  s( -- `i -> Italic Text )
    {
      trig = "`i",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        <>\textit{<>}
      ]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    ),
    {}
  ),
  s( -- `s -> Slanted Text )
    {
      trig = "`s",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        <>\textsl{<>}
      ]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    ),
    {}
  ),
  s( -- `c -> Small Capitals Text )
    {
      trig = "`c",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        <>\textsc{<>}
      ]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    ),
    {}
  ),
  s( -- `b -> Boldface Text )
    {
      trig = "`b",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        <>\textbf{<>}
      ]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    ),
    {}
  ),
  s( -- `e -> Emphasized Text )
    {
      trig = "`e",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        <>\emph{<>}
      ]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    ),
    {}
  ),
  s( -- `ul -> Underlined Text )
    {
      trig = "`ul",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        <>\uline{<>}
      ]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    ),
    {}
  ),
  s( -- `uul -> Double Underlined Text )
    {
      trig = "`uul",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        <>\uuline{<>}
      ]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    ),
    {}
  ),
  s( -- `uw -> Wavy Underlined Text )
    {
      trig = "`uw",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        <>\uwave{<>}
      ]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    ),
    {}
  ),
  s( -- `x -> Strikethrough Text )
    {
      trig = "`x",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        <>\sout{<>}
      ]],
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, get_visual),
      }
    ),
    {}
  ),
  s( -- `1 -> Tiny Text (Inline) )
    {
      trig = "`1",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        {\tiny <>}
      ]],
      {
        d(1, get_visual),
      }
    ),
    {}
  ),
  s( -- `! -> Tiny Text (Environment) )
    {
      trig = "`!",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        \begin{tiny}
          <>
        \end{tiny}
      ]],
      {
        d(1, get_visual),
      }
    ),
    {}
  ),
  s( -- `2 -> Small Text (Inline) )
    {
      trig = "`2",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        {\small <>}
      ]],
      {
        d(1, get_visual),
      }
    ),
    {}
  ),
  s( -- `@ -> Small Text (Environment) )
    {
      trig = "`@",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        \begin{small}
          <>
        \end{small}
      ]],
      {
        d(1, get_visual),
      }
    ),
    {}
  ),
  s( -- `3 -> Normal Text (Inline) )
    {
      trig = "`3",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        {\normalsize <>}
      ]],
      {
        d(1, get_visual),
      }
    ),
    {}
  ),
  s( -- `# -> Normal Text (Environment) )
    {
      trig = "`#",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        \begin{normalsize}
          <>
        \end{normalsize}
      ]],
      {
        d(1, get_visual),
      }
    ),
    {}
  ),
  s( -- `4 -> Large Text (Inline) )
    {
      trig = "`4",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        {\large <>}
      ]],
      {
        d(1, get_visual),
      }
    ),
    {}
  ),
  s( -- `$ -> Large Text (Environment) )
    {
      trig = "`$",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        \begin{large}
          <>
        \end{large}
      ]],
      {
        d(1, get_visual),
      }
    ),
    {}
  ),
  s( -- `5 -> Huge Text (Inline) )
    {
      trig = "`5",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        {\huge <>}
      ]],
      {
        d(1, get_visual),
      }
    ),
    {}
  ),
  s( -- `% -> Huge Text (Environment) )
    {
      trig = "`%",
      snippetType = "autosnippet"
    },
    fmta(
      [[
        \begin{huge}
          <>
        \end{huge}
      ]],
      {
        d(1, get_visual),
      }
    ),
    {}
  ),
}
