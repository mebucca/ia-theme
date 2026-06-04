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

-- 12 slides total: title + 10 content + closing
-- Distribute evenly across 360° so every slide is visually distinct
local n_total = 12
local start_hue = math.random(0, 359)

local function slide_color(index)
  local hue = (start_hue + (index / n_total) * 360) % 360
  local lit = 28 + (index % 3) * 4  -- cycles 28, 32, 36 — always dark
  return hsl_to_hex(hue, 90, lit)
end

-- Title gets index 0, content slides get 1..10, closing gets 11
local title_color = slide_color(0)
local slide_index = 1  -- content slides start at index 1

function Pandoc(doc)
  local js = string.format([[<script>
(function(){
  var c = "%s";
  function apply(){
    var b = document.querySelector(".reveal>.backgrounds>.slide-background:first-child");
    if(b) b.style.backgroundColor = c;
    var s = document.getElementById("title-slide");
    if(s) s.style.backgroundColor = c;
  }
  if(typeof Reveal !== "undefined") Reveal.on("ready", apply);
  window.addEventListener("load", function(){ setTimeout(apply, 100); });
})();
</script>]], title_color)
  table.insert(doc.blocks, pandoc.RawBlock("html", js))
  return doc
end

function Header(el)
  if el.level == 2 then
    local color = slide_color(slide_index)
    el.attributes["background-color"] = color
    slide_index = slide_index + 1
    return el
  end
end
