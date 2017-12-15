module Route exposing (Route(..))

import UrlParser as Url exposing (Parser, oneOf, s)


-- ROUTING --


type Route
    = Home


route : Parser (Route -> a) a
route =
    oneOf
        [ Url.map Home (s "") ]
