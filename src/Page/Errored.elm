module Page.Errored exposing (PageLoadError)

-- MODEL --


type PageLoadError
    = PageLoadError Model


type alias Model =
    { errorMessage : String }
