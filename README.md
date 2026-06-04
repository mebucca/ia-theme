# ia-theme

An iA Presenter-style Quarto Reveal.js theme. Full-bleed solid colors, bold headlines pinned bottom-left, and a unique random color palette baked in on every render.

## Install

```bash
quarto add mebucca/ia-theme
```

## Use

```yaml
---
title: "Your Title"
subtitle: "Your subtitle"
author: "Name · Institution"
date: today

format:
  ia-theme-revealjs: default
---
```

That's it. No other configuration needed.

## Slide layouts

**Headline only**
```markdown
## Slide title

<div class="headline">Your headline<br>goes here</div>
```

**Headline + body text**
```markdown
## Slide title

<div class="slide-content">
<div class="headline">Your headline<br>goes here</div>
<div class="body">
Supporting text. Supports bullet lists and math: $e=mc^2$
</div>
</div>
```

**Split: text left / image right**
```markdown
## Slide title {.split-slide}

::: {.split-text}
Headline<br>on the left
:::

::: {.split-image}
![](your-photo.jpg)
:::
```

**Closing slide**
```markdown
## {.closing-slide}

<div class="closing-content">
<div class="closing-title">Your Title</div>
<div class="closing-sub">Your subtitle</div>
<div class="closing-rule"></div>
<div class="closing-author">Name · Institution</div>
</div>
```

## Color palette

On every render, a random starting hue is chosen and distributed evenly across all slides (title + content + closing) covering the full 360° color wheel. Each render produces a completely different palette. All backgrounds are dark — no slide ever has a white or light background. Title and closing slides use black text; content slides use white.

## Line breaks in headlines

Use `<br>` inside `.headline` or `.split-text` divs to control where lines break:

```html
<div class="headline">Good design<br>is innovative</div>
```
