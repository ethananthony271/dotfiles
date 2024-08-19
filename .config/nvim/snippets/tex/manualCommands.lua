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
  s( -- -u -> Up Arrow )
    {
      trig = "-u",
    },
    {
      t("\\uparrow")
    },
    {}
  ),
  s( -- -r -> Right Arrow )
    {
      trig = "-r",
    },
    {
      t("\\rightarrow")
    },
    {}
  ),
  s( -- -d -> Down Arrow )
    {
      trig = "-d",
    },
    {
      t("\\downarrow")
    },
    {}
  ),
  s( -- -l -> Left Arrow )
    {
      trig = "-l",
    },
    {
      t("\\leftarrow")
    },
    {}
  ),
  s( -- -h -> Left-Right Arrow )
    {
      trig = "-h",
    },
    {
      t("\\leftrightarrow")
    },
    {}
  ),
  s( -- -v -> Up-Down Arrow )
    {
      trig = "-v",
    },
    {
      t("\\updownarrow")
    },
    {}
  ),
  s( -- -U -> Double Up Arrow )
    {
      trig = "-U",
    },
    {
      t("\\Uparrow")
    },
    {}
  ),
  s( -- -R -> Double Right Arrow )
    {
      trig = "-R",
    },
    {
      t("\\Rightarrow")
    },
    {}
  ),
  s( -- -D -> Double Down Arrow )
    {
      trig = "-D",
    },
    {
      t("\\Downarrow")
    },
    {}
  ),
  s( -- -L -> Double Left Arrow )
    {
      trig = "-L",
    },
    {
      t("\\Leftarrow")
    },
    {}
  ),
  s( -- -H -> Double Left-Right Arrow )
    {
      trig = "-H",
    },
    {
      t("\\Leftrightarrow")
    },
    {}
  ),
  s( -- -V -> Double Up-Down Arrow )
    {
      trig = "-V",
    },
    {
      t("\\Updownarrow")
    },
    {}
  ),
  s( -- c -> Centering Command )
    {
      trig = "c",
    },
    {
      t("\\centering")
    },
    {}
  ),
  s( -- h -> Hrule Command )
    {
      trig = "h",
    },
    {
      t("\\hrule")
    },
    {}
  ),
  s( -- r -> Reference (hyperref) )
    {
      trig = "r",
    },
    fmta(
      [[
        <>
      ]],
      {
        c(1, {
          fmta(
            [[
              Figure \ref{fig:<>}
            ]],
            {
              i(1),
            }
          ),
          fmta(
            [[
              Figure \ref{tbl:<>}
            ]],
            {
              i(1),
            }
          ),
          fmta(
            [[
              \ref{<>}
            ]],
            {
              i(1),
            }
          ),
        }),
      }
    ),
    {}
  ),
  s( -- v -> Vspace Command )
    {
      trig = "v",
    },
    fmta(
      [[
        \vspace{<>}
      ]],
      {
        i(0, "12pt"),
      }
    ),
    {}
  ),
}