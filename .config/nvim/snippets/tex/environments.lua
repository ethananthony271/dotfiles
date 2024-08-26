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
        d(2, get_visual),
        rep(1),
      }
    ),
    {
      condition = line_begin
    }
  ),
  s( -- eq -> Equation Environment )
    {
      trig = "eq",
    },
    fmta(
      [[
        \begin{<>}
          <>
        \end{<>}
      ]],
      {
        c(1, {
          t("equation"),
          t("equation*"),
          t("align"),
          t("align*"),
          t("multiline"),
          t("multiline*"),
          t("gather"),
          t("gather*"),
        }),
        d(2, get_visual),
        rep(1),
      }
    ),
    {
      condition = line_begin
    }
  ),
  s( -- tb -> Tabularray Environment )
    {
      trig = "tb",
    },
    fmta(
      [[
        \begin{tblr}{<>}
          \toprule
          <>
          \midrule
          <>
          \bottomrule
        \end{tblr}
      ]],
      {
        i(1, "columns"),
        i(2, "column headers"),
        i(0, "content"),
      }
    ),
    {
      condition = line_begin
    }
  ),
  s( -- fg -> Figure Environment )
    {
      trig = "fg",
    },
    fmta(
      [[
        \begin{figure}[<>]
          <>
        \end{figure}
      ]],
      {
        c(1, {
          t("H"),
          t("h"),
          t("t"),
          t("b"),
          t("p"),
          t("h!"),
          t("t!"),
          t("b!"),
          t("p!"),
        }),
        c(2, {
          fmta(
            [[
              <>
              \caption{<>}
              \label{<>}
            ]],
            {
              d(3, get_visual),
              i(1),
              c(2, {
                fmta(
                  [[
                    fig:<>
                  ]],
                  {
                    i(1),
                  }
                ),
                fmta(
                  [[
                    tbl:<>
                  ]],
                  {
                    i(1),
                  }
                ),
              }),
            }
          ),
          fmta(
            [[
              <>
            ]],
            {
              d(1, get_visual),
            }
          ),
        }),
      }
    ),
    {
      condition = line_begin
    }
  ),
  s( -- sfg -> Subfigure Environment )
    {
      trig = "sfg",
    },
    fmta(
      [[
        \begin{subfigure}[<>]{<>}
          <>
        \end{subfigure}
      ]],
      {
        c(1, {
          t("H"),
          t("h"),
          t("t"),
          t("b"),
          t("p"),
          t("h!"),
          t("t!"),
          t("b!"),
          t("p!"),
        }),
        c(2, {
          fmta(
            [[
              <>\textwidth
            ]],
            {
              i(1),
            }
          ),
        }),
        c(3, {
          fmta(
            [[
              <>
              \caption{<>}
              \label{<>}
            ]],
            {
              d(3, get_visual),
              i(1),
              c(2, {
                fmta(
                  [[
                    fig:<>
                  ]],
                  {
                    i(1),
                  }
                ),
                fmta(
                  [[
                    tbl:<>
                  ]],
                  {
                    i(1),
                  }
                ),
              }),
            }
          ),
          fmta(
            [[
              <>
            ]],
            {
              d(1, get_visual),
            }
          ),
        }),
      }
    ),
    {
      condition = line_begin
    }
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
        c(1, {
          t("r"),
          t("R"),
          t("l"),
          t("L"),
        }),
        c(2, {
          fmta(
            [[
              <>\textwidth
            ]],
            {
              i(1),
            }
          ),
          t("0pt"),
          i(0),
        }),
        c(3, {
          fmta(
            [[
              <>
              \caption{<>}
              \label{<>}
            ]],
            {
              d(3, get_visual),
              i(1),
              c(2, {
                fmta(
                  [[
                    fig:<>
                  ]],
                  {
                    i(1),
                  }
                ),
                fmta(
                  [[
                    tbl:<>
                  ]],
                  {
                    i(1),
                  }
                ),
              }),
            }
          ),
          fmta(
            [[
              <>
            ]],
            {
              d(1, get_visual),
            }
          ),
        }),
      }
    ),
    {
      condition = line_begin
    }
  ),
  s( -- en -> Enumerate Environment )
    {
      trig = "en",
    },
    fmta(
      [[
        \begin{enumerate}
          \itemsep0em
          \item <>
        \end{enumerate}
      ]],
      {
        i(0),
      }
    ),
    {
      condition = line_begin
    }
  ),
  s( -- fm -> Forumla Environment )
    {
      trig = "fm",
    },
    fmta(
      [[
        \begin{formula}{<>}
          <>
        \end{formula}
      ]],
      {
        i(1),
        d(2, get_visual),
      }
    ),
    {
      condition = line_begin
    }
  ),
  s( -- ex -> Forumla Environment )
    {
      trig = "ex",
    },
    fmta(
      [[
        \begin{example}
          <>
        \end{example}
      ]],
      {
        d(1, get_visual),
      }
    ),
    {
      condition = line_begin
    }
  ),
  s( -- def -> Definition Environment )
    {
      trig = "def",
    },
    fmta(
      [[
        \begin{definition}{<>}
          <>
        \end{definition}
      ]],
      {
        i(1),
        d(2, get_visual),
      }
    ),
    {
      condition = line_begin
    }
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
        d(1, get_visual),
      }
    ),
    {
      condition = line_begin
    }
  ),
  s( -- ax -> Axis Environment (Tikz) )
    {
      trig = "ax",
    },
    fmta(
      [[
        \begin{axis}[
          <>,
          title = <>,
          xmax = <>,
          xlabel = <>,
          xtick = {<>},
          xticklabels = {<>},
          ymax = <>,
          ylabel = <>,
          ytick = {<>},
          yticklabels = {<>},
          ]
          <>
        \end{axis}
      ]],
      {
        c(1, {
          t("basicAxis"),
        }),
        i(2),
        i(3),
        i(4),
        i(5),
        i(6),
        i(7),
        i(8),
        i(9),
        i(10),
        i(0),
      }
    ),
    {
      condition = line_begin
    }
  ),
  s( -- kv -> Known Values Example Split Tcolorbox )
    {
      trig = "kv",
    },
    fmta(
      [[
        \begin{tcolorbox}[
          standard jigsaw, % Allows opacity
          colframe=fg,
          boxrule=0px,
          opacityback=0,
          sidebyside,
          lefthand width=100px,
          coltext=fg,
        ]
        \textbf{Known Values}
        \begin{align*}
          <>
        \end{align*}
        \tcblower
        <>
        \end{tcolorbox}
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
}
