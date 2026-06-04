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
local n_slides = 11
local title_color = hsl_to_hex(start_hue, 90, 30)

function Pandoc(doc)
  -- Use Reveal's 'ready' event so slide-background divs exist in the DOM
  -- Also set #title-slide bg directly as a fallback
  local js = string.format([[<script>
(function(){
  var c = "%s";
  function apply(){
    // Reveal creates .slide-background inside .backgrounds, not inside .slides
    var b = document.querySelector(".reveal>.backgrounds>.slide-background:first-child");
    if(b) b.style.backgroundColor = c;
    // Also force the section bg directly
    var s = document.getElementById("title-slide");
    if(s) s.style.backgroundColor = c;
  }
  if(typeof Reveal !== "undefined"){
    Reveal.on("ready", apply);
  }
  window.addEventListener("load", function(){ setTimeout(apply, 100); });
})();
</script>]], title_color)
  table.insert(doc.blocks, pandoc.RawBlock("html", js))
  return doc
end

function Header(el)
  if el.level == 2 then
    local hue = (start_hue + (slide_index / n_slides) * 300) % 360
    local sat = 90
    local lit = 28 + (slide_index % 3) * 4  -- 28, 32, or 36 — always dark
    local color = hsl_to_hex(hue, sat, lit)
    el.attributes["background-color"] = color
    slide_index = slide_index + 1
    return el
  end
end
