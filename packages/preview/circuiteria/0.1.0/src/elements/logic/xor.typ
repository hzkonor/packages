#import "@preview/cetz:0.2.2": draw
#import "gate.typ"

#let space = 10%

#let draw-shape(id, tl, tr, br, bl, fill, stroke) = {
  let (x, y) = bl
  let (width, height) = (tr.at(0) - x, tr.at(1) - y)

  let tl2 = (tl, space, tr)
  let bl2 = (bl, space, br)

  let t = (x + width / 2, y + height)
  let b = (x + width / 2, y)

  let ctrl-bl = (x + width / 2, y)
  let ctrl-br = (x + width * 0.8, y + height * 0.1)
  let ctrl-tl = (x + width / 2, y + height)
  let ctrl-tr = (x + width * 0.8, y + height * 0.9)

  let l = (x + width * 0.2, y + height / 2)
  let l2 = (x + width * (0.2 + space / 100%), y + height / 2)
  let r = (x + width, y + height / 2)

  let f = draw.group(name: id, {
    draw.bezier-through(bl, l, tl, stroke: stroke)
    draw.merge-path(
      inset: 0.5em,
      fill: fill,
      stroke: stroke,
      name: id + "-path", {
        draw.bezier-through(bl2, l2, tl2)
        draw.bezier((), r, ctrl-tl, ctrl-tr)
        draw.bezier((), bl2, ctrl-br, ctrl-bl)
      }
    )
    
    draw.intersections("i",
      id + "-path",
      draw.hide(draw.line(t, b))
    )
    draw.anchor("north", "i.0")
    draw.anchor("south", "i.1")
  })
  return (f, tl, tr, br, bl)
}

/// Draws a XOR gate. This function is also available as `element.gate-xor()`
/// 
/// For parameters, see #doc-ref("gates.gate")
/// #examples.gate-xor
#let gate-xor(
  x: none,
  y: none,
  w: none,
  h: none,
  inputs: 2,
  fill: none,
  stroke: black + 1pt,
  id: "",
  inverted: (),
  debug: (
    ports: false
  )
) = {
  gate.gate(
    draw-shape: draw-shape,
    x: x,
    y: y,
    w: w,
    h: h,
    inputs: inputs,
    fill: fill,
    stroke: stroke,
    id: id,
    inverted: inverted,
    debug: debug
  )
}

/// Draws a XNOR gate. This function is also available as `element.gate-xnor()`
/// 
/// For parameters, see #doc-ref("gates.gate")
/// #examples.gate-xnor
#let gate-xnor(
  x: none,
  y: none,
  w: none,
  h: none,
  inputs: 2,
  fill: none,
  stroke: black + 1pt,
  id: "",
  inverted: (),
  debug: (
    ports: false
  )
) = {
  gate-xor(
    x: x,
    y: y,
    w: w,
    h: h,
    inputs: inputs,
    fill: fill,
    stroke: stroke,
    id: id,
    inverted: if inverted != "all" {inverted + ("out",)} else {inverted},
    debug: debug
  )
}