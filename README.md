# ia-theme

An iA Presenter-style Quarto Reveal.js theme. Full-bleed solid colors, bold headlines pinned bottom-left, and a random color palette generated fresh on every render.

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

A random hue is chosen at render time and stepped ~300° around the color wheel across slides. Re-render to get a new palette.
