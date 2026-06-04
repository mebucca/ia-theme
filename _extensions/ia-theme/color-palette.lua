-- Assigns a random-hue color progression to every level-2 slide header at render time.
-- Also injects a <style> block to color the auto-generated Quarto title slide.

math.randomseed(os.time())

local function hsl_to_hex(h, s, l)
  h = h % 360
  if h < 0 then h = h + 360 end
  s = s / 100
  l = l / 100
  local a = s * math.min(l, 1 - l)
  local function f(n)
    local k = (n + h / 30) % 12
    local v = l - a * math.max(-1, math.min(k - 3, 9 - k, 1))
    return string.format("%02x", math.floor(v * 255 + 0.5))
  end
  return "#" .. f(0) .. f(8) .. f(4)
end

local start_hue = math.random(0, 359)
local slide_index = 0
local n_slides = 11  -- total content slides (excluding title)

-- Title slide gets the start hue (same anchor as slide 0)
local title_color = hsl_to_hex(start_hue, 88, 44)

function Pandoc(doc)
  -- Inject a <style> that hard-codes the title slide background for this render
  local style = string.format(
    "<style>#title-slide { background-color: %s !important; }</style>",
    title_color
  )
  local raw = pandoc.RawBlock("html", style)
  table.insert(doc.blocks, 1, raw)
  return doc
end

function Header(el)
  if el.level == 2 then
    local hue = (start_hue + (slide_index / n_slides) * 300) % 360
    local sat = slide_index % 2 == 0 and 88 or 72
    local lit = slide_index % 2 == 0 and 44 or 36
    local color = hsl_to_hex(hue, sat, lit)
    el.attributes["background-color"] = color
    slide_index = slide_index + 1
    return el
  end
end
