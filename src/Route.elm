module Route exposing (Route(..), fromLocation)

import UrlParser as Url exposing (Parser, oneOf, s, parseHash)
import Navigation exposing(Location)

-- ROUTING --


type Route
    = Home


route : Parser (Route -> a) a
route =
    oneOf
        [ Url.map Home (s "") ]

-- INTERNAL --

fromLocation : Location -> Maybe Route
fromLocation location =
    if String.isEmpty location.hash then
        Just Home
    else
        parseHash route location