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
  s( -- -u -> Up Arrow )
    {
      trig = "-u",
      snippetType = "autosnippet"
    },
    {
      t("\\uparrow")
    },
    {
      condition = non_letter
    }
  ),
  s( -- -r -> Right Arrow )
    {
      trig = "-r",
      snippetType = "autosnippet"
    },
    {
      t("\\rightarrow")
    },
    {
      condition = non_letter
    }
  ),
  s( -- -d -> Down Arrow )
    {
      trig = "-d",
      snippetType = "autosnippet"
    },
    {
      t("\\downarrow")
    },
    {
      condition = non_letter
    }
  ),
  s( -- -l -> Left Arrow )
    {
      trig = "-l",
      snippetType = "autosnippet"
    },
    {
      t("\\leftarrow")
    },
    {
      condition = non_letter
    }
  ),
  s( -- -h -> Left-Right Arrow )
    {
      trig = "-h",
      snippetType = "autosnippet"
    },
    {
      t("\\leftrightarrow")
    },
    {
      condition = non_letter
    }
  ),
  s( -- -v -> Up-Down Arrow )
    {
      trig = "-v",
      snippetType = "autosnippet"
    },
    {
      t("\\updownarrow")
    },
    {
      condition = non_letter
    }
  ),
  s( -- -U -> Double Up Arrow )
    {
      trig = "-U",
      snippetType = "autosnippet"
    },
    {
      t("\\Uparrow")
    },
    {
      condition = non_letter
    }
  ),
  s( -- -R -> Double Right Arrow )
    {
      trig = "-R",
      snippetType = "autosnippet"
    },
    {
      t("\\Rightarrow")
    },
    {
      condition = non_letter
    }
  ),
  s( -- -D -> Double Down Arrow )
    {
      trig = "-D",
      snippetType = "autosnippet"
    },
    {
      t("\\Downarrow")
    },
    {
      condition = non_letter
    }
  ),
  s( -- -L -> Double Left Arrow )
    {
      trig = "-L",
      snippetType = "autosnippet"
    },
    {
      t("\\Leftarrow")
    },
    {
      condition = non_letter
    }
  ),
  s( -- -H -> Double Left-Right Arrow )
    {
      trig = "-H",
      snippetType = "autosnippet"
    },
    {
      t("\\Leftrightarrow")
    },
    {
      condition = non_letter
    }
  ),
  s( -- -V -> Double Up-Down Arrow )
    {
      trig = "-V",
      snippetType = "autosnippet"
    },
    {
      t("\\Updownarrow")
    },
    {
      condition = non_letter
    }
  ),
}
