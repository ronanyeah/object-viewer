module Style exposing (..)

import Element exposing (Attribute, Color, rgb255)


bgColor : Color
bgColor =
    rgb255 170 180 190


white : Color
white =
    rgb255 255 255 255


hover : Attribute msg
hover =
    Element.mouseOver [ fade ]


fade : Element.Attr a b
fade =
    Element.alpha 0.7
